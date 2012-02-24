require 'spec_helper'

describe InstitutionClassesController do

  context 'for user' do

    before(:each) do
      @institution_class = FactoryGirl.create(:institution_class)
      @institution_kind = FactoryGirl.create(:institution_kind, :institution_class => @institution_class)
      @parameter = FactoryGirl.create(:parameter, :institution_kind => @institution_kind)
    end

    describe 'GET index' do
      before(:each) do
        get :index
      end

      it 'should be successful' do
        response.should be_success
      end

      it 'should contain institution classes items' do
        assigns[:institution_classes].should_not be_blank
      end

      it 'should contain one institution classes items' do
        assigns[:institution_classes].size.should be_equal 1
      end

      it 'should render institution_classes/index view' do
        response.should render_template('institution_classes/index')
      end
    end

    describe 'GET edit' do
      before(:each) do
        get :edit, :id => @institution_class.id
      end

      it 'should render institution_classes/edit setting' do
        response.should render_template('institution_classes/edit')
      end

      it 'should contain @institution_class object' do
        assigns[:institution_class].id.should equal @institution_class.id
      end
    end

    describe 'GET show' do
      before(:each) do
        get :show, :id => @institution_class.id
      end

      it 'should render institution_classes/show setting' do
        response.should render_template('institution_classes/show')
      end

      it 'should contain @institution_class object' do
        assigns[:institution_class].id.should equal @institution_class.id
      end
    end

    describe 'GET new' do
      before(:each) do
        get :new
      end

      it 'should be successful' do
        response.should be_success
      end

      it 'should render institution_classes/new template' do
        response.should render_template('institution_classes/new')
      end
    end

    describe 'POST update' do
      before(:each) do
        post :update, :id => @institution_class.id, :institution_class => {:title => 'Updated!'}
      end

      it 'should redirect to institution class show path' do
        response.should redirect_to("/institution_classes/#{@institution_class.id}")
      end

      it 'should update institution class title' do
        @institution_class.reload.title.should == 'Updated!'
      end
    end

    describe 'POST create' do
      def do_post
        post :create, { :institution_class => {:title => "New Class" } }
      end

      it 'should redirect to institution class show path' do
        do_post
        response.should redirect_to("/institution_classes/#{InstitutionClass.last.id}")
      end

      it 'should create one more institution class item' do
        lambda { do_post }.should change{ InstitutionClass.count }.by(1)
      end
    end

    describe 'DELETE object' do
      def do_delete
        delete :destroy, :id => @institution_class.id
      end

      it 'should redirect to collections list path' do
        do_delete
        response.should redirect_to("/institution_classes")
      end

      it 'should delete one institution class item' do
        lambda { do_delete }.should change{ InstitutionClass.count }.by(-1)
      end

      it 'should delete nested institution kind item' do
        lambda { do_delete }.should change{ InstitutionKind.count }.by(-1)
      end

      it 'should delete nested parameter item' do
        lambda { do_delete }.should change{ Parameter.count }.by(-1)
      end

    end

  end

end