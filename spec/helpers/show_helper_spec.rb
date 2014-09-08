require 'rails_helper'

RSpec.describe ShowHelper, type: :helper do
  let(:title_example_one) { "The life and times of"}
  let(:title_example_two) { "This is a title that includes a slash and author concat / By Me"}

  describe "#prism_search_link" do
    before(:each) do
      HullHistoryCentre::Application.config.prism_server_name = "prism-test.server.org"
    end

    it "returns the expected search url" do
      expect(helper.prism_search_link(title_example_one)).to include("http://prism-test.server.org/uhtbin/cgisirsi.exe/x/HULLCENTRL/x/57/5?user_id=HULLWEB&amp;searchdata1=The%20life%20and%20times%20of")
    end 

    it "returns the search url without a concatenated author" do
        expect(helper.prism_search_link(title_example_two)).to include("http://prism-test.server.org/uhtbin/cgisirsi.exe/x/HULLCENTRL/x/57/5?user_id=HULLWEB&amp;searchdata1=This%20is%20a%20title%20that%20includes%20a%20slash%20and%20author%20concat%20")
    end

  end

end