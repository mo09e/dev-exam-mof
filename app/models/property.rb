class Property < ApplicationRecord
  has_many :stations
  accepts_nested_attributes_for :stations, reject_if: :reject_blank_station, allow_destroy: true

  def reject_blank_station(attributes)
    exists = attributes[:id].present?
    empty = attributes[:name].blank?
    attributes.merge!(_destroy: 1) if exists && empty
    !exists && empty
  end
end
