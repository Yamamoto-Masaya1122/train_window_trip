import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "modal"]

  connect() {
    this.showModalWithAnimation();
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

  showModalWithAnimation() {
    this.modalTarget.classList.remove('hidden');
    this.modalTarget.classList.add('modal-entering');
    setTimeout(() => {
      this.modalTarget.classList.add('modal-entered');
    }, 10); // 10msの遅延でアニメーションを開始
  }
}