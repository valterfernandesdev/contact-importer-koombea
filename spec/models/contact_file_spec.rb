# frozen_string_literal: true

require "rails_helper"

RSpec.describe ContactFile do
  subject(:contact_file) { build(:contact_file) }

  describe "associations" do
    it { is_expected.to have_one_attached(:file) }
    it { is_expected.to belong_to(:user) }
  end
end
