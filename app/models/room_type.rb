class RoomType < ActiveRecord::Base
    has_many :reservations
    belongs_to :reservation

    def set_room_description
        self.update(RoomTypeDescription::DESCRIPTIONS[room_type.to_s])
    end
end