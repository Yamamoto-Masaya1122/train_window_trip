import consumer from "./consumer"

document.addEventListener("turbo:load", () => {
  const comments = document.getElementById('comments');
  if (comments === null) {
    return;
  }
  const lineId = comments.dataset.lineId;
  const appLine = consumer.subscriptions.create({channel: "LineChannel", line_id: lineId}, {
    received(data) {
      const element = document.querySelector('#comments')
      element.insertAdjacentHTML('beforeend', data['comment'])
    },
  
    speak: function(comment, lineId) {
      return this.perform('speak', {comment: comment, line_id: lineId});
    }
  });

  const input = document.getElementById('line_input');
  if(input) {
    input.addEventListener("keypress", function(e) {
      if (e.key === 'Enter') {
        appLine.speak(e.target.value, lineId);
        e.target.value = '';
        e.preventDefault();
      }
    });
  }
});