Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C070388E76;
	Fri, 12 Jun 2026 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781279982; cv=none; b=pdF5XPGlVx5o0mPqNCqXjf9KJMce6kj4RjxglRoHVev/hAei+d5t1rh//zklQdOr1o5oFJueJ+dZWckIqmoL6vJxFeH1uCW4yjbhffqf7wEi20p5gEBrL5NfMeW1B/v0Pkkez3tdXlsf0oxzT5KX7gMnkIHZ35p9car3uTTQcNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781279982; c=relaxed/simple;
	bh=X2j8Hvg55PXpymBqpwRjgcvgVDeZUuLo2fkF3uSc6Xs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Frxzx8nfb4fXp8/PBRRPmo9EHPrti3FJ1WpIkoNaSkNi6S7tRzlU/JJdLm/ZM5+8keXb935yybHnZGWv2zCUC5foOT2NjVT2nKbnoEZt8xyDM7qr2NR8Go3T8uvbqhrIdSTk5CabxBD0T525w21xjVT+xCmti3GR35f14Ym2kCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=MXd8BkE+; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="MXd8BkE+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781279978; bh=T+6BpMARKOgVqqiEy09AK2gyXoxhZAWYzWNi6O1fhV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MXd8BkE+sH8ACN3Zfa5sOGv73b8a1xOr+bgbpXUzGOUEdtg8t66eray+qHaSXvtzW
	 IcOOrIg8frDzf44It5tMgNsO9mhDXBs6xTwNXDW7xN3GTn432PZ0heYgf5f0miDSRP
	 YyfyXm7wjVElj3Uc/+M3mI23gGzYVlz17Csk/XZA=
Received: from 172-1-1-128.lightspeed.hstntx.sbcglobal.net.localdomain ([27.38.179.189])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id EDDB30C4; Fri, 12 Jun 2026 23:59:29 +0800
X-QQ-mid: xmsmtpt1781279975t9yphjsh5
Message-ID: <tencent_584BF9CEE8686B0C1981EF5DCDE5CAB22005@qq.com>
X-QQ-XMAILINFO: MWpGaJ0Epp2gD2Dnudg2BYQENjzGnXX/lE0BcE5FZIfyMdvhBglmWZ/WkXYyRn
	 uOqgA7NyWA6sn2q27evGq+3+HpqdLRDnnFOGi7mZdEtacIxPzRdJMa6HfOSqey7nQeTCNJMzSOl0
	 mWMBtZV19pJmcqSyc84PUhB0IBO1teg98tbcI4vNTcpHQSeRNiinzX7LC2xQv50CkX9Sm7cK6FDY
	 nFOiFRSlGBcFSES4U21ssJutfz5QfmYHpqVGTqwUZgn5FoTPFm0lzvQlmLeUYuAwqOCteEkdqlzV
	 0qQWZTyEerrK62nqeZv/jIpVD/ZY2RUR9NeE+F4hG09a9caYU6F4+FrHKj1OE9deXh7p/8zs8nSb
	 rWcx6kkBjK9pgAZaVKxGc9f63+1aRit8pE4ElkppnHdyHUXpeCQpWF2INut55mJARzp/GEbUpLl2
	 1WKADj/iWrQbVZPRuuQrrpgTN2dawMjrzxhY3El7T7127JgJY+NlyPqsmJRXj+DP6WE1179DEbDw
	 Sgcubke/M4YHDtf9ojrHPNjr1VJ1I5Kjl7E0WNVEF1uVp7u1/vRtafT89YJWFCTSywo3w32rJ+vw
	 LF0Kw1hOOtJQ4y4Jf8UfL7MXpEL6LFL5WiKjnI+t1brndAtajzfvUR9UpZkmsUQzkqsANyUgriI+
	 zoi0yihp4JRkgFRDr3lC7TFDiqSq2YJ0KBvYRaXi4Kb9EL0dBp4MWyyM0uUsjt0r7GA4R7kgGAIK
	 ZIJoldkxKdtfvMWgDgS61UQVxz5oh/mNB7QE1lz7UqxyK+5FXCDFv9Jx+8vBvAKaIWkUEhLuezk2
	 lpBzulUm1q8CIkQmvWRfDNN7oqTEGsIhIuwQ3IrGlFdHYRq9XWhtpvKUsdrN4sm6Vx4yxwYDoAai
	 H4HDW5kpydzeYozwekWldMZo3k6OF4Y/oqLWSiOhG9cDsmMSdAPc/Zcf0/t2NywxA3Sco/bb9TZ2
	 Mx07XIAJMo+U4Ukw5rn4F23UT4HQ3WUN2Of328HgaV8n+0ewub60PDm1PfK72JGMQ2xqVWgcGG5V
	 U9fZIAEpm8WxX7J6Fy8Te1aE2233rBFZEs3IKjwTYrwQFaKjSNZV49ZENbFDxvo6lQK+qEwRjFjb
	 2FhyG+5S/CAquXEPAqcccYayi2vBqQ2o1knyS05FuXq1KER5aR1i1hkcdUmX0BzJIO3kKhIbziPB
	 pCobU=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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
Subject: [PATCH 06/10] docs/zh_CN: add LSM/tomoyo Chinese translation
Date: Fri, 12 Jun 2026 23:58:25 +0800
X-OQ-MSGID: <78fd946c52763b1ffea59f45b890c3b62556c201.1781105672.git.zhuyan2015@qq.com>
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

Translate Documentation/admin-guide/LSM/tomoyo.rst into Chinese.

Update the translation through commit c6144a21169f
("tomoyo: update project links")

Assisted-by: Claude:deepseek-4-pro
Signed-off-by: Yan Zhu <zhuyan2015@qq.com>
---
 .../zh_CN/admin-guide/LSM/tomoyo.rst          | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/tomoyo.rst

diff --git a/Documentation/translations/zh_CN/admin-guide/LSM/tomoyo.rst b/Documentation/translations/zh_CN/admin-guide/LSM/tomoyo.rst
new file mode 100644
index 000000000000..a354c2ee1b35
--- /dev/null
+++ b/Documentation/translations/zh_CN/admin-guide/LSM/tomoyo.rst
@@ -0,0 +1,63 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../disclaimer-zh_CN.rst
+
+:Original: Documentation/admin-guide/LSM/tomoyo.rst
+:翻译:
+ 朱岩 Yan Zhu <zhuyan2015@qq.com>
+
+
+======
+TOMOYO
+======
+
+TOMOYO 是什么?
+==============
+
+TOMOYO 是 Linux 内核中一种基于名称的 MAC（强制访问控制）扩展（LSM 模块）。
+
+LiveCD 示例教程可在以下地址获取：
+
+https://tomoyo.sourceforge.net/1.8/ubuntu12.04-live.html
+https://tomoyo.sourceforge.net/1.8/centos6-live.html
+
+虽然这些教程使用的是非 LSM 版本的 TOMOYO，但对理解 TOMOYO 的概念仍有帮助。
+
+如何启用 TOMOYO?
+================
+
+构建内核时启用 ``CONFIG_SECURITY_TOMOYO=y``，并在内核命令行加入
+``security=tomoyo`` 参数。
+
+详情请参阅 https://tomoyo.sourceforge.net/2.6/ 。
+
+文档在哪里?
+===========
+
+用户 ↔ 内核接口文档位于：
+
+https://tomoyo.sourceforge.net/2.6/policy-specification/index.html
+
+我们为研讨会和会议准备的材料可在以下地址获取：
+
+https://sourceforge.net/projects/tomoyo/files/docs/
+
+
+以下列出了三个方面精选的资料：
+
+TOMOYO 是什么?
+  TOMOYO Linux Overview
+    https://sourceforge.net/projects/tomoyo/files/docs/lca2009-takeda.pdf
+  TOMOYO Linux: pragmatic and manageable security for Linux
+    https://sourceforge.net/projects/tomoyo/files/docs/freedomhectaipei-tomoyo.pdf
+  TOMOYO Linux: A Practical Method to Understand and Protect Your Own Linux Box
+    https://sourceforge.net/projects/tomoyo/files/docs/PacSec2007-en-no-demo.pdf
+
+TOMOYO 能干什么?
+  Deep inside TOMOYO Linux
+    https://sourceforge.net/projects/tomoyo/files/docs/lca2009-kumaneko.pdf
+  The role of "pathname based access control" in security.
+    https://sourceforge.net/projects/tomoyo/files/docs/lfj2008-bof.pdf
+
+TOMOYO 的历史?
+  Realities of Mainlining
+    https://sourceforge.net/projects/tomoyo/files/docs/lfj2008.pdf
-- 
2.43.0

