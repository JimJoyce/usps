class USPS::Package

attr_accessor :service,
              :zip_origin,
              :zip_destination,
              :pounds,
              :ounces,
              :container,
              :width,
              :length,
              :height,
              :girth,
              :value,
              :ship_date


SERVICE_TYPES = ['FIRST CLASS', 'PRIORITY', 'ALL']

def initialize(*opts)
  opts.shift.each do |attr, value|
    send("#{attr.to_s}=", value)
  end
end


  def formatted_shipping_date
    return unless ship_date
    ship_date.strftime('%Y-%m-%d')
  end


  def self.build_random
    # width/length/height are optional, but if you provide one of them then they all become required
    new(
      service: SERVICE_TYPES.sample,
      zip_origin: 60559,
      zip_destination: 60622,
      pounds: rand(30..150),
      ounces: rand(4..10),
      ship_date: (Date.today..Date.today + 30).to_a.sample.strftime('%Y-%m-%d')
    )
  end


end