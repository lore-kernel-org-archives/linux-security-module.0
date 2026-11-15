Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794756044;
	b=jxTD3iNn/yaq5dyjKkUHBdN30x/QtGptBQbp/4Z1mLrdROD9+vLKYSzf/VyBVDAR+rB6
	 rxAH+fKRBk8nolc6ibE1/ZQ48uAYNARhY9GGfiSe6e3z9KcMrB/pMzOxV8XXBVvs5h7sj
	 Wp4oamWoNniA6dLVRzQqI/VEpVSATBIhFGbZhs+YrwpPaWoTr1JnH7Ftg3D1WTYgvCLKN
	 OcMVtGYaYRdptdTbe6y9v1QFVSjjz+Vz2h0/xX/oqHJYHFCofBMAPF4Dt6NJWCTOAfns5
	 Px4ghi6r4BvPJ6B5GwN0Hg1+vU58RF/gNnFsESMztketZXyvhxetU/CQOziE1OSmTlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756044;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=T+6BpMARKOgVqqiEy09AK2gyXoxhZAWYzWNi6O1fhV8=;
	b=z19McNQ1MrFvhX6rVEjcR9GcpHRNQfn2lprz8ICU2WzpSCKWMWFlBW5fYDCLcrY4me8a
	 9vd9HHfuFsTVa0N1GrGNYlpWYve/U9IMOcQ1RAwQ86j9EedI4p9WqFwtw2/VfLLOggKmI
	 r/XC81H7LkoTUkamOeYUTgWoC0LNFS+e7BO/uQV9l9lQjmXqXzG/4Dy4sVw2FPBD/hgnS
	 eYmBNk31v+ZeUe16C9tVzhZEJs44O93XJva6Ns8u5GPQM99+RzUxLd6awWWJ1d3YEDG3v
	 jwyK7BY4fq8msZ07Ypq/klcus/Fo+JKnlPkhstzb8OQ8nXTZeBnFGblucPOaYgmidVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=IoJ9Ays1;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D6A606A31A;
	Sun, 15 Nov 2026 15:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2D6A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=IoJ9Ays1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794756039; bh=T+6BpMARKOgVqqiEy09AK2gyXoxhZAWYzWNi6O1fhV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IoJ9Ays1q3ToklROkphQ0DrdaGyNXL9QmTh/XXrdyJRtFkYIDAz0/EXZP+CopLF5G
	 k2JRYuaa1pQE6JHyTgKJKMmseBcH1zJ+woPJN/lZY6VhZC+/m1dWwe5R2uUaoYXjoQ
	 D2or1aHfLtrchFAuVMof7Pipec4IvY7BHY6FDABo=
Received: from 172-1-1-128.lightspeed.hstntx.sbcglobal.net.localdomain ([163.125.232.4])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 5169F010; Sun, 15 Nov 2026 23:20:22 +0800
X-QQ-mid: xmsmtpt1794756036tmlfau3l9
Message-ID: <tencent_B692394BEE4EEE6871EC1121F3BDC2C5C805@qq.com>
X-QQ-XMAILINFO: OVjGlAuQBwB9X8vJgDN8tgZHX2jNuZ09TjRT+zPFfS7gJegCcbipcCo6kCeNrt
	 us3RRfUZUPg0el1H0qiaKig/RGXnYIX9zjaJpveNQQ1QMnOdL51ezuJBgBebR26GbZxVNM9Rw/AC
	 kcLOyjGuoIuDQsnMS2EYD4qXTcVdImuIfn+fwTDEJ7A/BR/LapHHjflgAZxpEJT1+w6m3krLNr0P
	 vJuSpUsVC+/8qCpYm5BkwytIuElJ/gflOtLWgRlktX55w+XEIil+N8MgQcv+aGwTS6e7nahSLB1n
	 dmNijoHuz2JFNwkV8DwSFYZ+RO+DaKeqzTsm71qaSDZidq+0HH2FYTHHqs+1tQMlH7wjyxSygMfM
	 0aXRz6wMngIEM5ZF5XY/fOxhRiw8nQGjKJLET+vmQWKlGYHUwAxHjlURx87jF4+KWoGOB6udj1/T
	 AqWW87uLyQ0QEr9YWUfkAEOlqbS+57kMujttL1W5XSh9DtVyFo7pXkF8Rq0+PUNPk7TTkxBxNzcB
	 xVtunr+vVuGhd1TYpQdjyleswvfWuuD+cGhKkGsa1wZCW5Nb9qJxp7X7J1LJsz80ywmnje2F2WFI
	 HAfRPI2Bpnk5G1aidJVfHYASzQ2OULoJlsO8MU5WBSDHqPEWB15xdvnwyuM/GmxRC7EImRWuKBuF
	 McIxNKvqvhUczdilSSdaW+qqFe+gYqyGyemGS9NsDaEDfVdoYyFXgB3DjJ+2EvYNkR1bNJPuzqIg
	 DL2e+aN028z2pmgWgd3QimND7Zv7VEgHE39D/RetEx+8BnaAJB4d04uayegFcWlMmZRENBHosiRc
	 vfo8zVALB/1GyBS0iG5V2BN7H5hKy6a7C1b8H3Gb3KyNjq0HEIDAySsuBsDz8hMEoMeSv3lCo7/h
	 2GS3Qsb9e5+6k1P2Ckst0cPE+i+5S5TOP5FM4mU2fXtwsKi+GYw2ksExdf+ujz3Gt6s0AEcuvqvA
	 Z0t5H2Tt3alJdmAW4Y9dBNUbHd4kXUokHpglQTHznpUrnGJKkdSgrJCb+5F2F5+CsQEtdoXqdXRm
	 TrlbO5nSPe3uBI0Wx+iX3xIHe1V8DfkXpwSeX65UONH8I40/eX6MR/HoNMK/z5wuQ+Ikue/tdwS2
	 xlQDHwbvEnnHd/UB8Ff5bgB3jMFbKFKYJdlly26AMF/MybVYZFSvvVMLKXX1x5YBSbTUoc0EsXHs
	 MReW9NzTvQubiIrl4Yh01JqGIZwZaQ/nr81GXtw8OKhcEWI7PLpLcy8Amh8qqfqLEKHzwgcSZ8EX
	 B9Lg==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
Date: Sun, 15 Nov 2026 23:20:02 +0800
X-OQ-MSGID: <20261115152026.69082-6-zhuyan2015@qq.com>
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

