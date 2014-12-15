class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  around_filter :scope_current_tenant	
  protect_from_forgery with: :exception

  def current_tenant
  	@current_tenant  ||= Tenant.where(subdomain: request.subdomain).first
  end  

  def scope_current_tenant &block
  		p "-----blcok"
  	p &block
  	p "-----blcok"
  	current_tenant.scope_schema("public", &block)
  end

end
