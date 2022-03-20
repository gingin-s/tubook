import consumer from "./consumer"

// スクロール
window.scrollToBottom = () => {
  const chatWindow = document.getElementById("chat-contents")
  chatWindow.scroll(0, chatWindow.scrollHeight)
}

window.addEventListener('load', () => {
  const roomId = document.getElementById("chat-room-id").innerHTML
  scrollToBottom();
  consumer.subscriptions.create({
    channel: "RoomChannel", 
    room_id: roomId
  }, {
    connected() {
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      const userId = Number(document.getElementById("current-user-id").innerHTML);
      debugger
      if (data.id === userId ){
        return
      }
      document.getElementById('chat-contents').insertAdjacentHTML("beforeend", data.message);
      scrollToBottom();
    }
  });
});
