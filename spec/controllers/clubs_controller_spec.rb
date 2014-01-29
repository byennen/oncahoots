require 'spec_helper'

describe ClubsController do

  #describe 'GET show' do
  #
  #  let(:university) { FactoryGirl.create(:university) }
  #  let(:club)       { FactoryGirl.create(:club, university_id: university.id) }
  #  let(:user)       { FactoryGirl.create(:user, university_id: university.id) }
  #  let!(:membership) { Membership.create(club_id: club.id, user_id: user.id) }
  #
  #  before do
  #    sign_in user
  #    get :show, id: club.slug, university_id: university.id
  #  end
  #
  #  it "should assign university" do
  #    expect(assigns(:university)).to eq(university)
  #  end
  #
  #  it "should assign club" do
  #    expect(assigns(:club)).to eq(club)
  #  end
  #
  #  it "should assign members" do
  #    expect(assigns(:members)).to eq([user])
  #  end
  #
  #  it "should assign build a new membership" do
  #    expect(assigns(:membership)).to be_a_new(Membership)
  #  end
  #
  #  it "should render the show template" do
  #    expect(response).to render_template('show')
  #  end
  #
  #end
  #
  #
  #describe 'GET new' do
  #
  #  context 'with valid user' do
  #
  #    let!(:university) { FactoryGirl.create(:university) }
  #    let!(:user)       { FactoryGirl.create(:user, university_id: university.id) }
  #
  #    before do
  #      sign_in user
  #      get :new, university_id: university.id
  #    end
  #
  #    it "should assign university" do
  #      expect(assigns(:university)).to eq(university)
  #    end
  #
  #    it "should assign a new club" do
  #      expect(assigns(:club)).to be_a_new(Club)
  #    end
  #
  #    it "should render the new template" do
  #      expect(response).to render_template(:new)
  #    end
  #
  #  end
  #
  #  context 'with invalid user' do
  #
  #  end
  #
  #end
  #
  #describe 'POST create' do
  #
  #  let!(:university) { FactoryGirl.create(:university) }
  #  let!(:user)       { FactoryGirl.create(:user, university_id: university.id) }
  #
  #  before do
  #    sign_in user
  #    post :create, university_id: university.id, club: {name: 'My Sharona', category: 'Music', description: 'For The Knack Fans'}
  #  end
  #
  #  it "should assign university" do
  #    expect(assigns(:university)).to eq(university)
  #  end
  #
  #  it "should assign club" do
  #    expect(assigns(:club)).to_not be_a_new(Club)
  #  end
  #
  #  #js is being used to do the save. Commenting this out for now. -Lance
  #  #it "should redirect to club show page" do
  #  #  expect(response).to redirect_to(university_club_path(university, assigns(:club)))
  #  #end
  #end
end
