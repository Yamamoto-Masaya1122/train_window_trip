import consumer from "./consumer"

document.addEventListener("turbo:load", () => {
  const comments = document.getElementById('comments');
  if (comments === null) {
    return;
  }
  const currentUserId = document.body.dataset.currentUserId;
  const lineId = comments.dataset.lineId;
  const appLine = consumer.subscriptions.create({channel: "LineChannel", line_id: lineId}, {
    received(data) {
      let commentHtml;
      if (data.sender_id.toString() === currentUserId) {
        commentHtml = data.comment;
      } else {
        commentHtml = data.second_comment;
      }
      
      comments.insertAdjacentHTML('beforeend', commentHtml);
    },
  
    speak: function(comment, lineId) {
      return this.perform('speak', {comment: comment, line_id: lineId});
    }
  });

  const input = document.getElementById('line_input');
  const button = document.getElementById('submit_button');

  if(input) {
    input.addEventListener("keypress", function(e) {
      if (e.key === 'Enter') {
        appLine.speak(e.target.value, lineId);
        e.target.value = '';
        e.preventDefault();
      }
    });
  } else {
    console.error("Could not find element with id 'line_input'");
  }

  if(button) {
    button.addEventListener("click", function(e) {
      if(input.value !== '') {
        appLine.speak(input.value, lineId);
        input.value = '';
      }
      e.preventDefault();
    });
  } else {
    console.error("Could not find element with id 'submit_button'");
  }
});