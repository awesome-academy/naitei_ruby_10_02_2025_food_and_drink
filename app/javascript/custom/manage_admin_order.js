window.openEditOrderModal = function(orderId) {
  const modal = document.getElementById(`editOrderModal${orderId}`);
  if (modal) {
    modal.classList.remove('hidden');
    modal.classList.add('flex');
  }
};

window.closeEditOrderModal = function(orderId) {
  const modal = document.getElementById(`editOrderModal${orderId}`);
  if (modal) {
    modal.classList.add('hidden');
    modal.classList.remove('flex');
  }
};

window.openDeleteOrderModal = function(orderId) {
  const modal = document.getElementById(`deleteOrderModal${orderId}`);
  if (modal) {
    modal.classList.remove('hidden');
    modal.classList.add('flex');
  }
};

window.closeDeleteOrderModal = function(orderId) {
  const modal = document.getElementById(`deleteOrderModal${orderId}`);
  if (modal) {
    modal.classList.add('hidden');
    modal.classList.remove('flex');
  }
};

document.addEventListener('turbo:submit-end', function(event) {
  const form = event.target;
  if (form.dataset.remote === 'true' && event.detail.success) {
    const orderId = form.dataset.orderId;
    window.closeEditOrderModal(orderId);
  }
});
