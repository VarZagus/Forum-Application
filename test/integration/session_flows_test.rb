require 'test_helper'

class SessionFlowsTest < ActionDispatch::IntegrationTest
  test 'unauthorized user will be redirected to login page' do
   
    get new_post_path
    assert_redirected_to controller: :session, action: :login
  end

  test 'user with incorrect credentials will be redirected to login page' do
    post session_create_url, params: { login: 'kek', password: 'kek' }
    assert_redirected_to controller: :session, action: :login
  end

 test 'user with correct credentials will see the root' do
    password = 'kek'

    user = User.create(username: 'lol', password: password, password_confirmation: password, is_admin: false, posts_count: 0)

    post session_create_url, params: { login: user.username, password: password }

    assert_redirected_to controller: :posts, action: :index
  end


  test 'user can logout' do
    password = 'bbb'

    user = User.create(username: 'aaa',password: password, password_confirmation: password)

    post session_create_url, params: { login: user.username, password: password }

    get session_logout_url

    assert_redirected_to controller: :session, action: :login
 end

   test 'not admin can not watch user list' do
     username = 'vvv'
     password = 'vvv'
     user = User.create(username: username, password: password, password_confirmation: password)
     
     post session_create_url, params: { login: user.username, password: password }
     get users_url
     assert_redirected_to controller: :posts, action: :index
   end

   test 'admin can  watch user list' do
    username = 'vvv'
    password = 'vvv'
    user = User.create(username: username, password: password, password_confirmation: password, is_admin: true)
    
    post session_create_url, params: { login: user.username, password: password }
    get users_url
    assert request.url ==  "http://www.example.com/users"
  end

  test 'user can comemnting' do
    username = 'vvv'
    password ='vvv'
    user = User.create(username: username, password: password, password_confirmation: password)
    post session_create_url, params: { login: user.username, password: password }
    post = Post.create(title: 'text', text: 'text', user_id: user.id)
    get "/posts/#{post.id}"
    assert request.url ==  "http://www.example.com/posts/#{post.id}"
    post "/posts/#{post.id}/comment"
    assert_redirected_to post
    
  end

  test 'not logged user can not commenting' do
    username = 'vvv'
    password ='vvv'
    user = User.create(username: username, password: password, password_confirmation: password)
    post = Post.create(title: 'text', text: 'text', user_id: user.id)
    get "/posts/#{post.id}"
    assert request.url ==  "http://www.example.com/posts/#{post.id}"
    post "/posts/#{post.id}/comment"
    assert_redirected_to controller: :session, action: :login
  end

end