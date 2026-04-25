// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('turbo:load', () => {
  const confirmModal = document.getElementById('confirmModal')
  if (confirmModal) {
    confirmModal.addEventListener('show.bs.modal', event => {
      const button = event.relatedTarget
      
      const actionUrl = button.getAttribute('data-bs-url')
      const message = button.getAttribute('data-bs-message')
      const title = button.getAttribute('data-bs-title')

      const mainComment = document.querySelector('textarea[name="request[comment]"]') //documentでモーダル内ではなく画面全体から探す
      const modalHiddenComment = confirmModal.querySelector('#modal-hidden-comment')
      const modalConfirmBtn = confirmModal.querySelector('#modal-confirm-button')
      const modalMessage = confirmModal.querySelector('#modal-message')
      const modalTitle = confirmModal.querySelector('#modal-title')
      const modalForm = modalConfirmBtn.closest('form')

      if (modalTitle) modalTitle.textContent = title
      if (modalMessage) modalMessage.textContent = message
      if (modalForm) modalForm.setAttribute('action', actionUrl)
      if (mainComment && modalHiddenComment) {
        modalHiddenComment.value = mainComment.value;
      }
    })
  }
})