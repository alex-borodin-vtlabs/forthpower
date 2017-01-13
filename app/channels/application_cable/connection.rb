module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      return if !self.current_user
      self.current_user.online = true
      self.current_user.save!
    end

    def disconnect
      return if !self.current_user
      self.current_user.online = false
      self.current_user.save!
    end

    protected

    def find_verified_user # this checks whether a user is authenticated with devise
      if verified_user = env['warden'].user
        verified_user
      end
    end
  end
end
