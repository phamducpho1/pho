require "rails_helper"
RSpec.describe UsersController, type: :controller do
  let(:user) {FactoryGirl.create :user}
  subject {user}

  let(:valid_params) do
    {
      name: "employee name",
      email: "email@gmail.com",
      password: "12345678",
      password_confirmation: "12345678",
      address: "tam ky",
      admin: 1
    }
  end
  let(:invalid_params) do
    {
      name: nil, email: "email", password: "1", password_confirmation: "2",
        address: nil, admin: nil
    }
  end
  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      before {post :create, params: {user: invalid_params}}
      it{expect(assigns :user).to be_a User}
      it{expect(response).to render_template :new}
    end
    context "with valid params" do
      before {post :create, params: {user: valid_params}}
      it{expect(flash[:info]).to match(I18n.t("users_controller.signup"))}
      it{expect(response).to redirect_to(root_url)}
    end
  end

  describe "GET #edit" do
    before{get :edit, params: {id: subject.id}}
    it "assings the requested user to user" do
      expect(assigns(:user)).to eq user
    end
    it "render new view" do
      expect(response).to render_template :edit
    end
  end

  describe "PATCH #update" do
    context "with good data" do
      it "updates the user and redirects" do
        patch :update, params: { id: subject.id, user:{name: "newpho"} }
        expect(flash[:success]).to match(I18n.t("admin.deleted"))
        expect(response).to redirect_to user_path
      end
    end
    context "with bad data" do
      it "updates the user and redirects" do
        patch :update, params: { id: subject.id, user:{name: "newpho", email: "phamducpho14t1@g22mail.com2"} }
        expect(flash[:warning]).to match(I18n.t("admin.notdelete"))
        expect(response).to redirect_to user_path
      end
    end
  end
end
