require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe SitePageKeystoresController do

  # This should return the minimal set of attributes required to create a valid
  # SitePageKeystore. As you add validations to SitePageKeystore, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "site_page" => "" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SitePageKeystoresController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all site_page_keystores as @site_page_keystores" do
      site_page_keystore = SitePageKeystore.create! valid_attributes
      get :index, {}, valid_session
      assigns(:site_page_keystores).should eq([site_page_keystore])
    end
  end

  describe "GET show" do
    it "assigns the requested site_page_keystore as @site_page_keystore" do
      site_page_keystore = SitePageKeystore.create! valid_attributes
      get :show, {:id => site_page_keystore.to_param}, valid_session
      assigns(:site_page_keystore).should eq(site_page_keystore)
    end
  end

  describe "GET new" do
    it "assigns a new site_page_keystore as @site_page_keystore" do
      get :new, {}, valid_session
      assigns(:site_page_keystore).should be_a_new(SitePageKeystore)
    end
  end

  describe "GET edit" do
    it "assigns the requested site_page_keystore as @site_page_keystore" do
      site_page_keystore = SitePageKeystore.create! valid_attributes
      get :edit, {:id => site_page_keystore.to_param}, valid_session
      assigns(:site_page_keystore).should eq(site_page_keystore)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new SitePageKeystore" do
        expect {
          post :create, {:site_page_keystore => valid_attributes}, valid_session
        }.to change(SitePageKeystore, :count).by(1)
      end

      it "assigns a newly created site_page_keystore as @site_page_keystore" do
        post :create, {:site_page_keystore => valid_attributes}, valid_session
        assigns(:site_page_keystore).should be_a(SitePageKeystore)
        assigns(:site_page_keystore).should be_persisted
      end

      it "redirects to the created site_page_keystore" do
        post :create, {:site_page_keystore => valid_attributes}, valid_session
        response.should redirect_to(SitePageKeystore.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved site_page_keystore as @site_page_keystore" do
        # Trigger the behavior that occurs when invalid params are submitted
        SitePageKeystore.any_instance.stub(:save).and_return(false)
        post :create, {:site_page_keystore => { "site_page" => "invalid value" }}, valid_session
        assigns(:site_page_keystore).should be_a_new(SitePageKeystore)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        SitePageKeystore.any_instance.stub(:save).and_return(false)
        post :create, {:site_page_keystore => { "site_page" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested site_page_keystore" do
        site_page_keystore = SitePageKeystore.create! valid_attributes
        # Assuming there are no other site_page_keystores in the database, this
        # specifies that the SitePageKeystore created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        SitePageKeystore.any_instance.should_receive(:update).with({ "site_page" => "" })
        put :update, {:id => site_page_keystore.to_param, :site_page_keystore => { "site_page" => "" }}, valid_session
      end

      it "assigns the requested site_page_keystore as @site_page_keystore" do
        site_page_keystore = SitePageKeystore.create! valid_attributes
        put :update, {:id => site_page_keystore.to_param, :site_page_keystore => valid_attributes}, valid_session
        assigns(:site_page_keystore).should eq(site_page_keystore)
      end

      it "redirects to the site_page_keystore" do
        site_page_keystore = SitePageKeystore.create! valid_attributes
        put :update, {:id => site_page_keystore.to_param, :site_page_keystore => valid_attributes}, valid_session
        response.should redirect_to(site_page_keystore)
      end
    end

    describe "with invalid params" do
      it "assigns the site_page_keystore as @site_page_keystore" do
        site_page_keystore = SitePageKeystore.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        SitePageKeystore.any_instance.stub(:save).and_return(false)
        put :update, {:id => site_page_keystore.to_param, :site_page_keystore => { "site_page" => "invalid value" }}, valid_session
        assigns(:site_page_keystore).should eq(site_page_keystore)
      end

      it "re-renders the 'edit' template" do
        site_page_keystore = SitePageKeystore.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        SitePageKeystore.any_instance.stub(:save).and_return(false)
        put :update, {:id => site_page_keystore.to_param, :site_page_keystore => { "site_page" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested site_page_keystore" do
      site_page_keystore = SitePageKeystore.create! valid_attributes
      expect {
        delete :destroy, {:id => site_page_keystore.to_param}, valid_session
      }.to change(SitePageKeystore, :count).by(-1)
    end

    it "redirects to the site_page_keystores list" do
      site_page_keystore = SitePageKeystore.create! valid_attributes
      delete :destroy, {:id => site_page_keystore.to_param}, valid_session
      response.should redirect_to(site_page_keystores_url)
    end
  end

end
