Return-Path: <SRS0=hMH8=MO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F096DC00449
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 00:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B623121471
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 00:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tz8qvHp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B623121471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbeJBHhj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:37:39 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37975 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJBHfj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Oct 2018 03:35:39 -0400
Received: by mail-it1-f194.google.com with SMTP id i76-v6so1071160ita.3
        for <linux-security-module@vger.kernel.org>; Mon, 01 Oct 2018 17:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bIT+tXwbFhC2CafNKpV0+tN2sDk8GJo0u4BK9sb0Eh8=;
        b=Tz8qvHp3hxRFPV0bnG5Hj58E41gyvJnQh2r8vAH0P1D9HJAGjJEa3X6evdDXXGuuAS
         gmRQFCMre0fPm25KWaO7GeovUmXyx2F365gyFoYts9mQ/5aZaFlCGJEYQrMNbNE4ELQo
         bTBSoKvA7W/jq34KzqhNGno+0vWrFevvrDdZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bIT+tXwbFhC2CafNKpV0+tN2sDk8GJo0u4BK9sb0Eh8=;
        b=dlKIXP3o2vs++KyQfnq60cMKmnSiymAaC+IGrhy73fVQY/yLzIAKc4tQ/D6DukEh55
         oypjRTGvCIaSA1SKlpIKzFOCpTRFip8l+rg4ncRFpXLudCfIFF0/7Cj4VURciBECt7Yq
         NxwJd8QMD91pYVxs5qv3hLTLg5RuzxIREKOv1dL3MDs/OthK1LqnQlM6jt3Yl4aqg/QI
         waxoBrMGBlTKY8qzsLbL8jNMC6znG6UwyDt4AGk7SzEzmTnM6PneVgoku7nqTV3TVM/z
         VsWMmv/fu4ZNv0NkBSIuqYTEA618U83jEiBC8AoCCyP9OblLTGY+tD+7Y1qkTWdJK18c
         dqmw==
X-Gm-Message-State: ABuFfoijP1DIKf4cFMd2gMcNZVz3JfYTzwjXShplIxdyjtQSTV9ttxoh
        X/MJxo+3Yi5D9qGd3+f9TSlSvA==
X-Google-Smtp-Source: ACcGV60a/X/a9MvokUO2/Y1Oz2x2K9ojPHg9s7U5exN/J2alUEsp0qSlBZ4iMJWE05KUN6kxefI81Q==
X-Received: by 2002:a63:6054:: with SMTP id u81-v6mr12048973pgb.74.1538441710527;
        Mon, 01 Oct 2018 17:55:10 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r1-v6sm20166862pff.145.2018.10.01.17.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 17:55:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH security-next v4 04/32] LSM: Remove initcall tracing
Date:   Mon,  1 Oct 2018 17:54:37 -0700
Message-Id: <20181002005505.6112-5-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This partially reverts commit 58eacfffc417 ("init, tracing: instrument
security and console initcall trace events") since security init calls
are about to no longer resemble regular init calls.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/security/security.c b/security/security.c
index 892fe6b691cf..41a5da2c7faf 100644
--- a/security/security.c
+++ b/security/security.c
@@ -30,8 +30,6 @@
 #include <linux/string.h>
 #include <net/flow.h>
 
-#include <trace/events/initcall.h>
-
 #define MAX_LSM_EVM_XATTR	2
 
 /* Maximum number of letters for an LSM name string */
@@ -47,17 +45,13 @@ static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 
 static void __init do_security_initcalls(void)
 {
-	int ret;
 	initcall_t call;
 	initcall_entry_t *ce;
 
 	ce = __start_lsm_info;
-	trace_initcall_level("security");
 	while (ce < __end_lsm_info) {
 		call = initcall_from_entry(ce);
-		trace_initcall_start(call);
-		ret = call();
-		trace_initcall_finish(call, ret);
+		call();
 		ce++;
 	}
 }
-- 
2.17.1

