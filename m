Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06426C47082
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Jun 2021 23:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D855861278
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Jun 2021 23:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhFHXLo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Jun 2021 19:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbhFHXLn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Jun 2021 19:11:43 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC12C061574;
        Tue,  8 Jun 2021 16:09:34 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id q25so16912338pfh.7;
        Tue, 08 Jun 2021 16:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pxB1xtoHHkw69OMEALOXeDp7Pni62I/nw63DWa+Tj/o=;
        b=iTP8gMp2oYKaN/tIBjZWiVWQcwQg1wIZ9Brf3K/E++4JjjGpFbFR+WNVMk31R1XTGU
         lZ6y2Lb5wPRsZ+5z2yARawwMQQhUJaWamXla8i8Df1eu47UDOcPDdxRZMqtuI1kHtqSf
         sifS0mAAXXVUuUZIRt/n62iJO9y0r5OzK9CfauuJrrGAIMStXq/ihADfMK8yngw0NpYt
         gIzqWCeKZAjGkIwGFSIzbLm4t+Hxo0dEtlHK2tVOWMgKVR5gnnbW3CzddZhciupP3+8q
         DujFkq6sQsG9661v2SBCFzDdLF6junI4eshji1VpWcD+aiePBCuYqWB0kqeg2a7mFk80
         lqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pxB1xtoHHkw69OMEALOXeDp7Pni62I/nw63DWa+Tj/o=;
        b=C9sch2tAtHAME/CP1QqbgSpw8XBqb9fHw2pihpxOlePrw6bJH6yhhtVXU1j4WO4Ubx
         RBrbAyoYskvziCpqv3PHQZB2uS5ZSZx99jRDDoGC5W7K7q02AGgfycKDCosN5/GKoFRP
         AsV0FQ78HetFhYxVUeZqVBH/jMBWWBBwov5ezMssf6DLBoMCigCHJa2OcuE+RcAjmXDz
         q3kA63Y6Qh8/dtiKML1EYIuxbk/ecE0xMSRB1bQ4BLHHmFHzYFG6GBMigTD3ZgzFcHZb
         VW3TDiUhKctKVpAP83MmObQD6pfr0o0wgegsY2F+gj3/J+IS7NpsH7qONSFBfw32f4/j
         XlcQ==
X-Gm-Message-State: AOAM533kw3IlmWbqrXUs4DTd30K3zlmRVfY6Mbri4rcAXWR34fw5JaQg
        N3ytKa4xHAB33IFQwu5LH6U=
X-Google-Smtp-Source: ABdhPJx7uMwq1jcrznElfdv1IOnoq0Xg69qXTt1txWdh4AQ/4VpNFYPgS3FKNfvDbK3C+QQrBqP4yQ==
X-Received: by 2002:aa7:9537:0:b029:2ea:2312:d2cb with SMTP id c23-20020aa795370000b02902ea2312d2cbmr2036969pfp.27.1623193773574;
        Tue, 08 Jun 2021 16:09:33 -0700 (PDT)
Received: from raspberrypi ([125.141.84.155])
        by smtp.gmail.com with ESMTPSA id f8sm10925846pfv.73.2021.06.08.16.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 16:09:33 -0700 (PDT)
Date:   Wed, 9 Jun 2021 00:09:29 +0100
From:   Austin Kim <austindh.kim@gmail.com>
To:     mortonm@chromium.org, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, austindh.kim@gmail.com,
        austin.kim@lge.com
Subject: [PATCH] LSM: SafeSetID: Mark safesetid_initialized as __initdata
Message-ID: <20210608230929.GA1214@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Mark safesetid_initialized as __initdata since it is only used
in initialization routine.

Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 security/safesetid/lsm.c | 2 +-
 security/safesetid/lsm.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 1079c6d54784..963f4ad9cb66 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -22,7 +22,7 @@
 #include "lsm.h"
 
 /* Flag indicating whether initialization completed */
-int safesetid_initialized;
+int safesetid_initialized __initdata;
 
 struct setid_ruleset __rcu *safesetid_setuid_rules;
 struct setid_ruleset __rcu *safesetid_setgid_rules;
diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
index bde8c43a3767..d346f4849cea 100644
--- a/security/safesetid/lsm.h
+++ b/security/safesetid/lsm.h
@@ -19,7 +19,7 @@
 #include <linux/hashtable.h>
 
 /* Flag indicating whether initialization completed */
-extern int safesetid_initialized;
+extern int safesetid_initialized __initdata;
 
 enum sid_policy_type {
 	SIDPOL_DEFAULT, /* source ID is unaffected by policy */
-- 
2.20.1

