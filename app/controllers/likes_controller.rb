class LikesController < ApplicationController
	before_action :require_signin
	before_action :set_event
	
	def create
		# event.likes.create!(user: current_user)
		@event.likers << current_user
		redirect_to @event, notice: "Glad you liked it!"
	end
	
	def destroy
		like = current_user.likes.find(params[:id])
		#like = current_user.likes.find_by(id: params[:id], event_id: @event.id)
		like.destroy
		redirect_to @event, notice: "Sorry you unliked it!"
	end
	
private

	def set_event
		@event = Event.find(params[:event_id])
	end
end