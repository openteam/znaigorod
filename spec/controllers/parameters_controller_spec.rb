require 'spec_helper'

describe ParametersController do

  context 'for user' do

    before(:each) do
      @institution_class = FactoryGirl.create(:institution_class)
      @institution_kind = FactoryGirl.create(:institution_kind, :institution_class => @institution_class)
      @parameter = FactoryGirl.create(:parameter, :institution_kind => @institution_kind)
    end

    describe 'GET edit' do
      before(:each) do
        get :edit, :institution_class_id => @institution_class.id, :institution_kind_id => @institution_kind.id, :id => @parameter.id
      end

      it 'should render parameters/edit' do
        response.should render_template('parameters/edit')
      end

      it 'should contain @parameter object' do
        assigns[:parameter].id.should equal @parameter.id
      end
    end

    describe 'GET show' do
      before(:each) do
        get :show, :institution_class_id => @institution_class.id, :institution_kind_id => @institution_kind.id, :id => @parameter.id
      end

      it 'should render parameters/show' do
        response.should render_template('parameters/show')
      end

      it 'should contain @parameter object' do
        assigns[:parameter].id.should equal @parameter.id
      end
    end

    describe 'GET new' do
      before(:each) do
        get :new, :institution_class_id => @institution_class.id, :institution_kind_id => @institution_kind.id
      end

      it 'should be successful' do
        response.should be_success
      end

      it 'should render parameters/new template' do
        response.should render_template('parameters/new')
      end
    end

    describe 'POST update' do
      before(:each) do
        put :update, :institution_class_id => @institution_class.id, :institution_kind_id => @institution_kind.id, :id => @parameter.id, :parameter => {:title => 'Updated!', :kind => 'boolean'}
      end

      it 'should redirect to parameter show path' do
        response.should redirect_to("/institution_classes/#{@institution_class.id}/institution_kinds/#{@institution_kind.id}")
      end

      it 'should update parameter title' do
        @parameter.reload.title.should == 'Updated!'
      end

      it 'should not update parameter kind' do
        @parameter.reload.kind.should == 'string'
      end
    end

    describe 'POST create' do
      def do_post
        post :create, :institution_class_id => @institution_class.id, :institution_kind_id => @institution_kind.id, :id => @parameter.id, :parameter => {:title => "New Parameter", :kind =>'string' }
      end

      it 'should redirect to parameter show path' do
        do_post
        response.should redirect_to("/institution_classes/#{@institution_class.id}/institution_kinds/#{InstitutionKind.last.id}")
      end

      it 'should create one more parameter item' do
        lambda { do_post }.should change{ Parameter.count }.by(1)
      end
    end

    describe 'DELETE object' do
      def do_delete
        delete :destroy, :institution_class_id => @institution_class.id, :institution_kind_id => @institution_kind.id, :id => @parameter.id
      end

      it 'should redirect to collections list path' do
        do_delete
        response.should redirect_to("/institution_classes/#{@institution_class.id}/institution_kinds/#{InstitutionKind.last.id}")
      end

      it 'should delete one parameter item' do
        lambda { do_delete }.should change{ Parameter.count }.by(-1)
      end
    end

  end

end