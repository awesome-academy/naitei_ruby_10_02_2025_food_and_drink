function openOrderModal(orderId) {
  const modal = document.getElementById(`orderModal${orderId}`);
  if (modal) {
    modal.classList.remove('hidden');
    modal.classList.add('flex');
  }
}

function closeOrderModal(orderId) {
  const modal = document.getElementById(`orderModal${orderId}`);
  if (modal) {
    modal.classList.remove('flex');
    modal.classList.add('hidden');
  }
}

window.openOrderModal = openOrderModal;
window.closeOrderModal = closeOrderModal;
