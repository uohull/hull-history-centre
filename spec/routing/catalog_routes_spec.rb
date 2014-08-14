require 'rails_helper'

describe 'Catalog routes' do

  describe 'show route' do
    let(:space) { '%20' }

    let(:simple_id) { '1' }
    let(:id_with_dots) { '1.1.1' }
    let(:id_with_space_entities) { "L#{space}WH#{space}1" }
    let(:id_with_slashes) { "L#{space}WH/1/1.1/01a" }

    let(:all_ids) { [simple_id, id_with_dots,
                     id_with_space_entities, id_with_slashes
    ] }

    it 'routes to show' do
      all_ids.each do |id|
        expect(get: "catalog/#{id}").to route_to(
          controller: 'catalog',
            action: 'show',
            id: id.gsub(space, ' ')
        )
      end
    end

  end
end
