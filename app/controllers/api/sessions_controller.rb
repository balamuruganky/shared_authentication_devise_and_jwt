class Api::SessionsController < Devise::SessionsController
  before_action :authenticate_user!
  skip_before_action :verify_signed_out_user
  respond_to :json

  begin
    def create
      super { @token = current_token }
    end

    private
      def respond_with(resource, _opts = {})
        render json: { :resource => resource, :token => current_token }.to_json, :status => :ok
      end

      def respond_to_on_destroy
        #head :ok
        render json: { :status => "Success"}.to_json, :status => :ok
      end

      def current_token
        request.env['warden-jwt_auth.token']
      end
  end

end
