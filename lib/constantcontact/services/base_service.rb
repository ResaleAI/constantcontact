#
# base_service.rb
# ConstantContact
#
# Copyright (c) 2013 Constant Contact. All rights reserved.

module ConstantContact
  module Services
    class BaseService
      class << self
        attr_accessor :api_key

        protected

        # Helper function to return required headers for making an http request with constant contact
        # @param [String] access_token - OAuth2 access token to be placed into the Authorization header
        # @return [Hash] - authorization headers
        def get_headers(access_token)
          {
            :content_type   => 'application/json',
            :accept         => 'application/json',
            :authorization  => "Bearer #{access_token}"
          }
        end
        
        # returns the id of a ConstantContact component
        def get_id_for(obj)
          if obj.kind_of? ConstantContact::Components::Component
            obj.id
          elsif obj.kind_of? Hash
            obj["id"]
          else
            obj
          end
        end 


        # Build a url from the base url and query parameters hash
        def build_url(url, params = nil)
          if params.respond_to? :each
            params.each do |key, value|
              # Convert dates to CC date dormat.
              if value.respond_to? :iso8601
                params[key] = value.iso8601
              end
            end
          else
            params ||= {}
          end
          
          params['api_key'] = BaseService.api_key
          url += '?' + Util::Helpers.http_build_query(params)
        end

      end
    end
  end
end