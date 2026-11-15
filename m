Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794756041;
	b=R6Tr7bf+f6Bh7cno5ChjLMx/Wz43aS942WuteO163JRUk/ntGUf6jb1680YoV9/rMIc1
	 O5BFReG5ATwvgBVrjOkHbU4FwmTWBEai7cmE0m7PzGAUCjIIf4PhlSP1y/1ybM2OxgVmR
	 pfV4HX+33cpLbJpkwd5VGKwC4H9Y5GCPSoQzvIbfQVVFj38Knhxzx5gVSK24PLznv+uR4
	 58RkWsqnRavlrjv4IPjiLU1QYNH8RabxpfHK+HFe3iHx1LsQFFeiTTSnfoM6bZyKm/Hd1
	 4f+2gxAqYnCfTzLAGJqp7SBN/djXFG3aDf9pPXqVoTp/JaFKhNbpX1XPUkKUum0dBOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756041;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UQp8VX9JypZ6E6O1OqUQjFmFxUx8YP9qAGPt+56zDhY=;
	b=nSSKI16V9PQxYkWeXzf3KpgnKCvIy0w8O1I+r6GbLIg8pCzzcfNVxmExlm3i8iGEzKyt
	 DkiojAKayqFuTC7SPTXMZYWlS6Vfpjvbq5XEwpNA5Fa0sPoqNiqt/MLJZ4MjlRYLHayRp
	 mVSmL0ylPmm/fSM/Aw97Dl0+D4noVQAfzT29TuryAMn4N9WICFYN7o2Y+XlZotTXt+Bel
	 ywTf+tN/2YoQ/XyW1sKIrrbLKw+iH9bCMTIO2TCr/AOT3HzBBPddaPs/p4WUen0dCxG2c
	 SYCfZuTD3zSQKjSrVxdbcqg128bV4fp0SP3D0Vmdji7gw/eZOfe8zuhfdFDIDPXWFBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=oqOExLhh;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA083606A323;
	Sun, 15 Nov 2026 15:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA083606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=oqOExLhh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794756035; bh=UQp8VX9JypZ6E6O1OqUQjFmFxUx8YP9qAGPt+56zDhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oqOExLhhY7XFS/QhrCO1xEznq+HPjmayWkQTagfCnhIaTP/Tv73ISoXYgSZpKHX74
	 kBLh84l5qlzaOiweGZkcu4Kxv56E4u+agOkp/S4mPECNCBXXhYij8psPI5KXgVKUqL
	 mpsfXiGtyEWPJXglD17mOyYJt4J3WC48uZIhTzNk=
Received: from 172-1-1-128.lightspeed.hstntx.sbcglobal.net.localdomain ([163.125.232.4])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 5169F010; Sun, 15 Nov 2026 23:20:22 +0800
X-QQ-mid: xmsmtpt1794756031t4kmq65o6
Message-ID: <tencent_BC47EB63600886EF052E8C967659A9775108@qq.com>
X-QQ-XMAILINFO: MKuia7bJYsehC6R58VatiaReU0MeyRveEe1K5pBBEXDSI5KU8nUVvoJsJeQfh7
	 2S0Yjywwnfb7yTEBvgetTRwBix/+jU+tdOlD7wxGo7QsIcV+Igraj1LoYkYuEafym5Y6cUnXy79I
	 v18Cmvl83GCuKPRyg8rq67l7g33k9/bQXH4+3hkEJlNCIFgoHTVOLx7bpH3Z30UchjgITYz/n35+
	 oPGObt9IzaiB4jR4vEbEQOuRojXIyjEjODQ3dllA/VzyK7VZMEmw4ofRSR08+aMUHwlztw5YwsSy
	 6RdIY3azECJ06YGb7SDmkwz7MQOe6DscGEULefLD3QMoskdJJHfUbww7wx2GTU6MephOFiayxUkl
	 EWqblYmBbwN95ZoonIhyUpB2gyJxee8cXL9HleDt4Rick0N6sMfJsq+S3fHcjbUtMW8zjhGV9vyd
	 Y4GUPvcJgm6W5UwnvUgiWlvghEimKEHrXOChq4VPnDJgyvKmWLRvW7sLEYV+OuFaA/9c7V3ain29
	 5fN9gjZwLF6MJEPwWDi3RTJqBjTUcbvsHNxdPXmfDjIRM0eXxs5+E1Z5jBH9ny4lYhGgqihttevt
	 LXLE4cFm55gW4UzC592wUTl0z+NAsMH6MInjuDznFymGwjRbnmRI8/grAw16mmTLIT6Fec0c88dy
	 1Drt6oovbF3XOdOkCW0NOa4TO+mtu/6f34y5hLlSGifJINyaEJ+YzfT5JWhGbXtA18GjUkPhBcXX
	 A8Aa5qBNVRnmZmKkYW2b3tX7T/bqF4T1SPgkkydjTXLjvFWSc0fp9AkVIcipqurndPjn+x07SIsX
	 lYFAbh2pKiL6kiiMJpdUoEiPDJiqLRoE6m3UEBS5IlCtcaM25GJTY8bD2eaJH6i+HUUfjw7srNSx
	 61JTq/YpcBrnCD6xcJPwpz6PGBpAlNSNf5PZFrB16YVXBT+FAIiAtpeEE+4XAMTmxSQepr7pH/qZ
	 xfETClRBCfjXFIEsG+Tvz++IjJtQz82QqAShdmnshzBgi1R2EWdFlV8fVXFobuf0TNsg7XmFj6er
	 qJOMRQJEgoOv71POwt89Ep1zXkMIR4/W+1GKqTbyqx7ti1nh3VTX3fEa1u1o0dwShihpgJlm1jhg
	 CnDHd/sRzF1Y7pwh6/X1zSnsZ16o3JgFVcW/VY3XgCsLl2PPKBozLy/qeohcvRvzTPf0EVsrvFAT
	 N9rzkU8BfE/cMyL5Y3ixj79ML+IwGPlyiRJDMuyuQ5w+p1dw==
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
Subject: [PATCH 03/10] docs/zh_CN: add LSM/LoadPin Chinese translation
Date: Sun, 15 Nov 2026 23:19:59 +0800
X-OQ-MSGID: <20261115152026.69082-3-zhuyan2015@qq.com>
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

