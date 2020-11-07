Return-Path: <SRS0=bsG4=EN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A380C388F9
	for <linux-security-module@archiver.kernel.org>; Sat,  7 Nov 2020 08:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC4220B1F
	for <linux-security-module@archiver.kernel.org>; Sat,  7 Nov 2020 08:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzzQ3l9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgKGIYX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 7 Nov 2020 03:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgKGIYX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 7 Nov 2020 03:24:23 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E79C0613CF;
        Sat,  7 Nov 2020 00:24:23 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id w11so2071574pll.8;
        Sat, 07 Nov 2020 00:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=X3ARY3PTyer7Z02B1BX5GRWkyi0fpbbIHapRKzO+iJ0=;
        b=ZzzQ3l9AKBwmLI+dtdEgGqGX/ZKsssAhA+GJ06aiQ8PZth9Qrrrz5yIGPD3q7iWxoU
         HSjMXPHn6JDCql2/qKSwNEuZzQR/r00tWBllZeL91maZ52t5GU2wBbVZmUkArvrGq0NQ
         OsMmkw22lelkyDhJPLnNuIiTHnRZ/8K93IytAVwI/kFvRl+JtrHhi/CjAFXzQqerGX6q
         WJ2tQRLBmcp847yhT7CWAtmUUK+Oo3LO4fPPh+dxBSIzHtpWjXVL+34K+xEPHLTpCIAv
         TicHcBkc2Ume/SKCswGXC/VQ9Fc1iBl9Tx8Z1DZ+XAik3vQ8kCeNAAV/kiOAw6G0G6C7
         m80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X3ARY3PTyer7Z02B1BX5GRWkyi0fpbbIHapRKzO+iJ0=;
        b=mzDJ8fGsT+GzhT9Qj37nu/UVc7NoWHmtN3nGNcGm467IdlqbHd41sl8TezM5aXyNey
         V4KnekGors1emLxRZiWvMl3hoO/o0LCrRmWhi8x0FJeDzJvy0YjOJ80TAuDnWurjUNow
         d+CGz8iQPV2sEuOnx5TpoM7sVhO+7loIRMJ9pR8hSMUF9EwREC2GDvt3oVN3qkaf3/Yn
         aFU63RdWTR+gB0gxi1O5JOvY3WMCLRI14vn6HQg9vNWmxJUSJgKTuJ+4EHI4rXM2j1YI
         aJK0bbtI1KmSN0yDAv12vMNDn0kCny6m0tJA4GDgBAhNEAWqwB+O7BTVG8XdunXb0Ngq
         +8vw==
X-Gm-Message-State: AOAM530cyMmnn8uMxV7Uqvf6ZBwX1ziqFGcHSqgwjXuxKs8m8vV2FGkW
        mNnY07tVD6q9jAooOta5c34YKEmGbHfRYw==
X-Google-Smtp-Source: ABdhPJwDyY9M/ZHLKKH7UFge4odFt6za4aYpx45k2KdPkqICExycMeEwBaDLIoRl0XpXeeJ5YHr84Q==
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr3608586pja.36.1604737462838;
        Sat, 07 Nov 2020 00:24:22 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.182.253.68])
        by smtp.gmail.com with ESMTPSA id 128sm4705273pfd.110.2020.11.07.00.24.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2020 00:24:22 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     takedakn@nttdata.co.jp, penguin-kernel@I-love.SAKURA.ne.jp,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/2] tomoyo: Convert get_user_pages*() to pin_user_pages*()
Date:   Sat,  7 Nov 2020 13:54:10 +0530
Message-Id: <1604737451-19082-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In 2019, we introduced pin_user_pages*() and now we are converting
get_user_pages*() to the new API as appropriate. [1] & [2] could
be referred for more information. This is case 5 as per document [1].

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
        https://lwn.net/Articles/807108/

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 security/tomoyo/domain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index dc4ecc0..bd748be 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -914,7 +914,7 @@ bool tomoyo_dump_page(struct linux_binprm *bprm, unsigned long pos,
 	 * (represented by bprm).  'current' is the process doing
 	 * the execve().
 	 */
-	if (get_user_pages_remote(bprm->mm, pos, 1,
+	if (pin_user_pages_remote(bprm->mm, pos, 1,
 				FOLL_FORCE, &page, NULL, NULL) <= 0)
 		return false;
 #else
@@ -936,7 +936,7 @@ bool tomoyo_dump_page(struct linux_binprm *bprm, unsigned long pos,
 	}
 	/* Same with put_arg_page(page) in fs/exec.c */
 #ifdef CONFIG_MMU
-	put_page(page);
+	unpin_user_page(page);
 #endif
 	return true;
 }
-- 
1.9.1

