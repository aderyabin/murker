class Martian
  MAX_ID = 100_000_000
  @@martians = []

  attr_reader :id, :name, :age

  def self.create!(id: nil, name:, age:)
    new(id: id, name: name, age: age).tap { |martian| @@martians << martian }
  end

  def self.all
    @@martians
  end

  def self.find(id)
    id = Integer(id)
    @@martians.find { |martian| martian.id == id }
  end

  def initialize(id: nil, name:, age:)
    @id = id ? id : rand(MAX_ID)
    @name = name
    @age = age
  end

  def pets
    Pet.all.select { |pet| pet.id == id }
  end
end
