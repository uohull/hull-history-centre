require 'rails_helper'

describe 'Catalogue routes' do

  describe 'GET show' do
    let(:id) { "L-WH-1-1.1-01a" }

    it 'routes to show' do
      expect(get: "catalogue/#{id}").to route_to(
        controller: 'catalogue',
        action: 'show',
        id: id
      )
    end
  end

  describe 'POST track' do
    let(:id) { "L-WH-11-11.1-13-01a" }

    it 'routes to track' do
      expect(post: "catalogue/#{id}/track").to route_to(
        controller: 'catalogue',
        action: 'track',
        id: id
      )
    end
  end

end
