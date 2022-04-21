const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); // PAY.JPテスト公開鍵

  const submit = document.getElementById("button");  //送信ボタンの要素取得
  submit.addEventListener("click", (e) => {  //イベント発火（送信ボタンクリック）

    e.preventDefault();  //通常のRuby on Railsにおけるフォーム送信処理をキャンセル
    
    const formResult = document.getElementById("charge-form");  //フォーム全体の情報取得
    const formData = new FormData(formResult);  //jsで取り扱えるオブジェクトに変更

    const card = {
      number: formData.get("purchase_address[number]"),  //カード情報を取得
      cvc: formData.get("purchase_address[cvc]"),  //セキュリティーコードを取得
      exp_month: formData.get("purchase_address[exp_month]"),  //有効期限（月）を取得
      exp_year: `20${formData.get("purchase_address[exp_year]")}`,  //有効期限（年）を取得
    };

    Payjp.createToken(card, (status, response) => {  //PAYJPへのカード情報の送信、その後の処理
      if (status == 200) {  //正しく処理が行われた場合
        const token = response.id;  //responseで取得したidを代入
        const renderDom = document.getElementById("charge-form");  //フォーム全体の情報取得
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;  //HTMLのinput要素にトークンの値を埋め込み
        renderDom.insertAdjacentHTML("beforeend", tokenObj);  //フォームに追加
      }

      document.getElementById("card-number").removeAttribute("name");  //フォームに存在するカード情報を削除
      document.getElementById("card-cvc").removeAttribute("name");  //フォームに存在するセキュリティーコードを削除
      document.getElementById("card-exp-month").removeAttribute("name");  //フォームに存在する有効期限（月）を削除
      document.getElementById("card-exp-year").removeAttribute("name");  //フォームに存在する有効期限（年）を削除

      document.getElementById("charge-form").submit();  //フォーム情報をサーバーサイドに送信
    });
  });
};

window.addEventListener("load", pay);