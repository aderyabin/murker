require 'active_support/concern'
require 'murker/spy'

module Murker
  module SpecHelper
    module Rails
      extend ActiveSupport::Concern

      module ClassMethods
        module MurkerSession
          def process(*)
            super.tap do
              if Murker::Spy.enabled?
                Murker::Spy.current
                  .add_interaction_by_action_dispatch(@request, @response)
              end
            end
          end
        end

        def new(*)
          super.extend(MurkerSession)
        end
      end
    end
  end
end

if defined?(ActionDispatch::Integration::Session)
  ActionDispatch::Integration::Session.send :include, Murker::SpecHelper::Rails
end

if defined?(ActionController::TestCase::Behavior)
  ActionController::TestCase::Behavior.send :include, Murker::SpecHelper::Rails
end
