Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9F33A0B1D;
	Fri, 12 Jun 2026 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781279985; cv=none; b=bVueae7sqk72jnYkRkzvuHJTkNB87XvSkjdKwuNgbkzJdcWMGu92wr4TpTzbscaU5ah52ekFYhax0viBpeyO014TRSZVFj35AmrDRvZxXc0MTAKq42mfO72Mo3WDJUV3u9cgKqOJNEQtE6xY/9oM3OuzF26eU9Oye6Ud/J/0jxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781279985; c=relaxed/simple;
	bh=jFhMv2Eq5UsUE0V5x/pME8DDFzupryWmD5nOFIZtG2E=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jM22ziKdyxYtwOH6M6JdMV+inHVN0J6JhjNuEMqhRPr6rec13OWn4XjGHj8lExx97JaAt77XFPRehKSzKRR5tzvPxLoIlyn4l0NMUvZYrumYpo5DTOxTW0NGblxaWljdFNEdCpVkZeQ9U2kg6lWjtGQo+BHsF6GpI6KnHR1NvYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=arQfPLs8; arc=none smtp.client-ip=43.163.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="arQfPLs8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781279972; bh=kVaQJf0/wMsXIIL/sNl9/eds/ejHMEuszvuEd3cepbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=arQfPLs8PFWhSHD56/ADGAaAr9BnZ6Ha+U0/klxex9Yu0MB5bQUBkGONhwcwGi7Un
	 nfseMBhQsrWNN6PtlJOtBXMtF6fTOTE78smMNOsn2Pvvqj0SiiqwCZean9CQdMob7k
	 y9lw6GC1AbbOcfphwlPzCACLQD9r2Vez4ucgV5gs=
Received: from 172-1-1-128.lightspeed.hstntx.sbcglobal.net.localdomain ([27.38.179.189])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id EDDB30C4; Fri, 12 Jun 2026 23:59:29 +0800
X-QQ-mid: xmsmtpt1781279971ticmw5bcz
Message-ID: <tencent_7080BF6BB8F05936649DDC091FFD8C45210A@qq.com>
X-QQ-XMAILINFO: NQp/UN4soYLTjbLuSZgRAa5X+6koEViAeBRHCS6SZLhr1lkFMQZ7SFwk+tG7Uh
	 u/Ai0iAljXWpvBu725vphfNoxy1uw3oJMBTTjNX0IAqy8K1/tQTfL5AbE9XmgvTt03tZjoiR6LYl
	 LthqN8wz0SiRcCd35IMRlh1MUGibmfklDHSuOtNGyQa0YAMAMBQJNkUW+bbQWcbBF37/Tcr6vT0O
	 tUXkdDSOnk5TLRH2oToHKx7oPeKJvS3DJrxOTQ0NiMgO8FL9B2YMNZiGfOoh7ke1fOx20AwViBh0
	 WgFEg4DQc8fSqp2VPXHZD7iNDNtWaBVmC7G2kQIg5OoihGkkFGcXiratD+f0hlZVfVSdR2ggkJLS
	 liwip8WyUUrsL9nYDUfvVsukk+JUxb2+OCsZs8fw6kkla+zTu+ii2Lsc3aYAJ5aFVQKDUxPE5K4V
	 VIh3yPFL2oErZoTw30JSWxFNdedpXMcxd6JzMfhn1GWL1hj0B0D1qTaItlJjH6yE/f02bfhM0yTz
	 QiQftF/CEI+WiO3TXOaYWxxBzlEAaXsnFa/eKY72UxLhBUC8m3WyyKLoXFIno1TkgRE4Bu6/EkuD
	 5QCQcRw35tIHCy8j4lzf0RlG5JSvi7r9vsSMkWeTIAM+wOmIAnM9qOBN1tHzfXahg8dyC6GH57II
	 +rgAs0fxr7yAGG7oXKeLUTrSS0QK57y31jIN0SLjW7j95jQIb7P7bzLFy7bMWtUWCJoASBByDrj4
	 i4QRmPZ5QylL85nmrANS9leFkW20hQe6yQMoNeMmfbYF1vFBFmp72ltZMd2b+zk96wbgl7RmncN7
	 1tbARYu7mDYmqgWzodIbn/EQQ3Z5gJrpmU98alAvppugCD5eKCJqoAwBZ0cA9fo8a+5nYFcpI5qA
	 Z4jGBijD2mU8Cuc0OSRBgNcsp0yCMegYkwTiQP/krVie1Ui9mlS+1+oqAxnGRN9ulaScwbVb6j6Y
	 QGfwerZaO3X1FYY35KXMMyrKN1s54NaciA6YLi9i8Xcku1XtOp8J6/jW6xyRUg1sIIZNg0d4CUX4
	 j6QackmVAqXG0yG0w1lDkOu7tIlpj5T9uyFeGxFXYQYDxWAvHDw1HbMEnl36WoA49MhC1VNY/tWt
	 fCujWegMMVcDhk31E=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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
Date: Fri, 12 Jun 2026 23:58:20 +0800
X-OQ-MSGID: <5a41d34bae5af26901b8d2045a5f5235aae35b4b.1781105672.git.zhuyan2015@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781105672.git.zhuyan2015@qq.com>
References: <cover.1781105672.git.zhuyan2015@qq.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
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

