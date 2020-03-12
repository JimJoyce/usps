module USPS::Response
  autoload :Base, 'usps/response/base'
  autoload :CityAndStateLookup,     'usps/response/city_and_state_lookup'
  autoload :DeliveryConfirmation,   'usps/response/delivery_confirmation'
  autoload :AddressStandardization, 'usps/response/address_standardization'
  autoload :TrackingLookup,         'usps/response/tracking_lookup'
  autoload :TrackingFieldLookup,    'usps/response/tracking_field_lookup'
  autoload :RateLookup,    'usps/response/rate_lookup'
end
