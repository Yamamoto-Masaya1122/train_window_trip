// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@fortawesome/fontawesome-free"
import jquery from "jquery"
window.$ = jquery

// Turbo フレームが読み込まれた際にファンクションが実行される
document.addEventListener("turbo:load", function() {
  // "prefecture-select" という ID を持つ要素を取得します
  const prefectureSelect = document.getElementById("prefecture-select");
  // "line-select" という ID を持つ要素を取得します
  const lineSelect = document.getElementById("line-select");

  // もし "prefecture-select" と "line-select" が両方とも存在する場合に処理を実行します
  if (prefectureSelect && lineSelect) {
    // "prefecture-select" の値が変更されたときにファンクションが実行される
    prefectureSelect.addEventListener("change", function() {
      // 選択された都道府県の ID を取得します
      const selectedPrefectureId = prefectureSelect.value;
      // 選択された都道府県に基づいて路線の選択肢を更新します
      updateLineOptions(selectedPrefectureId);
    });
  }
  // 選択された都道府県に基づいて路線の選択肢を更新する関数です
  function updateLineOptions(selectedPrefectureId) {
    // サーバーからデータを取得し、選択された都道府県に基づいて路線の選択肢を更新します
    fetch(`/lines/update_lines_options?prefecture_id=${selectedPrefectureId}`)
      .then(response => response.json()) // レスポンスを JSON 形式に変換します
      .then(data => {
        // 既存の選択肢をクリアします
        lineSelect.innerHTML = "";

        // 取得したデータに基づいて新しい選択肢を追加する
        data.lines.forEach(line => {
          const option = document.createElement("option");
          option.value = line.id;
          option.text = line.name;
          lineSelect.appendChild(option);
        });
      })
      .catch(error => {
        console.error("データの取得中にエラーが発生しました:", error);
      });
  }
});