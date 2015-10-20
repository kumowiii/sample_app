module SessionsHelper

	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token 				 # クッキーの期限を20年後に設定してローカル変数remember_tokenを保存
		user.update_attribute(:remember_token, User.encrypt(remember_token)) # update_attribute: データベースを更新、単一の属性を更新できる。
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)		 # @current_userが未定義の場合にのみ@current_userインスタンス変数に記憶トークンを設定
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end
end
