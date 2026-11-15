Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794756046;
	b=xUmhxdoE8wiDI0iHA2or6J2mYioiLSfPnR4Nu0xnn896E/E08Pz8rCV/TK3ldPLTAJsd
	 MnbKdw0q1TPRLtn3tx3giYWIBHbSiF0Vfrr4SQ84/PvDuCTkEvO5v3FNREuTPikUDFXiv
	 7hFqg+XldBr5aKtXeQ1Zz+e/YMmdkFAoitCbIz+WXIgUcuwYmgSXiWYIFIZq2VXgVnqZb
	 yiZuyKzo2MQWytTXRHfdNh2tfiq2UlkmTsNoT1cSPENtBLVNoInjdJypJ5JVZo0zSoV3h
	 S+mUlFJepMMBNEwNR2Kf/8LoRM1bzKoTNh/VgDfIEm3L7YyrFs6/gwEvW5ejeqWGlvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756046;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0PANv8T8h90ZbIlyN/IEyMg70LoIbnAv57ZiFsopnkg=;
	b=rIWG4mpP2V1JAeirriQ3GFRkIQy9UYEzhCquvdgRV7ufZbhCGSO2r1Roo5e6LYIh1u+Z
	 Lo7ZSYeles9j6tTdaWC16mTBQRFwd6/dtouqLcIcA/cOPLli14CA+wS65NbQZ/L5ZPw2/
	 sdQffyg7LcOBVjSNCPSsiuBGcPEJJGWJlwhaB3/EOHZqh6+jShXqbv7+AeMEsT0f9RHQQ
	 x0SslLvlwYAoOnellYMjqs5mdT9zigEoutKR1U8wDHBqhi2Qi94QwnWnAfPpOaoghKanE
	 6IKaqRqOfk7RnBmOczBdp4r4xolkIQqWFqzy4oI5UkVaeLS7dAeasU3w47IG2JTRplw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=QGusQCei;
	arc=none smtp.remote-ip=162.62.57.87
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BD9606A329;
	Sun, 15 Nov 2026 15:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8BD9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=QGusQCei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794756040; bh=0PANv8T8h90ZbIlyN/IEyMg70LoIbnAv57ZiFsopnkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QGusQCeivBZ2tEilSw0hhlMCmvQG5J4tg5heCxdAghkUg0gPf1R/LfA2+XzdWSu+Z
	 w3C0Rt8J7E43xhfqJ9hA3yiXmONU7XOwFWnN3wKehZx65B5Hg/8A80Mtn9zpehXE7O
	 7C8R4evQQsJmZjOzz1E6NqiKx0sidhqS8fk+i7w8=
Received: from 172-1-1-128.lightspeed.hstntx.sbcglobal.net.localdomain ([163.125.232.4])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 5169F010; Sun, 15 Nov 2026 23:20:22 +0800
X-QQ-mid: xmsmtpt1794756037tf5qz2dwr
Message-ID: <tencent_58599B779D476D63C80830EF7C2E66968508@qq.com>
X-QQ-XMAILINFO: N0PTwYhxbheSQ0QYQsfVWeH0LBYlrkU9eo7fnXNIlB+r4BQXY4qmzRW9qmlVjx
	 R3JUgvf2HLzP89Wr9DFmyhNLI946y/vdH7kruM+A4QSQevinE7qwVQJEEcdfAOj2Qx1VrldxyySV
	 9/TxQo/PoTT5H8olVoz91IiXfFWtMdt5OpvurCt07Y5/fx/xTTisYryobl19VWn4JVLNKodlUY8p
	 N/c9jQAbuoilA/Ou9etGFqgsZ2kAPPHzsAep/MKekgGjjikUatPmtX2iORmCg3gk5mRqJT+oau3Q
	 Q7E7cHSm8T5uFhcbEiFgSqCsnOyrw0Zxfhw3f9dUkzqd7bxlRGwzppQS5IKn7YtsRTmKSG57XBsG
	 dux5yHeXVfOWt9zfVElXGuGCR0h5BFON50934ACcKrVVUo+jKooT0uKsbnTXH6vNGUTftm8Yhdac
	 U4Uhh5ali7zjTisI2hRE1CF2DSdgiFEAlSnGuSl882sZ5kRtycRzMcWv7z55mWa0bgf3nMfkStXG
	 CUI1+gJfLbY+P9kL3s1ndz9NZejaHF4Oses1wO15S3z9/2L0jITu8ySD2/3ec+kkaCq/uLsiP2R6
	 +j7PJHkTwUZjDkag3MPn6ya918e+91OIUERCVlGaFTAxYQF/jLIrvurPWRkR/Um8Sae/YqEL1lTs
	 LQ0NadfsugMFqLJz9HA8la9J2NUfivQAa86qVcgQz11gjcxuWggQbyP0WonOfkfK+6SpnXz45V3s
	 lmpniNchEkW4fay2IQlWKl2yI3qu3mFm2QoiZFmvjWHm54zaVanUBHRmKk+ouvw6OpZmRbkaEpSO
	 1Qvsjk/1mjuncar3gErXEEVkSMf4v7tl6JnyJo1s7RYKs9JEE3bqFcr0DaGAJjIb3yfvjEyGzCFU
	 uv20whahfLTHwJSWDnr6O+x72J8RfKJfLhWdEiPKmTQxtNPkUcxU+RSOZoCnlikpXi0SzCZ5xfyo
	 bi3kl8cui8dEhwrKn9nNyIgjl5TQ48mpjrsHWYt3i2XYB9Rn6VkqSMr9oXP5FrMCFAvwl6G0vKJn
	 Ki3rEojqQAvu/9Jx6+QcaPfaseodEp4KmeQ2mZEwPHCjMxpN/xlHUClSde0nKp1LZtxDnZMMnFQl
	 d4y0B1T/7PO6jR7xItzlvkeLKBNYctehh+34SNqJd/fnJzya+dKvTRvyuAa+HDIw+rB8j1/puUO2
	 2azNceZHKJp5T/8IHxTvXGSjAJFrpwtMa/rBaUdGexHyoOoNaKXBD13/jI
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
Subject: [PATCH 07/10] docs/zh_CN: add LSM/Yama Chinese translation
Date: Sun, 15 Nov 2026 23:20:03 +0800
X-OQ-MSGID: <20261115152026.69082-7-zhuyan2015@qq.com>
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

