window.addEventListener("load", function(){
  const btn = this.document.getElementById("add-member-btn");
  //メンバー追加ボタンが押されたら実行
  btn.addEventListener("click", function(){
    document.getElementById("add-member-error").innerHTML = "";//エラーメッセージの削除
    const form = document.getElementById("add_member");
    const XHR = new XMLHttpRequest();
    //フォームのユーザー名をadd_member_to_listsコントローラーに送信
    XHR.open("POST", "/rooms/add_member_to_lists", true);
    XHR.setRequestHeader( 'content-type', 'application/x-www-form-urlencoded;charset=UTF-8' );
    XHR.responseType = "json";
    XHR.send("user_name=" + form.value);
    XHR.onload = () => {
      //フォームに入力されたアカウント名が存在しなければ
      if (XHR.response.user_id === undefined ){
        if ( !XHR.response.form_value ) {
          const errorMessage = "アカウント名を入力してください"
          document.getElementById("add-member-error").innerHTML = errorMessage;
        } else {
          const errorMessage = XHR.response.error_message
          document.getElementById("add-member-error").innerHTML = errorMessage;
        }
      } else {
        const user_id = XHR.response.user_id;
        const user_name = XHR.response.user_name;
        const user_img = XHR.response.user_img;
        //フォームに入力されたアカウント名がすでにリストに追加済みであれば
        if  (document.getElementById(`add-member-list-${user_id}`)) {
          const errorMessage = XHR.response.error_message
          document.getElementById("add-member-error").innerHTML = errorMessage;
        //フォームに入力されたアカウント名が正しければ
        } else {
          const memberLists = document.getElementById("add-member-lists");
          const html =`
          <div id="add-member-list-${user_id}" class="add-member-list">
            <div>-</div>
            <div class="member-user-avatar">
                <img alt="mdo" width="40" height="40" class="rounded-circle user-icon" src=${user_img}>
            </div>
            <div class="member-user-name">
              ${user_name}
              <input placeholder="アカウント名" class="visually-hidden" type="text" name="room[user_ids][]" value=${user_id}>
            </div>
            <div class="delete-new-room-member">
              <a data-list="add-member-list-${user_id}" onclick="deleteNewRoomMember(this.dataset.list)" href="javascript:void(0);"> 
                <svg class="svg-inline--fa fa-circle-xmark text-secondary" aria-hidden="true" focusable="false" data-prefix="far" data-icon="circle-xmark" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M175 175C184.4 165.7 199.6 165.7 208.1 175L255.1 222.1L303 175C312.4 165.7 327.6 165.7 336.1 175C346.3 184.4 346.3 199.6 336.1 208.1L289.9 255.1L336.1 303C346.3 312.4 346.3 327.6 336.1 336.1C327.6 346.3 312.4 346.3 303 336.1L255.1 289.9L208.1 336.1C199.6 346.3 184.4 346.3 175 336.1C165.7 327.6 165.7 312.4 175 303L222.1 255.1L175 208.1C165.7 199.6 165.7 184.4 175 175V175zM512 256C512 397.4 397.4 512 256 512C114.6 512 0 397.4 0 256C0 114.6 114.6 0 256 0C397.4 0 512 114.6 512 256zM256 48C141.1 48 48 141.1 48 256C48 370.9 141.1 464 256 464C370.9 464 464 370.9 464 256C464 141.1 370.9 48 256 48z"></path></svg><!-- <i class="far fa-times-circle text-secondary"></i> Font Awesome fontawesome.com -->
              </a>
            </div>
          </div>
          `;
          memberLists.insertAdjacentHTML("beforeend", html);
        }
      form.value = ""
      }
    }
  });
});

//リストの削除ボタンが押されたら呼び出される
window.deleteNewRoomMember = function(listId){
const list = document.getElementById(listId);
list.remove();
};

