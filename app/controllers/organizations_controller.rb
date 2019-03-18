class OrganizationsController < ApplicationController
	before_action :set_user
  def index
  	@organizations=current_user.organization
  end

  def new
  	@organization=current_user.build_organization
  end

  def create
  	@organization = current_user.create_organization(organization_params)
   		 if @organization.save
   		 	redirect_to organization_path(@organization)
   		 else
   		 	render 'new'
   		 end
  end

  def show
  	@organization = Organization.find(params[:id])
  end

  def edit
  		@organization = Organization.find(params[:id])
  end

  def update
  	@organization = Organization.find(params[:id])
			
			if @organization.update(organization_params)
				redirect_to organization_path(@organization)
			else
				render 'edit'
			end
  end

  def destroy
  	@organization = current_user.organizations.find(params[:id])
   		 @organization.destroy
    	 redirect_to organizations_path
  end

  private
  def organization_params
		params.require(:organization).permit(:name, :city, :state, :avatar, :country, :phone, :address)
	end

	def user_params
		param.require(:user_id)
	end
	def set_user
		@user = User.find(current_user.id)
	end
end
