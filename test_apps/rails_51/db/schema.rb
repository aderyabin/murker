ActiveRecord::Schema.define(version: 20_180_107_194_526) do
  create_table 'martians', force: :cascade do |t|
    t.string 'name'
    t.integer 'age'
  end

  create_table 'pets', force: :cascade do |t|
    t.integer 'martian_id'
    t.string 'name'
    t.integer 'weight'
  end
end
