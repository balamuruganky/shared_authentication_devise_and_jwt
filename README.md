Here's the deal!!!!
===================

  - Web application shall create a shared authentication platform with Devise for both API and non-API usage.
  - Web application shall handle 4 type of users.
      - Guest user (No login required)
      - Clients (Login required and allowed to deal with some models)
      - Supervisior (Login required and allowed to view, export all the records. No create and delete is allowed)
      - Super admin (Full control including record deletion through rails-admin dashboard)
  - Super admin shall create user and user can reset password or access forgot password option.

Gems used:
----------
Authentication

	- devise
	- devise-jwt
	- cancancan
	- rack-cors
Dashboard

	- rails_admin
UI

	- jquery-rails
	- toastr-rails
	- devise-i18n
	- gravatar_image_tag
	- font-awesome-sass
	- bootstrap

Setup:
------
	- Rails version : 6.0.2.2
	- Ruby version  : 2.6.3
	- Database	  : sqlite3

Development environment setup
------------------------------

	- yarn install --check-files
	- rake db:drop
	- rake db:create
	- rake db:migrate
	- rake db:seed
	- rake assets:precompile

Start the appilcation
----------------------
rails s

Default credentials
--------------------
Super Admin

	- Usename  : test_admin@mydomain.com
	- Password : default
Client

	- Username : test@mydomain.com
	- Password : default
Supervisor

	- Username : test_supervisor@mydomain.com
	- Password : default

Setup email credential (for dev puposes only)
----------------------------------------------
	- EDITOR="vim --wait" rails credentials:edit --environment development

Edit the below content as per your gmail creditials. Gmail is used as SMTP gateway.

	gmail:
	  mail_username: your_email_id@gmail.com
	  mail_password: your_password

Turn on Gmail "Less secure app access" to use Gmail as gateway. For more details, please go through this (https://support.google.com/cloudidentity/answer/6260879?hl=en). Please note, "Your account is vulnerable because you allow apps and devices that use less secure sign-in technology to access your account." (Copied from Google).

Testing:
--------

To open the website : http://127.0.0.1:3000 

API test using CuRL
-------------------

	Sign in
	-------
	curl -X POST -v -H 'Content-Type: application/json' http://127.0.0.1:3000/api/auth/sign_in -d '{"user" : {"email": "test_admin@mydomain.com", "password": "default" }}'

	Access Customers.json
	----------------------
	curl -X GET -v -H 'Content-Type: application/json' -H 'Authorization: Bearer <Token returned from sign_in api>' http://127.0.0.1:3000/api/v1/customers

	Sign out
	--------
	curl -X DELETE -v -H 'Content-Type: application/json' http://127.0.0.1:3000/api/auth/sign_out -d '{"authenticity_token" : "<Token returned from sign_in api>" }'

	Note : Replace the token returned from 'api/auth/sign_in' to <Token returned from sign_in api>

API test using AJAX
--------------------

      Sign in
      -------
      $.ajax({
        type: "POST",
        dataType: "json",
        url: "http://127.0.0.1:3000/api/auth/sign_in",
        data: {
          user: {
            email: "test@mydomain.com",
            password: "default"
          }
        },
        success: function(data, textStatus, request) {
          localStorage.token = data.token;
          console.log('Got a token from the server! Token: ' + data.resource.email + " " + localStorage.token);
        },
        error: function() {
          alert("Login Failed");
        }
      });

      Access Customers.json
      ---------------------

      $.ajax({
        type: 'GET',
        url: 'http://127.0.0.1:3000/api/v1/customers',
        beforeSend: function(xhr) {
          if (localStorage.token) {
            xhr.setRequestHeader('Authorization', 'Bearer ' + localStorage.token);
          }
        },
        success: function(data) {
          console.log('Hello ' + JSON.stringify(data) + '! You have successfully accessed to /api/v1/customers.');
        },
        error: function() {
          alert("Sorry, you are not logged in.");
        }
      });

      Sign out
      --------

      $.post(
          "http://127.0.0.1:3000/api/auth/sign_out",
          {
              'authenticity_token': localStorage.token,
              '_method': 'DELETE'
          }
      ).done(function(data) {
          localStorage.clear();
          console.log('sign_out status : ' + data.status);
      }).fail(function() {
          alert("Logout Failed");
      });

Please use the html file, available in "misc_test" folder for AJAX based API test.

TODOs:
------
	*) Dockerize the application for development environment
	*) Dockerize the production application with heroku support
