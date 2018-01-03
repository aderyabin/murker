class MartianSerializer < ActiveModel::Serializer
  attributes :name, :age, :ololo

  def ololo
    'OLOLO'
  end
end
