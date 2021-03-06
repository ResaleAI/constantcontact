#
# base_service_spec.rb
# ConstantContact
#
# Copyright (c) 2013 Constant Contact. All rights reserved.

require 'spec_helper'

describe ConstantContact::Services::BaseService do
  describe "#get_headers" do
    it "gets a hash of headers" do
      token = 'foo'
      ConstantContact::Services::BaseService.access_token = token
      headers = ConstantContact::Services::BaseService.send(:get_headers)

      expect(headers).to be_a Hash
      expect(headers[:content_type]).to be_a String
      expect(headers[:content_type]).to eq('application/json')
      expect(headers[:accept]).to be_a String
      expect(headers[:accept]).to eq('application/json')
      expect(headers[:authorization]).to be_a String
      expect(headers[:authorization]).to eq("Bearer #{token}")
      expect(headers[:user_agent]).to be_a String
      expect(headers[:user_agent].include?("Ruby SDK v#{ConstantContact::SDK::VERSION}")).to be_truthy
      expect(headers[:user_agent].include?(RUBY_DESCRIPTION)).to be_truthy
      expect(headers[:x_ctct_request_source]).to be_a String
      expect(headers[:x_ctct_request_source].include?(ConstantContact::SDK::VERSION)).to be_truthy
    end
  end

  describe "#build_url" do
    it "combines all the given parameters into the url" do
      components = ConstantContact::Services::BaseService.send(:build_url, "http://testing.com", :arg1 => 'abc', :arg2 => 123).split('&')
      expect(components[0]).to eq('http://testing.com?api_key=api+key')
      expect(components.length).to eq(3)
      expect(components.include?('arg1=abc')).to be_truthy
      expect(components.include?('arg2=123')).to be_truthy
    end

    it "does not parse the next param when not in next_link format" do
      url = ConstantContact::Services::BaseService.send(:build_url, "http://testing.com", :next => "abcdef")
      expect(url).to eq('http://testing.com?api_key=api+key&next=abcdef')
    end

    it "parses next id from next param given in next_link format" do
      url = ConstantContact::Services::BaseService.send(:build_url, "http://testing.com", :next => "/some/path?next=abcdefg")
      expect(url).to eq('http://testing.com?api_key=api+key&next=abcdefg')
    end
  end
end
