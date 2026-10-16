# @deepwhale-cn/dsh-cn-data-export

**数据出境检查** —— 查代码与配置里的境外数据出口。

## 不装它会怎样

你的代码里有这么一行：

```js
fetch('https://api.mixpanel.com/track', {
  body: JSON.stringify({ phone, email })
});
```

看起来是普通的埋点。但**这是数据出境** —— 用户手机号和邮箱被发到了境外服务。

《数据出境安全评估办法》要求这类传输走**安全评估 / 标准合同 / 认证**三条路径之一。
法务和客户尽调都会问这件事，而**开发通常不知道自己踩了**。

## 它查什么

| 级别 | 内容 |
|---|---|
| 🟠 高 | 个人信息字段直接发往境外端点 · 境外服务密钥硬编码 |
| 🟡 中 | 代码/配置里出现境外服务端点（**需人工确认**）|
| 🟢 低 | 文档里找不到数据出境说明 |

## 重要的边界：出现 ≠ 违规

**`EXPORT-OVERSEAS-ENDPOINT` 报的是「这里有个境外域名」，不是「你违规了」。**

```
拉取公开文档 / 从境外 CDN 取图        → 没问题
把用户手机号 POST 到境外分析服务       → 构成数据出境
```

**同一个域名，两种性质。** 所以这条规则是**提示你逐个确认**，不是判定。

真正说明问题的是 **`EXPORT-PII-OVERSEAS`** —— 个人信息字段与境外端点在同一个文件里。

## 安装

```bash
dsh plugin --profile web add @deepwhale-cn/dsh-cn-data-export
# 或纯 CLI
npx @deepwhale-cn/dsh-cn-data-export
```

![dsh-cn-data-export 检查报告示例](https://www.deepwhale.org.cn/plugin-assets/dsh-cn-data-export/report.png)

![dsh-cn-data-export 演示模式输出](https://www.deepwhale.org.cn/plugin-assets/dsh-cn-data-export/demo.png)

![dsh-cn-data-export 规则与依据](https://www.deepwhale.org.cn/plugin-assets/dsh-cn-data-export/rules.png)

## 用法

```bash
dsh-cn-data-export --demo
dsh-cn-data-export --list-rules
dsh-cn-data-export --html r.html
```

## 边界

- **域名清单有限** —— 覆盖常见境外 SaaS/云服务；自建境外机房、IP 直连扫不到。
- **不做数据流分析** —— 只看代码里字面出现的域名与字段名。
- **判断不了「是否构成出境」** —— 那是需要知道数据种类/数量/接收方的人工判断。
- 与 [dsh-data-scan](https://github.com/feely0208/dsh-data-scan) 分工：那个查**境内**数据在哪，这个查**数据去哪了**。

**关键词**：数据出境 · 个人信息出境 · 跨境传输 · 数据出境安全评估办法 · 数据安全法 · 出境安全评估 · 标准合同
**Keywords**: data export · cross-border transfer · data export assessment · standard contractual clauses · China compliance

本插件是一个工具。使用者必须遵守所在地区法律法规，**对使用本项目造成的任何后果自行承担责任。**

---

## 深鲸网安守护系列（共 31 个）

> 一个插件做一件事。**安全问题是链式的** —— 配套用才完整。

**国内合规** ｜ [等保对照](https://github.com/feely0208/dsh-cn-mlps) · [日志留存](https://github.com/feely0208/dsh-cn-log-retention) · [备案公示](https://github.com/feely0208/dsh-cn-filing) · [用户同意](https://github.com/feely0208/dsh-consent-guard) · [个人信息权利](https://github.com/feely0208/dsh-data-rights) · [未成年人保护](https://github.com/feely0208/dsh-minor-guard) · [影响评估](https://github.com/feely0208/dsh-pipia) · [数据分类分级](https://github.com/feely0208/dsh-data-classify) · [算法备案](https://github.com/feely0208/dsh-algorithm-filing) · [**数据出境**](https://github.com/feely0208/dsh-cn-data-export) · [国密合规](https://github.com/feely0208/dsh-cn-crypto) · [AI 内容标识](https://github.com/feely0208/dsh-cn-ai-labeling)

**AI 与 Agent 治理** ｜ [AI 输出信任](https://github.com/feely0208/dsh-ai-output-trust) · [外部内容信任](https://github.com/feely0208/dsh-content-trust) · [MCP 安全](https://github.com/feely0208/dsh-mcp-audit) · [Agent 权限](https://github.com/feely0208/dsh-agent-scope) · [策略核对](https://github.com/feely0208/dsh-agent-policy) · [可疑指令](https://github.com/feely0208/dsh-phishing-guard)

**数据与凭据** ｜ [敏感数据](https://github.com/feely0208/dsh-data-scan) · [密钥轮换](https://github.com/feely0208/dsh-key-rotate) · [数据留存](https://github.com/feely0208/dsh-data-lifecycle) · [配置审计](https://github.com/feely0208/dsh-env-audit) · [密钥扫描](https://github.com/feely0208/dsh-secret-scan)

**供应链与构建** ｜ [开源许可](https://github.com/feely0208/dsh-license-guard) · [依赖投毒](https://github.com/feely0208/dsh-dep-audit) · [CI 安全](https://github.com/feely0208/dsh-ci-guard) · [工具审查](https://github.com/feely0208/dsh-tool-vet) · [物料清单](https://github.com/feely0208/dsh-sbom)

**权限与应急** ｜ [最小权限](https://github.com/feely0208/dsh-least-privilege) · [告警外发](https://github.com/feely0208/dsh-alert-relay) · [应急证据包](https://github.com/feely0208/dsh-incident-package)

都在 DSH 插件市场（dsh-plugin.org）、npm 和 deepwhale.org.cn/guard.html 上。
