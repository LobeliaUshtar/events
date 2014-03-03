require 'spec_helper'

describe "Deleting a registration" do 

=begin
	it "destroys the registration and shows the registration listing" do
		event = Event.create(event_attributes)
		
		visit event_path(event)
		
		click_link 'Delete'
		
		expect(current_path).to eq(events_path)
		expect(page).not_to have_text(event.name)
		expect(page).to have_text("Event successfully deleted!")
	end
=end

end