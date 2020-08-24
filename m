Return-Path: <SRS0=szIC=CC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEDAC433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 20:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F65D205CB
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 20:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="pX8HeaHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgHXUpI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgHXUpH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Aug 2020 16:45:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE72C061574
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2020 13:45:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y9so12043770ybp.8
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2020 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=UhQXWcJr+5AoGLVvN3r8tMmBPLG9sprnFDAtBah1ytY=;
        b=pX8HeaHXQwwtYqEGVbc7owuncNK+VkVxqA6JrBLkHY0VR5Fq5NOdR6ewx8RTxsmV7P
         vL/VyLPRSdOCsaBC26za2O+cn40t0EE7laqYOe6/JcNeAoF0/2u9NDJT0uXGF+EEzx75
         kCBRCTdBhW2tSC5tm5MevbX3P7/mFYSq0B3BfU1EKZ0vGRKwfEhAsJR2HJUZZL5cgnLg
         m99+a3KP7Lz9DeajCxjgNCRuauILDxJm0EGQB7Ey/M81yS2G3qC7VYpkyVNsTcK4inIo
         tTckhqkb1oDaAtBwIhTgSaP36fqUXffXWyxtWMOY/jejZ7iXUWJ5NPWfDlnpFKuxikzK
         RnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=UhQXWcJr+5AoGLVvN3r8tMmBPLG9sprnFDAtBah1ytY=;
        b=faQKgkB6FH1jjxf3EUpFiUVPk6WEz8N2i+1kSqRKRoccU8v0jbNCfz9QMjK9P24WIx
         5eD9q3UuGAUqY9LwiAo/3wpeaLUeTL1L+pQOkOQiexqPtR8aQILtMdXW+/0SAxXOXQQP
         5MaWKBT384NOT/CmqOX5Ondc9AaXRvEe1cUp+mWcK0+Lj6T4/9yIw2W2vk9XPy0X7I0j
         ysQh2iZoYkDlkgTSHEhu282AiE7xLzWu43za7MUuBzAH/2c/1kIggBrExaplDn/v9/IV
         stJe5cJTzPdudA8AJXJmqR5EXMhUcO7a2YZiDe1iyItXyXwQS/9IMJ2UFMmcf6IMUbvS
         uQ+A==
X-Gm-Message-State: AOAM530HoRLV/V4d/1xAfgfpAGIj4uMjt5qYWGl1ooqmcY/FhVT+7pYf
        jFXxwJtF8sypFiDpVKbtI2n6ibs9oRk=
X-Google-Smtp-Source: ABdhPJyQtPlZNY8qKcSrGSypIXx7bMWbjne4oaHh5ALmmnqay5BvInjL0APbUOk1+SCle/Y14u8sml+iLig=
X-Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2cd:202:1ea0:b8ff:fe75:bae4])
 (user=khazhy job=sendgmr) by 2002:a25:1189:: with SMTP id 131mr9454007ybr.364.1598301905865;
 Mon, 24 Aug 2020 13:45:05 -0700 (PDT)
Date:   Mon, 24 Aug 2020 13:45:01 -0700
Message-Id: <20200824204501.1707957-1-khazhy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH] block: grant IOPRIO_CLASS_RT to CAP_SYS_NICE
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

diff --git a/block/ioprio.c b/block/ioprio.c
index 77bcab11dce5..4572456430f9 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -69,7 +69,7 @@ int ioprio_check_cap(int ioprio)
 
 	switch (class) {
 		case IOPRIO_CLASS_RT:
-			if (!capable(CAP_SYS_ADMIN))
+			if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_NICE))
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

