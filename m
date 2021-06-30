Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D5AC11F69
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Jun 2021 09:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B6661D08
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Jun 2021 09:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbhF3JkO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 30 Jun 2021 05:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbhF3JkN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Jun 2021 05:40:13 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7687C061766
        for <linux-security-module@vger.kernel.org>; Wed, 30 Jun 2021 02:37:43 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id 13-20020a1c010d0000b02901eca51685daso2504090wmb.3
        for <linux-security-module@vger.kernel.org>; Wed, 30 Jun 2021 02:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JhgrCS9Vj640V8x1cFNbO5yNaZtMM+Zz5JPkP+NN88k=;
        b=hOGR+88o6wgh2BS77C9e3IW5lpLeoKlfQpOyo0vBRi0/nOkMjDwyqlhB1sCe+OArkh
         9qxed+lEX/yr9DODAh2C+/67NHa38Ru3QIfEuTWy+N0mZPdR3yc9FmtU7HR5TSYrw4XR
         Pnbphx2nxpTq0y3aE6Xf1wIJNFBrQor8dRtXxpwz+UWHJbubCIMHVOdhrDBe7YaQ9KF1
         N4zqbDnQD4evL1iqNYm8CkXIeoIU8aKeMUq622KMpnRNff716iQW6ahiSRDH2jjddvWf
         dHcLiyQq9vn9oEC7xE6//J8vX3Onwt2Syz6i/JKPiGuxKlfK/BuNH3TSq8mNnz0JrMNR
         /Kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JhgrCS9Vj640V8x1cFNbO5yNaZtMM+Zz5JPkP+NN88k=;
        b=l478V+HdzT5g40nE5RoFWszpJFybIHNC2t+6AcDinGgAdgDQ8VjWLTKOlMZDfpYSIu
         3AmXElQCso9kXzfLvOvKVdqQ7OjYbxSvop6Y2GgDU1OADZwqbnY7VQs+H5NtvuBvP4FV
         MmztWlA+snLA+haKwect05MnG1P0Q5q+HvREaDCXo783p9ADQyGSPNPYyBmedGJDZuLh
         5kVasTi1d14K1kM2vulcJlCV3NNWa6XEskAJ2YcCb0l2hPe7tYZUnd+hDfNwqqQAffLE
         X/QeiQlvEFA+6NfEyRc6K282K5UpgRuFvWiJCA3AdcBP8letSxTHzsM9VbJx3bG1kbBB
         MkUA==
X-Gm-Message-State: AOAM533ZpmYHXFGpHR+JDUEOtDXwTOtjNwipwIcBc1nstJT0Wyf3uptt
        ey01Gsc6sebOPbx7sPQQMq8YkYBPsg==
X-Google-Smtp-Source: ABdhPJy8vek+rU0qtXlFDtYJdt3+PNfx3+B41Bo8Y+sjctSSWlzprffXwO4wD8JBVvpgXgYl9+b5QOromw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:d0e2:84e5:6f2a:9752])
 (user=elver job=sendgmr) by 2002:a1c:e486:: with SMTP id b128mr3501221wmh.58.1625045861994;
 Wed, 30 Jun 2021 02:37:41 -0700 (PDT)
Date:   Wed, 30 Jun 2021 11:37:09 +0200
Message-Id: <20210630093709.3612997-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] perf: Require CAP_KILL if sigtrap is requested
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org
Cc:     tglx@linutronix.de, mingo@kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, serge@hallyn.com, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-security-module@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

If perf_event_open() is called with another task as target and
perf_event_attr::sigtrap is set, and the target task's user does not
match the calling user, also require the CAP_KILL capability.

Otherwise, with the CAP_PERFMON capability alone it would be possible
for a user to send SIGTRAP signals via perf events to another user's
tasks. This could potentially result in those tasks being terminated if
they cannot handle SIGTRAP signals.

Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/capability.h |  5 +++++
 kernel/events/core.c       | 13 ++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 65efb74c3585..1c6be4743dbe 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -264,6 +264,11 @@ static inline bool bpf_capable(void)
 	return capable(CAP_BPF) || capable(CAP_SYS_ADMIN);
 }
 
+static inline bool kill_capable(void)
+{
+	return capable(CAP_KILL) || capable(CAP_SYS_ADMIN);
+}
+
 static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 {
 	return ns_capable(ns, CAP_CHECKPOINT_RESTORE) ||
diff --git a/kernel/events/core.c b/kernel/events/core.c
index fe88d6eea3c2..1ab4bc867531 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12152,10 +12152,21 @@ SYSCALL_DEFINE5(perf_event_open,
 	}
 
 	if (task) {
+		bool is_capable;
+
 		err = down_read_interruptible(&task->signal->exec_update_lock);
 		if (err)
 			goto err_file;
 
+		is_capable = perfmon_capable();
+		if (attr.sigtrap) {
+			/*
+			 * perf_event_attr::sigtrap sends signals to the other
+			 * task. Require the current task to have CAP_KILL.
+			 */
+			is_capable &= kill_capable();
+		}
+
 		/*
 		 * Preserve ptrace permission check for backwards compatibility.
 		 *
@@ -12165,7 +12176,7 @@ SYSCALL_DEFINE5(perf_event_open,
 		 * perf_event_exit_task() that could imply).
 		 */
 		err = -EACCES;
-		if (!perfmon_capable() && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
+		if (!is_capable && !ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
 			goto err_cred;
 	}
 
-- 
2.32.0.93.g670b81a890-goog

