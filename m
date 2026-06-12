Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5402F28FC;
	Fri, 12 Jun 2026 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280181; cv=none; b=Y3baLYxR98tl6qYkoIht96aXMcS8hhZErjyaK4XpKPLNOmIV9unigvB9O+sj45r6gum40FAt+OfVCTOZJwImGTtcut24Xv0GVcIuifDTJI5gq/RtQrFlu/0SCDIXNRVuN+nT48Upwfh5ugu+cU5vfPToNxa9lJdJRgDJuCkx09g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280181; c=relaxed/simple;
	bh=C4yDMJ/YOtLv28/s4/Pf+JBqBSSwrKjndXwButUTlqo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZcSS/Mz+gzTxlKrZolFBKovbBJNX/fFytT5enUKuz6iVHCMvTls31WNLBz3+WMJzZAqikcWdEU7hWPOCsj4MQo6zvXgSRy2DFpO+mwwIDorTrCvdxZ5a8xFLf67AN0KqVb9jTYOO1R6W+3ZzPclAhz0J2ADNSJIxb7ZO4aUp1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DMq4xzMb; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DMq4xzMb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781280176; bh=UQp8VX9JypZ6E6O1OqUQjFmFxUx8YP9qAGPt+56zDhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DMq4xzMbalvjobZH2yTOHgpfpZm8O9fb3sADGFndiOt8Cmqb3ltww+5NwRR0AKq6Y
	 5p3RwyRb1JfUsGt8/oi5BUcz6kTJ9wCryEMqKf5/306xT/BJYwoLxe40ufvan8sCRD
	 vQFX/J5yfco1rSrKbmXEBFfbLisjdOQw4Ny2CanM=
Received: from 172-1-1-128.lightspeed.hstntx.sbcglobal.net.localdomain ([27.38.179.189])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id EDDB30C4; Fri, 12 Jun 2026 23:59:29 +0800
X-QQ-mid: xmsmtpt1781279973tb3jvefd7
Message-ID: <tencent_4D8EDAC71A10FADF8B5C682C57B266EE1A09@qq.com>
X-QQ-XMAILINFO: NmRjDopJZVxO5pna6SIxMkGCCpAdL8Cu5y/WA9ySV3lEwneQLJXGx5y9iTewyb
	 gGGNVXUYAoqerYx/P8HEeSI7ZMoPBCeOIpCzDapRal/2IQeGyFe47722tf5FNDM+4zvigetfUNaf
	 P1oJNB7q52vnXagrmULSuzaxzCgRUwLWNdXFBZWDQC+A3283OdovR6oceUCslDmn1HKmgWAnh75z
	 04BuwAQfh49bz8GCm2haRJJNWTZ0S2wO7QGZpzh4o0tlcSfzRVRaiR4b0/6ixzljWcMGi0jgLPcj
	 YktNozGQvSO1ROAyfYvkPObiB6XYyzpwDiEaQuyGEMe9l0+fCLOF46i6WSmhTltetoDLY0P1wAF/
	 AzXVJF2MZBSLSoqGITYzhfBVicLYOLXLBuQKuyJ1jjb6Cj14mgegt8R3LCaFxOKiKpvK0Io0auc6
	 zouzTBsaGEyw6ZXgVVcpyJXWnTHsF0rmvHEIDjKJHJgtTUOCYaUnu6MEERSC39dnLIQjutt7lRhE
	 BcFDstp+f61F73f84G52yEcMZ7Mh9y/YZOVC3tOtZHlNWq+fxGJBe93wWqsRisZbQru5dw+EhuJq
	 r0HJFz6Gk6ZoyHIPdOIfj4WHdgo1fJ674FNpfEsMuCjjHReW3J60WX2ghEaaLO0pc6Tu552pBFc3
	 Z2l4ZRtjRklAhCwHOTcuBlRO6hLcrNT2UGmzQoyVa3CHUcU01nt57NQ+QYSGWutFljiJXg4fVczn
	 3nvooIkKZALX/HqaduUoqfK+lQ8dXxTW6h4v0eN7xJqFuD0nO80hcb8TDRgo71qm3eOxEbm7OCHV
	 HCckFH6UdXZFkrXv9is7oD2XVxuRDReU5e02yXlapcy2KUDNnkjFfodvsHt10Nxhp6hQC3cGZGJY
	 XlQ7Q4qODxj8K0PGDSqGmKpzN5nn7KIuf05KytLwuneNLDCpMMwbzv88N3XtIExz5h2a7A9tp8ji
	 iVRjz0MxJeAKCFM69l9QlMadF1FhBMUNLeyj/eM9yc4K/pGmSK02sV1PmHXs9BbIToLB/wTu6USx
	 ngmmSLqcAIBRLo4+L49MouQjiuPJo53gtHpPWff5T6w6rbwnTDeG+oWYijWO+EP8TrVCI401LNpa
	 pI2fJWIn89TkNX9FdjZKaQ1H90SNnK2caUT0WX
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
Subject: [PATCH 03/10] docs/zh_CN: add LSM/LoadPin Chinese translation
Date: Fri, 12 Jun 2026 23:58:22 +0800
X-OQ-MSGID: <3c91369ba21c1bfab48f8dd49f04629128d97057.1781105672.git.zhuyan2015@qq.com>
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

Translate Documentation/admin-guide/LSM/LoadPin.rst into Chinese.

Update the translation through commit 0860b72d535f
("security/loadpin: Update the changing interface in the source code.")

Assisted-by: Claude:deepseek-4-pro
Signed-off-by: Yan Zhu <zhuyan2015@qq.com>
---
 .../zh_CN/admin-guide/LSM/LoadPin.rst         | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/LoadPin.rst

diff --git a/Documentation/translations/zh_CN/admin-guide/LSM/LoadPin.rst b/Documentation/translations/zh_CN/admin-guide/LSM/LoadPin.rst
new file mode 100644
index 000000000000..d75a06f515f6
--- /dev/null
+++ b/Documentation/translations/zh_CN/admin-guide/LSM/LoadPin.rst
@@ -0,0 +1,33 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../disclaimer-zh_CN.rst
+
+:Original: Documentation/admin-guide/LSM/LoadPin.rst
+:翻译:
+ 朱岩 Yan Zhu <zhuyan2015@qq.com>
+
+
+=======
+LoadPin
+=======
+
+LoadPin 是一种 Linux 安全模块（LSM），保证所有内核加载的文件（模块、固件等）
+均来自同一文件系统，并且该文件系统应当以只读设备（如 dm-verity 或 CDROM）为后
+端存储。这使得在拥有经过验证和/或不可更改的文件系统的系统上，能够在不对每个文
+件单独签名的前提下，强制模块和固件的加载限制。
+
+该 LSM 在编译时通过 ``CONFIG_SECURITY_LOADPIN`` 进行选择，并且可以在启动时通
+过内核命令行参数 ``loadpin.enforce`` 进行控制。默认情况下该功能是启用的，亦可
+在启动时通过 ``loadpin.enforce=0`` 将其关闭。
+
+LoadPin 会在检测到首个文件被加载时开始生效。如果承载该文件系统的块设备不是只
+读的，系统会创建一个 sysctl 条目 ``/proc/sys/kernel/loadpin/enabled`` 用于切
+换锁定功能。可写的文件系统意味着锁定功能亦可被修改，但通过 sysctl 可以在可
+写文件系统上便捷地进行测试。
+
+也可以使用内核命令行参数 ``loadpin.exclude`` 将特定文件类型从 LoadPin 中排除。
+默认情况下所有文件均被包含，但可以通过
+``loadpin.exclude=kernel-module,kexec-image`` 等方式排除相应类型。这允许在使
+用 ``CONFIG_MODULE_SIG``、``CONFIG_KEXEC_VERIFY_SIG`` 等机制对内核模块和内核
+镜像进行校验的同时，仍然利用 LoadPin 保护其他内核加载文件的完整性。有效文件类
+型的完整列表可在 ``include/linux/kernel_read_file.h`` 中的
+``kernel_read_file_str`` 找到。
-- 
2.43.0

