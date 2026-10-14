// 合规：数据留在境内，个人信息单独加密后仅存内部
const INTERNAL_ENDPOINT = "https://api.internal.example.cn/track";
function trackLogin(userId) {
  fetch(INTERNAL_ENDPOINT, {
    method: 'POST',
    body: JSON.stringify({ uid: userId })  // 不带手机号/邮箱
  });
}
