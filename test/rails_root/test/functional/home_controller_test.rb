require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  def test_index_action
    get :index
    assert_response :success
    assert_template 'index'
  end

  def test_markup_on_index
    get :index
    assert_select 'div.milestone1'
    assert_select 'div.milestone2'
  end

  def test_javascript_includes
    get :index
    %w(jquery jquery-ui jrails).each do |jslib|
      assert_select 'script[src=?]', /.*#{jslib}.*/
    end
  end
  
  def test_milestone_helper_output
    Thoughtbot::MileMarker.environments = ['development']
    ENV['RAILS_ENV']="development"
    get :index
    assert_select 'div.milestone1[mile=?]', 'Milestone 1'
    assert_select 'div.milestone2[mile=?]', 'Milestone 2'
  end
end
