# frozen_string_literal: true
require "spec_helper"

describe Symplectic::Elements::CSV::TransformJob do
  describe '.build_csv_file' do
    let(:path) { File.join('spec', 'fixtures', 'test.csv') }
    let(:csv_file) do
      described_class.build_csv_file(path: path)
    end

    it 'parses the CSV file' do
      expect(csv_file).to be_a(CSV::Table)

      rows = csv_file.to_a
      expect(rows.length).to eq(4)
      expect(rows[1]).to eq(["", "AS", "Alice", "Smith", "", "", "user1@Princeton.EDU", "CAS", "user1", "000000001", "English", "TRUE", "TRUE", "FALSE", "", "", "Faculty", "English"])
    end
  end

  describe '.perform' do
    let(:path) { File.join('spec', 'fixtures', 'test.csv') }
    let(:request_document) do
      described_class.perform(csv_path: path)
    end
    let(:document) { request_document.document }

    it 'transforms the CSV file into an XML Document' do
      expect(request_document).to be_a(Symplectic::Elements::XML::ImportUsersRequest)
      expect(request_document.document).to be_a(Nokogiri::XML::Document)

      position_element = document.at_xpath('//api:generic-field-01', api: 'http://www.symplectic.co.uk/publications/api')
      expect(position_element.content).to eq('Faculty')

      department_element = document.at_xpath('//api:generic-field-02', api: 'http://www.symplectic.co.uk/publications/api')
      expect(department_element.content).to eq('English')
    end
  end
end
