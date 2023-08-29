require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '正常に登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = 'test1234'
        @user.password_confirmation = 'test1234'
        expect(@user).to be_valid
      end
      it 'first_nameとlast_nameが全角であれば登録できる' do
        @user.first_name = '山田'
        @user.last_name = '隆太郎'
        expect(@user).to be_valid
      end
      it 'first_name_kanaとlast_name_kanaが全角カタカナであれば登録できる' do
        @user.first_name_kana = 'ヤマダ'
        @user.last_name_kana = 'リクタロウ'
        expect(@user).to be_valid
      end
    end

    context '新規登録出来ない時' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end
      it 'passwordが数字だけだと登録できない' do
        @user.password = '11111111'
        @user.password_confirmation = '11111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'passwordが英字だけだと登録できない' do
        @user.password = 'aaaaaaaa'
        @user.password_confirmation = 'aaaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'first_nameがない場合は登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'last_nameがない場合は登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'first_nameが半角英字の場合は登録できない' do
        @user.first_name = 'aaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name 全角文字を使用してください')
      end
      it 'last_nameが半角英字の場合は登録できない' do
        @user.last_name = 'aaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name 全角文字を使用してください')
      end
      it 'first_name_kanaがない場合は登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'last_name_kanaがない場合は登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'first_name_kanaが漢字だと登録できない' do
        @user.first_name_kana = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana 全角カタカナを使用してください')
      end
      it 'last_name_kanaが漢字だと登録できない' do
        @user.last_name_kana = '隆太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana 全角カタカナを使用してください')
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
