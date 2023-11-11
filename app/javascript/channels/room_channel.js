import consumer from "./consumer"

document.addEventListener("turbo:load", () => {
  const comments = document.getElementById('comments');
  if (comments === null) {
    return;
  }
  const currentUserId = document.body.dataset.currentUserId;
  const roomId = comments.dataset.roomId;
  const appRoom = consumer.subscriptions.create({channel: "RoomChannel", room_id: roomId}, {
    received(data) {
      let commentHtml;
      if (data.sender_id.toString() === currentUserId) {
        commentHtml = data.comment;
      } else {
        commentHtml = data.second_comment;
      }
      
      comments.insertAdjacentHTML('beforeend', commentHtml);
    },

    speak: function(comment, roomId) {
      return this.perform('speak', {comment: comment, room_id: roomId});
    }
  });

  const input = document.getElementById('room_input');
  const button = document.getElementById('submit_button');

  if(input) {
    input.addEventListener("keypress", function(e) {
      if (e.key === 'Enter') {
        appRoom.speak(e.target.value, roomId);
        e.target.value = '';
        e.preventDefault();
      }
    });
  } else {
    console.error("Could not find element with id 'room_input'");
  }

  if(button) {
    button.addEventListener("click", function(e) {
      if(input.value !== '') {
        appRoom.speak(input.value, roomId);
        input.value = '';
      }
      e.preventDefault();
    });
  } else {
    console.error("Could not find element with id 'submit_button'");
  }
});
