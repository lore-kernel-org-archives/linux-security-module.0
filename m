Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5D6386C25;
	Fri, 12 Jun 2026 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781279983; cv=none; b=lkmkXo8H5l2buGRtcEGy143Yc3qe0JLSQi0bX1gxqd7SPscR0uw+E2p/vyBbEVabGVtaI2vAEWYn1I0woL1Or0vG6QwKtyOn+A6Q3cqYrQRqAdF5zMlnm9xvxIarM6qdz/atxLYiw1gf2rJ5iD1oR7hv9rEUpga4IuDJXTTUSSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781279983; c=relaxed/simple;
	bh=2ACb2HMWwsqYqjQGyzixuztZ7oCVv1Xp2WKv+wQkIY8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awbGqtQ/vptGHoC5M9PpGOGT7b/UYOAo7uyB2wkA6dkP7p4tKkRj/LzVffm5duFBzu01+TeQv4zmL+pwgtGKbmXlVHZldCT4+hm+ksogYSCEcRz/USLRT6o+PjZgRHrchs3BEuBldg8dEHJ5KIZVGsd2abtJFhCj7wQdasginRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ZHPW56+2; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ZHPW56+2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781279976; bh=jXrh73iVMql4JAyQujF61e6EHSqzGXNNYYSKJ48BXL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZHPW56+2eXjLYTz24mOoVHT/KKdo/51EOqtCW8icI1N9WfiRo/Blp17gIPG1ZSxaL
	 DukKWvqyHTIfWAs3NpTMLtIAdc2ArkBz2Cln7PdoWFpD8UvbVPab10WAdUt+1M1sS3
	 qi3nOEI/qNS/xNXVV+cp8CJhQT0aKpwkbPxtMQdM=
Received: from 172-1-1-128.lightspeed.hstntx.sbcglobal.net.localdomain ([27.38.179.189])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id EDDB30C4; Fri, 12 Jun 2026 23:59:29 +0800
X-QQ-mid: xmsmtpt1781279973tw8pvr9ls
Message-ID: <tencent_03EFCA2E14961D59A37729478C633B085008@qq.com>
X-QQ-XMAILINFO: NNx03Vc3qykcyrkWk5S4aLI9ig0Oag5VuWpCeDZszcL/+WtA68D2/IpmepwfN5
	 bd9C7vRj7WYDnvnmh3EOxZY+wq4+/Kytj2p+PeV2P6JMMbTf1l+nNlSOmcHK3DZnFLwTA3KHIkTz
	 GVWZNNNcyz4Quj2v3jIuHmofBNtMi3lJGnrc6zAmDP2PZ1OO+hrBh6OJfxUVCMYM9YkOxhVkJ+IS
	 B6OuUNrGzQxBlnmdzrhOSE9ngvZwd9G9J02pLoBSb73LQTNyw33udqpfhIjz6N/PQuiMllwMc5JV
	 y91SotkRxBWVMeAS+jMXu736vnlduX8GMwgHddOyVydeCeJys27c4fpW123RNHrSET/yCO2ckee1
	 ZuvWTSYcSmQSY1pEY8DX7ned7YfXok0H8+uCWKdU8cgl6dWT42EuhgR8u3zk3IKLZX8OE/pIXcYU
	 VEgKpHM9oXd0HOaMFDsjm0d0VTLEiCT6qzN9IM5CfZPzdztexuXvzu61XR9b9GoIo4nuhZMhqO83
	 oQJrW55PnYWOlw1QtdViHjpaSr9/9ZqPOPfGCbmUlXiTowa35G4LGlacKgxKTDxo/qg4vmbHZr/y
	 fH2DDFVgd8iZfN+4luB8JAHQ8gSENZHrPPDOFxbpyMYh/EVVIxHFIcG1ZvxrWmjer6sr21oemnWC
	 hdExXSJYL9BAraPc6Zk/dQcEWxD1j0lOZaieBvsFmj4F6nqhmOc7fdqgkBAwL2G0wvjMPTDa5XN5
	 HLU6xb3xKQYtLxQHPo8t3KfGx+Bw0SnEHnHZxKbeE8qdl5zBuB6CwLGevCIij2FLZaiPpxBdY9aH
	 mmU7vTHkp57mB/vYeN2cN/qjRjmO3vtXsSUTz0ISX4K4MxORmm2tXySfFy+qiwHTVoamvY/8CVzx
	 2eVIW5iGjCEf5GlCKBTNj8HhDfWimzQ+QeB6ZGscT52+cAlqqD36STXStQRLQITyH29S/neol6Du
	 R3nK5sLbADdmISP4OTYu07HpHHJknoJkc64FNn4Q2qu/AguRPPqKLNWKMOveo/KaodHbeKaPSgyy
	 FhIIptEEutO6QwvAac7YgwZ8ibO0zIGGL/WL29vQ2Gy0bQtUFURWCQ253wPCL7OLVg539yuJ7mdv
	 0isPV8RIepAeOegVSK6ua0ES0CdWJcBztGQ/RKCMnsI1pSw63UQKcknBasUOnY7U5gV3uO7ib/wZ
	 xy2cPWBsANSkEXBw==
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
Subject: [PATCH 04/10] docs/zh_CN: add LSM/SELinux Chinese translation
Date: Fri, 12 Jun 2026 23:58:23 +0800
X-OQ-MSGID: <5213b018d531f6852fe2ad71f1571b6606e09e25.1781105672.git.zhuyan2015@qq.com>
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

Translate Documentation/admin-guide/LSM/SELinux.rst into Chinese.

Update the translation through commit 17bd3c01667a
("documentation: add links to SELinux resources")

Assisted-by: Claude:deepseek-4-pro
Signed-off-by: Yan Zhu <zhuyan2015@qq.com>
---
 .../zh_CN/admin-guide/LSM/SELinux.rst         | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/SELinux.rst

diff --git a/Documentation/translations/zh_CN/admin-guide/LSM/SELinux.rst b/Documentation/translations/zh_CN/admin-guide/LSM/SELinux.rst
new file mode 100644
index 000000000000..4962c7c24ec2
--- /dev/null
+++ b/Documentation/translations/zh_CN/admin-guide/LSM/SELinux.rst
@@ -0,0 +1,45 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../disclaimer-zh_CN.rst
+
+:Original: Documentation/admin-guide/LSM/SELinux.rst
+:翻译:
+ 朱岩 Yan Zhu <zhuyan2015@qq.com>
+
+
+=======
+SELinux
+=======
+
+关于 SELinux 内核子系统的信息可以在以下链接获取：
+
+    https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/tree/README.md
+
+    https://github.com/selinuxproject/selinux-kernel/wiki
+
+关于 SELinux 用户空间的资料可以在以下地址找到：
+
+    https://github.com/SELinuxProject/selinux/wiki
+
+如果你想使用 SELinux，通常需要使用发行版提供的策略，或者从以下地址获取最新的
+参考策略：
+
+    https://github.com/SELinuxProject/refpolicy
+
+如果你仅需安装一个用于测试的示例策略，可以使用位于 scripts/selinux 下的
+``mdp`` 工具。注意这要求系统已经安装了 SELinux 用户空间工具，尤其需要
+``checkpolicy`` 来编译内核策略，以及 ``setfiles`` 和 ``fixfiles`` 来为文件系
+统打标签。
+
+    1. 编译内核并启用 SELinux。
+    2. 运行 ``make`` 编译 ``mdp``。
+    3. 确认当前未启用 SELinux 且未加载真实策略。
+       如果已启用，请在继续前重启并在 SELinux 已禁用状态下操作。
+    4. 执行 ``install_policy.sh``::
+
+        cd scripts/selinux
+        sh install_policy.sh
+
+第 4 步会为当前内核生成一个新的示例策略，包含单一的 SELinux 用户、角色和类型。
+它会编译该策略，将 ``SELINUXTYPE`` 设置为 ``dummy``
+（写入 ``/etc/selinux/config``），并将策略以 ``dummy`` 名称安装，同时重新标
+记文件系统。
-- 
2.43.0

