require 'murker'

module Murker
  class Interaction
    class NonroutableRequest < RuntimeError; end

    PREFIX = 'action_dispatch.request'.freeze

    attr_reader(
      :verb,
      :endpoint_path,
      :path_info,
      :path_params,
      :query_params,
      :payload,
      :status,
      :body
    )

    def initialize(**params)
      @verb = params[:verb]
      @endpoint_path = params[:endpoint_path]
      @path_info = params[:path_info]
      @path_params = params[:path_params]
      @query_params = params[:query_params]
      @payload = params[:payload]

      @status = params[:status]
      @body = params[:body]
    end

    def self.from_action_dispatch(request, response)
      json_body = JSON.parse(response.body) rescue nil
      unless json_body
        error_message = "Murker requires response.body to be parsable JSON, " <<
          "but got '#{response.body}'"
        raise MurkerError, error_message
      end

      params = {
        verb: request.method,
        endpoint_path: route_name(request),
        path_info: request.path_info,
        path_params: request.env["#{PREFIX}.path_parameters"].stringify_keys.except('format'),
        query_params: request.env["#{PREFIX}.query_parameters"],
        payload: request.env["#{PREFIX}.request_parameters"].merge(
          request.env["#{PREFIX}.query_parameters"]
        ).stringify_keys.except('action', 'controller', 'format', '_method'),
        status: response.status,
        body: json_body
      }

      new(params)
    end

    private

    def self.route_name(request)
      return unless defined? Rails

      Rails.application.routes.router.recognize(request) do |route, _|
        return route.path.spec.to_s.sub('(.:format)', '')
      end
      raise NonroutableRequest,
        "Cannot find named route for: #{request.env['HTTP_HOST']}#{request.path_info}"
    end
  end
end
