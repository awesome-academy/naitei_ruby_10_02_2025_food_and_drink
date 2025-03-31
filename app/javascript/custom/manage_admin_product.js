document.addEventListener('turbo:load', function() {
  const imageInputs = document.querySelectorAll('[id^="image-input-"]');
  const previewImages = document.querySelectorAll('[id^="preview-image-"]');
  const deleteButtons = document.querySelectorAll('.show-delete-confirmation');
  const closeButtons = document.querySelectorAll('.close-delete-confirmation');
  const actualDeleteButtons = document.querySelectorAll('.actual-delete-btn');

  imageInputs.forEach((imageInput, index) => {
    imageInput.removeEventListener('change', imageInput.changeHandler);
    imageInput.changeHandler = function() {
      const file = this.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
          previewImages[index].src = e.target.result;
        };
        reader.readAsDataURL(file);
      } else {
        previewImages[index].src = '';
      }
    };
    imageInput.addEventListener('change', imageInput.changeHandler);
  });

  deleteButtons.forEach(button => {
    button.removeEventListener('click', button.deleteClickHandler);

    button.deleteClickHandler = function(event) {
      event.preventDefault();
      const productId = this.dataset.productId;
      const modal = document.getElementById(`confirm-delete-modal-${productId}`);
      if (modal) {
        modal.classList.remove('hidden');
      }
    };

    button.addEventListener('click', button.deleteClickHandler);
  });

  closeButtons.forEach(button => {
    button.removeEventListener('click', button.closeClickHandler);

    button.closeClickHandler = function(event) {
      event.preventDefault();
      const productId = this.dataset.productId;
      const modal = document.getElementById(`confirm-delete-modal-${productId}`);
      if (modal) {
        modal.classList.add('hidden');
      }
    };

    button.addEventListener('click', button.closeClickHandler);
  });

  actualDeleteButtons.forEach(button => {
    button.removeEventListener('click', button.actualDeleteClickHandler);

    button.actualDeleteClickHandler = function(event) {
      const productId = this.dataset.productId;
      const modal = document.getElementById(`confirm-delete-modal-${productId}`);
      if (modal) {
        modal.classList.add('hidden');
      }
    };

    button.addEventListener('click', button.actualDeleteClickHandler);
  });
});
