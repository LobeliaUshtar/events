require 'spec_helper'

describe "Editing a registration" do
=begin
	it "updates the registration and shows the registration's updated details" do
		event = Event.create(event_attributes)

		visit event_url(event)

		click_link 'Edit!'

		expect(current_path).to eq(edit_event_registration_path(event))

		expect(find_field('registration_name').value).to eq(registration.name)
		
		fill_in "Name", with: "Updated Registration Name"

		click_button 'Update Registration'

		expect(current_path).to eq(event_registrations_path(event))

		expect(page).to have_text("Updated Registration Name")
		expect(page).to have_text("Registration successfully updated!")
	end

	it "does not update the registration if it's invalid" do
		event = Event.create(event_attributes)
		
		visit edit_event_registration_url(event)
		
		fill_in 'Name', with: " "
		
		click_button 'Update Registration' 
				
		expect(page).to have_text('error')
	end
=end

end