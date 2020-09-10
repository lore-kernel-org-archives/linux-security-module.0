Return-Path: <SRS0=OzCb=CT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175C6C43461
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Sep 2020 20:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B72EE20829
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Sep 2020 20:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QqSA5OLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgIJUWx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgIJUWB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Sep 2020 16:22:01 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD06C0617AB
        for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2020 13:21:23 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jw11so590436pjb.0
        for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2020 13:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fekJawXuRCxGrjYQI8OQvxsZTGlCFbLJj9FaUGr/A7E=;
        b=QqSA5OLvk2Qdik/W7fOSu9hkPXdjQzGi3H6oVrZUyklZ+UzgX6HE9UM609d6dK+kyh
         54tXPlf8gvwGJYpP5jiKL4Mqt3GvS4R+0mJa2dhY7V+8gDdXSbCJ3tIl9uerrba1ObNl
         fq3FyNkenrkMAEkbOEdq32NFyGXYfubBxsfyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fekJawXuRCxGrjYQI8OQvxsZTGlCFbLJj9FaUGr/A7E=;
        b=KufJmgUQIQqjlzaBfPkE51TFrf9PxxV95IeKr7PIaExPS3wu1Wurz+d33a8QOS+VO5
         cmS49DkW5vd2d11PRjbl04/F06IlJ5CV/AhAQLOA//dVE13IWTD8wDEcoIwcQCHvaDKa
         b3GoLdj9LArKFiGnqgFYAmKo6lcCAsYEkAwPdhs8eamZSYNUkpjA/ER1rKypPb2niIYs
         o4Vp8rbBxOdD6jSFKuol11sQvwbIUtk4FcQ0b+tv+efbMhzTf5PC8tZKUy6gu4oBuN31
         1/0lMcUjy7J2AbfH7EKmjiCbgdOBWiGwc9OREYvLh5McwPuRD61zVafozEcr1d/3BDNq
         zYfQ==
X-Gm-Message-State: AOAM531SSlfasz1hSBiBEjtdRrbQojyT/YXqBzgYyih79NmMZ68UUp27
        Au32J/63n8Efc50uv9pytkXWGA==
X-Google-Smtp-Source: ABdhPJymFVJ+9HWBVHudVut19/nL7d3aLa8ZpMZHZNa4qlaiqrKo1FAhdiapRQw62yOFnHB/LJtf8A==
X-Received: by 2002:a17:90b:a51:: with SMTP id gw17mr1654063pjb.118.1599769282707;
        Thu, 10 Sep 2020 13:21:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i17sm6876859pfa.2.2020.09.10.13.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 13:21:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     Kees Cook <keescook@chromium.org>, John Wood <john.wood@gmx.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [RFC PATCH 5/6] security/fbfam: Detect a fork brute force attack
Date:   Thu, 10 Sep 2020 13:21:06 -0700
Message-Id: <20200910202107.3799376-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910202107.3799376-1-keescook@chromium.org>
References: <20200910202107.3799376-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: John Wood <john.wood@gmx.com>

To detect a fork brute force attack it is necessary to compute the
crashing rate of the application. This calculation is performed in each
fatal fail of a task, or in other words, when a core dump is triggered.
If this rate shows that the application is crashing quickly, there is a
clear signal that an attack is happening.

Since the crashing rate is computed in milliseconds per fault, if this
rate goes under a certain threshold a warning is triggered.

Signed-off-by: John Wood <john.wood@gmx.com>
---
 fs/coredump.c          |  2 ++
 include/fbfam/fbfam.h  |  2 ++
 security/fbfam/fbfam.c | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 76e7c10edfc0..d4ba4e1828d5 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -51,6 +51,7 @@
 #include "internal.h"
 
 #include <trace/events/sched.h>
+#include <fbfam/fbfam.h>
 
 int core_uses_pid;
 unsigned int core_pipe_limit;
@@ -825,6 +826,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 fail_creds:
 	put_cred(cred);
 fail:
+	fbfam_handle_attack(siginfo->si_signo);
 	return;
 }
 
diff --git a/include/fbfam/fbfam.h b/include/fbfam/fbfam.h
index 2cfe51d2b0d5..9ac8e33d8291 100644
--- a/include/fbfam/fbfam.h
+++ b/include/fbfam/fbfam.h
@@ -12,10 +12,12 @@ extern struct ctl_table fbfam_sysctls[];
 int fbfam_fork(struct task_struct *child);
 int fbfam_execve(void);
 int fbfam_exit(void);
+int fbfam_handle_attack(int signal);
 #else
 static inline int fbfam_fork(struct task_struct *child) { return 0; }
 static inline int fbfam_execve(void) { return 0; }
 static inline int fbfam_exit(void) { return 0; }
+static inline int fbfam_handle_attack(int signal) { return 0; }
 #endif
 
 #endif /* _FBFAM_H_ */
diff --git a/security/fbfam/fbfam.c b/security/fbfam/fbfam.c
index 9be4639b72eb..3aa669e4ea51 100644
--- a/security/fbfam/fbfam.c
+++ b/security/fbfam/fbfam.c
@@ -4,7 +4,9 @@
 #include <linux/errno.h>
 #include <linux/gfp.h>
 #include <linux/jiffies.h>
+#include <linux/printk.h>
 #include <linux/refcount.h>
+#include <linux/signal.h>
 #include <linux/slab.h>
 
 /**
@@ -172,3 +174,40 @@ int fbfam_exit(void)
 	return 0;
 }
 
+/**
+ * fbfam_handle_attack() - Fork brute force attack detection.
+ * @signal: Signal number that causes the core dump.
+ *
+ * The crashing rate of an application is computed in milliseconds per fault in
+ * each crash. So, if this rate goes under a certain threshold there is a clear
+ * signal that the application is crashing quickly. At this moment, a fork brute
+ * force attack is happening.
+ *
+ * Return: -EFAULT if the current task doesn't have statistical data. Zero
+ *         otherwise.
+ */
+int fbfam_handle_attack(int signal)
+{
+	struct fbfam_stats *stats = current->fbfam_stats;
+	u64 delta_jiffies, delta_time;
+	u64 crashing_rate;
+
+	if (!stats)
+		return -EFAULT;
+
+	if (!(signal == SIGILL || signal == SIGBUS || signal == SIGKILL ||
+	      signal == SIGSEGV || signal == SIGSYS))
+		return 0;
+
+	stats->faults += 1;
+
+	delta_jiffies = get_jiffies_64() - stats->jiffies;
+	delta_time = jiffies64_to_msecs(delta_jiffies);
+	crashing_rate = delta_time / (u64)stats->faults;
+
+	if (crashing_rate < (u64)sysctl_crashing_rate_threshold)
+		pr_warn("fbfam: Fork brute force attack detected\n");
+
+	return 0;
+}
+
-- 
2.25.1

