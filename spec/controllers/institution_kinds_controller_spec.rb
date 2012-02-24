require 'spec_helper'

describe InstitutionKindsController do

  context 'for user' do

    before(:each) do
      @institution_class = FactoryGirl.create(:institution_class)
      @institution_kind = FactoryGirl.create(:institution_kind, :institution_class => @institution_class)
      @parameter = FactoryGirl.create(:parameter, :institution_kind => @institution_kind)
    end

    describe 'GET edit' do
      before(:each) do
        get :edit, :institution_class_id => @institution_class.id, :id => @institution_kind.id
      end

      it 'should render institution_kinds/edit setting' do
        response.should render_template('institution_kinds/edit')
      end

      it 'should contain @institution_class object' do
        assigns[:institution_kind].id.should equal @institution_kind.id
      end
    end

    describe 'GET show' do
      before(:each) do
        get :show, :institution_class_id => @institution_class.id, :id => @institution_kind.id
      end

      it 'should render institution_kinds/show setting' do
        response.should render_template('institution_kinds/show')
      end

      it 'should contain @institution_class object' do
        assigns[:institution_kind].id.should equal @institution_kind.id
      end
    end

    describe 'GET new' do
      before(:each) do
        get :new, :institution_class_id => @institution_class.id
      end

      it 'should be successful' do
        response.should be_success
      end

      it 'should render institution_kinds/new template' do
        response.should render_template('institution_kinds/new')
      end
    end

    describe 'POST update' do
      before(:each) do
        put :update, :id => @institution_kind.id, :institution_class_id => @institution_kind.institution_class.id, :institution_kind => {:title => 'Updated!'}
      end

      it 'should redirect to institution kind show path' do
        response.should redirect_to("/institution_classes/#{@institution_class.id}/institution_kinds/#{@institution_kind.id}")
      end

      it 'should update institution kind title' do
        @institution_kind.reload.title.should == 'Updated!'
      end
    end

    describe 'POST create' do
      def do_post
        post :create, :institution_class_id => @institution_class.id, :institution_kind => {:title => "New Kind" }
      end

      it 'should redirect to institution kind show path' do
        do_post
        response.should redirect_to("/institution_classes/#{@institution_class.id}/institution_kinds/#{InstitutionKind.last.id}")
      end

      it 'should create one more institution kind item' do
        lambda { do_post }.should change{ InstitutionKind.count }.by(1)
      end
    end

    describe 'DELETE object' do
      def do_delete
        delete :destroy, :institution_class_id => @institution_class.id, :id => @institution_kind.id
      end

      it 'should redirect to collections list path' do
        do_delete
        response.should redirect_to("/institution_classes/#{@institution_class.id}")
      end

      it 'should delete one institution kind item' do
        lambda { do_delete }.should change{ InstitutionKind.count }.by(-1)
      end

      it 'should delete nested parameter item' do
        lambda { do_delete }.should change{ Parameter.count }.by(-1)
      end

    end

  end

end