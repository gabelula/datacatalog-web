module LocationsHelper
  def all_countries_for_select
    Location.countries.map {|c| [t(c.name), c.id.to_s] }.sort_by {|name, _| name }
  end

  def all_locations_for_select(*preferential)
    options = preferential.extract_options!
    options.reverse_merge!(:stringify_ids => true)

    get_id = lambda do |obj|
      if options[:stringify_ids]
        obj.id.to_s
      else
        obj.id
      end
    end

    locations = []
    locations += preferential
    locations << [I18n.t(Location.global.name), get_id[Location.global]]
    locations << "-------------"
    locations += Location.countries.map {|c| [I18n.t(c.name), get_id[c]] }.sort_by {|name, _| name }
    locations
  end
end
