class ApiController < ApplicationController
  before_filter :login_or_oauth_required

  def verify_credentials
    user_data = {'login' => current_user.login, 'name' => current_user.name}
    respond_to do |format|
      format.json { render :json => user_data.to_json }
      format.xml  { render :xml => user_data.to_xml }
    end
  end

  def permissions
    #TODO: This should retrieve actual permissions for the user making the request.
    @permissions = {'ProveedoresController' => ['new', 'edit', 'show']}
    respond_to do |format|
      format.json { render :json => @permissions.to_json }
      format.xml  { render :xml => @permissions.to_xml }
    end
  end

end
