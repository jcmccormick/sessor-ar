require 'spec_helper'

describe ReportsController do
  render_views
  describe "index" do
    before do
      Report.create!(name: 'Baked Potato w/ Cheese')
      Report.create!(name: 'Garlic Mashed Potatoes')
      Report.create!(name: 'Potatoes Au Gratin')
      Report.create!(name: 'Baked Brussel Sprouts')

      xhr :get, :index, format: :json, keywords: keywords
    end

    subject(:results) { JSON.parse(response.body) }

    def extract_name
      ->(object) { object["name"] }
    end

    context "when the search finds results" do
      let(:keywords) { 'baked' }
      it 'should 200' do
        expect(response.status).to eq(200)
      end
      it 'should return two results' do
        expect(results.size).to eq(2)
      end
      it "should include 'Baked Potato w/ Cheese'" do
        expect(results.map(&extract_name)).to include('Baked Potato w/ Cheese')
      end
      it "should include 'Baked Brussel Sprouts'" do
        expect(results.map(&extract_name)).to include('Baked Brussel Sprouts')
      end
    end

    context "when the search doesn't find results" do
      let(:keywords) { 'foo' }
      it 'should return no results' do
        expect(results.size).to eq(0)
      end
    end

  end

  describe "show" do
    before do
      xhr :get, :show, format: :json, id: report_id
    end

    subject(:results) { JSON.parse(response.body) }

    context "when the report exists" do
      let(:report) {
        Report.create!(name: 'Baked Potato w/ Cheese',
               submission: "Eat the cheese.")
      }
      let(:report_id) { report.id }

      it { expect(response.status).to eq(200) }
      it { expect(results["id"]).to eq(report.id) }
      it { expect(results["name"]).to eq(report.name) }
      it { expect(results["submission"]).to eq(report.submission) }
    end

    context "when the report does not exist" do
      let(:report_id) { -9999 }
      it { expect(response.status).to eq(404) }
    end
  end

  describe "create" do
    before do
      xhr :post, :create, format: :json, report: { name: "Toast", 
                                           submission: "Add bread to toaster, push lever" }
    end
    it { expect(response.status).to eq(201) }
    it { expect(Report.last.name).to eq("Toast") }
    it { expect(Report.last.submission).to eq("Add bread to toaster, push lever") }
  end

  describe "update" do
    let(:report) { 
      Report.create!(name: 'Baked Potato w/ Cheese', 
                     submission: "Nuke for 20 minutes; top with cheese") 
    }
    before do
      xhr :put, :update, format: :json, id: report.id, report: { name: "Toast", 
                                                 submission: "Add bread to toaster, push lever" }
      report.reload
    end
    it { expect(response.status).to eq(204) }
    it { expect(report.name).to eq("Toast") }
    it { expect(report.submission).to eq("Add bread to toaster, push lever") }
  end

  describe "destroy" do
    let(:report_id) { 
      Report.create!(name: 'Baked Potato w/ Cheese', 
                     submission: "Nuke for 20 minutes; top with cheese").id
    }
    before do
      xhr :delete, :destroy, format: :json, id: report_id
    end
    it { expect(response.status).to eq(204) }
    it { expect(Report.find_by_id(report_id)).to be_nil }
  end
end
