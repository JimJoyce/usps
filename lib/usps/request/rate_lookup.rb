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

    # The USPS api is only capable of handling at most 5 zip codes per request.
    def initialize(from_zip, to_zip, pounds, ounces, package_size, width, lenght, height, girth)
      @from_zip = from_zip 
      @to_zip = to_zip 
      @pounds = pounds 
      @ounces = ounces 
      @package_size = package_size 
      @width = width 
      @lenght = lenght 
      @height = height 
      @girth = girth
    end

    def build

      super do |builder|

        builder.tag!('Package', ID: '1ST') do
          builder.tag!('ZipOrigination', from_zip)
          builder.tag!('ZipDestination', to_zip)
          builder.tag!('Pounds', pounds)
          builder.tag!('Ounces', ounces)
          builder.tag!('Container')
          builder.tag!('Size', 'REGULAR')
          builder.tag!('Width', width)
          builder.tag!('Length', length)
          builder.tag!('Height', height)
          builder.tag!('Girth', girth)
        end

      end

    end

  end
end
