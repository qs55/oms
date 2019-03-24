class OrganizationsController < ApplicationController
  before_action :authenticate_user!
	before_action :set_user
  before_action :set_message_users
  def index 
  #		authorize User       #pundit policy 
  		if (@user.user_type=="admin")
  			redirect_to organizations_organizationslist_path
  			return
  		else
  			@organizations=Organization.where(:id => current_user.org_id).first  #here lies the problem'

  		end
  		
  end

  def new
  	@organization=current_user.build_organization
  end

  def create
  	@user=User.find(current_user.id)
  	@organization = current_user.create_organization(organization_params)
   		 if @organization.save
   		 	@user.org_id=@organization.id
   		 	@user.save
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

  def organizationslist
  	@organizations=Organization.all
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
