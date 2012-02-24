require 'spec_helper'

describe InstitutionsController do

  context 'for user' do

    before(:each) do
      @institution_class = FactoryGirl.create(:institution_class)
      @institution_kind = FactoryGirl.create(:institution_kind, :institution_class => @institution_class)
      @parameter = FactoryGirl.create(:parameter, :institution_kind => @institution_kind)
      @institution = FactoryGirl.create(:institution)
      @kind = FactoryGirl.create(:kind, :institution => @institution, :institution_kind => @institution_kind)
      @parameter_string = FactoryGirl.create(:parameter_string, :kind => @kind, :parameter => @parameter)
    end

    describe 'GET index' do
      before(:each) do
        get :index
      end

      it 'should be successful' do
        response.should be_success
      end

      it 'should contain institution items' do
        assigns[:institutions].should_not be_blank
      end

      it 'should contain one institution items' do
        assigns[:institutions].size.should be_equal 1
      end

      it 'should render institutions/index view' do
        response.should render_template('institutions/index')
      end
    end

    describe 'GET edit' do
      before(:each) do
        get :edit, :id => @institution.id
      end

      it 'should render institutions/edit setting' do
        response.should render_template('institutions/edit')
      end

      it 'should contain @institution object' do
        assigns[:institution].id.should equal @institution.id
      end
    end

    describe 'GET show' do
      before(:each) do
        get :show, :id => @institution.id
      end

      it 'should render institutions/show setting' do
        response.should render_template('institutions/show')
      end

      it 'should contain @institution object' do
        assigns[:institution].id.should equal @institution.id
      end
    end

    describe 'GET new' do
      before(:each) do
        get :new
      end

      it 'should be successful' do
        response.should be_success
      end

      it 'should render institutions/new template' do
        response.should render_template('institutions/new')
      end
    end

    describe 'POST update' do
      before(:each) do
        post :update, :id => @institution.id, :institution => {:title => 'Updated!', :address => 'New Address'}
      end

      it 'should redirect to institution show path' do
        response.should redirect_to("/institutions/#{@institution.id}")
      end

      it 'should update institution title' do
        @institution.reload.title.should == 'Updated!'
      end

      it 'should update institution address' do
        @institution.reload.address.should == 'New Address'
      end
    end

    describe 'POST create' do
      def do_post
        post :create, { :institution => {:title => "New Class", :address => "New Address" } }
      end

      it 'should redirect to institution show path' do
        do_post
        response.should redirect_to("/institutions/#{Institution.last.id}")
      end

      it 'should create one more institution item' do
        lambda { do_post }.should change{ Institution.count }.by(1)
      end
    end

    describe 'DELETE object' do
      def do_delete
        delete :destroy, :id => @institution.id
      end

      it 'should redirect to collections list path' do
        do_delete
        response.should redirect_to("/institutions")
      end

      it 'should delete one institution item' do
        lambda { do_delete }.should change{ Institution.count }.by(-1)
      end

      it 'should delete nested kind item' do
        lambda { do_delete }.should change{ Kind.count }.by(-1)
      end

      it 'should delete nested parameter string item' do
        lambda { do_delete }.should change{ ParameterString.count }.by(-1)
      end

    end

  end

end