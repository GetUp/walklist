require "sinatra/base"
require "sinatra/cookies"

module Sinatra
  module LoginHelper
    module Helpers
      def user_email
        session[:user_email]
      end

      def authorise(email)
        session[:user_email] = email
      end

      def authorised?
        !user_email.nil? && settings.db[:users].where(email: user_email).any?
      end

      def authorised
        if authorised?
          yield
        else
          flash[:notice] = "You need to login before you can view that page."
          redirect "/"
        end
      end
    end

    def self.registered(app)
      app.helpers LoginHelper::Helpers
    end
  end

  register LoginHelper
end