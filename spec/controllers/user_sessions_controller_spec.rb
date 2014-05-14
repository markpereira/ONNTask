require 'spec_helper'

describe UserSessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success  
    end

    it "renders the new template" do
      get 'new'
      expect(response).to render_template('new')
    end  
  end

  describe "POST 'create'" do
      context "with correct credentials" do
        let!(:user){User.create(first_name: "Tom", last_name: "Tester", email: "tom@tester.com", password: "password", password_confirmation: "password")}
        
        it "redirects to the todo list path" do  
          post :create, email: "tom@tester.com", password: "password"
          expect(response).to be_redirect
          expect(response).to redirect_to(todo_lists_path)
        end

        it "finds the user" do
          expect(User).to receive(:find_by).with({email: "tom@tester.com"}).and_return(user)
          post :create, email: "tom@tester.com", password: "password"
        end  


        it "authenticates the user" do
          User.stub(:find_by).and_return(user) #get Joel to explain this (stubbing the user class - and where else you would use it)
          expect(user).to receive(:authenticate)
          post :create, email: "tom@tester.com", password: "password"        
        end 

        it "sets the user_id in the session" do
          post :create, email: "tom@tester.com", password: "password"
          expect(session[:user_id]).to eq(user.id)
        end 
      
        it "sets the flash success message" do
          post :create, email: "tom@tester.com", password: "password" 
          expect(flash[:success]).to eq("Thanks for logging in!")
        end  
      end  

      share_examples_for "denied login" do
         it "renders the new template" do
          post :create, email: email, password: password
          expect(response).to render_template('new')
        end 

        it "sets the flash error message" do
          post :create, email: email, password: password
          expect(flash[:error]).to eq("There was a problem logging in. Please check your email and password")
        end 
      end  

      context "with blank credentials" do
        let(:email) {""}
        let(:password) {""}
        it_behaves_like "denied login" 
      end  

      context "with an incorrect password" do
        let!(:user){User.create(first_name: "Tom", last_name: "Tester", email: "tom@tester.com", password: "password", password_confirmation: "password")}
        let(:email) {user.email}
        let(:password) {"incorrect"}
        it_behaves_like "denied login"
      end  

      context "with no email in existence" do
        let(:email) {"noemail@tester.com"}
        let(:password) {"incorrect"}
        it_behaves_like "denied login"
      end  
  end

end
