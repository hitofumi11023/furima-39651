crumb :root do
  link "Home", root_path
end

crumb :items do
  link "出品する", items_path
  parent :root
end

crumb :item do
  link "商品詳細", item_path
  parent :root
end

crumb :edit_item do
  link "商品の編集", edit_item_path
  parent :item
end

crumb :purchase do
  link "商品の購入", item_purchases_path
  parent :root
end

