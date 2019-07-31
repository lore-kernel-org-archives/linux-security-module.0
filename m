Return-Path: <SRS0=Q99v=V4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569FCC32751
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Jul 2019 22:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C701216C8
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Jul 2019 22:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WgfOcd+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbfGaWR3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:17:29 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:41641 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731370AbfGaWR2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 Jul 2019 18:17:28 -0400
Received: by mail-pl1-f201.google.com with SMTP id i3so38352803plb.8
        for <linux-security-module@vger.kernel.org>; Wed, 31 Jul 2019 15:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wWUVtXS/AXD8335Dh0MfmfyjjxhSNslzhtjFi/unWYg=;
        b=WgfOcd+GV4OVtIno0HQyfo43vO+tBTJBq9QqE6rV1M2zqAcxD7E/ZD5NsA7EhpUuc5
         45s7M16pcxOi4rEVdkQ+9hFbF71/H6IROYSjAGIzuKO3KcbZyB0V3asJufea/KwGp5SW
         Z5kUm/+pkMmllKBYgzvd1zuvdvEQsG3UHwOFfRGPsF4UA4yAvWSSZ/cFiWPX2+FziZc5
         2Mv9La03pwKvRun/H4eTMcwUSq9nm2Nn4rUedo3V1XrZcfmbQ1J6qPvC2pkSFmY0UYmb
         CH900MEmb5G5qo33u9sHDlHQbBiVKeDw/9aqsLb9CfjGVDzAeu+88OEkv0NPeG9L5okI
         3UNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wWUVtXS/AXD8335Dh0MfmfyjjxhSNslzhtjFi/unWYg=;
        b=nYIg4Q9T3zMypyGd/YT4FelEXOuBSckuqXJsYzbvM7ipZ6xXSAtl9RfsTTwjDFA8Eh
         NTlzLhzPcsJkzHnfA+DPFM854wBvC6rBpDRErV8+Vg/8ItUA+brtLZ9qH8CUL9OQzouD
         VJ4erD2mGTu2RqtsA19kSpF/BfL+BJsAJZWeYLmjmSAK5d7drsnWyrCyL7H1fDEFFDz0
         1PsdevVailWHZqumb1jWAwPZHCv5BcH5cQhsJG+zeqqCt/Rpje2kuGzCtfT7uPNY8bI9
         RxxWyAfx5WUI4R/7wwX2YSscZ+DWv246gFoWTn2x9/8/pj1wzurN+7+xNDl3kTeEt3wS
         zSLA==
X-Gm-Message-State: APjAAAXPYs+N7ViiquCmcRJObmY9Ma+0/hBQPcZBvaW2SWOgiM3+T/zJ
        2Wb/uU2TTKpNCmr7V+OgimVQ9u80OS1NjfIH5v8VpA==
X-Google-Smtp-Source: APXvYqy+X2dzCHtRPst4ysDD9BbNu7qMVvFfzAyzKqmC9bYr5tZu+RgvWdURQcxGPILgA+Sxs9/P5zStyGUFpMScbfDltQ==
X-Received: by 2002:a63:d30f:: with SMTP id b15mr114671377pgg.341.1564611447877;
 Wed, 31 Jul 2019 15:17:27 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:16:12 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-25-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 24/29] Lock down perf when in confidentiality mode
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
index c1f52a749db2..5c520b60163a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10826,6 +10826,13 @@ SYSCALL_DEFINE5(perf_event_open,
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
index 1b89d3e8e54d..fb437a7ef5f2 100644
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
2.22.0.770.g0f2c4a37fd-goog

