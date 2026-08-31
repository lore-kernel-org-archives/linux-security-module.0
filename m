Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086033C819D
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 10:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173944; cv=none; b=i+uoZiSD8eb0/lJIewx3CbYFu5g/+yDX0JOuNTko/J4+fl46AX7Kl+oP/HCwjUHhrZ/A6M3oV7/WoTVj9yMkmkLOYWK1lClQLdE5JhHxL2T8jfntWJ9fmSoF6Wl2+wUtlG/izMXuuS4gPdQ4cbEcXMaXoO6qGc59gq4dRkkDfK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173944; c=relaxed/simple;
	bh=k3QpJN8+I55g8FljqrOCQatYFMgxnbzdJ4RZK6pPUDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcvIPxiUyQ05xAW69d+WMLEpdMsSw0O4VVGcOUC8d1KNUsmvHlEbkmDcvGzUtUtY7BtSqlrUOqlBC3IGKykF0iMo7nbUDtSMOkSJquSMEgiYCpimXOU9vKPSQA8DTYvWY3tujJnUU+VK2fNkO6HtPwKWfw5U8+IjGID0FcaBjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixG+J5a1; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixG+J5a1"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-482e2904915so2259086f8f.0
        for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 03:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788173941; x=1788778741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dQnrI08QM+nCVE1+dkRjMX2+ccdW5vMfHjCDAg3RBlU=;
        b=ixG+J5a1l2fRVsn861M+crTbHrewieqrh7DuKVfM9vvtAcUHkZg4Nn992xpXrkh/FR
         8hfvKwdHK0cpr886inKlYmPXmKtDm5BWRVPiPbtrpzxCnSctZh0nhJOT7EfLm7ruRJ+C
         q9UYOedMrv9GVZZyHNWOIg817sCHlWLnm4YgyhxOxsZMbN7edz+KDe1HIF5912MVnFMW
         huOBGma66X/P9FYm/6VfU5vm/U6qVr28nrKrU5VbCdl4C6F56zF0JPNuXu8ZRoRkWHQj
         4exOTArhDGFlWWQQ9mVHrB0+nRSgfOC52Wq0BIlOKRA2SIPJ/5SYQa5H2/cZMIHXaY6J
         iH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788173941; x=1788778741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dQnrI08QM+nCVE1+dkRjMX2+ccdW5vMfHjCDAg3RBlU=;
        b=izpPOhIULgBGJLU1Lb3JaBp7ZK5ZZhfyiiaNQcbjRoR14jxgvarKCW22pwIjwJ49fG
         v+CgBLx/r6Aj+SWWFR4uPEpKrUAfV5Pd+gx6OwZTwo5bGHZEk9V3LPvS4m+jNTrwQd7u
         cAKCHomkMSYQwy2CEKk9gf/Y/uNRpE3YZQtg0ZWduzsSknzXhy3jyM0sK3Uda0xlU4Ef
         3iLJJ9VX2iBOu4t/3QLloLR5xkHVvGYWJXvGtOok18MequzcL6+5IoJ1Nv1k/du3sVoz
         qP1rEVLrAViArih2Nz1w23QVdO3PTXdaGpDz5Ta3uhplKJGlrTtXL/FdJicw87+ZeRFI
         fSfQ==
X-Forwarded-Encrypted: i=1; AKwUvBwo2lF9FJKkQtcHoGvqp22Yqrz9YY4sZNBL+51MMUF0eyA5pcEU44d/SHywaC1JvAP/3bNMVz2M4tCAkfLLKGD21TiB2Fo=@vger.kernel.org
X-Gm-Message-State: AFuF++l9Fl31akwQp93GYiR0C4L8yh/9ILi/5Vho+guxeu1ECLx3JfqJ
	qQpgq6f9beU7xL2Ga/hdJSyE0XGu095wQgOrHuwPCHauvX7djwPPXs/g
X-Gm-Gg: AYBFou37p6fCgFVavYaRTY6/pK7OHNCnt8uXiLTsBI4ldsggJ8CwYF8DiR/bdNRfiiQ
	DopcmcKENa8p3AzIEDlM7bc9U0BwOUheXDWoXccFp0yNkFREA0BpWQbhEvA2AEpB1SlmzUE0J0E
	9BI8FEvMpBfTHC7ewDYO5oBfit+MY/kiZm2cX6jV+LWvpjDvnE9QDkLrN+Fwas+fiDJf3MElRZX
	BpQQHYgblFHOSUXd4D1qVdcvMJOr5RhiNc75KF1CxY00ODkyN/YumnbE5J5B9IxkvKMj+tSy2ag
	4GCWSk+C9S7QYx4xwvMq2oFAoMhfHc6J8Z9zm16tVzzGaXosgB8evApodhrRoXkkEMx9Hhc+Rmb
	cGQgmZoMDMW3JhJRakVTB3aQXGMNJmYz24hCbG6uPWlc02hP/ePThTnPGDxxtd+hmzu0QGHIxNX
	OngbEVmoI8fRuQihtpX7hdmjEEpmej8ir2JfoEo7cMkeJH+3NJ7SmA1a00/8si3gPXNzUzB86hU
	AabArc=
X-Received: by 2002:a05:6000:4609:b0:482:e451:6810 with SMTP id ffacd0b85a97d-482f7976116mr43355819f8f.1.1788173941076;
        Mon, 31 Aug 2026 03:59:01 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484322ce2a6sm16110776f8f.19.2026.08.31.03.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 03:59:00 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf <bpf@vger.kernel.org>,
	lsm <linux-security-module@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 1/7] bpf: Allow BPF LSM programs to attach to more hooks
Date: Mon, 31 Aug 2026 11:09:26 +0000
Message-ID: <20260831110934.241898-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831110934.241898-1-a.s.protopopov@gmail.com>
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF LSM programs are allowed to attach to LSM hooks, all of which
are defined in the <lsm_hook_defs.h> header file.  From BPF's point
of view the set of attachment points is defined in the bpf_lsm_hooks
BTF set. By analogy with existing code, add a new header file
<bpf_lsm_hook_defs.h> which will also be included in the bpf_lsm_hooks
BTF set.

This change allows attaching BPF LSM programs to more functions.
The actual hooks are added in subsequent commits.

Each BPF hook calls a [__weak] noinline function each time a hook is
reached. This may be too expensive for hot paths if a BPF program is
not attached. A future commit will optimize this by adding a per-hook
static key and inc/dec it on attach/detach. This way disabled hooks
will be bypassed efficiently.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 MAINTAINERS                       |  1 +
 include/linux/bpf_lsm.h           | 12 ++++++++++++
 include/linux/bpf_lsm_hook_defs.h |  6 ++++++
 kernel/bpf/bpf_lsm.c              |  2 ++
 4 files changed, 21 insertions(+)
 create mode 100644 include/linux/bpf_lsm_hook_defs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 460cb7268845..d01dd1f096fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5035,6 +5035,7 @@ L:	bpf@vger.kernel.org
 S:	Maintained
 F:	Documentation/bpf/prog_lsm.rst
 F:	include/linux/bpf_lsm.h
+F:	include/linux/bpf_lsm_hook_defs.h
 F:	kernel/bpf/bpf_lsm.c
 F:	kernel/bpf/bpf_lsm_proto.c
 F:	kernel/trace/bpf_trace.c
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index dda272d78f01..1e54c7cca27a 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -16,9 +16,19 @@
 
 extern bool bpf_lsm_initialized __ro_after_init;
 
+/*
+ * Technically, checking bpf_lsm_initialized is not necessary.
+ * But if it is off, then this means that all security_* calls
+ * do not call BPF, and it doesn't look reasonable to enable
+ * only "non-LSM" bpf hooks...
+ */
+#define bpf_lsm_hook(NAME, ...) \
+	(bpf_lsm_initialized ? bpf_lsm_##NAME(__VA_ARGS__) : 0)
+
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	RET bpf_lsm_##NAME(__VA_ARGS__);
 #include <linux/lsm_hook_defs.h>
+#include <linux/bpf_lsm_hook_defs.h>
 #undef LSM_HOOK
 
 struct bpf_storage_blob {
@@ -114,6 +124,8 @@ static inline bool bpf_lsm_hook_returns_errno(u32 btf_id)
 {
 	return true;
 }
+
+#define bpf_lsm_hook(NAME, ...) 0
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/include/linux/bpf_lsm_hook_defs.h b/include/linux/bpf_lsm_hook_defs.h
new file mode 100644
index 000000000000..29bc0b514d16
--- /dev/null
+++ b/include/linux/bpf_lsm_hook_defs.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * This is a set of BPF LSM hooks, which are _not_ fully implemented
+ * as LSM hooks. Thus, they only can be used by BPF LSM programs.
+ */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 82c5988417a0..add344ea2691 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -28,11 +28,13 @@ __weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
 }
 
 #include <linux/lsm_hook_defs.h>
+#include <linux/bpf_lsm_hook_defs.h>
 #undef LSM_HOOK
 
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
 BTF_SET_START(bpf_lsm_hooks)
 #include <linux/lsm_hook_defs.h>
+#include <linux/bpf_lsm_hook_defs.h>
 #undef LSM_HOOK
 BTF_SET_END(bpf_lsm_hooks)
 
-- 
2.43.0

