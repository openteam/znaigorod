require 'spec_helper'

describe KindsController do

  context 'for user' do

    before(:each) do
      @institution_class = FactoryGirl.create(:institution_class)
      @institution_kind = FactoryGirl.create(:institution_kind, :institution_class => @institution_class)
      @institution_kind2 = FactoryGirl.create(:institution_kind, :institution_class => @institution_class, :title => 'kind2')
      @parameter = FactoryGirl.create(:parameter, :institution_kind => @institution_kind)
      @parameter2 = FactoryGirl.create(:parameter, :institution_kind => @institution_kind2, :title => 'attr2')
      @institution = FactoryGirl.create(:institution)
      @kind = FactoryGirl.create(:kind, :institution => @institution, :institution_kind => @institution_kind)
      @parameter_string = FactoryGirl.create(:parameter_string, :kind => @kind, :parameter => @parameter)
    end

    describe 'GET edit' do
      before(:each) do
        get :edit, :institution_id => @institution, :id => @kind.id
      end

      it 'should render kinds/edit setting' do
        response.should render_template('kinds/edit')
      end

      it 'should contain @kind object' do
        assigns[:kind].id.should equal @kind.id
      end
    end

    describe 'GET show' do
      before(:each) do
        get :show, :institution_id => @institution, :id => @kind.id
      end

      it 'should render kinds/show setting' do
        response.should render_template('kinds/show')
      end

      it 'should contain @kind object' do
        assigns[:kind].id.should equal @kind.id
      end
    end

    describe 'GET new' do
      before(:each) do
        get :new, :institution_id => @institution, :institution_kind => @institution_kind.id
      end

      it 'should be successful' do
        response.should be_success
      end

      it 'should render kinds/new template' do
        response.should render_template('kinds/new')
      end
    end

    describe 'POST update' do
      before(:each) do
        post :update, :id => @kind.id, :institution_id => @institution, :parameter  => {"string" => {@parameter.id.to_s => 'value'}  }
      end

      it 'should redirect to institution show path' do
        response.should redirect_to("/institutions/#{@institution.id}")
      end

      it 'should update kind parameter' do
        @parameter_string.reload.value.should == 'value'
      end
    end

    describe 'POST create' do
      def do_post
        post :create, :institution_kind => @institution_kind2, :institution_id => @institution, :parameter  => {"string" => {@parameter2.id.to_s => 'new value2'}  }
      end

      it 'should redirect to institution show path' do
        do_post
        response.should redirect_to("/institutions/#{Institution.last.id}")
      end

      it 'should create one more kind item' do
        lambda { do_post }.should change{ Kind.count }.by(1)
      end

      it 'should create one more attribute item' do
        lambda { do_post }.should change{ ParameterString.count }.by(1)
      end
    end

    describe 'DELETE object' do
      def do_delete
        delete :destroy, :institution_id => @institution.id, :id => @kind.id
      end

      it 'should redirect to institution show path' do
        do_delete
        response.should redirect_to("/institutions/#{Institution.last.id}")
      end

      it 'should delete one kind item' do
        lambda { do_delete }.should change{ Kind.count }.by(-1)
      end

      it 'should delete nested parameter item' do
        lambda { do_delete }.should change{ ParameterString.count }.by(-1)
      end

    end

  end

end