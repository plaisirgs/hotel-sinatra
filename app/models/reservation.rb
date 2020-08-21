class Reservation < ActiveRecord::Base
     belongs_to :user
     has_many :room_types

     def generate_code(number)
          charset = Array('A'..'Z') + Array('A'..'Z')
          conf_number = Array.new(number) { charset.sample }.join
          self.update(confirmation: conf_number)
     end


end