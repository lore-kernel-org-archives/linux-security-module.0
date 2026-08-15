Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0EB364E98
	for <linux-security-module@vger.kernel.org>; Sat, 15 Aug 2026 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786792850; cv=none; b=car0u29cQgjo1OZkgYrcIPXud5M6O6pHSRasKCEjL0NLetzFSVtdYrtKOduTsnmIjJdc/ffud5jsqkKyGiAKVhLJS5/N2rH1ZA190+GZh6DW5NcsZlPaiyWfE4pdFn3ZCSu7HAYDzpUS8bTdlH7PDMtuxK+OEtWZCbRXqD3B6bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786792850; c=relaxed/simple;
	bh=XyDeqj2fD+0+G3mRSLG62bdrTVlYw2OMacrjdWijgkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAUDNPLdalAwCTf6sSJSjSviwD23AYG6Jdtf+uca8LL9ajYJeSBrT+0kumYjiikIwYigVP/+6xtxTNKUupNSjHSP/zOxj4bz8/cNxXGo0y9b838zanXL86C7xIUYgttDGaQIGo1Iq/iHYt2/D4M6RiDs+Vaka8HMkhCFhuHWMMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oBdXc3uX; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBdXc3uX"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-669944f60b3so2076534d50.1
        for <linux-security-module@vger.kernel.org>; Sat, 15 Aug 2026 04:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786792848; x=1787397648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pj7Fxr4MHKxBNNl7rVyxiVL6srT0xXkYcTtb3hLd+N0=;
        b=oBdXc3uXB5KSDW8gAAIZW3cd0PbRUAb6Rg5NRyioLs/34ZgbPnZYjj6kdjbiWr0C2b
         T5IzLPLD5WyZLVcu53eBpvSTZ3HUZwKsuCU/npWEonWqRBgbqtBuPEjxnTnub81tzbax
         RYSWuPLWMZtknIKoJAwvfeyBAv/nIyloxrrxWUmAYIF2NwFmohpyUK+wxS6KpT/HQc+U
         qaLhlgYAw8hsOZ2yeYfceLcjCm+8HWL7oEWa6cuAgPaK0C1Ae7s0HBit7E8beIREf2fG
         DIWL2GT2oDnBqNBdedXmr6AEDYhIPhjbYvYCIlo+59GTTjKNo35F23lrkVaHDPywioRw
         Ethg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786792848; x=1787397648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pj7Fxr4MHKxBNNl7rVyxiVL6srT0xXkYcTtb3hLd+N0=;
        b=mmJ1BQyHbyV38jZB04CylvU0+CJQ3QZ8qznLWgzsMI4ptOC0lQj3kb4loqvcZWYfJA
         iGiwjjSnhsWc+u5LXnRK8GX9OHK9X3uoTc/EUKfPxhjdMUJkSvoMuSTWqEjK0xP1N7E2
         Vv+63Zswum3yVe8LyaFawpezAO4xh/Nc8P6gownSE4E2S5dJUDimoDYs4n+GZxnTmRfF
         024dIl8nBKF8WSNe5Can7+6/bao5lLnrCfpAvqMq1RgdEpNHTpIUmaw4REbcowS/eBx5
         dUkFao7921p/pApMTmiY+8tApzrX4O4CGUFxOLW88tfr0OXKe+mzP2JL2MhFXWqa3QX3
         uouA==
X-Forwarded-Encrypted: i=1; AHgh+RqTE70kmxEykzYQZDRPoKOshjZummFpbCBdhxOqNa+EUSuCRd/TB5USBv6CRuOyvRfpZf51iW5u+FfONup0pX24FM6wMgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAGhox8G28m8BuUEaK4Y+vjGph8nLWAsloIr74yH6A7weovyKe
	OpNm/Mm04cHAaRF7bywks42Gpdtb0/LXP8BVxSKuM24hdq47wDPcUGw1nSWw1wJM
X-Gm-Gg: AR+sD12Bg362QNhBAzb0DujYS4/X7C8XN52KymErMgvEd+HrDJMRu9qi2c1EFoTXrIm
	c3ZG0v0voRf1qYJfSzf/RyJ4phso6oyTeHsGQJhxpa3K7N8ERt0qOkY6rKNzLVTXQ+IjY2056Hi
	XL9vdSeF6T7Wk4F0fbff961ZT3x2NQ6uVBYSsuz3WMjrBIyRC8+t53biAhc3Z14ZejSq/SQWx0N
	1GmUi/LXt2Li7djnG3NjniGVOUWkMrkYGVjCYQPzFfhXpXpOUrqtv5x7e9OYe7fdH3ALZaqNcGE
	7Hmagob8SUtp8xwavGoPqG1OmdCV4/8K8QgOrSWvXqOYJlaLQ3WHG3wal1pw7QfxWvXKhidWURP
	q0VCWemvvT/RIBbUmrPNGKVE4yw2ZbbKI3AcfBmYHqArFVq1LUlF3CE4k+39SqP5tneMfOMO9Qh
	6F6hb0jC0anrDY7UuFiTrO4qC2u0psN73Ma3zZrKHKKsRFttBeBNu1A9ttl5iYOFB6bU62789rC
	zjYxHhnOdBtvjapyRYN3C0=
X-Received: by 2002:a05:690e:1247:b0:66a:f513:5053 with SMTP id 956f58d0204a3-66c72b1bd27mr4460525d50.10.1786792847796;
        Sat, 15 Aug 2026 04:20:47 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:31f0:efe0:f2d8:ae44])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836c36a84d9sm24388037b3.46.2026.08.15.04.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 04:20:47 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next 1/2] lsm: add bpf_security_locked_down() kfunc
Date: Sat, 15 Aug 2026 07:20:40 -0400
Message-ID: <20260815112041.1248855-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260815112041.1248855-1-utilityemal77@gmail.com>
References: <20260815112041.1248855-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new kfunc bpf_security_locked_down, which calls
security_locked_down and returns the result.

Create a new file security/lsm_kfuncs.c for LSM framework kfuncs.

Reject reasons outside (LOCKDOWN_NONE, LOCKDOWN_CONFIDENTIALITY_MAX)
with -EINVAL before dispatching the hook. Limit the kfunc to
BPF_PROG_TYPE_LSM and BPF_PROG_TYPE_SYSCALL programs, and refuse it
to programs attached to the locked_down hook itself, which would
recurse into the dispatch.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/Makefile     |  1 +
 security/lsm_kfuncs.c | 84 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 security/lsm_kfuncs.c

diff --git a/security/Makefile b/security/Makefile
index 4601230ba442..dee8ff218548 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_MMU)			+= min_addr.o
 
 # Object file lists
 obj-$(CONFIG_SECURITY)			+= security.o lsm_notifier.o lsm_init.o
+obj-$(CONFIG_BPF_SYSCALL)		+= lsm_kfuncs.o
 obj-$(CONFIG_SECURITYFS)		+= inode.o
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/
 obj-$(CONFIG_SECURITY_SMACK)		+= smack/
diff --git a/security/lsm_kfuncs.c b/security/lsm_kfuncs.c
new file mode 100644
index 000000000000..a324e7d978ca
--- /dev/null
+++ b/security/lsm_kfuncs.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * kfuncs exposing LSM interfaces to BPF programs.
+ *
+ * Copyright (C) 2026 Justin Suess
+ */
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/init.h>
+#include <linux/security.h>
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_security_locked_down - Call the security_locked_down() LSM hook
+ * @what: lockdown reason to query
+ *
+ * Return: 0 if @what is not locked down, -EPERM if it is, or -EINVAL if
+ * @what is outside (LOCKDOWN_NONE, LOCKDOWN_CONFIDENTIALITY_MAX).
+ */
+__bpf_kfunc int bpf_security_locked_down(enum lockdown_reason what)
+{
+	if (what <= LOCKDOWN_NONE || what >= LOCKDOWN_CONFIDENTIALITY_MAX)
+		return -EINVAL;
+	return security_locked_down(what);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(lsm_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_security_locked_down)
+BTF_KFUNCS_END(lsm_kfunc_ids)
+
+#ifdef CONFIG_BPF_LSM
+BTF_ID_LIST_SINGLE(lsm_locked_down_hook_id, func, bpf_lsm_locked_down)
+#endif
+
+static int lsm_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	/* Filters run for every kfunc resolved through the hook. */
+	if (!btf_id_set8_contains(&lsm_kfunc_ids, kfunc_id))
+		return 0;
+
+	/*
+	 * Raw prog->type: keep out the rest of the shared tracing kfunc
+	 * set (incl. perf/NMI) and extension programs.
+	 */
+	switch (prog->type) {
+	case BPF_PROG_TYPE_SYSCALL:
+		return 0;
+#ifdef CONFIG_BPF_LSM
+	case BPF_PROG_TYPE_LSM:
+		/*
+		 * A locked_down program calling this kfunc would recurse.
+		 * Match on attach_btf_id: attach_func_name is not yet set
+		 * when the filter runs from check_cfg.
+		 */
+		if (prog->aux->attach_btf_id == lsm_locked_down_hook_id[0])
+			return -EACCES;
+		return 0;
+#endif
+	default:
+		return -EACCES;
+	}
+}
+
+static const struct btf_kfunc_id_set lsm_kfunc_set = {
+	.owner  = THIS_MODULE,
+	.set    = &lsm_kfunc_ids,
+	.filter = lsm_kfunc_filter,
+};
+
+static int __init lsm_kfuncs_init(void)
+{
+	int err;
+
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &lsm_kfunc_set);
+	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &lsm_kfunc_set);
+	if (err)
+		pr_warn("lsm_kfuncs: kfunc registration failed: %d\n", err);
+	return err;
+}
+late_initcall(lsm_kfuncs_init);
-- 
2.54.0

