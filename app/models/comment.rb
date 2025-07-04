class Comment < ApplicationRecord
  include Visible
  
  belongs_to :article

  validates :commenter, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  VALID_STATUSES = [ "public", "private", "archived" ]

  validates :status, inclusion: { in: VALID_STATUSES }

  def archived?
    status == "archived"
  end
end