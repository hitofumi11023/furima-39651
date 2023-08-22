## Usersテーブル
| Column                | Type   | Options                   |
| nickname              | string | null: false               |
| first_name            | string | null: false               |
| last_name             | string | null: false               |
| first_name_kana       | string | null: false               |
| last_name_kana        | string | null: false               |
| birth_date            | string | null: false               |
| email                 | string | null: false, unique: true |
| password              | string | null: false               |
| password_confirmation | string | null: false               |
### Association
- has_many :items
- has_many :purchases

## Itemsテーブル
| Column                  | Type       | Options                        |
| item_name               | string     | null: false                    |
| item_info               | text       | null: false                    |
| item_category           | string     | null: false                    |
| item_sales_status       | string     | null: false                    |
| item_shipping_fee       | string     | null: false                    |
| item_prefecture         | string     | null: false                    |
| item_scheduled_delivery | string     | null: false                    |
| item_price              | string     | null: false                    |
| user                    | references | null: false, foreign_key: true |
### Association
- belongs to user
- has one purchase

## Purchasesテーブル
| Column | Type       | Options                        |
| user   | references | null: false, foreign_key: true |
### Association
- belongs to item
- belongs to user
- has one address

## Addressesテーブル
| Column       | Type       | Options                        |
| postal_code  | string     | null: false                    |
| prefecture   | string     | null: false                    |
| city         | string     | null: false                    |
| addresses    | string     | null: false                    |
| building     | string     | null: false                    |
| phone_number | string     | null: false                    |
| purchase     | references | null: false, foreign_key: true |
### Association
- belongs to purchase
