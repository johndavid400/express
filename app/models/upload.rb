class Upload < ApplicationRecord
  dragonfly_accessor :attachment
  belongs_to :entry
end
