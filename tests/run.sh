#!/bin/bash
set -uo pipefail
export PATH="/usr/local/bin:$PATH"
cd "$(dirname "$0")/.."
PASS=0; FAIL=0
ok(){ echo "  ✅ $1"; PASS=$((PASS+1)); }
bad(){ echo "  ❌ $1"; FAIL=$((FAIL+1)); }
echo ""; echo "  @deepwhale-cn/dsh-cn-data-export · 双向验证"
echo "  ────────────────────────────────────────────────"
J=$(node bin/cli.mjs --root tests/fixtures/fail/demo-project --json 2>&1)
for rid in EXPORT-OVERSEAS-ENDPOINT EXPORT-PII-OVERSEAS EXPORT-NO-ASSESSMENT; do
  c=$(echo "$J" | python3 -c "
import json,sys; d=json.load(sys.stdin)
print(len([f for f in d['findings'] if f['ruleId']=='$rid']))" 2>/dev/null)
  [ "${c:-0}" -gt 0 ] && ok "$rid 报出" || bad "$rid 未报出"
done
M=$(node bin/cli.mjs --root tests/fixtures/pass/clean-project --quiet 2>&1 | grep -oE '^[0-9]+' | head -1)
[ "${M:-1}" = "0" ] && ok "合规样本 0 命中（境内端点 + 出境说明齐全）" || bad "误报 ${M} 条"
echo ""; echo "  【误报回归】境内域名不该被当成境外端点"
node bin/cli.mjs --root tests/fixtures/pass/clean-project --json 2>&1 | python3 -c "
import json,sys
d=json.load(sys.stdin)
n=len([f for f in d['findings'] if f['ruleId']=='EXPORT-OVERSEAS-ENDPOINT'])
print(n)" > /tmp/n.txt
[ "$(cat /tmp/n.txt)" = "0" ] && ok "api.internal.example.cn 未误报" || bad "境外端点规则误报"
echo ""; echo "  【溯源】每条规则必须带 source 且引法条"
python3 - <<'PY' && ok "全部规则均有 source 且引法条" || bad "有规则缺 source/法条"
import json,glob,sys
for f in glob.glob('rules/*.json'):
    r=json.load(open(f,encoding='utf-8')); s=r.get('source','')
    if not s: print('缺:',r.get('id'),file=sys.stderr); sys.exit(1)
    if '第' not in s: print('未引法条:',r.get('id'),file=sys.stderr); sys.exit(1)
PY
echo ""; echo "  ────────────────────────────────────────────────"
echo "  通过 $PASS · 失败 $FAIL"; echo ""
[ "$FAIL" -eq 0 ] || exit 1
