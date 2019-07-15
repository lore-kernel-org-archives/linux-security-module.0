Return-Path: <SRS0=DosV=VM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9B0C7618F
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jul 2019 20:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C016420659
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jul 2019 20:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ChqgzH2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbfGOUA6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:00:58 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:39702 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732683AbfGOUA6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jul 2019 16:00:58 -0400
Received: by mail-pf1-f202.google.com with SMTP id 6so10864913pfi.6
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2019 13:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6flDTB2cc+idlYkETJxAjqgCPIisACHtzrHaM3jrXOY=;
        b=ChqgzH2zFDK3tT4H5IhQ4S8ryxEnULmECSos4ucFSEGrnmOhH4smTTrqP3rLmwJ6bm
         nHqApST8qhDWjUtUcr05S+8nZlo1vwWRNXWvAH5yUG7B1wschRgRPDG81Xmrt0cTjm6s
         7rqClyqIOA12viOU8/hoPxZYow/PEP4KU1BVkH7NLkKaDTPJZ+EEy2X+6KtwhHhSjpY7
         /azlbfPRNT+YYiwAd0qDqEvJpgwfUi+gsZUtQoQnBN1qPg+us7qlLqvddyD4IpPC3m6C
         5cSUD3Klw3rDnkU7p39B7KGLg28nfmarFbFKQ2a2psShO56Euq2nph1i5SHHvAcsrVz1
         QFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6flDTB2cc+idlYkETJxAjqgCPIisACHtzrHaM3jrXOY=;
        b=AXEMF2b5scK7tYGWgNEQKdPVcTngD79peeuohtF2Jed2FOQqYhJ3Vhe6WQam3YOMok
         lvqWRmdBoTCTxVIrgfAKFxikH0nr5IxdRolcWsSX5Lfj283iBy4zMR/azyw/mDOj5kb1
         kOiCL4JQXF8MlUbxBfiNEF90SJdjNFyGtDytgbrLGSCNs4PPM25WgHsoc+lykUTC0QYw
         lDbEMCno4ISAamx3PJrGbhzbQQwAQpTgQHeiVwF5QcrAusl1mtE8FBYp3gbvfcLK3b/Y
         usEPK+QnG842hzAh7cMCTJUscFUSKzLnAOHxh+XwBenDbAsxZR0eWSFVxzoZiUUV64kr
         YFSA==
X-Gm-Message-State: APjAAAWnwUQlH/jjKIMsbOKqH7UVX9yZLKILElLg/0TvjVi9uId49kMu
        JSuj1YBVFECVm/7TNNILOzRUnwFmBWsJLJhg3frvlw==
X-Google-Smtp-Source: APXvYqxg52NsoxTabPM1Dv5rjomAok9LsWGgpqy0K2qiQR90JV7TUbpE8F353AcRIJ8oasv5d+Jl4wW0ZOgZMy7Slf0MLQ==
X-Received: by 2002:a63:1a03:: with SMTP id a3mr27318096pga.397.1563220857095;
 Mon, 15 Jul 2019 13:00:57 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:41 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-25-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 24/29] Lock down perf when in confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Disallow the use of certain perf facilities that might allow userspace to
access kernel data.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 include/linux/security.h     | 1 +
 kernel/events/core.c         | 7 +++++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 8dd1741a52cd..8ef366de70b0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -119,6 +119,7 @@ enum lockdown_reason {
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,
 	LOCKDOWN_BPF_READ,
+	LOCKDOWN_PERF,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 785d708f8553..738d6f1cf5ec 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10806,6 +10806,13 @@ SYSCALL_DEFINE5(perf_event_open,
 	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
+	err = security_locked_down(LOCKDOWN_PERF);
+	if (err && (attr.sample_type & PERF_SAMPLE_REGS_INTR))
+		/* REGS_INTR can leak data, lockdown must prevent this */
+		return err;
+
+	err = 0;
+
 	/*
 	 * In cgroup mode, the pid argument is used to pass the fd
 	 * opened to the cgroup directory in cgroupfs. The cpu argument
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index d14b89784412..e43c9d001e49 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -34,6 +34,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_KPROBES] = "use of kprobes",
 	[LOCKDOWN_BPF_READ] = "use of bpf to read kernel RAM",
+	[LOCKDOWN_PERF] = "unsafe use of perf",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.22.0.510.g264f2c817a-goog

