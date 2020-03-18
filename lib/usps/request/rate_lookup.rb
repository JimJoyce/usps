module USPS::Request
  # All the address information APIs are essentially identical
  class RateLookup < Base
    config(
      :api => 'RateV4',
      :tag => 'RateV4Request',
      :secure => false,
      :response => USPS::Response::RateLookup
    )
#     <Package ID="1ST">
#     <Service>ALL</Service>
#     <ZipOrigination>59759</ZipOrigination>
#     <ZipDestination>90210</ZipDestination>
#     <Pounds>5</Pounds>
#     <Ounces>5</Ounces>
#     <Container />
#     <Size>REGULAR</Size>
#     <Width>2</Width>
#     <Length>1</Length>
#     <Height>3</Height>
#     <Girth>10</Girth>
#     <Machinable>false</Machinable>
#  </Package>
  attr_reader :package

    # The USPS api is only capable of handling at most 5 zip codes per request.
    def initialize(package)
      @package = package
      # from_zip, to_zip, pounds, ounces, package_size, width, lenght, height, girth
    end

    def build

      super do |builder|

        builder.tag!('Package', ID: '1ST') do
          builder.tag!('Service', package.service)
          builder.tag!('ZipOrigination', package.zip_origin)
          builder.tag!('ZipDestination', package.zip_destination)
          builder.tag!('Container', '')
          builder.tag!('Machinable', false)
          
          builder.tag!('Pounds', package.pounds) unless package.pounds.nil?
          builder.tag!('Ounces', package.ounces) unless package.ounces.nil?
          builder.tag!('ShipDate', package.ship_date) unless package.ship_date.nil?
          builder.tag!('Width', package.width)  unless package.width.nil?
          builder.tag!('Length', package.lenght)  unless package.length.nil?
          builder.tag!('Height', package.height)  unless package.height.nil?
          builder.tag!('Girth', package.girth)  unless package.girth.nil?
          
          # builder.tag!('Value', package.value)
        end

      end

    end

  end
end
