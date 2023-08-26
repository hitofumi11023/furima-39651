require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
 
  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "内容に問題なければ登録できる" do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it "nicknameが空だと登録できない" do
        @user.nickname = nil
        @user.valid?

        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "emailに@がないと登録できない" do
        @user.email = "furima39651.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "重複したemailが存在すれば登録できない" do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "passwordが空では登録できない" do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが5文字以下であれば登録できない" do
        @user.password = "12345"
        @user.password_confirmation = "12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordが英字のみであれば登録できない" do
        @user.password = "aaaaaa"
        @user.password_confirmation = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password パスワードは6文字以上の半角英数字で入力してください")
      end
      it "passwordが数字のみであれば登録できない" do
        @user.password = "000000"
        @user.password_confirmation = "000000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password パスワードは6文字以上の半角英数字で入力してください")
      end
      it "passwordが全角文字を含むものであれば登録できない" do
        @user.password = "Ａaaaaa"
        @user.password_confirmation = "Ａaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password パスワードは6文字以上の半角英数字で入力してください")
      end
      it "passwordとpassword_confirmationが不一致では登録できない" do
        @user.password = "123456"
        @user.password_confirmation = "1234567"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "名字が空だと登録できない" do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it "名前が空だと登録できない" do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it "名字は全角（漢字・ひらがな・カタカナ）でなければ登録できない" do
        @user.first_name = "kana"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name 名前は全角で入力してください")
      end
      it "名前は全角（漢字・ひらがな・カタカナ）でなければ登録できない" do
        @user.last_name = "kana"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name 名字は全角で入力してください")
      end
      it "フリガナ（名字）が空だと登録できない" do
        @user.first_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it "フリガナ（名前）が空だと登録できない" do
        @user.last_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it "名字のフリガナは全角（カタカナ）でなければ登録できない" do
        @user.first_name_kana = "かな"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 名前（カナ）は全角（カタカナ）で入力してください")
      end
      it "名前のフリガナは全角（カタカナ）でなければ登録できない" do
        @user.last_name_kana = "かな"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana 名字（カナ）は全角（カタカナ）で入力してください")
      end
      it "生年月日が空だと登録できない" do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
