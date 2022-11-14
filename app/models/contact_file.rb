# frozen_string_literal: true

class ContactFile < ApplicationRecord
  belongs_to :user

  enum status: {
    on_hold: "on hold",
    processing: "processing",
    failed: "failed",
    finished: "finished"
  }

  has_one_attached :file
end
