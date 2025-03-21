document.addEventListener('turbo:load', function () {
  const quantityElement = document.getElementById('quantity');
  const decreaseButton = document.getElementById('decrease-quantity');
  const increaseButton = document.getElementById('increase-quantity');
  const addToCartButton = document.getElementById('add-to-cart');
  const quantityField = document.getElementById('cart-quantity');

  let quantity = parseInt(quantityElement.textContent, 10);

  function updateQuantity(newQuantity) {
    quantity = newQuantity;
    quantityElement.textContent = quantity;
    quantityField.value = quantity;
  }

  increaseButton.addEventListener('click', function () {
    updateQuantity(quantity + 1);
  });

  decreaseButton.addEventListener('click', function () {
    if (quantity > 1) {
      updateQuantity(quantity - 1);
    }
  });

  addToCartButton.addEventListener('click', function () {
    quantityField.value = quantity;
  });
});
