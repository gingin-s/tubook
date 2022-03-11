// IFrame Player API の読み込みタグを挿入
const tag = document.createElement('script'); // scriptタグを生成
tag.src = "https://www.youtube.com/iframe_api";  // APIのURLを付与
const firstScriptTag = document.getElementsByTagName('script')[0]; // 生成したタグをセット
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag); // HTML上に挿入
// 関数onYouTubeIframeAPIReadyでiframeとYoutubeプレイヤーを作成
let player
const youtubeId = gon.youtube_id
window.onYouTubeIframeAPIReady = function() { // APIが読み込まれて準備が整ったら実行
  player = new YT.Player('player', { // YT.Playerオブジェクトを作成
    videoId: youtubeId,
    playerVars: {
      'loop': 0,
    },
    events: {
			'onStateChange': onPlayerStateChange
    }
  });
};

function onPlayerStateChange(event) {

}

//video_timeのリンクをクリックされたとき、動画をシークする
window.seekPlayer = function(seekTime){
  player.seekTo(seekTime);
};

// noteの投稿が成功したら呼び出し
window.afterCreateNote = (notes) =>{
//フォームのリセット 
document.getElementById("video-time-display").innerHTML = "";
document.getElementById("note-form").reset();
reloadNotes(notes)
};

//notesを更新
function reloadNotes(notes){
  seekTimes = notes.map(item => item.video_time);
  texts = notes.map(item => item.text);
};

function controlPlayer(){
  reloadNotes(gon.notes)
  const btn = document.getElementById("btn");
  btn.addEventListener("click", () => {
    
    const time = player.getCurrentTime();
    document.getElementById("video_time").value = (Math.floor(time));
    document.getElementById("video-time-display").innerHTML = (`${Math.floor(time / 60)}:${( '00' + Math.floor(time) % 60).slice( -2 )}`);
  });  
};

  window.addEventListener("load",controlPlayer);