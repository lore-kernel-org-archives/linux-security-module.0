Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794756038;
	b=w985pAvzqcUIMlOJ4G445cXQwP5c2jJ4sMBLppMt6LmCfV5Qq5DGTS/ufdPpU+1nR/63
	 OGoLHjZ/YlZ74hlMEzgRffMCxQdM/9zt3nyxLj8R/WnRJDszsP2U57xczY/AVDI/oMSGJ
	 43WqwJaM45c02JoOTwYkiq/7fQv9x/YxewXckUt+6oFjXjqd0eEIYr2iXSNI0v2tGYls0
	 xZl+3Y3X691V5QOkHmRZDw7l7gk5TqmdBdeUh5j4XH3lMtcB9oecfL/Q5orBHaOsTUQZa
	 BF0FGajFP+ymmf+mLr5Oxl6CGRkrIxi5gSvkDyYhKmmlNW+55panVagzS6TajBJYurg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756038;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gnXYqDOPnoHixd3+zglNjsCbuKCRPQbq/Mhkt4+mJdg=;
	b=AOEa2jDLLcm/jkACIT2LXEVHtzV0RYXlm+KD2QydpRQMS/hb62zdhoWXi13tI9/DqANA
	 sKsv0Ggjqkvk+rv54xaBhxYDw+0Y5hLJ4iFT5JFZMXjsb6er37ol4jUS9vXWx+fFJ3De6
	 MSrEQYrYioGVHt5w8ruMR4HU0IfCCjEUcKLqaWKfGTJn0bIdsrtz/WPgkWGHQCU0m+8dk
	 9b8z8JhHg4paVRuR+9GpC0cjoRImgMnWNBViF3BuUoWKI9JIAOP1N5IvHGZUL+bjwP0R/
	 ab24/7zMuCk0CNv/OQNGFs1ocqxFvW83RBdB2UI1BnXOgcDK7C1n2n2dEHlUiYuMCZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=YWhr6fV8;
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC90606A32F;
	Sun, 15 Nov 2026 15:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EC90606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=YWhr6fV8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794756032; bh=gnXYqDOPnoHixd3+zglNjsCbuKCRPQbq/Mhkt4+mJdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YWhr6fV87spSzmc1eGGnT+rQa6zEg1j3spOLSLUyleojMcsevok+BjgJ7RKccNyxb
	 zlDkDAy6bYSfq2Q3IIInkyHxh6kCkT92FEYaAj5eHAk5WvG3GrLSaJ7u6MKznRAl7y
	 Skw8kDsSJUC/mRRfOwFyjaAtYo6hx66+7BEB3O/Q=
Received: from 172-1-1-128.lightspeed.hstntx.sbcglobal.net.localdomain ([163.125.232.4])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 5169F010; Sun, 15 Nov 2026 23:20:22 +0800
X-QQ-mid: xmsmtpt1794756028tg74cb88w
Message-ID: <tencent_F5CC59EA6495DEFD1C818E49213CBF3BB90A@qq.com>
X-QQ-XMAILINFO: NnDokEWiexQTdy3MyRFSgkbCTcKmm7GrNnQMMvcjoA81pcaxLG26LQj0Y9aYzG
	 XQes285kkDNG0kJmHNE0lrwjOc6GmEZSnGeUZSy7qbQaoeiy42hJYWJa92/mxGpYueVjdweJw6EP
	 o731Au2eTlyGLOLdgLq0ce6lO26ADVNYOAb83zA2UP2R+JOz++c9G3c5GVPBVUxaG9/9FRBxbTZr
	 OPOIqqZL4FLZmp4NCSvaP5Fc+Eke3351EMzequXlF0AOrPCrBeoO9q2U62+o7d0lVXDOl3Zs4SZh
	 2n9PDPtGmco+ZgNIVtnwO8XrLjGFwKqLUyypoh/w3C08LnVB2Y5ISSC3mFyc1eA4anxavS2U06eo
	 64U86c9AUPK1ZHwgvlcrvocrNa3SXOx4D9rWHK+jFPri9JRb+/JxJil1qW9swxDgS8agCUuP67YG
	 +GG9nYDJ+HlK3I96jL6i/c02+yglWgVDVVA1YxgmpKkpViqyb1eiq1Iwu9v91QkTXM3fbkINJq7n
	 skKimcwBpY52uNIM5btsBpbNWgMxoHAXpApieoOOY+YQZQ2sbixUkv9ocgkoGi/+/aCW/gEr1RoD
	 wBzvKmOmyLI+lvQaSEXJQDH/GQ3cDKH3zWji51BTHKoiSTiIYqYL32JisGPSjzsInmZeAmnQPC+8
	 VRtrT6wxvFWPVNILjodMLv1V/q4BKD/Aq3oueoexbL0+B1rJ7waHbEeH6jE6GV3g7lAwLa8nPb1l
	 UJuLkU3rSOmyNcqdt4E5ZP1p3MKdgVdqYPg0K7FP94ha1vxcKODfgXQZsiffYYt0TUGFnnb79L94
	 YLgdrNwsh2Inz9fjXRKzbZGievG3C9S7ctqrs0AUa/dYQUKdzEm+IfzShW4e3sKMlrkyRrDaZOA7
	 PqYUv9g24QufdwirYHFrXkXgPg74Ku7GqK5IcjpwEsqYYQVCn9kkzpjKY1xvnp75NkZWUu0pD0e/
	 khjkdhmZyj42nfzq5532HhVDR6PwFQB9PPR6VjMEJdSYVjExL3ToVW6IB1Z/q0H5S5X+sRLc2/oZ
	 muQaU+5NW3TgWW5tvBhxAInPZZfe0jzdObvSP5VMu0Jm8MCt65wYgxQAxvzGXdDGH5pvrnnDU6On
	 y+YJ0elEBsMzhGwPl2O2z1li9zM2Mt4zoo+MZX/6JY4IS+btuXfaUmz3fYy4NQkgxPTYAPQ1Jdi7
	 fQYKJknBYooc26Ex7s/+A0lm0hNM/0hPTec7UV5d6KVXqiZw==
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
Date: Sun, 15 Nov 2026 23:19:58 +0800
X-OQ-MSGID: <20261115152026.69082-2-zhuyan2015@qq.com>
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

