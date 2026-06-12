Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFD53876A9;
	Fri, 12 Jun 2026 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781279982; cv=none; b=rhUPloVgb03CpCq9995pSs42q5ddm+7kVCqZQvCIMN7eg8MmIA08ATBc+OcOSEWljumyH9EwSE629LcZDT5mdnic1AKMjwC09PDgD8LmyVSUlGXXemYnTr4ZDC/mu19VQIFa86YfQw80b040EehvO4LgVamTE2jYN1vnVRUZ1ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781279982; c=relaxed/simple;
	bh=jVQUnmMlqBvxVmfxOoPWYL1MattybvdDlNA4Iz015lQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMUY5LYCD96mRTzFsESjug3b8jKI+8ckK7NKIQm2kY8puuqT/F+TFpY5+8XDNjQ+1re+YX7E2AkFehSFqS6MlWe8TGNs1CuGYqZcgf77OrPPIajYfHKZKRECBhQtFaTInXFwUqw6heMrYtbzB6eYIrA0SwRS0U6Jszq3XmSmOjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ImgVhXPP; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ImgVhXPP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781279978; bh=0PANv8T8h90ZbIlyN/IEyMg70LoIbnAv57ZiFsopnkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ImgVhXPPM+lHTV5NoWYZz5O2mTWY9nCVZ4Z8gPJUbYPGHJFrCpgLCDjiBy5oTn2Ia
	 QkBls6ua/46PhzhQS/e39iXBc67B09HErqwgqoi3t8GOQBKqQSflz5Fdodm2Q00iE7
	 hhDbj5yuBP9tcDcCyvahlYJH3AL29Lvbxjn8Milk=
Received: from 172-1-1-128.lightspeed.hstntx.sbcglobal.net.localdomain ([27.38.179.189])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id EDDB30C4; Fri, 12 Jun 2026 23:59:29 +0800
X-QQ-mid: xmsmtpt1781279976tdix2g0b0
Message-ID: <tencent_D565966559E777D84773634D0813EFD52E08@qq.com>
X-QQ-XMAILINFO: NepF8YL2AyLPTmPPh+6NEsV3p7tbeIN38dkWZMRm2o9i0TYFEdjo8rWj1kDb4N
	 /otf/le53gCSWDs4xqjznPQE6mCfbG16+VMpjmi6nF1zXLBTL5ux8x70m0qEfgAESfpVkV2R+N0r
	 LlqAfelj6jHYy9bWRtC8RUZGwNpo+C5acdVUJcfLZfTvlAK99pY3W6w9RXC2zo9TdfgTNSzk+Vcu
	 Z21glDoG/ma/UhUbcvnaQYjE0pEoQA1MhKJAlpKc8dMhs8ro0vudwojkU/QPsMw9tGkcF5WFTEuf
	 jaFP3AAKRgFeJ+R2C8S5SjW9zFzxJtOaXntgsEaQHTTGScorJyC9G0Rp1ib7FewdCyU4Ji8oZyd5
	 7mi2T/LYVN3/qiLJdvhWbfgA8uodwdpcPSSO4AGnbmz0R+9s84HQdkslXqc87NskE6WlxiN1kEXt
	 /NipBHHCSI1sBUDEwtNNBu5N4oEF5CQoo5tdRJz+4YOlylcyibj5IrM7TCmcJx1rXRLqLQyD1rT8
	 xvprg3eFJsIpcZtM7a37mmxlEzMxcT+oGMvO6LyPKFgqXl8V3Aa/x7amEIp0Rrzp81pbHNbOkkLX
	 VUWL/F7X5p7ARaQwO/NHgvskYXHrcm06NLNBFYvoqB8tpGrT62ftl2jrG25Y8s4jP3tiBegxluJ4
	 AMnvmt2iG2PPR5Wzp4BOPoVRhXScsMd/YUofCe/ZTNt6kwfN77xZoWAyKdr0+XW+zosEHnEULnEj
	 0Sc5U/5DZiEcSvczfQzSVq38t2Xk1cAqX7bB09FPEGjeiqD2znkQEXV3GvAWwH9lTwy39aEeIAIW
	 HA/yt1HocYhP2B+5icTqjgGZef7dZd+y985kozlnOkYCkF2JfotKCLxAsqQY3t+Y+2yLLzcA3pVh
	 ZSj32hAR/8y42i7JjccY6w8ufTv2ZUkTy5vCPZ/Zai3d06CuCJe/IvagiROaFebwxRvq1YMXHFEZ
	 j6E1vJ42aGjz9kLYo5MBx2uIp3vTkwazVSYCFo3J7msOEkCyKQDrTeEqtL7aAFxqaIxS7tr6nYan
	 h4D94BRcbEf0LYPI03RbQprSZbOePBq9x1FqfB/bPJLHHMUVS5neOZM8JintlxWZ3Nw9vW4GzcSX
	 J5kKUtkjlIneT0RZ88rjjOQRKDwAgpcMrP/hFQy2FqLZEfW79Eqapdkm7oTY7BjSINs7sc
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
Subject: [PATCH 07/10] docs/zh_CN: add LSM/Yama Chinese translation
Date: Fri, 12 Jun 2026 23:58:26 +0800
X-OQ-MSGID: <cdb20531b4be633a8dc14f047914f460dfcab5f8.1781105672.git.zhuyan2015@qq.com>
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

Translate Documentation/admin-guide/LSM/Yama.rst into Chinese.

Update the translation through commit 9d1bd9e8e028
("doc: yama: Swap HTTP for HTTPS and replace dead link")

Assisted-by: Claude:deepseek-4-pro
Signed-off-by: Yan Zhu <zhuyan2015@qq.com>
---
 .../zh_CN/admin-guide/LSM/Yama.rst            | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/Yama.rst

diff --git a/Documentation/translations/zh_CN/admin-guide/LSM/Yama.rst b/Documentation/translations/zh_CN/admin-guide/LSM/Yama.rst
new file mode 100644
index 000000000000..ada3ec079432
--- /dev/null
+++ b/Documentation/translations/zh_CN/admin-guide/LSM/Yama.rst
@@ -0,0 +1,71 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../disclaimer-zh_CN.rst
+
+:Original: Documentation/admin-guide/LSM/Yama.rst
+:翻译:
+ 朱岩 Yan Zhu <zhuyan2015@qq.com>
+
+
+====
+Yama
+====
+
+Yama 是一种 Linux 安全模块（LSM），用于收集系统范围内的 DAC（自主访问控制）
+安全保护，这些保护并不是由内核本身直接处理的。在编译时可通过
+``CONFIG_SECURITY_YAMA`` 选择，并可在运行时通过 ``/proc/sys/kernel/yama``
+中的 sysctl 接口控制：
+
+ptrace_scope
+============
+
+随着 Linux 的流行度提升，它将成为更大的恶意软件攻击目标。Linux 进程接口的一个
+突出弱点是单个用户能够检查其拥有的任意进程的内存和运行状态。例如，若 Pidgin
+被入侵，攻击者即可附加到其他运行中的进程（如 Firefox、SSH 会话、GPG 代理等），
+提取更多凭证，并在不依赖用户钓鱼的情况下扩大攻击范围。
+
+这不是理论上的问题。已有文献记载 `SSH 会话劫持 <yama_ssh_hijack_>`_ 和
+`任意代码注入 <yama_code_injection_>`_ 攻击，这些攻击在允许 ptrace 如前所述
+时仍然可能发生。由于 ptrace 并不是非开发者和非管理员常用的功能，系统构建者应
+当能够选择关闭此调试机制。
+
+一种解决方案是某些应用使用 ``prctl(PR_SET_DUMPABLE, ...)`` 明确禁止 ptrace
+附加（如 ssh‑agent），但大多数并未如此。更通用的方案是仅允许父进程向子进程的
+ptrace（即 ``gdb <child>``、``strace <child>`` 仍可工作），或通过
+``CAP_SYS_PTRACE``（即 root 仍可使用 ``gdb --pid=PID``、``strace -p PID``）。
+
+在模式 1 中，软件可以通过 ``prctl(PR_SET_PTRACER, pid, ...)`` 为调试进程与其
+子进程之间定义特定关系。子进程可声明哪些进程（及其后代）被允许调用
+``PTRACE_ATTACH``。每个子进程同一时间只能有一个此类声明的调试进程。例如 KDE、
+Chromium、Firefox 的崩溃处理器以及 Wine 用于相互 ptrace 的进程均采用此方式。
+若进程希望完全禁用这些限制，可调用
+``prctl(PR_SET_PTRACER, PR_SET_PTRACER_ANY, ...)``，从而允许任何已被允许的进
+程（即使在外部 pid 命名空间）进行附加。
+
+sysctl 配置如下（仅在拥有 ``CAP_SYS_PTRACE`` 时可写）：
+
+0 - 经典 ptrace 权限：
+    一个进程可以对任何在相同 uid 下运行的其他进程执行 `PTRACE_ATTACH`
+    操作，只要目标进程是可转储的（即未转换 uid、未以特权启动或未调用过
+    `prctl(PR_SET_DUMPABLE...)`）。同样，`PTRACE_TRACEME` 保持不变。
+
+1 - 限制性 ptrace：
+    进程必须与其欲 attach 的子进程预先建立关系。默认关系为仅限其后代，且满
+    足上述经典条件。若要更改这种关系，子进程可以调用
+    ``prctl(PR_SET_PTRACER, debugger, ...)`` 来声明允许的调试器 PID，以便在
+    该子进程上调用 ``PTRACE_ATTACH``。使用 ``PTRACE_TRACEME`` 则保持不变。
+
+2 - 仅管理员可 attach：
+    只有具备 ``CAP_SYS_PTRACE`` 权限的进程才能使用 ptrace，无论是通过
+    ``PTRACE_ATTACH`` 还是通过子进程调用 ``PTRACE_TRACEME``）。
+
+3 - 禁止 attach：
+    任意进程不可使用 ``PTRACE_ATTACH`` 或 ``PTRACE_TRACEME``。一旦设定，此值
+    不可更改。
+
+最初的仅限于子进程的逻辑源自 grsecurity 中的限制条件制定的。
+
+.. _yama_ssh_hijack:
+ https://www.blackhat.com/presentations/bh-usa-05/bh-us-05-boileau.pdf
+
+.. _yama_code_injection:
+ https://c-skills.blogspot.com/2007/05/injectso.html
-- 
2.43.0

