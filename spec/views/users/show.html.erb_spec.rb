require "rails_helper"
RSpec.describe "users/show.html.erb", type: :view do
  let(:user) {FactoryGirl.create(:user)}
  subject {user}

  it "displays user details" do
    assign(:user, subject)
    render
    expect(response.body).to include("/assets/avatar_2x-cdcc6d6dcda827a694dce8bfa9a1ab41113b629ef1cc11f886866af9194c81d0.png")
    expect(response.body).to have_css(".img-responsive")
    expect(subject).to render_template("users/show")
    expect(rendered).to include(user.name)
    expect(rendered).to include(user.email)
    expect(rendered).to include(user.phone)
    expect(rendered).to include(user.address)
  end
end
