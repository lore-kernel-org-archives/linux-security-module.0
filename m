Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (unknown [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1608CC433E0
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Mar 2021 03:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC2C6194D
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Mar 2021 03:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhCUDeb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 20 Mar 2021 23:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhCUDeV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 20 Mar 2021 23:34:21 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6EDC061574;
        Sat, 20 Mar 2021 20:34:20 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id f12so9942232qtq.4;
        Sat, 20 Mar 2021 20:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n8w1eH7eROhNtrsz0SZcF8+sLNNFxSNw1Hceyzky/t4=;
        b=R5+MEtSUCDqdcrKGdHzcgi6ku/Rn8hyn2UCzIpi+JgFHAfXswAU+dNk0GTYL5PH8XQ
         t2X3JPW7bz9iW9FpZXJKHr4GYx9qvxrjYAaceCTQcT63gHe3tTXOhiNOcH/OtO/3klwH
         ygyAgfl6McZcGui8KRRkNIE0xkEJrvmg3Dd+2U3j4qVC3aWgnW+5BV0fOhsLMBR4nJI+
         rSimDsD2co2P9w7wjtJmBPkA1SnD5cX75hY7I+9gEtwzabszu+6NqvZ67dtJwS0mAjSN
         PY30Zchse7+S/Uki/1K094EZWEgSwxV/G6aRdRRzcnToU5QuPj6lhmgaUF0/t/Km9391
         PHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n8w1eH7eROhNtrsz0SZcF8+sLNNFxSNw1Hceyzky/t4=;
        b=jnHJXbcJYN1NX1baSxDDa5kAZKWPbHuUSbuq8X1d9pf916j3d48iKWVa7hjIXmhcai
         SvzJk0P0UDT4ZwqTcz3615O5temsHHGDdhhJZNEBQzZ9utsofUonU669p/aQCpKgRTwK
         2XcDCloFKV/JMNChyp6X2PUhRYBdSxbzphREHXgUImVcGSbsehO/3JE46oCujTxT42sZ
         FJLafThYYOzGTKESWTZK3u0Pz7tbTpuDSKjZQVmjLi6SI/b5r3myn1/2bXvhrR7SJ28u
         WEcJtGvE/4K8ZG84SaHOoOLB/yVPe5ASgaPFxc/VJgssN9nd8AiEDdLOND3KlD9IK/Z8
         7/EQ==
X-Gm-Message-State: AOAM5319jo8o2i10no44Lv2lLRQPAnHgAGWSq4N/qqHmBTRMZtisB/Hi
        pRlwndbZKqvmZ8CfgS48rj4=
X-Google-Smtp-Source: ABdhPJxumIiSFoPb6T4PHuSC26JVlRP0hVOqFKo6qRJv4mvLmUXPZ8ZlryfBiJF7HFshd2FRnTd/ow==
X-Received: by 2002:aed:2ce3:: with SMTP id g90mr4873757qtd.308.1616297660114;
        Sat, 20 Mar 2021 20:34:20 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.26])
        by smtp.gmail.com with ESMTPSA id r133sm8200442qke.20.2021.03.20.20.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 20:34:19 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     serge@hallyn.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] cap: Trivial spelling fixes throughout the file
Date:   Sun, 21 Mar 2021 09:04:02 +0530
Message-Id: <20210321033402.5728-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Mundane spelling fixes throughout the file.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 security/commoncap.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 1c519c875217..d4bb6d619200 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -83,7 +83,7 @@ int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
 		if (ns->level <= cred->user_ns->level)
 			return -EPERM;

-		/*
+		/*
 		 * The owner of the user namespace in the parent of the
 		 * user namespace has all caps.
 		 */
@@ -842,7 +842,7 @@ static inline bool __is_setgid(struct cred *new, const struct cred *old)
  *   1) cap_effective has all caps
  *   2) we became root *OR* are were already root
  *   3) root is supposed to have all caps (SECURE_NOROOT)
- * Since this is just a normal root execing a process.
+ * Since this is just a normal root executing a process.
  *
  * Number 1 above might fail if you don't have a full bset, but I think
  * that is interesting information to audit.
@@ -1132,7 +1132,7 @@ int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags)
 		break;

 	case LSM_SETID_FS:
-		/* juggle the capabilties to follow FSUID changes, unless
+		/* juggle the capabilities to follow FSUID changes, unless
 		 * otherwise suppressed
 		 *
 		 * FIXME - is fsuser used for all CAP_FS_MASK capabilities?
@@ -1183,10 +1183,10 @@ static int cap_safe_nice(struct task_struct *p)
 }

 /**
- * cap_task_setscheduler - Detemine if scheduler policy change is permitted
+ * cap_task_setscheduler - Determine if scheduler policy change is permitted
  * @p: The task to affect
  *
- * Detemine if the requested scheduler policy change is permitted for the
+ * Determine if the requested scheduler policy change is permitted for the
  * specified task, returning 0 if permission is granted, -ve if denied.
  */
 int cap_task_setscheduler(struct task_struct *p)
@@ -1195,11 +1195,11 @@ int cap_task_setscheduler(struct task_struct *p)
 }

 /**
- * cap_task_ioprio - Detemine if I/O priority change is permitted
+ * cap_task_ioprio - Determine if I/O priority change is permitted
  * @p: The task to affect
  * @ioprio: The I/O priority to set
  *
- * Detemine if the requested I/O priority change is permitted for the specified
+ * Determine if the requested I/O priority change is permitted for the specified
  * task, returning 0 if permission is granted, -ve if denied.
  */
 int cap_task_setioprio(struct task_struct *p, int ioprio)
@@ -1208,11 +1208,11 @@ int cap_task_setioprio(struct task_struct *p, int ioprio)
 }

 /**
- * cap_task_ioprio - Detemine if task priority change is permitted
+ * cap_task_ioprio - Determine if task priority change is permitted
  * @p: The task to affect
  * @nice: The nice value to set
  *
- * Detemine if the requested task priority change is permitted for the
+ * Determine if the requested task priority change is permitted for the
  * specified task, returning 0 if permission is granted, -ve if denied.
  */
 int cap_task_setnice(struct task_struct *p, int nice)
--
2.20.1

