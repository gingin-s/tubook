// IFrame Player API設定
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

//video_timeのリンクをクリックされたとき、動画をシークする
window.seekPlayer = function(time){
  player.seekTo(time);
};

// noteの編集・削除表示切り替え
window.displayEdit = (id) => {
  const noteId = document.getElementById(id);
  if (noteId.getAttribute("style") == "display:block;") {
    noteId.removeAttribute("style", "display:block;")
  } else {
    noteId.setAttribute("style", "display:block;")
  }
};

// noteの投稿・編集モード後呼び出し
window.afterCreateNote = (notes) =>{
//notes更新
reloadNotes(notes);
//時間取得ボタン有効化
controlPlayer();
};

//notesを更新
function reloadNotes(notes){
  noteSeekTimes = notes.map(item => item.video_time);
  noteTexts = notes.map(item => item.text);
};

//動画の時間に応じてnoteを表示
var movieTimeCounter, timerId;
function onPlayerStateChange(event) { //プレーヤーの状態が変わったら実行
  if ( event.data == YT.PlayerState.PLAYING ) { //動画が再生中であれば実行
    const displayNote = document.getElementById("display-note");
    // 一秒ごとに実行
    var movieTimeCounter = setInterval(() => {
      const videoTime = Math.floor(player.getCurrentTime());
      const noteNum = noteSeekTimes.indexOf(videoTime);
      //現在の再生時間にnoteが存在する場合
      if ( noteNum != -1) {
        const text = noteTexts[noteNum];
        displayNote.innerHTML = text;
        //タイマーリセット
        clearTimeout(timerId)
        //5秒後にtextを非表示
        timerId = setTimeout(timer1, 5000);
      };
    }, 1000);
  } else {
    clearInterval(movieTimeCounter);
  }
};

//textを非表示にするタイマー
function timer1() {
  const displayNote = document.getElementById("display-note");
  displayNote.innerHTML = ""
};

//時間取得ボタンの有効化
window.controlPlayer =() => {
  const btn = document.getElementById("btn");
  //note作成・動画の時間の取得
  btn.addEventListener("click", () => {
    const time = player.getCurrentTime();
    document.getElementById("video_time").value = (Math.floor(time));
    document.getElementById("video-time-display").innerHTML = (`${( '00' + Math.floor(time / 60)).slice( -2 )}:${( '00' + Math.floor(time) % 60).slice( -2 )}`);
  });  
};

  window.addEventListener("load",controlPlayer);
  window.addEventListener("load",reloadNotes(gon.notes));