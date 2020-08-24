Return-Path: <SRS0=szIC=CC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94321C433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 12:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755552078D
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 12:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgHXMuD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:50:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46443 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgHXMuC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Aug 2020 08:50:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id h19so9461902ljg.13;
        Mon, 24 Aug 2020 05:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gvOrwFdrNoIKZpBYrzMhMigaSOSnkliOa0D4FtRauyo=;
        b=Fge5OPS2AMd/7JRaeCCe6sNg9HYeHGQKTxnPC8ARiuDdZvQ7TW73hXYvcre9p8R3UB
         NdBMCjY2cAU9P3+osB0inn1HRbqBoc0jaVDNPat7yQJWYT9AFz8Z+iS4hXjKqjiiqU3a
         +zJd+qZmxttoE4Io2QozJRG5XEAxJfh5CciZghoWS87ygNhY2bBHLklHjokga2+NrG69
         hhoKZIQRDmLEPFYmhBdq42alCJi6Rt/94ZJtTYLlbqB4yLkdorn6nti1GLCUoSiao5I5
         B13mdGG6eHVdVrJt8GltfpYn6LjOyBqSwN2r5VWaiIjZHV430RusIsEtz7p3CRWGzB2l
         IePQ==
X-Gm-Message-State: AOAM532VWIYkeZaoNVu+mTk6/ZCCC3HAPCpFUBeW2GVIV2wd1gbfrpqM
        WMumpJ7yFhu5GFObjoFLn77/4ZtgVTw=
X-Google-Smtp-Source: ABdhPJzbqz/ZHLB2zP4m4MdzXpDMkmvjL30Iy7yYnA3v7NASAZN5gbpzR+R/Qt/3Rq6kwpS0RVw2yw==
X-Received: by 2002:a2e:a316:: with SMTP id l22mr2689012lje.301.1598273399100;
        Mon, 24 Aug 2020 05:49:59 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.111])
        by smtp.googlemail.com with ESMTPSA id h23sm2166181lji.139.2020.08.24.05.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 05:49:58 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
Cc:     Denis Efremov <efremov@linux.com>, Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] security/commoncap: Use current_user_ns()
Date:   Mon, 24 Aug 2020 15:49:39 +0300
Message-Id: <20200824124939.486728-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Modify cap_inh_is_capped(), cap_task_prctl() to use current_user_ns().

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 security/commoncap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 59bf3c1674c8..82a61f77c07c 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -220,7 +220,7 @@ static inline int cap_inh_is_capped(void)
 	/* they are so limited unless the current task has the CAP_SETPCAP
 	 * capability
 	 */
-	if (cap_capable(current_cred(), current_cred()->user_ns,
+	if (cap_capable(current_cred(), current_user_ns(),
 			CAP_SETPCAP, CAP_OPT_NONE) == 0)
 		return 0;
 	return 1;
@@ -1206,7 +1206,7 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 		    || ((old->securebits & SECURE_ALL_LOCKS & ~arg2))	/*[2]*/
 		    || (arg2 & ~(SECURE_ALL_LOCKS | SECURE_ALL_BITS))	/*[3]*/
 		    || (cap_capable(current_cred(),
-				    current_cred()->user_ns,
+				    current_user_ns(),
 				    CAP_SETPCAP,
 				    CAP_OPT_NONE) != 0)			/*[4]*/
 			/*
-- 
2.26.2

