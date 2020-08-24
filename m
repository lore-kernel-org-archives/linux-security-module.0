Return-Path: <SRS0=szIC=CC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EB9C433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 12:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E367020706
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 12:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHXMyx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:54:53 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38061 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXMyw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Aug 2020 08:54:52 -0400
Received: by mail-lf1-f65.google.com with SMTP id k10so1434336lfm.5;
        Mon, 24 Aug 2020 05:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SfkQJO0WX7QYvcvwyypgBXvjdOGetP3yae225kbDPA0=;
        b=OjwtheQlj2je4vqPGpUnKbo8Nk9Er2JZnzMOQPWbAYMaHqsHzkb/rhZYKzsybwKj9I
         HfncScfOwRDOyYELReLPAF3TmWYUAD+ZPbubTe9c/UPN9GthSxPpapZyTN5Lr3E326WX
         hDdj2SBaufTdIFkSD+8sXifnDU+hlL/C4/ujHQtermMKju2eDvpm6Q2Mhm66t94xMoAK
         mW9AfLjj5cECSlwayNI9XBTI2hV61QjAa4m4RFgldOS45VsMhFg0KvQfhytQAtc8UOyo
         Bj4VzJxmKw5ESGyOp1GdBNvQsA7xUH3xAY8XcwbGqLr+5ovieR6/ZMfZQ4CoUkGC304y
         p8QA==
X-Gm-Message-State: AOAM533cYqJgJzmlqbPsDdcVeNHPjakK8W2aCaCHEwtykTFUB2xCqY8B
        SLfckJv8xGFFnlME5TEtfig=
X-Google-Smtp-Source: ABdhPJwyAl2uc3oyptrluwFV1MiM+VwGe1DqD+6Z1SICiQM/MTtZ2Ox39NlC1Wchh/4jnEE/Sv9NkA==
X-Received: by 2002:a19:4290:: with SMTP id p138mr1743951lfa.187.1598273689854;
        Mon, 24 Aug 2020 05:54:49 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.111])
        by smtp.googlemail.com with ESMTPSA id e17sm2177112ljg.85.2020.08.24.05.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 05:54:49 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
Cc:     Denis Efremov <efremov@linux.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] integrity: Use current_uid() in integrity_audit_message()
Date:   Mon, 24 Aug 2020 15:54:35 +0300
Message-Id: <20200824125435.487194-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Modify integrity_audit_message() to use current_uid().

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 security/integrity/integrity_audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index f25e7df099c8..29220056207f 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -47,7 +47,7 @@ void integrity_audit_message(int audit_msgno, struct inode *inode,
 	ab = audit_log_start(audit_context(), GFP_KERNEL, audit_msgno);
 	audit_log_format(ab, "pid=%d uid=%u auid=%u ses=%u",
 			 task_pid_nr(current),
-			 from_kuid(&init_user_ns, current_cred()->uid),
+			 from_kuid(&init_user_ns, current_uid()),
 			 from_kuid(&init_user_ns, audit_get_loginuid(current)),
 			 audit_get_sessionid(current));
 	audit_log_task_context(ab);
-- 
2.26.2

