// 违规：把用户手机号发到境外分析服务，密钥还硬编码
const MIXPANEL_TOKEN = "a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6";
function trackLogin(phone, email) {
  fetch('https://api.mixpanel.com/track', {
    method: 'POST',
    body: JSON.stringify({ phone, email, token: MIXPANEL_TOKEN })
  });
}
