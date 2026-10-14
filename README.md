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

## License

MIT © 深鲸 DeepWhale
