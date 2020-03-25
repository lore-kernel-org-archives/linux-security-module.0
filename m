Return-Path: <SRS0=gnGb=5K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99477C1975A
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Mar 2020 15:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FC220409
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Mar 2020 15:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ddx1gQA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbgCYP0l (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:26:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33120 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgCYP0k (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Mar 2020 11:26:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id a25so3706366wrd.0
        for <linux-security-module@vger.kernel.org>; Wed, 25 Mar 2020 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nCrFodf8gzPXJ5e54+kF5dVCwH81VQJ2rk5gvSkpECg=;
        b=ddx1gQA6mgjT1fQJv0YrZQemVl9aUCukMi97PtvmM8V5exHN4Fy59YSLtBu65elyQX
         zcwFFRF5rgxIjariTbCfmKf9Dv/caquYRkJQuo3xehSKiMOrenQGRrgk+aqbGoSoHhnl
         a+SgLTVbZ7cUNhpbFC/ZI0Sz03jVPPpbaJPIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nCrFodf8gzPXJ5e54+kF5dVCwH81VQJ2rk5gvSkpECg=;
        b=FaC29muHHf/vvzSQuk/Zwfm5lVex1XXHbNbeIsreX4fiUBKxsksJ8cpnDKpBpIqGhV
         9Ony0BtBxLMBvvHrszwD2JKlH0XCbv6ZBRtf9h+s/spNcrQAn1NBqtTvbaATO0S7JkZi
         VBUonP07ZXnhH6i6Y8sS6SRSfbOS7GhaXh2qeNlCi9x2kGxH9kKnVoCbyVJ7QG445gGz
         W00z7mBYOSRfnZB8iKz/LARWyFuoZ4tjfdz5eJOhVDUYNMI8kPE9hKSunIwsEYACaO7H
         gosjT0mPQ0+NRc+ApavqRAL0krVY8prucqH49kW5tSDMJcB889J8TvF5mO2Hq7P4EIBf
         wSRg==
X-Gm-Message-State: ANhLgQ0UDNlxVuNqr2BjvcppFCAxSiXlxTIEgBguwJe4UDMP5hJm5XqP
        SoAWoYHztdzGpCfpqPRJY2PKsA==
X-Google-Smtp-Source: ADFU+vsPPRk4nc+/kq66l7nTyEn3zwq2klB7XWvJNiMRlZ6ak4SQGg4LGcAjV68LQUjo+WIS9W2mZw==
X-Received: by 2002:adf:9322:: with SMTP id 31mr4014249wro.297.1585149997723;
        Wed, 25 Mar 2020 08:26:37 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id a2sm4033701wrp.13.2020.03.25.08.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 08:26:37 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v6 1/8] bpf: Introduce BPF_PROG_TYPE_LSM
Date:   Wed, 25 Mar 2020 16:26:22 +0100
Message-Id: <20200325152629.6904-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325152629.6904-1-kpsingh@chromium.org>
References: <20200325152629.6904-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: KP Singh <kpsingh@google.com>

Introduce types and configs for bpf programs that can be attached to
LSM hooks. The programs can be enabled by the config option
CONFIG_BPF_LSM.

Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Thomas Garnier <thgarnie@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 MAINTAINERS                    |  1 +
 include/linux/bpf.h            |  3 +++
 include/linux/bpf_types.h      |  4 ++++
 include/uapi/linux/bpf.h       |  2 ++
 init/Kconfig                   | 12 ++++++++++++
 kernel/bpf/Makefile            |  1 +
 kernel/bpf/bpf_lsm.c           | 17 +++++++++++++++++
 kernel/trace/bpf_trace.c       | 12 ++++++------
 tools/include/uapi/linux/bpf.h |  2 ++
 tools/lib/bpf/libbpf_probes.c  |  1 +
 10 files changed, 49 insertions(+), 6 deletions(-)
 create mode 100644 kernel/bpf/bpf_lsm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5dbee41045bc..3197fe9256b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3147,6 +3147,7 @@ R:	Martin KaFai Lau <kafai@fb.com>
 R:	Song Liu <songliubraving@fb.com>
 R:	Yonghong Song <yhs@fb.com>
 R:	Andrii Nakryiko <andriin@fb.com>
+R:	KP Singh <kpsingh@chromium.org>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bdb981c204fa..af81ec7b783c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1513,6 +1513,9 @@ extern const struct bpf_func_proto bpf_tcp_sock_proto;
 extern const struct bpf_func_proto bpf_jiffies64_proto;
 extern const struct bpf_func_proto bpf_get_ns_current_pid_tgid_proto;
 
+const struct bpf_func_proto *bpf_tracing_func_proto(
+	enum bpf_func_id func_id, const struct bpf_prog *prog);
+
 /* Shared helpers among cBPF and eBPF. */
 void bpf_user_rnd_init_once(void);
 u64 bpf_user_rnd_u32(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index c81d4ece79a4..ba0c2d56f8a3 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -70,6 +70,10 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_STRUCT_OPS, bpf_struct_ops,
 	      void *, void *)
 BPF_PROG_TYPE(BPF_PROG_TYPE_EXT, bpf_extension,
 	      void *, void *)
+#ifdef CONFIG_BPF_LSM
+BPF_PROG_TYPE(BPF_PROG_TYPE_LSM, lsm,
+	       void *, void *)
+#endif /* CONFIG_BPF_LSM */
 #endif
 
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY, array_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 5d01c5c7e598..9f2673c58788 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -181,6 +181,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_TRACING,
 	BPF_PROG_TYPE_STRUCT_OPS,
 	BPF_PROG_TYPE_EXT,
+	BPF_PROG_TYPE_LSM,
 };
 
 enum bpf_attach_type {
@@ -211,6 +212,7 @@ enum bpf_attach_type {
 	BPF_TRACE_FENTRY,
 	BPF_TRACE_FEXIT,
 	BPF_MODIFY_RETURN,
+	BPF_LSM_MAC,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/init/Kconfig b/init/Kconfig
index 20a6ac33761c..deae572d1927 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1616,6 +1616,18 @@ config KALLSYMS_BASE_RELATIVE
 # end of the "standard kernel features (expert users)" menu
 
 # syscall, maps, verifier
+
+config BPF_LSM
+	bool "LSM Instrumentation with BPF"
+	depends on BPF_SYSCALL
+	depends on SECURITY
+	depends on BPF_JIT
+	help
+	  Enables instrumentation of the security hooks with eBPF programs for
+	  implementing dynamic MAC and Audit Policies.
+
+	  If you are unsure how to answer this question, answer N.
+
 config BPF_SYSCALL
 	bool "Enable bpf() system call"
 	select BPF
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 046ce5d98033..f2d7be596966 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -29,4 +29,5 @@ obj-$(CONFIG_DEBUG_INFO_BTF) += sysfs_btf.o
 endif
 ifeq ($(CONFIG_BPF_JIT),y)
 obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
+obj-${CONFIG_BPF_LSM} += bpf_lsm.o
 endif
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
new file mode 100644
index 000000000000..82875039ca90
--- /dev/null
+++ b/kernel/bpf/bpf_lsm.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2020 Google LLC.
+ */
+
+#include <linux/filter.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+
+const struct bpf_prog_ops lsm_prog_ops = {
+};
+
+const struct bpf_verifier_ops lsm_verifier_ops = {
+	.get_func_proto = bpf_tracing_func_proto,
+	.is_valid_access = btf_ctx_access,
+};
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e619eedb5919..37ffceab608f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -779,8 +779,8 @@ static const struct bpf_func_proto bpf_send_signal_thread_proto = {
 	.arg1_type	= ARG_ANYTHING,
 };
 
-static const struct bpf_func_proto *
-tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+const struct bpf_func_proto *
+bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	switch (func_id) {
 	case BPF_FUNC_map_lookup_elem:
@@ -865,7 +865,7 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_override_return_proto;
 #endif
 	default:
-		return tracing_func_proto(func_id, prog);
+		return bpf_tracing_func_proto(func_id, prog);
 	}
 }
 
@@ -975,7 +975,7 @@ tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_stack:
 		return &bpf_get_stack_proto_tp;
 	default:
-		return tracing_func_proto(func_id, prog);
+		return bpf_tracing_func_proto(func_id, prog);
 	}
 }
 
@@ -1082,7 +1082,7 @@ pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_read_branch_records:
 		return &bpf_read_branch_records_proto;
 	default:
-		return tracing_func_proto(func_id, prog);
+		return bpf_tracing_func_proto(func_id, prog);
 	}
 }
 
@@ -1210,7 +1210,7 @@ raw_tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_stack:
 		return &bpf_get_stack_proto_raw_tp;
 	default:
-		return tracing_func_proto(func_id, prog);
+		return bpf_tracing_func_proto(func_id, prog);
 	}
 }
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 5d01c5c7e598..9f2673c58788 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -181,6 +181,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_TRACING,
 	BPF_PROG_TYPE_STRUCT_OPS,
 	BPF_PROG_TYPE_EXT,
+	BPF_PROG_TYPE_LSM,
 };
 
 enum bpf_attach_type {
@@ -211,6 +212,7 @@ enum bpf_attach_type {
 	BPF_TRACE_FENTRY,
 	BPF_TRACE_FEXIT,
 	BPF_MODIFY_RETURN,
+	BPF_LSM_MAC,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index b782ebef6ac9..2c92059c0c90 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -108,6 +108,7 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
 	case BPF_PROG_TYPE_TRACING:
 	case BPF_PROG_TYPE_STRUCT_OPS:
 	case BPF_PROG_TYPE_EXT:
+	case BPF_PROG_TYPE_LSM:
 	default:
 		break;
 	}
-- 
2.20.1

