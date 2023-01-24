# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User', type: :system do

	scenario "sign in" do
		user = User.create(email: "rspec@test.ru", password: "Mm12345678")
		# visit new_user_session_path # переходим на страницы ввода
		visit root_path
		visit 'users/sign_in'

		fill_in "user_email", with: user.email
		fill_in "user_password", with: user.password

		find('#my-btn').click
		expect(current_path).to eql("/users/sign_in")

	end

	scenario "sign in incorrect password" do
		user = User.create(email: "rspec@test.ru", password: "Mm12345678")
		visit 'users/sign_in'

		fill_in "user_email", with: user.email
		fill_in "user_password", with: "m123456789"

		find('#my-btn').click
		expect(page).to have_text('Invalid Email or password.')
	end

	scenario "sign in incorrect email" do
		user = User.create(email: "rspec@test.ru", password: "Mm12345678")
		visit 'users/sign_in'

		fill_in "user_email", with: "rspeccc@test.ru"
		fill_in "user_password", with: user.password

		find('#my-btn').click
		expect(page).to have_text('Invalid Email or password.')
	end

	scenario "sign up" do
		visit root_path
		visit 'users/sign_up'

		fill_in "user_email", with: "rspec1@test.ru"
		fill_in "user_password", with: "Mm12345678"
		fill_in "user_password_confirmation", with: "Mm12345678"

		find('#my-btn').click
		expect(current_path).to eql(root_path)
	end

	scenario "sign up already been created user" do
		user = User.create(email: "rspec1@test.ru", password: "Mm12345678")

		visit root_path
		visit 'users/sign_up'

		fill_in "user_email", with: "rspec1@test.ru"
		fill_in "user_password", with: "Mm12345678"
		fill_in "user_password_confirmation", with: "Mm12345678"

		find('#my-btn').click
		expect(page).to have_text('Email has already been taken')
	end

	scenario "sign up no match passwords" do
		visit root_path
		visit 'users/sign_up'

		fill_in "user_email", with: "rspec1@test.ru"
		fill_in "user_password", with: "Mm12345678"
		fill_in "user_password_confirmation", with: "Mm123456789"

		find('#my-btn').click
		expect(page).to have_text("Password confirmation doesn't match Password")
	end

	scenario "sign up short password" do
		visit root_path
		visit 'users/sign_up'

		fill_in "user_email", with: "rspec1@test.ru"
		fill_in "user_password", with: "Mm12"
		fill_in "user_password_confirmation", with: "Mm12"

		find('#my-btn').click
		expect(page).to have_text('Password is too short (minimum is 6 characters)')
	end

	scenario "sign up password without A-Z" do
		visit root_path
		visit 'users/sign_up'

		fill_in "user_email", with: "rspec1@test.ru"
		fill_in "user_password", with: "m12345678"
		fill_in "user_password_confirmation", with: "m12345678"

		find('#my-btn').click
		expect(page).to have_text('Password : Пароль должен содержать хотя бы один прописной символ')
	end

	scenario "sign up password without a-z" do
		visit root_path
		visit 'users/sign_up'

		fill_in "user_email", with: "rspec1@test.ru"
		fill_in "user_password", with: "M12345678"
		fill_in "user_password_confirmation", with: "M12345678"

		find('#my-btn').click
		expect(page).to have_text('Password : Пароль должен содержать хотя бы один строчный символ')
	end

	scenario "sign up password numbers" do
		visit root_path
		visit 'users/sign_up'

		fill_in "user_email", with: "rspec1@test.ru"
		fill_in "user_password", with: "password"
		fill_in "user_password_confirmation", with: "password"

		find('#my-btn').click
		expect(page).to have_text('Password : Пароль должен содержать хотя бы одну цифру')
	end

	scenario "sign up password numbers" do
		visit root_path
		visit 'users/sign_up'

		fill_in "user_email", with: "rspec1@test.ru"
		fill_in "user_password", with: "Mm12345678 "
		fill_in "user_password_confirmation", with: "Mm12345678 "

		find('#my-btn').click
		expect(page).to have_text('Password : Пробел не допустим в начале или конце строки')
	end

	scenario "sign up password numbers" do
		visit root_path
		visit 'users/sign_up'

		fill_in "user_email", with: ""
		fill_in "user_password", with: "Mm12345678 "
		fill_in "user_password_confirmation", with: "Mm12345678 "

		find('#my-btn').click
		expect(page).to have_text("Email can't be blank")
	end

end