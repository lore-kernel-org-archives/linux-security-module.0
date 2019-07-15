Return-Path: <SRS0=DosV=VM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96006C7618F
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jul 2019 20:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F62B20659
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jul 2019 20:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JJBIrjjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbfGOUBt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:01:49 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:40672 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732617AbfGOUAx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jul 2019 16:00:53 -0400
Received: by mail-qt1-f202.google.com with SMTP id e32so15818416qtc.7
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2019 13:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uhU8rRk9ssWJivLHP7v3OR1+99tdkTFoizPFQKNdwe8=;
        b=JJBIrjjJzae8JoufMUY5p2Xzah+XXUlMVPZRSmZOY36Jgo20AhbpPZawkEBT4xt9CI
         UMnuaCruuSHuXXvqdFZBMtwSvl4t0IqdLAWwTmYA52CfjZGA3E4i8Gfl2ESgAszhKDWH
         1oEEltwJN2uPQ3KjZNWNFT+0uMtDU4H1avgCjsBQu3I6RhBh3srjJDwJPD1QLjUhDVdU
         8+jctr+k5408YV2PlndTV18NE43rC+ipzp7az2r5gd6dXRRGRlBBoi/2hUPYmZ30+PCU
         X+MNhgkwY1Y72MueKA0y585tPXunJy8hcgIfBqY/aBrhr2wnBn2wAliTIc0u45bqvkWY
         qb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uhU8rRk9ssWJivLHP7v3OR1+99tdkTFoizPFQKNdwe8=;
        b=B2jVrH1SCdxfLARQUQWIGbov//7x1dkZ8f0t7raBsYXRW7hA4tVHdMmEyU3PKXQshA
         ZeyVCTsbog4hzCJ6Kd/L01UmuhxBAHWKtHlrU5N3NMf/ReXUUXjTAQhmxlwzdM45Gf0v
         DqKVrUSLeil3L7qq5Qlb0SCDGIUIuQ6qWSKGCuNDwmcgo501mgz66eYXtxnZ/BudNgt5
         60a/kXj5+vBdz4E2hx6kKF5TNK2NDDcxFKvwqnO/Nkqfn86V2fsfDbecCQ8eUusJ9d2b
         HRsYD1SWvVrP/gOhOu1osf2LLI7iN7105vQY7fZYwFTpkcf5hzxzepf1kkl1L40LZcu4
         PVvA==
X-Gm-Message-State: APjAAAWgu1vmyb+AYLbk2xmU7Vo2W0/isAr1f5J8vGFb5x45tbJWqsB7
        SmFQ0XhLGauxO1sCe0Fq8aVDGZMDoENeGbLJrVKSUQ==
X-Google-Smtp-Source: APXvYqylW6r3pfE8eFjlmMirtVudGlaMh2+nmiRimFW5pWQ7r+wx5kZxLBjObC/dT2zgY9YDhkhq0AHf3oUq3xTxcd/s4g==
X-Received: by 2002:ac8:142:: with SMTP id f2mr19678032qtg.336.1563220851847;
 Mon, 15 Jul 2019 13:00:51 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:39 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-23-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 22/29] Lock down tracing and perf kprobes when in
 confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Disallow the creation of perf and ftrace kprobes when the kernel is
locked down in confidentiality mode by preventing their registration.
This prevents kprobes from being used to access kernel memory to steal
crypto data, but continues to allow the use of kprobes from signed
modules.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: davem@davemloft.net
Cc: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/security.h     | 1 +
 kernel/trace/trace_kprobe.c  | 5 +++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index f0cffd0977d3..987d8427f091 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -117,6 +117,7 @@ enum lockdown_reason {
 	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
+	LOCKDOWN_KPROBES,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 7d736248a070..fcb28b0702b2 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -11,6 +11,7 @@
 #include <linux/uaccess.h>
 #include <linux/rculist.h>
 #include <linux/error-injection.h>
+#include <linux/security.h>
 
 #include "trace_dynevent.h"
 #include "trace_kprobe_selftest.h"
@@ -415,6 +416,10 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 {
 	int i, ret;
 
+	ret = security_locked_down(LOCKDOWN_KPROBES);
+	if (ret)
+		return ret;
+
 	if (trace_probe_is_registered(&tk->tp))
 		return -EINVAL;
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 9c097240a3a6..ccb3e9a2a47c 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -32,6 +32,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
+	[LOCKDOWN_KPROBES] = "use of kprobes",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.22.0.510.g264f2c817a-goog

