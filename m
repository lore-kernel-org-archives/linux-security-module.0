Return-Path: <SRS0=y35J=WQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39D8C3A5A0
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Aug 2019 00:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A5322CE8
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Aug 2019 00:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHQV+bc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfHTATO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:19:14 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:52633 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbfHTATN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Aug 2019 20:19:13 -0400
Received: by mail-pf1-f202.google.com with SMTP id a20so3520237pfn.19
        for <linux-security-module@vger.kernel.org>; Mon, 19 Aug 2019 17:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SWzpT147tCKuH/oJTsJ3VrcaxfdUFKv8ds0JG4GiFSY=;
        b=EHQV+bc9TXTCrfRPG8bkkaSnOFigWkj9dXi1eDR7rjHTlRlucdTw/UFKyyxdsYbmAC
         FQckkCxclwBYXwS7LW0xVdfnDOjrk4D8osCtDmyLWja8qVv39kB771nlwhKy0fcM8G/d
         YmZ0EcFswmBwf2D5bwT5q/y9xDL5m/FPXF68lP7fmzaNksewzCj6csVrGoZjsRGf+qXb
         5CzOT8Q54XyNEh1X2eapAkOy4RbNi7IpKt4UDNssbJ3JWTcRfIrAEZLPnC0/oy9YKtV7
         wuN0W8Y/EgFaVlLlFRDlgYNHXkJJyKjRZWlwPzuoLE+OmyVyAyz9gZFzMZUq5X3duq8X
         nhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SWzpT147tCKuH/oJTsJ3VrcaxfdUFKv8ds0JG4GiFSY=;
        b=HWEltD94gLLYe8ySKq7PK/yYO6ivK+KhofDp1D5e3g7DPofp1WTt6Y81iQg0FRqYna
         unJq/lbRFudus4S46VwttVuDcyAikAzwrctFUzLG4tqOiF8VJq8Z5EsY6GsUKztZYSZ+
         L9qyJ1ovSLs2en2n/k4nJ0pBZ/I1qUHL0GdT3eTJIf1dcpujLuhRI6XMR8j1l5MVvML7
         /fsBr3WaWS1UwFvMnhoLbdB4bJwzHcNKISYFsYMTQuybjMviGvajX8Dw+i8ztupzarhQ
         TF4N5KDuCB8zNRYCW2OERpwMSx/qqufxkQjtjnVcvVnDfpjf8UVdlvGhl2dhKz6Yi+A2
         GV4Q==
X-Gm-Message-State: APjAAAUOSdUrRoT8nYMELw6b3sqA4QtnKIMs3TKl0sY+xCiPGHFMkygK
        +GXyvYKoSOn99NynkSMTvpiE6YptlRM/Kc13TeHNLw==
X-Google-Smtp-Source: APXvYqy3T3xOZ3OC9eye1W57qGnc5hILVQiaU7tjW3elKXxqq/A6iItV6wLMZTnHlNr4EkOli22l+AoNki42WA9FP9tppw==
X-Received: by 2002:a63:7709:: with SMTP id s9mr21692152pgc.296.1566260352401;
 Mon, 19 Aug 2019 17:19:12 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:18:00 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-25-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 24/29] lockdown: Lock down perf when in confidentiality mode
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
Signed-off-by: James Morris <jmorris@namei.org>
---
 include/linux/security.h     | 1 +
 kernel/events/core.c         | 7 +++++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index e604f4c67f03..b94f1e697537 100644
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
index f85929ce13be..8732f980a4fc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10798,6 +10798,13 @@ SYSCALL_DEFINE5(perf_event_open,
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
index 2397772c56bd..3d7b1039457b 100644
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
2.23.0.rc1.153.gdeed80330f-goog

