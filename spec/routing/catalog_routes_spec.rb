require 'rails_helper'

describe 'Catalog routes' do

  describe 'GET show' do
    let(:space) { '%20' }
    let(:slash) { '%2F' }
    let(:dot)   { '%2E' }

    let(:simple_id) { '1' }
    let(:id_with_dots) { "1#{dot}1#{dot}1#{dot}1" }
    let(:id_with_spaces) { "L#{space}WH#{space}1" }
    let(:id_with_slashes) { "L#{space}WH#{slash}1#{slash}1#{dot}1#{slash}01a" }


    context 'simple ID' do
      let(:id) { '1' }

      it 'routes to show' do
        expect(get: "catalog/#{simple_id}").to route_to(
          controller: 'catalog',
            action: 'show',
            id: id
        )
      end
    end

    context 'ID with dots' do
      let(:id) { '1.1.1.1' }

      it 'routes to show' do
        expect(get: "catalog/#{id_with_dots}").to route_to(
          controller: 'catalog',
            action: 'show',
            id: id
        )
      end
    end

    context 'ID with spaces' do
      let(:id) { "L WH 1" }

      it 'routes to show' do
        expect(get: "catalog/#{id_with_spaces}").to route_to(
          controller: 'catalog',
            action: 'show',
            id: id
        )
      end
    end

    context 'ID with slashes' do
      let(:id) { "L WH/1/1.1/01a" }

      it 'routes to show' do
        expect(get: "catalog/#{id_with_slashes}").to route_to(
          controller: 'catalog',
            action: 'show',
            id: id
        )
      end
    end

  end
end
