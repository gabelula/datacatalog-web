Location.transaction do
  latin_america = Location.create!(:name => "latin_america")

  [
      "mexico",
      "antigua_and_barbuda",
      "argentina",
      "bahamas",
      "barbados",
      "belize",
      "bolivia",
      "brazil",
      "chile",
      "colombia",
      "costa_rica",
      "cuba",
      "dominica",
      "dominican_republic",
      "ecuador",
      "el_salvador",
      "grenada",
      "guatemala",
      "guyana",
      "haiti",
      "honduras",
      "jamaica",
      "nicaragua",
      "panama",
      "paraguay",
      "peru",
      "saint_kitts_and_nevis",
      "saint_lucia",
      "saint_vincent_and_the_grenadines",
      "suriname",
      "trinidad_and_tobago",
      "uruguay",
      "venezuela"
  ].each do |country_key|
    country = Location.create(:name => country_key)
    country.move_to_child_of(latin_america)
  end
end
