Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794756041;
	b=AyJNneCuKyzuukQQNyMh7I8+Bo7FD5aaAFCVdKG49UlfqOydQomW7P51u04VVHq2Rbjb
	 fnknldEaYGHl/AFK+09YAyFNPsMJ56YSu5i6k4Omv6M01IxM6inQnqCTDoOCXcXaxKV4h
	 XRUd3EqDAsxPDiEohDKy1kOIml7x+5WBUt9Wf/eXuKLN3bBmdMvm3SjfSu5QxOGuFN3XE
	 EcGpKVUSebGjCct5V/7nrnMnDpTvWEEupyUBnyEqKbmQoe3eI/xa8waixpBJoMWx8V7Tq
	 mVlEvBK2zAhHAP4dOkKqBsogxT4Bz3F1OzNYemuZmU2xRCvs9YQdjTYlJjFOihjSW3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756041;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jXrh73iVMql4JAyQujF61e6EHSqzGXNNYYSKJ48BXL4=;
	b=zGiAmY8SBoBX7qfcK3nyhVcLhy1xBlP9WeChsmnxl80RSymPJf24AwaApgDFPI+Ukp0Z
	 Ydavw5FrgrXOpfYies81b7WDWxIeTzP5EKKYFqL8jEmyN6p3qu7FxqWYFwANKHHHuO0i4
	 bZyt2r17mvQ7yMnnvtKv97lQx/a9P2eOhrdwLRjSmfbGGdkm7lY6gwp1lxmtbaSH6rRKS
	 EV65lyfRfytVDV7Xla2MFDTA8n7W44t/kZPkQV1T95In5jFKlJ9s5mF0h/F1uzHTUWmYw
	 C6fUPBX0GKa5ub2kCM+j1pskmv7G02eeusNyh6avpWUAHPm3xmwWvhyzv8F7ce3OJhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=hTbO5UiV;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD5B606A31A;
	Sun, 15 Nov 2026 15:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAD5B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=hTbO5UiV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794756036; bh=jXrh73iVMql4JAyQujF61e6EHSqzGXNNYYSKJ48BXL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hTbO5UiVvl9PyCtHhoiw0T3ch7j3MEEea6CjejN+aupYSWoa034S0CP6uX+Gg4CBA
	 f4ONLq2pMYKxQdp43IZ4WOBJs8Bv0XZD2QJOxWaox58NuOyVG3rgdJWoyhRDY+VhYG
	 Q7hMVUkighoWo8qtE1baNaHr+8REFCCpKu0WdQBA=
Received: from 172-1-1-128.lightspeed.hstntx.sbcglobal.net.localdomain ([163.125.232.4])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 5169F010; Sun, 15 Nov 2026 23:20:22 +0800
X-QQ-mid: xmsmtpt1794756033tzuujwsbr
Message-ID: <tencent_AF8D0120D4BC3FBA2059A26651DC691DE10A@qq.com>
X-QQ-XMAILINFO: Oc918D08lNHEWFbZXHDuu++pfvXSewi32lsxZkfhhJc2TJPHHcSJVHbtN92QcC
	 Vkltw03DVlYLumGSsSdi93aPMDfpnukmyB8MkC/xlomMmVC4aGDDhwtsgC2w9AfdVxjZJxDYWvKU
	 WckolUNgIoE4jBGs2ugKWxdfWEEgK1AC+K6aDeXKcPFph3jWjMRf6HZyGp/TqLo1oDvAAi5hLvhc
	 JYggh3FgMeI6Qd3lG0rqGa1ZQNGLFOeL0Yj53FXNmpun+Y4Idz7kbx7ECFJoz0icGHkdjJMOgGUf
	 N36mxuXBH0vM/bINtA/WoiqSwpdXbBNa1GU8gcN0/wYbZ86KdDfKP1dn+/UDWNdwECmQJbdrDiZh
	 d7f3hN4sD79pLrVz+IlaBU1C1YMQQ/QEEp389N7BTaxUB0znoeDgKi1vc6zcNMSwLjl2UHrsnaB/
	 xYCbSCz1Yq9aBLMbP+MlhdSzKvW8WDy4wgHPEKjebDHDJDpsE1RF/+w5oI9i+uj/sl12J8ynF2Jy
	 6t8Uw58DL/eKZlHh07lu/PY2Phrje3GzquARSoGCH6HIJRPmFlMlSAwOBk2OygHsxs7njLHBPKd5
	 Rx8MfWYrXYkRXyZw3pHuBtEeoDPnae+EiOlyb5Sc6BGK3LbvqdSWN+AxEHBEDFug9SRdu1OwzHck
	 9fT1U7JQttHOXXEuJF3ATZSlu70tYPVC++KkFP8pCFsCdAQwLLYBlcG2nBHouVtrRwgQm6szqsL0
	 5DrwPG6Gshl4ByJSPoxjPtrWL2EILaO43LlBRAmeJYy0sHfYCItvI8/0O5lyv2SEciGHmBivLsCX
	 9i/lDqejG5bxeMlQMK/1tIQR6hYj52MFG0qCUnpUhA0ra4RARBvrIE4JTMKyY4m4huPWUGb5BnZf
	 osw6w0eBtzCqTS7SuM+DEdhlK2Yy2ObCJtSEq5PhksglpihW85XaZRWOQy7+hplJGordaMrkWEPY
	 2J8R6mXgmS7icfMveA8oMHtK+mwBTV6lr7+glz4kcv2vFQ7bjQeK8YyKjrGmzBJfz1xmEaWDEkxn
	 8tw6fAtapsXEVXC/urH0rDia2iKDkDFtS2bc+06a7EcpOsiAYZNxe9AoBiTdorYzHiecSJqdvdkx
	 OKgO1IxPK57cd8dxfWHpmZV8qWc/BRFu0jxCXERekOK4ojdCSFPg+//y3YFD1cxNP+XJh94J6iMT
	 AevsnmJhokWS539ZyMSiZSyfihnQLeDJS60dK0Ssh+vt5/adpRXd/STQ3A+J+wOIUWSOA=
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
Date: Sun, 15 Nov 2026 23:20:00 +0800
X-OQ-MSGID: <20261115152026.69082-4-zhuyan2015@qq.com>
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

