module Features
  module SessionHelpers
    require 'vcr'

    def sign_in_leader
      VCR.use_cassette("leader_sign_in") do
        visit new_session_path
        fill_in 'user_username', with: "leader@example.com"
        fill_in 'user_password', with: "password"
        click_on 'Sign In'
      end
    end

    def sign_in_editor
      VCR.use_cassette("editor_sign_in") do
        visit new_session_path
        fill_in 'user_username', with: "editor@example.com"
        fill_in 'user_password', with: "password"
        click_on 'Sign In'
      end
      @user = User.find_by(email: "editor@example.com")
      @user.editor = true
      @user.save
    end

    def sign_in_admin
      VCR.use_cassette("admin_sign_in") do
        visit new_session_path
        fill_in 'user_username', with: "admin@example.com"
        fill_in 'user_password', with: "password"
        click_on 'Sign In'
      end
      @user = User.find_by(email: "admin@example.com")
      @user.admin = true
      @user.save
    end

    def sign_in_superadmin
      VCR.use_cassette("superadmin_sign_in") do
        visit new_session_path
        fill_in 'user_username', with: "superadmin@example.com"
        fill_in 'user_password', with: "password"
        click_on 'Sign In'
      end
      @user = User.find_by(email: "superadmin@example.com")
      @user.superadmin = true
      @user.save
    end

    def trigger_event_for(selector, event)
      raise "Please supply a selector" if selector.blank?
      sleep 0.5
      if Capybara.javascript_driver == :selenium
        page.execute_script %Q{ $('#{selector}').trigger("#{event}") }
      end
      if Capybara.javascript_driver == :webkit
        page.find(selector).trigger(event.to_sym)
      end
      sleep 0.5
    end

  end
end
