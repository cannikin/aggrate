require 'test_helper'

class GooglePostsControllerTest < ActionController::TestCase
  setup do
    @google_post = google_posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:google_posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create google_post" do
    assert_difference('GooglePost.count') do
      post :create, google_post: @google_post.attributes
    end

    assert_redirected_to google_post_path(assigns(:google_post))
  end

  test "should show google_post" do
    get :show, id: @google_post.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @google_post.to_param
    assert_response :success
  end

  test "should update google_post" do
    put :update, id: @google_post.to_param, google_post: @google_post.attributes
    assert_redirected_to google_post_path(assigns(:google_post))
  end

  test "should destroy google_post" do
    assert_difference('GooglePost.count', -1) do
      delete :destroy, id: @google_post.to_param
    end

    assert_redirected_to google_posts_path
  end
end
