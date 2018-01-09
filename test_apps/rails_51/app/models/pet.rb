class Pet
  MAX_ID = 100_000_000
  @@pets = []

  attr_reader :id, :martian_id, :name, :weight

  def self.create!(id: nil, martian_id:, name:, weight:)
    new(id: id, martian_id: martian_id, name: name, weight: weight).tap do |pet|
      @@pets << pet
    end
  end

  def self.all
    @@pets
  end

  def self.find(id)
    id = Integer(id)
    @@pets.find { |pet| pet.id == id }
  end

  def initialize(id: nil, martian_id:, name:, weight:)
    @id = id ? id : rand(MAX_ID)
    @martian_id = martian_id
    @name = name
    @weight = weight
  end
end
