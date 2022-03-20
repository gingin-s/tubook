window.addEventListener("load",()=>{
  const btnOpen = document.getElementById('open-chat-button');
  const btnClose = document.getElementById('close-chat-button');
  const chatRoom = document.getElementById('chat-room');
  
  btnOpen.addEventListener('click', () => {
    chatRoom.classList.add('open-menu');
    scrollToBottom();
  });
  btnClose.addEventListener('click', () => {
    chatRoom.classList.remove('open-menu');
  });
});

// スクロール
window.scrollToBottom = () => {
  const chatWindow = document.getElementById("chat-contents")
  chatWindow.scroll(0, chatWindow.scrollHeight)
}