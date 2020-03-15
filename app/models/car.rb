class Car < ActiveRecord::Base
  belongs_to :user
  belongs_to :garage
end
