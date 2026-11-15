Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794756047;
	b=yiCwEvXMk1uGqZ1WzT/2btg+vUbYf3m+4m75edDitHJcvQSc9aeTy642dZDN58j1xKZB
	 EKJx4XbdB8W5Kzu/Or63mth+ovZ5q2xB+PW09pQlEe2scNfklOqv8Jsw8q4G5qQemOe+c
	 bAUNJvW6jiu8p6qup8IOaC3Fg08M1RRLhA8NfRsNycE2GvdGe1pZDTKbn0CEATtLckuCJ
	 buKbQSBsOFFat5Tayh9xgQg4sFga8yv37lqz9Og+nZmjBMEViZMS40cJLYkB5bmBcxRo3
	 Ba4cA/JSn0P1RO3IJSPSgIWNpC8mVP17wCH+eXbFOabnhpb4RZzzlIsHgXrcUTg0HRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756047;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5K9LmwVu9oORjjSCeF/aiuH8N36KFvnRHm/K+VIXTic=;
	b=j1Mo6nTakEHbdRqHQh84uxT6/UpsSLj8glFQiIeDHAY60pfhlY9I5aJMB0/MEwyNUMDY
	 2CADGV0Lgpq40calKoR0FM6+mksuLDSNt+pG8gJvjZvaTzWb0eMDlu08GjabRq+aY/rsQ
	 3jcnbxXvlY6b0UPZlsGQHXGqfXZKlWdUotoMfjeKMHUs5Ipu8a3RWpsIQx82k3j4tMoaW
	 ouLlBzVpfCx0eayTmN7L/Wdcjp5ruVZoDWqhAUACVv2m24omGS0Pk780pxyyEDP/PgiS3
	 z1Go/fcTY2TD4AK10MnEXZbxBNicWj4u9c+0OQtsMZPamPP1dLdFLdkimxKSWcbU0Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Z7MLmBZW;
	arc=none smtp.remote-ip=162.62.57.87
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE20606A330;
	Sun, 15 Nov 2026 15:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CE20606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Z7MLmBZW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794756042; bh=5K9LmwVu9oORjjSCeF/aiuH8N36KFvnRHm/K+VIXTic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z7MLmBZWuzW2CymVK/KTfxQ5gfhpnuqGZIeHx9mc2cwrsVmpq7A9rbQN+zArpryux
	 Zgq1qvXdcLuepWg6YnPkKPl1mUDenl13xYM1tDdzVIdeftdA+/7C2yg/VV0ciNQhiK
	 IgrIxvjT7DVVdmxPXkScL97GSyoBvJdxh8a9I1ek=
Received: from 172-1-1-128.lightspeed.hstntx.sbcglobal.net.localdomain ([163.125.232.4])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 5169F010; Sun, 15 Nov 2026 23:20:22 +0800
X-QQ-mid: xmsmtpt1794756039tmehij9ds
Message-ID: <tencent_B2BC8FB9485A6E6645DDD11CED8F6123F80A@qq.com>
X-QQ-XMAILINFO: M7+MjJVZrEreRkFS8clb8G41ichGlRewkTxuP4NZNbC/KdYOMMiA9/DouScTFM
	 QkYNizgs+UMnUB63S1exQYAdxn+ORCjMD570pz5U7/vhH+6s+CpTaCO+M20WnI98WNpP2bGY4Y+h
	 J8+1rs95tXhstOdjGcb1+aVwJiqIyoTuBvWhn8PNhqEnyY1SunThjALvHRL5OrHsL5mqEQBLGyzp
	 JzEBHRdFNPkThWH+XVRasOk5fl4QnP7f75L/UtbDjjD/7U55cryWmtJif+kvI5f25Lq0zAMZaG4a
	 eolcRNgmYVy7TF9vFLC0WLGvdhvr8jTtSM1+OXfKUVipdFkUCj7k6y/LATnb8nDgWkd6z4ujsw4Q
	 zSVft0Mc0M5H5F1aQj7pxLWLW2xCs+PL4YB2/GdfkU8jgm1wZe/Aug8PlL+kmpLkNjC/c4vA/GVE
	 FBOLOkljHpt1O+ioDO3Avhzd8dgoGOxn9ZfLs+fZUEObXyn0cvKMk+R79Fjp3vYiGBJqw8oWqAc/
	 b82ezc5Qlvwaj4nNa3eoyhkRxcKnTfRBCX4zARWZD064F13fXD+q8OrQGF8vL6JwU3orDi8yrPsg
	 yY6WcKrY3tfvx+MqlVN2CVtwnrurO5e9YBZXWS5CpHR0lE6rKWr7t4xMRB35zGCV1RhYPidevkn4
	 D+F8gd5xxKEdiX7E1S2QfrRPyaSu0I3cslEM6oDbqCbCiYEx2Z3yHLhI5l5ixU5sFbvMvy0QQLH8
	 CGYSoAj+3Ppq23Z9PqY7BIJD7zRf0/fx/ttVHqfhgkwPsXhN4mjNNoAVnqpcJDcQe2BJHhIagtkr
	 lBl8taBQ7AsvADFRsuSTcfCkQ+FxtR+y6lioiYFP8IyCwTSln4AGWMvqgcxlHrE6OYi0ft8zIile
	 sjOb2a5VEM8Z492AeK3+SWrO9GNKEmUnYl/jory6U6GujOcDuDhMal/kuShEB7uUgd7pVe99mKrc
	 /OYQndVt8qy3fqPHLGXmnfB22rD7Ljt7cp9KHvKXaMFkLxwyLl9ycNYcJaKvFmssKtqg/X5L5Qh3
	 4s/8fFevPYrsqLrFL9STywa8RKEdenZWBusTFMRWMGQX9O16eSLNPV7BS22/xAXM0s1XZwOB0x93
	 pfqqp4WIIdOY5lv3Ow6ivy1DIdtyZ6xFyCoPFQAXf+v3zA9TEws12aQ3Xi1Vwk9rcmye94xHlIdb
	 WpXpg9yapEe73lfAxomBY70l4iDk7KLB94EMc=
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
Subject: [PATCH 08/10] docs/zh_CN: add LSM/SafeSetID Chinese translation
Date: Sun, 15 Nov 2026 23:20:04 +0800
X-OQ-MSGID: <20261115152026.69082-8-zhuyan2015@qq.com>
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

Translate Documentation/admin-guide/LSM/SafeSetID.rst into Chinese.

Update the translation through commit c34921670736
("Documentation: Fix admin-guide typos")

Assisted-by: Claude:deepseek-4-pro
Signed-off-by: Yan Zhu <zhuyan2015@qq.com>
---
 .../zh_CN/admin-guide/LSM/SafeSetID.rst       | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/SafeSetID.rst

diff --git a/Documentation/translations/zh_CN/admin-guide/LSM/SafeSetID.rst b/Documentation/translations/zh_CN/admin-guide/LSM/SafeSetID.rst
new file mode 100644
index 000000000000..3f96df3ed776
--- /dev/null
+++ b/Documentation/translations/zh_CN/admin-guide/LSM/SafeSetID.rst
@@ -0,0 +1,82 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../disclaimer-zh_CN.rst
+
+:Original: Documentation/admin-guide/LSM/SafeSetID.rst
+:翻译:
+ 朱岩 Yan Zhu <zhuyan2015@qq.com>
+
+
+=========
+SafeSetID
+=========
+
+SafeSetID 是一个 LSM 模块，用于对 setid 系列系统调用进行门控，限制 UID/GID
+的转变只能在系统范围的白名单中批准的 UID/GID 之间进行。这些限制还禁止给定的
+UID/GID 获得与 ``CAP_SET{U/G}ID`` 关联的辅助特权，例如允许用户设置用户命名空
+间的 UID/GID 映射。
+
+背景
+====
+在缺少文件能力的情况下，需要切换到其他用户的进程必须具备 ``CAP_SETUID`` 权限。
+``CAP_SETUID`` 只授予以 root 身份运行的程序或显式获得 ``CAP_SETUID`` 运行时
+能力的非 root 程序。相较于文件能力，通常更推荐使用 Linux 运行时能力，因为使
+用文件能力以提升的权限运行程序会带来潜在的安全风险——任何拥有该文件访问权限的
+用户都可以通过 ``exec()`` 运行该程序来获得提升的特权。
+
+虽然可以通过为完整的 ``CAP_SET{U/G}ID`` 能力给进程树授予权限来实现，但这与在
+非 root 用户下运行进程树的目标相冲突。尤其 ``CAP_SETUID`` 允许切换到系统上任
+何用户，包括 root，这在很多场景中过于强大。实际中多数程序仅调用 ``setuid()``
+降低特权，而非提升特权。Linux 并未提供通用机制限制用户通过 ``setuid()`` 能切
+换到的 UID 范围，除非允许其切换到系统上任意用户。SafeSetID LSM 正是为了解决
+这一问题。
+
+主要使用场景是允许非 root 程序在不拥有完整 ``CAP_SETUID`` 能力的情况下，安全
+地切换到其他非受信任的 UID。该非 root 程序仍需 ``CAP_SETUID`` 才能执行任何转
+变，但SafeSetID 施加的额外限制，使其成为 ``CAP_SETUID`` 的“安全版”，防止其进
+行未授权操作（如切换到 UID 0 或创建/进入新的用户命名空间）。这为系统服务提供
+基于UID 的沙箱化提供了可能，而无需在大量非 root 程序上分配完整的
+``CAP_SETUID``。
+
+其他已考虑的方案
+================
+
+在用户空间解决此问题
+--------------------
+可以通过在用户空间完全移除 setid 能力并使用特权帮助程序来完成进程的 UID/GID
+转换。然而，这会影响大量与进程生成相关的语义，如 ``fork()`` 后不立即
+``exec()`` 的行为、父进程自定义环境变量或命令行参数、以及文件句柄跨
+``fork()/exec()`` 的继承等。因此，此类方案对依赖特定进程生成语义的现有项目
+支持度较低。
+
+使用用户命名空间
+----------------
+另一种思路是在独立的用户命名空间中运行进程树，并在该命名空间内授予 setid 能力。
+这样，进程可以在自己的命名空间内自由切换 UID/GID，但只能映射到系统范围白名单
+中的 UID/GID。遗憾的是，用户命名空间往往需要与其他命名空间配合使用，例如网络
+或 PID 命名空间，否则会导致失去 ``CAP_NET_ADMIN`` 等关键能力，限制了实际可用
+性。
+
+使用已有 LSM
+------------
+当前树中没有任何其他 LSM 能够对 setid 转换进行门控，也没有实现
+``security_task_fix_setuid`` 钩子。SELinux 对此钩子声明：
+"由于setuid仅影响当前进程，并且由于SELinux的权限控制不基于Linux标识属性。
+因此，SELinux不需要控制此操作。"
+
+使用方法
+========
+SafeSetID 在 ``securityfs`` 中通过写入 ``safesetid/uid_allowlist_policy``
+与 ``safesetid/gid_allowlist_policy`` 文件来配置策略。策略的格式为
+``<UID>:<UID>`` 或 ``<GID>:<GID>``（使用十进制数字），并以换行符结束，例如
+``123:456\n``。写入空字符串 ``""`` 可清空策略。为特定 UID/GID 配置策略后，将
+阻止该 UID/GID 获得 ``CAP_SET{U/G}ID`` 相关的辅助特权，例如设置用户命名空间
+UID/GID 映射。
+
+GID 策略与 ``setgroups()``
+==========================
+在 v5.9 中已加入对 ``CAP_SETGID`` 限制的支持，与之前对 ``CAP_SETUID`` 的处理
+相同。然而，为了兼容用户空间常见的沙箱化代码规范，目前允许具有 ``CAP_SETGID``
+限制的进程调用任意 ``setgroups()``。这意味着在这些 ``setgroups()`` 限制策略
+检查代码就位之前，**当前的 GID 策略并未提供任何有意义的安全保障**。
+``setgroups()`` 的限制将在未来版本中加入策略检查代码后真正生效，该代码将依赖
+于 v5.9 中加入的 GID 策略配置代码。
-- 
2.43.0

