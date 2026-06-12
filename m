Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505B933D4EE;
	Fri, 12 Jun 2026 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781279979; cv=none; b=Fr+PXGT8+DVWs1Dj7YgSNTosLhvwOrioc4lQ3AmNCXnWCd2x3w4Eum+yEsIUQnKIxWPnhr9Cds9P45lWkB9DRJD8JzpKjJGPTLAyFqXXNINpe07/7wyvVGSKuxa2OcuvfEsjNBavciQ9k0Eb0ZF19uEeT2hXuqxalIhkv5ddOVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781279979; c=relaxed/simple;
	bh=Q+ANZXSOm/DZJP1jNI3nH8wxdIEcS2BoPF7hnwAchBY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jx1lNEmgBdoWzK6BMfDqzdqdjsvQYBqHoorEDQyxjEXaLF+GLde46CgvuSrEeNAvVTFS2uw66NOL8NRyXMmguWXfbpXU+foLHXsEveJt3W6Pu6qYWQNUcwpG9+w4XsEPkxc7paWgZkzEggVZnBWC1LI+9CDAII+xYsyWJEZTR5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BA92haYo; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BA92haYo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781279974; bh=gnXYqDOPnoHixd3+zglNjsCbuKCRPQbq/Mhkt4+mJdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BA92haYogqRDmj7J6f/+ET5rAFErYGhLM+eapw1eQ1LA51ghlZiH7K3AxSMwghgU2
	 TpfO0iPqUEEXArZMUj4939C94sDdbsReA4gGKqJDK+kdYRGNn83ZOvBCOyMBwLN6l/
	 7U20l2z8JBIY6eCoISbfujiggjrX1MzZuTWM7x8c=
Received: from 172-1-1-128.lightspeed.hstntx.sbcglobal.net.localdomain ([27.38.179.189])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id EDDB30C4; Fri, 12 Jun 2026 23:59:29 +0800
X-QQ-mid: xmsmtpt1781279972tf9kxqqm2
Message-ID: <tencent_F3D55D1A2C8FB266EE628EF8C68C10DEDF09@qq.com>
X-QQ-XMAILINFO: Od8VqZhFMB3NK9jNUI+6TH09d4hkjGfskg+Z8iQ+mJrEhtaK4j8XshKzi4B30v
	 DnNwKVi+RI+HuJIebPB172J4YkPo2oyyKdZQ7sMJQxJFvmd1zIN23D6N3tBOzXRvpV0oig+6ITWo
	 0d8aQE28wjgew/5b/r/8tEDljp6NqNrgKpgtS1ZcJ2GN4P/cmeQh4VlX85bYWsyvmih8P6T39mn3
	 p6o+BjOnzlSCErw1nBIp8QknEyVNTFyQ6xKqAureK1aAjLXLIoGF3iTv7Io8xWbw3cQx7w4W7Zyd
	 q678uZBWCUOTCbTtGgYyQyIg7PhPLQpv96se/8C/cpcuLNHtw06o8UZ81R25mlX6YZguo8UoQlYV
	 qTDwqhEdqixU2nOhEt/S63xxKnCJbma0MKXAtP7ac8hWJT4gwemxau13tEon2PgJztFPXLRiRhfe
	 35r1jLy1vfp2OUQojbU54SwIy8X/Ivbsa4c3K5gSHsAPqut8RGmp0lrkaOmULBtkb95jUw6PMrNa
	 sm42ne/bTG97dIu0vADM5DtZGexydIFeKRljm8wincX6xSPCj9HsSMaxPGjp5beQJNC2REefiaHm
	 q7SQdjZ9QnnCBaBmnGImAS3TRbloBMAJCxzv7c1kBMXZdN3nCTTHgCRaWBmAfCpxdihsGyou8hp0
	 DBqLUBGCIMC1xuqfH+vQya7wvOyx1WhDba4KT9DuefbU1XwW1JjYiL1cuGlWVM+LPk0hhpV8hyL3
	 HBKh1jJD3548sxiAZDZB9X6EO1OPwBM5bacvFdeQJojxZnNtH6hPrIIX5HpHLlyWjHA3XR14ebkr
	 v3lwCQ7MM1Pd6Z/0uszP4uZwjrR7eiSZ6SMdRcsPrd1jiyoK5rcXDoQcKrpk2gLu1qAZA4ENGCn8
	 6+TptJOqxGIcjo2RMBqJ4lE6y+6ILqL4eMX4ZtThqUsrxykd4zQnUPyGIIMzKl6wcVKRZO8p/t4D
	 thfpAfoh9V6tDHcpl3EDANA+/NKz9oGsQIS+1Jl9stDDoqf5j2ztIJ5vi8I9vwVmhZKYfFAkMh6K
	 4VJ5UbmAmCYyVo0viUbg7TEzoeadQksdJBGyItqMquT9+PnGxX5GQ4a5VB4Y7tva+z3T9VFhUfGK
	 s5WTGx/5tGINrMcfJi4QeRVZJOoTN8yoBQ2yp4
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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
Subject: [PATCH 02/10] docs/zh_CN: add LSM/apparmor Chinese translation
Date: Fri, 12 Jun 2026 23:58:21 +0800
X-OQ-MSGID: <f875040e30fac487c8d539a9b4cb40544da5841f.1781105672.git.zhuyan2015@qq.com>
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

Translate Documentation/admin-guide/LSM/apparmor.rst into Chinese.

Update the translation through commit d00c2359fc18
("Docs: Update LSM/apparmor.rst")

Assisted-by: Claude:deepseek-4-pro
Signed-off-by: Yan Zhu <zhuyan2015@qq.com>
---
 .../zh_CN/admin-guide/LSM/apparmor.rst        | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/apparmor.rst

diff --git a/Documentation/translations/zh_CN/admin-guide/LSM/apparmor.rst b/Documentation/translations/zh_CN/admin-guide/LSM/apparmor.rst
new file mode 100644
index 000000000000..6b0638aedacb
--- /dev/null
+++ b/Documentation/translations/zh_CN/admin-guide/LSM/apparmor.rst
@@ -0,0 +1,59 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../disclaimer-zh_CN.rst
+
+:Original: Documentation/admin-guide/LSM/apparmor.rst
+:翻译:
+ 朱岩 Yan Zhu <zhuyan2015@qq.com>
+
+
+========
+AppArmor
+========
+
+AppArmor 是什么?
+================
+
+AppArmor 是 Linux 内核的 MAC（强制访问控制）安全扩展。它实现了一个基于任务
+（profile）的策略，即从用户空间创建并加载任务的配置文件。系统中未为任务定义
+profile 的进程将在 unconfined（未限制）状态下运行，这相当于标准的 Linux DAC
+权限。
+
+如何启用和禁用
+==============
+
+设置 ``CONFIG_SECURITY_APPARMOR=y``
+
+如果希望将 AppArmor 设为默认的安全模块，请使用以下配置::
+
+   CONFIG_DEFAULT_SECURITY_APPARMOR=y
+
+``CONFIG_LSM`` 参数用于管理 LSM（Linux Security Module）的顺序和选择。请在列
+表中将 apparmor 指定为第一个 “主要” 模块（例如 AppArmor、SELinux、Smack）。
+
+构建内核
+--------
+
+如果 AppArmor 不是默认的安全模块，可以在内核命令行上添加
+``security=apparmor`` 来启用。
+
+如果 AppArmor 是默认的安全模块，则可以在内核命令行上添加
+``apparmor=0, security=XXXX``（其中 ``XXXX`` 为有效的安全模块）来禁用它。
+
+要让 AppArmor 在标准的 Linux DAC 权限之外施加任何限制，必须从用户空间向内核
+加载策略，具体请参阅文档和工具链接。
+
+文档
+====
+
+文档可在 wiki 上找到，链接如下。
+
+链接
+====
+
+Mailing List - apparmor@lists.ubuntu.com
+
+Wiki - http://wiki.apparmor.net
+
+User space tools - https://gitlab.com/apparmor
+
+Kernel module - git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor
-- 
2.43.0


