require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_address = FactoryBot.build(:purchase_address, user_id: user.id, item_id: item.id)
  end
  
  describe '商品購入情報の保存' do
    context '商品購入情報に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_address).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @purchase_address.building = ''
        expect(@purchase_address).to be_valid
      end
    end
    context '商品購入情報に問題がある場合' do
      it 'user_idが空だと保存できないこと' do
        @purchase_address.user_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Userを入力してください")
      end
      it 'item_idが空だと保存できないこと' do
        @purchase_address.item_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Itemを入力してください")
      end
      it 'postal_codeが空だと保存できないこと' do
        @purchase_address.postal_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal codeは不正な値です")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @purchase_address.postal_code = '1231234'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal codeは不正な値です")
      end
      it 'prefecture.idを選択していないと保存できないこと' do
        @purchase_address.prefecture_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefectureを入力してください")
      end
      it 'cityが空だと保存できないこと' do
        @purchase_address.city = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Cityを入力してください")
      end
      it 'addressesが空だと保存できないこと' do
        @purchase_address.addresses = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Addressesを入力してください")
      end
      it 'phone_numberが空だと保存できないこと' do
        @purchase_address.phone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone numberを入力してください", "Phone numberは不正な値です")
      end
      it 'phone_numberがハイフンがあると保存できないこと' do
        @purchase_address.phone_number = '0000-00-0000'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone numberは不正な値です")
      end
      it 'phone_numberが10桁以上でないと保存できないこと' do
        @purchase_address.phone_number = '123456789'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone numberは不正な値です")
      end
      it 'phone_numberが11桁以内でないと保存できないこと' do
        @purchase_address.phone_number = '123456789000'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone numberは不正な値です")
      end
      it 'phone_numberが半角でないと保存できないこと' do
        @purchase_address.phone_number = '１２３４５６７８９０'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone numberは不正な値です")
      end
      it 'phone_numberが数値でないと保存できないこと' do
        @purchase_address.phone_number = 'AAAAAAAAAA'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone numberは不正な値です")
      end
      it "tokenが空では登録できないこと" do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Tokenを入力してください")
      end
    end
  end
end
