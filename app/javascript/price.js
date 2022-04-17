function price (){
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("keyup", () => {
    const addTaxPrice = document.getElementById("add-tax-price");
    const fee = itemPrice.value * 0.1;
    addTaxPrice.innerHTML = `${Math.floor(fee)}`
    const profit = document.getElementById("profit");
    const salesProfit = itemPrice.value - fee;
    profit.innerHTML = `${Math.floor(salesProfit)}`
  });
};

window.addEventListener('load', price);
