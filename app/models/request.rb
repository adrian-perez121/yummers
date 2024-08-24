class Request < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :requested, class_name: 'User'

  def self.can_request?(from, to)
    !(where(requester_id: from.id, requested_id: to.id).exists? || from == to)
  end
end
