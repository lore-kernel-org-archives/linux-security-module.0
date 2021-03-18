Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66C0C433E9
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Mar 2021 12:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B51DD64F2A
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Mar 2021 12:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhCRMAd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Mar 2021 08:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhCRMAY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Mar 2021 08:00:24 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B678CC06174A;
        Thu, 18 Mar 2021 05:00:23 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso2995019pjb.4;
        Thu, 18 Mar 2021 05:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1n8VJuZ5LIE4mmJ/U2z0wAE75pe1NtOJnkRjFceP1Kk=;
        b=m4V3qJNHV9zTfL7enYp6wXNqSlwWJomDx4t3Wujdgv21iRwuycSuE1JVg1okpiRFPz
         rWhmXvBMSNgaaxYXigQpPeOCxnS/XKwm/2EeR/BAZ6tLHUTJiA5epBEB41DZsb6f+qz4
         AIavO7aqmwI+qH01JpWoAu7HdGNvqSwZmSyaQJENoJyXIuyWnCYFbNbjOLsJkbWAAOga
         DYatKwz9XWOlwhsx6T6j8YcYmWOD2TPIE8sclPipGs3A1zRh+ojqDjFE2p2p1yKA7mFe
         xC7kNd7YtE7vxlZdKB9YNkgz2Q5SnSlyEYdOjk+D/m8my0x40LZiHeS0pIH1DsNzYM3l
         kd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1n8VJuZ5LIE4mmJ/U2z0wAE75pe1NtOJnkRjFceP1Kk=;
        b=XjLseCyIKVvL21oA1TAIhmgtubWOBeoNSFrAI8POdoVWREQ9Ng00J2NdchXd+ipUVe
         Cne7RPKrxFsspmBCHxqjNj9NLR3fOagqOSEVZqxsqvtkz+s8pwPZ4wuUzqJB8XDvXGAo
         mvoyg9ffW75uHLRROGLoiSK6ubXUvAc0V5PVbDmtc1xjjR0fK2EbJvWaHHs8tT8RF38Y
         3+ps+b8ySRodRu/KcTlW8CGSbAm7T1qUjXczai3vMmh7MGfqMMx9v+B5qn27TD2BDV3m
         3U0p6rkdBLgaZOm+C7FEZKbtFhy9E1RjuEGF6Hdt7tMUMeJsu4tucUlO/ojZuCbNXLDJ
         gm7A==
X-Gm-Message-State: AOAM530U0ERMWwyPlVUB/K3grt0tEUBKZvFB5Iu/6c9FqHYiGTcPvC+2
        PPziVrqflFvTF9zN5frpApQ=
X-Google-Smtp-Source: ABdhPJwbLHvhlpx4bOM/CtfIq5YILHJVbBrUCFKjLqHnGjDt6Ff9/F1f8yHL8EXRQdD1epOncqOUOA==
X-Received: by 2002:a17:90b:1c0e:: with SMTP id oc14mr3986655pjb.188.1616068823294;
        Thu, 18 Mar 2021 05:00:23 -0700 (PDT)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id a20sm2456176pfl.97.2021.03.18.05.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 05:00:22 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: xiong.zhenwu@zte.com.cn
To:     serge@hallyn.com
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
Subject: [PATCH] security: fix misspellings using codespell tool
Date:   Thu, 18 Mar 2021 05:00:17 -0700
Message-Id: <20210318120017.474770-1-xiong.zhenwu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>

A typo is found out by codespell tool:

$ codespell ./security

./security/commoncap.c:1135: capabilties  ==> capabilities

Fix a typo found by codespell.

Signed-off-by: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
---
 security/commoncap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 1c519c875217..598d077572c0 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1132,7 +1132,7 @@ int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags)
 		break;
 
 	case LSM_SETID_FS:
-		/* juggle the capabilties to follow FSUID changes, unless
+		/* juggle the capabilities to follow FSUID changes, unless
 		 * otherwise suppressed
 		 *
 		 * FIXME - is fsuser used for all CAP_FS_MASK capabilities?
-- 
2.25.1

