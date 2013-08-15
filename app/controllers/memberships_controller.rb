class MembershipsController < ApplicationController

  def handshake
    @person = Person.find(params[:user_id])
    @membership = Membership.find_by_person_id(params[:user_id]) || Membership.new
  end

  def create
    @membership = Membership.new
    @membership.person_id = params[:membership][:person_id]
    @membership.organization_id = params[:membership][:person_id]
    @membership.save
    if @membership.save
      redirect_to people_url, notice: "You've successfully connected to CW Dash!"
    else
      render action: "new"
    end
  end

  def update
    @membership = Membership.find(params[:id])
    @membership.person_id = params[:membership][:person_id]
    @membership.organization_id = params[:membership][:person_id]
    @membership.save
    if @membership.save
      redirect_to people_url, notice: "You've successfully connected to CW Dash!"
    else
      render action: "edit"
    end
  end

end
