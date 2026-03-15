require "test_helper"

class PostsControllerTest < BaseTestController
  setup do
    @user = users(:one)
    @post = posts(:one)
  end

  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@user)
    get new_user_post_url(@user)
    assert_response :success
  end

  test "should create post" do
    sign_in_as(@user)
    assert_difference("Post.count") do
      post user_posts_url(@user), params: { post: { title: "A Brand New Post Title", description: "A valid description here", content: "Content that is long enough to be valid here" } }
    end
    assert_redirected_to post_url(Post.find_by(title: "A Brand New Post Title"))
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(@user)
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    sign_in_as(@user)
    patch user_post_url(@user, @post), params: { post: { content: @post.content, description: @post.description, title: @post.title } }
    assert_redirected_to post_url(@post)
  end

  test "should destroy post" do
    sign_in_as(@user)
    assert_difference("Post.count", -1) do
      delete user_post_url(@user, @post)
    end
    assert_redirected_to user_posts_url(@user)
  end
end
