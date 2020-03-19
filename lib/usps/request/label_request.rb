module USPS::Request
  # All the address information APIs are essentially identical
  class LabelRequest < Base
    config(
      :api => 'eVS',
      :tag => 'eVSRequest',
      :secure => true,
      :response => USPS::Response::LabelRequest
    )

    OPTIONS = [
      :WeightInOunces,
      :FromName,
      :FromFirm,
      :FromFirm,
      :FromAddress1,
      :FromAddress2,
      :FromCity,
      :FromState,
      :FromZip5,
      :FromZip4,
      :FromPhone,
      :ServiceType
    ]

    IMAGE_TYPES = [
      'PDF',
      'TIF',
      'None'
    ]


    SERVICE_TYPES = [
      'PRIORITY EXPRESS',
      'PRIORITY',
      'FIRST CLASS',
      'PARCEL SELECT GROUND',
      'LIBRARY',
      'MEDIA',
      'BPM',
      'PRIORITY MAIL CUBIC'
    ]

    attr_reader :from, :to, :weight

    def initialize(from, to, weight)
      @from   = from
      @to     = to
      @weight = weight
      @format = IMAGE_TYPES[1]
    end


    def build
      super do |builder|
        builder.tag!('ServiceType', SERVICE_TYPES.sample)
        builder.tag!('WeightInOunces', self.weight)
        builder.tag!('ImageType', @format)
        # builder.tag!('ImageParameters')

        [
          [self.from, 'From'],
          [self.to,   'To']
        ].each do |address, prefix|
          builder.tag!("#{prefix}Name",  address.name)
          builder.tag!("#{prefix}Firm",  address.company)
          builder.tag!("#{prefix}Address1", address.extra_address)
          builder.tag!("#{prefix}Address2", address.address)
          builder.tag!("#{prefix}City",  address.city)
          builder.tag!("#{prefix}State", address.state)
          builder.tag!("#{prefix}Zip5",  address.zip5)
          builder.tag!("#{prefix}Zip4",  address.zip4)
        end

      end
    end

  end
end
