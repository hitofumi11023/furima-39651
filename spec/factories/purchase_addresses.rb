FactoryBot.define do
  factory :purchase_address do
    user_id       { 1 }
    item_id       { 1 }
    postal_code   { '123-1234' }
    prefecture_id { 2 }
    city          { '山田市' }
    addresses     { '山田町1-1' }
    building      { '山田ビル'}
    phone_number  { '0000000000' }
    token         {"tok_abcdefghijk00000000000000000"}
  end
end
