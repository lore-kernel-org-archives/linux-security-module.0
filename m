Return-Path: <SRS0=szIC=CC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC5AC433E1
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 22:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FEAD207D3
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 22:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="EqHlX/qM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgHXWLR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Aug 2020 18:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHXWLQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Aug 2020 18:11:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF82DC061574
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2020 15:11:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g127so12309428ybf.11
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2020 15:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=7libFXTeoVXtSxsZx4eAfjri3vn9ydzbEFYgezZigKg=;
        b=EqHlX/qMRMx/LOwfZ1t7WQK/nNN6yCRmIDpxachI3gcsZfP/KIGo3bOlFE9vp/zh+F
         tCOnzlWuSPyTdi1yDrB95sLgu3Iq5Jn55KtezGQ1Ar7Z/xzw1pqTLWmU2chqAKL1zR1K
         K86rsCcH4CvK90lNsaaLZok/HBhHi/fw3BLbprys2DBLQHMFaqQ7C4LDnTaaVpQYgk6h
         EVbC+8oLy3pOkK/AL3GTgSBMJZxGuJMS7rgzpqGUBu6za8FP0vaqa4KujiTQtGOCBLGP
         vVSmEqn+Jp8Sk6Wmz5vOk8u9PE9NGeTprgIlPEyyfJ4eGzQVOHes5tXsS27n9QGgwvZ0
         I2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=7libFXTeoVXtSxsZx4eAfjri3vn9ydzbEFYgezZigKg=;
        b=JyML6Bn9OhG+cKjLx8OxgIrn2IDONps+pY0lyvJUtfIGmVSZxLukBZD6qn7tGYHLk/
         BcgItOl7doram6gP4QqxElVilQiow5WwRZzq44IpQ4lbqwAekhQ3S+BXc+CENmzqWOHj
         Ybhtl2WWNg9xfLMRGKKR/oB/XdPdTM47PT9Fwa5bzfQJ4qHrXXA5iYkBb6NXe5a8HvrP
         BX2vmbEk19czqE5WcES/ctkvr16+bAHgcBtZydCAla8k4E5fjywo41unb0exDboQMefM
         u3tQGzf2OcPy7wiiiyU/L8E/e+ydd6wTcLBcla7HRpknDuIB3EgHM+uGlqb1BCQdyk3v
         sdQg==
X-Gm-Message-State: AOAM532wd2MBjjgXvA7E4HMwIB8kmGYmvIiPbSmw8LJDbnWLrxtCaauU
        W6gBxUgvZPEsxRMxi2TcwVqlInPV1aM=
X-Google-Smtp-Source: ABdhPJyYbIT3pRoEDWt2ng9koXX6AnueTSFvvd/SsxvbXJGSutYvdR3F5iCExJF30Lab3lVhBZgD2c8i/SU=
X-Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2cd:202:1ea0:b8ff:fe75:bae4])
 (user=khazhy job=sendgmr) by 2002:a25:502:: with SMTP id 2mr10156615ybf.6.1598307075217;
 Mon, 24 Aug 2020 15:11:15 -0700 (PDT)
Date:   Mon, 24 Aug 2020 15:10:34 -0700
Message-Id: <20200824221034.2170308-1-khazhy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v2] block: grant IOPRIO_CLASS_RT to CAP_SYS_NICE
From:   Khazhismel Kumykov <khazhy@google.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Serge Hallyn <serge@hallyn.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

CAP_SYS_ADMIN is too broad, and ionice fits into CAP_SYS_NICE's grouping.

Retain CAP_SYS_ADMIN permission for backwards compatibility.

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/ioprio.c                  | 2 +-
 include/uapi/linux/capability.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

v2: fix embarrassing logic mistake
diff --git a/block/ioprio.c b/block/ioprio.c
index 77bcab11dce5..276496246fe9 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -69,7 +69,7 @@ int ioprio_check_cap(int ioprio)
 
 	switch (class) {
 		case IOPRIO_CLASS_RT:
-			if (!capable(CAP_SYS_ADMIN))
+			if (!capable(CAP_SYS_NICE) && !capable(CAP_SYS_ADMIN))
 				return -EPERM;
 			/* fall through */
 			/* rt has prio field too */
diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 395dd0df8d08..c6ca33034147 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -288,6 +288,8 @@ struct vfs_ns_cap_data {
    processes and setting the scheduling algorithm used by another
    process. */
 /* Allow setting cpu affinity on other processes */
+/* Allow setting realtime ioprio class */
+/* Allow setting ioprio class on other processes */
 
 #define CAP_SYS_NICE         23
 
-- 
2.28.0.297.g1956fa8f8d-goog

