import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "modal"]

  connect() {
    this.modalTarget.classList.remove('hidden');
    document.body.style.overflow = 'hidden';
  }

  close(event) {
    if (event.detail.success) {
      this.modalTarget.classList.add('hidden');
      document.body.style.overflow = '';
      window.location.reload();
    }
  }
  buttonClose() {
    this.modalTarget.classList.add('hidden');
    document.body.style.overflow = '';
  }
}