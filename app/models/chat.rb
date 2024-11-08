class Chat < ApplicationRecord
  belongs_to :chatter_1, class_name: "User"
  belongs_to :chatter_2, class_name: "User"
end
