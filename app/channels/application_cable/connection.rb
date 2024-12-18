module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private
    def find_verified_user
      if verified_user = env['warden'].user # I can use this because I have devise
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
