module Ead
  class Item

    def self.root_xpath
      'c[@level = "item"]'
    end

    # Map the name of the field to its xpath within the EAD xml
    def self.fields_map
      { id: 'did/unitid[@label = "Reference"]',
        title: 'did/unittitle'
      }
    end

  end
end
