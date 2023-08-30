function itemPrice() {
  const priceInput  = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const price = priceInput.value 
    const fee = Math.floor(price * 0.1);
    const addTaxPrice = document.getElementById("add-tax-price");
    addTaxPrice.innerHTML = `${fee}`;
    const SalesProfit = Math.floor(price - fee) ;
    const addProfitPrice = document.getElementById("profit");
    addProfitPrice.innerHTML = `${SalesProfit}`;
  });
}

window.addEventListener('load', itemPrice)