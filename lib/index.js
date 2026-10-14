import { createPlugin, pkgRootFrom } from '@deepwhale-cn/dsh-guard-core/plugin';

export const { name, inject, apply } = createPlugin({
  name: 'cn-data-export',
  pkgRoot: pkgRootFrom(import.meta.url),
  skillFile: 'skill/cn-data-export.md',
  binFile: 'bin/cli.mjs',
  description: '查代码与配置里的境外数据出口：境外端点、个人信息外发、缺安全评估说明',
  whenToUse: 'TODO：写清什么时候该用（用户会说的话也列上）',
});
