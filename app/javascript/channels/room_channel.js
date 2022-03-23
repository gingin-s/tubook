import consumer from "./consumer"

window.addEventListener('load', () => {
  const roomId = document.getElementById("chat-room-id").innerHTML
  scrollToBottom();
  consumer.subscriptions.create({
    channel: "RoomChannel", 
    room_id: roomId
  }, {
    connected() {
      console.log("接続")
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
      console.log("解除")
    },

    received(data) {
      console.log("受信成功")
      const userId = Number(document.getElementById("current-user-id").innerHTML);
      if (data.id === userId ){
        document.getElementById('chat-contents').insertAdjacentHTML("beforeend", data.rightMessage);
      } else {
        document.getElementById('chat-contents').insertAdjacentHTML("beforeend", data.leftMessage);
      }
      scrollToBottom();
      document.getElementById("chat-form").reset();
    }
  });
});

