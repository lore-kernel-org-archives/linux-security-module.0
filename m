Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794756035;
	b=cBMueFUWqms+rcO08EtHvwjoPmGZbFZJ0TNu+p3LHoiKGytV8Bwf1ZkFaaSfaqYTSfVs
	 vPy/QcUkSDcpuo11vKlnMUB4G5/9w+9pJ+5keDBfUpOJErhP2HETadXqci9XNJF9I3e2M
	 aOrvgGYon9QwPK82Tj1KkQi3waxJXd8OQRRcrgKS6HaaTdAGBlsXN9y0KXaKxXqdYshvV
	 q2cnHgbToKZFsV2LsiZSbkxJ1e0Wyk2eUd3jeEMROiha6TnP3LfUeLf1StHL9HjWi9P4A
	 vIx/1ZYzUUKO+8uH0BVo0rYJolcqMgpMD/JbcAnourARNxZHGWoPImRlWd4kyttJhng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756035;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kVaQJf0/wMsXIIL/sNl9/eds/ejHMEuszvuEd3cepbg=;
	b=KCN8TOHCAQM3VFhGyqDg/m1i6nOGC08UKloJajhUPpNxGtaDCf6LMY3AkTz4P4zbQVi+
	 McoM1TmPTNc7HDDA+oN8HbzTF6v+JdmmtRhDWxSjKJKoCN7mVXfNiz5Y3jhCEp+6tvz06
	 81e/e2QHGzUv7r8nfjIX1voNNYvqMl1O55ikzRVzunViQ/Lc/wjHJ7MSBy2mk+RagnimA
	 lJQJxRlrg27eff+xIzATECtrgVYthqqgWq4VVl7nG+fW6qve/h4RbGRpN/YJGt/C2IcSJ
	 TYEFg/7qyDzT1SYHd+jn/h7MYcal9RqVH/6z2n9kvNYLJdWnoc6Zcju1lG0tEejSAuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=YO2A90Qe;
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C16D606A31D;
	Sun, 15 Nov 2026 15:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C16D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=YO2A90Qe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794756030; bh=kVaQJf0/wMsXIIL/sNl9/eds/ejHMEuszvuEd3cepbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YO2A90QeBe/Y2TQaCxiVjDi4jaMSqeFiVz5im5SOgog5X7/+WMzfegxGbtBP+/+sq
	 cddZ11agJnRJ6RMROYqo9dAgAcqw3a4uB0gYrqj0lcWHQrbeIYAE5y8IrpRkVyBaS7
	 bjOqG+x+mkWjxpSBPhqdiSFeMjXiebxvm5bsxYXg=
Received: from 172-1-1-128.lightspeed.hstntx.sbcglobal.net.localdomain ([163.125.232.4])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 5169F010; Sun, 15 Nov 2026 23:20:22 +0800
X-QQ-mid: xmsmtpt1794756026tyyxwrkaf
Message-ID: <tencent_EF8DF9217CBE27B90C58FE6419DF3D1EC50A@qq.com>
X-QQ-XMAILINFO: MXi5mP+Kml/P9+cONA3qE6pgUz+yL24FZKqFuz/ZNY1vp5X5CvYXIEjVmzQa14
	 0gFgcWoZKNownnLPDIGKuDx++CnQE0zGxGwtW6whTDBVNZcwy9Wj2XiU+tUKBXmHu/ekE5kVcQpT
	 VYFudoYC0uu4Xn4cA6y295PH92365DlBI8Q5kLguLDNQf6FcXD/1MwbnW06mTQ62DuQJUvwm8dlu
	 XC70QtjkGC7Wqw3eMX8f8OsmDAvlX1UIYkcZu9o7+N672FvsccU7KABHbPhSwUhXmaOAp+Fr6xMs
	 BVMjRwUa9yiCO32DOVccbEG86Ujbrm8cM4WWj/N9/wOjLP38b4MYEB8a4e2MO82PT+JUGR+N1J4l
	 ndGG9IBFHftiDP+Om3XzB5i7sSmXduIbnd++YN00FH6Gtujy6EvDOslc8bvJKPAC3hYHI/+ulF+I
	 isGYcpyEU8hy/RYMAMbgZ7jQzFZejOpQ4KFRB+w67PO3hkrL2drmyiz/yzLwWcVZe4XC5OhNmOZV
	 3/SeILHhvNA2uN8I+xC8laDXNGfzr6HYEgtHvF01p3vazJzBqRtl4LOeZ5kCAoAvOMjLPOqKqYDl
	 bQeATPuddX6hVuJMUZBY49sXemsXluGtQpBT/9wEpCtgJxhsVgdDoFiY5Ij5/a2/7hrowNx71ycY
	 ToDdEb3fB2uCs2GQGqYjyoxVISQxcfZ/W9j8KSHl2hzaLTN8ZYD+4O9BopNopPJ3c++vZq5uuSJ4
	 TpbNcaZZoKuUx7NqBRW74G73IWDR5daZOplkPFOcF2yIqSdUk0Z8nbWEJgLkjI3XpNxEAUyeWwAw
	 dFgkr2Se+Zx8mJpMpKNjzSrBHrXVmenH71vLd9l7oY0Bi4zL8CMFGfUgItb9t7cHxktgplZpPnZC
	 ygbNuwrXU9u/xyVO2+NE2TXdTLIVQtlRo8UnI90JwBgEGnNnhcGQbrBLQ6X6Lndt9PZY6hwO4ZTq
	 vv0meMVXqvr85VN249FwPVhJQzha2D21f9c80n1VrWF7UDj+q0p96Jnw3GmtuWuPywFPlNwyx6Qo
	 WfFgfaGRctkZGL1dFKDqhjw2PyN/w8jzp9OC5ed7gXxOTS0TFYmhNlMJpDafxMmwzbzhP/eRSQ7P
	 IbEjGzoMGGNwBFoOOXHhB8d39EGU4sQJxj5qgO5fwUWXlGnemyQv+qwj1V6kKYI7ZzxXNKDoupyR
	 lru+4N0MQnWJWEO47dp+O3AcltPHqX6DtZwVDVpkfiXXPL+g==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Yan Zhu <zhuyan2015@qq.com>
To: alexs@kernel.org,
	si.yanteng@linux.dev,
	corbet@lwn.net,
	mic@digikod.net
Cc: dzm91@hust.edu.cn,
	skhan@linuxfoundation.org,
	gnoack@google.com,
	zhuyan2015@qq.com,
	linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 01/10] docs/zh_CN: add LSM/index Chinese translation
Date: Sun, 15 Nov 2026 23:19:57 +0800
X-OQ-MSGID: <20261115152026.69082-1-zhuyan2015@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781105672.git.zhuyan2015@qq.com>
References: <cover.1781105672.git.zhuyan2015@qq.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Translate Documentation/admin-guide/LSM/index.rst into Chinese, and
update admin-guide/index.rst to include LSM/index in the toctree.

Update the translation through commit 504f231cda56
("doc: ReSTify and split LSM.txt")

Assisted-by: Claude:deepseek-4-pro
Signed-off-by: Yan Zhu <zhuyan2015@qq.com>
---
 .../zh_CN/admin-guide/LSM/index.rst           | 46 +++++++++++++++++++
 .../translations/zh_CN/admin-guide/index.rst  |  3 +-
 2 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/index.rst

diff --git a/Documentation/translations/zh_CN/admin-guide/LSM/index.rst b/Documentation/translations/zh_CN/admin-guide/LSM/index.rst
new file mode 100644
index 000000000000..21e2b00af544
--- /dev/null
+++ b/Documentation/translations/zh_CN/admin-guide/LSM/index.rst
@@ -0,0 +1,46 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../disclaimer-zh_CN.rst
+
+:Original: Documentation/admin-guide/LSM/index.rst
+:翻译:
+ 朱岩 Yan Zhu <zhuyan2015@qq.com>
+
+==================
+Linux 安全模块用法
+==================
+
+Linux 安全模块（LSM）框架提供了一种机制，允许新内核扩展在各种安全检查点挂载钩
+子。“module” 一词实际上有些误导，因为这些扩展并不是可加载的内核模块。它们在编
+译时通过 CONFIG_DEFAULT_SECURITY 选择，当多个 LSM 被编译进同一内核时，可以在
+启动时通过 “security=…” 内核命令行参数覆盖。
+
+LSM 接口的主要使用者是强制访问控制（MAC）扩展，提供完整的安全策略。典型例子包
+括 SELinux、Smack、Tomoyo、AppArmor。除了这些大型 MAC 扩展外，还可以利用 LSM
+构建其他扩展，在 Linux 本身未提供的系统行为上做特定修改。
+
+Linux capability 模块始终会被包含。其后可能出现任意数量的“次要”模块，且最多
+只有一个“主要”模块。有关 capability 模块的详细信息，请参见 Linux man‑pages
+项目中的 ``capabilities(7)`` 手册页。
+
+可以通过读取 ``/sys/kernel/security/lsm`` 查看当前激活的安全模块列表。该列表
+以逗号分隔，并始终包括 capability 模块。列表的顺序即检查顺序。capability 模
+块始终排在第一位，如果系统配置了的话，随后是所有“次要”模块（例如 Yama），然后
+是“主要”模块（例如 SELinux）。
+
+与“主要”安全模块关联的进程属性应通过 ``/proc/.../attr`` 中的特殊文件访问和维
+护。安全模块可能在该目录下维护以其名字命名的子目录，例如
+``/proc/.../attr/smack`` 由 Smack 模块提供，包含其所有专用文件。
+``/proc/.../attr`` 中的文件仍然是为提供子目录的模块保留的旧接口。
+
+.. toctree::
+   :maxdepth: 1
+
+   apparmor
+   LoadPin
+   SELinux
+   Smack
+   tomoyo
+   Yama
+   SafeSetID
+   ipe
+   landlock
diff --git a/Documentation/translations/zh_CN/admin-guide/index.rst b/Documentation/translations/zh_CN/admin-guide/index.rst
index bd01cf6474c8..10f9e3c577c3 100644
--- a/Documentation/translations/zh_CN/admin-guide/index.rst
+++ b/Documentation/translations/zh_CN/admin-guide/index.rst
@@ -52,10 +52,11 @@ Todolist:
 .. toctree::
    :maxdepth: 1
 
+   LSM/index
+
 Todolist:
 
 *   hw-vuln/index
-*   LSM/index
 *   perf-security
 
 
-- 
2.43.0

