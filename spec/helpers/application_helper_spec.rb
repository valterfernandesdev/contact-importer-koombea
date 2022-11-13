require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#header_text" do
    subject(:header_text) { helper.header_text(controller_name) }

    context "when controller name is contacts" do
      let(:controller_name) { "contacts" }

      it { is_expected.to eq("Contacts") }
    end

    context "when controller name is contact files" do
      let(:controller_name) { "contact_files" }

      it { is_expected.to eq("Import Contacts") }
    end
  end

  describe "#current_controller_nav_class" do
    subject(:current_controller_nav_class) { helper.current_controller_nav_class(nav_text, controller_name) }

    let(:active_nav_classes) { "bg-gray-900 text-white px-3 py-2 rounded-md text-sm font-medium" }
    let(:nav_classes) { "text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium" }

    context "when nav text is the same as the active controller" do
      let(:nav_text) { "contacts" }
      let(:controller_name) { "contacts" }

      it { is_expected.to eq(active_nav_classes) }
    end

    context "when nav text is not the same as the active controller" do
      let(:nav_text) { "contacts" }
      let(:controller_name) { "contact_files" }

      it { is_expected.to eq(nav_classes) }
    end
  end
end
