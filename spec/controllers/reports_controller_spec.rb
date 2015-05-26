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
      let(:report_id) { report_id }

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
end
