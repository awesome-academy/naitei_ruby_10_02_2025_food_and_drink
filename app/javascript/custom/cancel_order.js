document.addEventListener('turbo:load', initializeCancelOrder);
document.addEventListener('DOMContentLoaded', initializeCancelOrder);
document.addEventListener('turbo:render', initializeCancelOrder);

function initializeCancelOrder() {
  function handleClick(event) {
    const openButton = event.target.closest('[data-modal-toggle]');
    if (openButton) {
      const modalId = openButton.getAttribute('data-modal-toggle');
      const modal = document.getElementById(modalId);
      if (modal) modal.classList.remove('hidden');
    }

    const closeButton = event.target.closest('[data-modal-hide]');
    if (closeButton) {
      const modalId = closeButton.getAttribute('data-modal-hide');
      const modal = document.getElementById(modalId);
      if (modal) modal.classList.add('hidden');
    }
  }

  document.body.removeEventListener('click', handleClick);
  document.body.addEventListener('click', handleClick);

  function handleSubmit(event) {
    if (event.detail.success) {
      const modal = event.target.closest('.modal');
      if (modal) modal.classList.add('hidden');
    }
  }

  document.removeEventListener('turbo:submit-end', handleSubmit);
  document.addEventListener('turbo:submit-end', handleSubmit);
}
