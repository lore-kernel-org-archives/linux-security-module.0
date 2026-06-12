Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A695282F06;
	Fri, 12 Jun 2026 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280498; cv=none; b=Bqz/ZMyv8+srTckm4dKr6Xr9Y1BMQJwMeieoIuNJZo6htuTp+3CM7TWIg1Qw/peVYVMtQbzec6iBjXwA0cyDflhEr7YCvt5+dgF4xDqLy5yP+L4aKZawydOVZ01pGJjdvQyCuUsxAmCw5yy0tqwKN2uZTp5vZ0hEDAYxKwa7x9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280498; c=relaxed/simple;
	bh=C4yDMJ/YOtLv28/s4/Pf+JBqBSSwrKjndXwButUTlqo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTJzFYQIoGj7Dg3i4fRHXxGYsHtyAtS7mNFJQxb5JKP62dVJ71WUxQvoTLiFhBd42aECnb3lkS54ypGqs7QZWQ53EHJeKPsxcbfAWSgdwYfnaOJUx+f4zNWN4Q0Qu2AaFnpMFqUT0n41nn6pi960njpbRHHzkDZEZC3U79AnRV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=An2VG86X; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="An2VG86X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781280486; bh=UQp8VX9JypZ6E6O1OqUQjFmFxUx8YP9qAGPt+56zDhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=An2VG86X3EQ90g20+bcqcsw39Es0lz4u1b9mCgDUyA7XWZF+I28sxwT7xs9oU5B4B
	 dvXhA6VUdAdJ5x9i8IAi3+wE6Z5Gv8iYOnB+dNn28HfSCR1QYZCdBocCZEEzU8c0bS
	 Gf6Yf/TGMceF9yIjuR6gnD/xrg/TAejuquZI51+4=
Received: from 172-1-1-128.lightspeed.hstntx.sbcglobal.net.localdomain ([27.38.179.189])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id F4B72B6; Sat, 13 Jun 2026 00:03:52 +0800
X-QQ-mid: xmsmtpt1781280232taf7h5xff
Message-ID: <tencent_F5C99221ABE8EEE4A8610C0DE1E1BDD8E505@qq.com>
X-QQ-XMAILINFO: N6IfSeM/PG+tR7SiFRbKESHf2jgLdxAzdRFrx5jg1EiRiDaePdyaG45GBeNKva
	 FP5tl7hGSmBMkLESnZHMOrT5T6ICpM+bGy7m/HnIkA6JzZf9sdVZhkAlvwT1J8k/T+VK1gxYZlha
	 mRpL7uPmBVCSy0PBMrO7Hp/quvx/M08WopCTppfxmb1SsEUP8J7BiGrqc6sAbSKvL/UNXTGjyGdD
	 Fu78OwC4BdaPbrUagnhL1Lyj0X6SSST6e2BnIC37nTWU8ymGqlvdgZYr4FYy6T3hUptDJdO2bWna
	 DAh1iQBzwS1TtoYTjtDAITV78Aj+kasq5GdbR9bmWM7AQdOckd6bbcQ65DyZFR+kUwQMwUNKoO9k
	 n4Wy6vekCgrKn37IrYHoKZuJz76NWLTZQul/zmc7pWcszCEL+b2GfcBD2qATNWJ4ilF3jbIxvr3p
	 KyHyORqixr1RYAnYN5YaJjHQd5YQbV/qKXzJVQZh8iypF/zF1iP59HBcLFRNbxKMyO1DQZ6PXyTP
	 iQGJL5jCSkyKfsRGyyq08H7bvEEMizevDAwW2KiYo/d8GWL+y34Fk0K2SSY854nVokp+AEAigeYz
	 FhvL876IxNs/yz52/8C5CqfoGdaowYkuaWWHYWYHPbsnbn02cEI+w3CzIVuZGgUe66Pe/rK6a1xP
	 nZ48FnXgj+3iazYtSnwILSIKe1ujd4TZ/MECIrpvbhzuDuBs/6FnY2R8fEhNYxE/RzKeHCsdaeQf
	 gmQ6UaYlj1PCNb5rqfvQJ1x1UZpxTfRu2r6r6Xme3GFtATcFXRacdAUEpv2BdRzH+m/odPOmxNtF
	 nMnS2SEqkedrCbi/DWMsESkuoRbh1y5cv5ZybODpntUeX/lUYz725BnE4yljk/etW9pSap8+Hjxs
	 Wet+HHaj4qkDTWarlBP7sEfL2e11EaQ0LtQqZJTbClmtM+Gy7rcbrQGiZB8n+WnEe/HiG3Nv0eEW
	 +AuY1kFgFnFxvlduW5ek6cocwY+klh1YNW1NVDG/mcBRenR4Jex36fxhtmLpn7Kbm19DimY75Qr/
	 vbIfYylXMhdGFDBjshqXK+NU43bsP/m9ejBskOP12tsmFkQ1S8f5IBviwhCKwKMpoYOzAgNbZPyb
	 DuEVftjlelVUf5X+sKz9BM8bL/rW4GnDQgGoydlwEuh+wu5reJ+GobfcNY8vu4pyb6DqsBZRKCGS
	 wJKnA=
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
Subject: [PATCH 03/10] docs/zh_CN: add LSM/LoadPin Chinese translation
Date: Sat, 13 Jun 2026 00:03:39 +0800
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

