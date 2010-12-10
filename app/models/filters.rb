class Filters < OpenStruct
  def initialize(table)
    super(table || {})
  end

  def apply(model)
    @table.each do |filter, value|
      if value.present? && value != "All" && model.respond_to?("by_#{filter}")
        model = model.send("by_#{filter}", value)
      end
    end
    model
  end

  def any?
    @table.any? {|_,v| v.present? }
  end

end
