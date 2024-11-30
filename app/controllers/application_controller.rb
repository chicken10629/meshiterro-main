class ApplicationController < ActionController::Base
  #before_action :authenticate_user!, except: [:top], unless: :admin_controller? #adminコントローラーの場合を除外。admin_controller?は下に記述
  #上記authenticate_user!回避。
  #applicationコントローラーに書いちゃったので、
  #全コントローラーで一般ユーザーの認証が必要になってしまっている
  
  #self.classはそのオブジェクトがどのクラスに属しているか取得=>このコントローラークラスを参照
  #module_parent_nameは現在のクラスがどのモジュールを親に持つか、文字列を返す=>Admin
  #つまりコントローラーの親がAdminであるか？完全に一致するか確認する
  
  #authenticate_admin!の記述もこちらに書かないと、向こうのコントローラー一つ一つ書かないといけなくなるので
  #if文で場合分けする
  before_action :configure_authentication

  private

  def configure_authentication
    if admin_controller?
      authenticate_admin!
    else
      authenticate_user! unless action_is_public?
    end
  end
  #adminコントローラーだった場合、adminでログインしていないとadmin認証を求められる（ログイン画面に飛ばす）
  #userコントローラーだった場合、homes/topを除きuserでログインしていないとユーザー認証を求められる

  def admin_controller?
    self.class/module_parent_name == 'Admin'
  end

  def action_is_public?
    controller_name == 'homes' && action_name == 'top'
  end

end
