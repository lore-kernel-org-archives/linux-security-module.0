Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A20EC433B4
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Apr 2021 02:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C8F06128A
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Apr 2021 02:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhDFCMg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 5 Apr 2021 22:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbhDFCMf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 5 Apr 2021 22:12:35 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C6BC06174A;
        Mon,  5 Apr 2021 19:12:27 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id h20so6635380plr.4;
        Mon, 05 Apr 2021 19:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vvj3ULEtvxm+cvylN4kU3oiHLtQMyycJKz27i88lQuM=;
        b=VQAcf6zSB+nI48NmtkQZg3m9+RKoVKRyJLBBJKMcxPw1dnXdTpsjyHTdWvqWzZv2ei
         P1S76AkRH9mXOqK4VHR436Ulo7c0Isf8gNGFsuHPF8gv4ULrdS+QGTsOlEzXWfv/ynDb
         SX+sk1WpgcgsuuAtkPe8rAKzOn1vpNd8XGXrUYmAZQrnFed0zgkhx905i0rTiLzJU56j
         NMU3ZLOXsLv05vBR6OMCa2juZqP+e3cZkvMgGvByadQmipBJIvgOKVWY1P6Fnyh7seuO
         b0QtEFiae7v3lX9nMKrdcH4ZJXqGR3qMEwkgmIiGXQ9HKotpH607x/xN+hA9n+0YcQsW
         QpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vvj3ULEtvxm+cvylN4kU3oiHLtQMyycJKz27i88lQuM=;
        b=f4Os02B9PvCv0R5q3h2Nn7SebPKbSfihy21bqxLja9DCdto/+ldo0iSVqG9xqixWjF
         SJs1IJb/EwGJlqTYNgTMCRqD3ckRQbK0K/xEoOmH7OkBu4jzX/QaW+knRDqngwEuU8ex
         UXOwGEL+dmqmJEwuXFvpBnkWrxxQoVinWFlBHFfs9iWZkxu3lzGaLNyP5r+6vsH0IJU/
         IDDcoqXbf4tTlxXn6Bg9cRtctQ4PhredL62OVk5nOao7CrVUOBkfNko2f9LW1g2AoQW5
         IcTnL+PgpGy00HObKfgiTobf3CPtATFkSBzDN32fYAPVImwKx+4P83eC8iVwKjXlR2fQ
         HtbQ==
X-Gm-Message-State: AOAM5318F7IwqeUB0PYW8qNJ2FOIZCknma24NR+OARAV9R2iyQXavidd
        rmQn1gqBMu2kkB5AUjpFU2ZBOmVRfjk=
X-Google-Smtp-Source: ABdhPJzLzCwi3KvzLBgFOT8c7oNay1Yy2Lg/jSLd5W1njaZG7Dxi3pj9RUNs29BrFzjlR+CvVTNzTg==
X-Received: by 2002:a17:90b:ed0:: with SMTP id gz16mr2093001pjb.182.1617675146919;
        Mon, 05 Apr 2021 19:12:26 -0700 (PDT)
Received: from localhost.localdomain ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id s8sm617466pjg.29.2021.04.05.19.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 19:12:26 -0700 (PDT)
From:   Jiele Zhao <unclexiaole@gmail.com>
To:     zohar@linux.ibm.com, jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiele Zhao <unclexiaole@gmail.com>
Subject: [PATCH v2] ima: Fix function name error in comment.
Date:   Tue,  6 Apr 2021 02:12:10 +0000
Message-Id: <20210406021210.2843-1-unclexiaole@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The original function name was ima_path_check().  The policy parsing
still supports PATH_CHECK.   Commit 9bbb6cad0173 ("ima: rename
ima_path_check to ima_file_check") renamed the function to
ima_file_check(), but missed modifying the function name in the
comment.

Fixes: 9bbb6cad0173 ("ima: rename ima_path_check to ima_file_check").

Signed-off-by: Jiele Zhao <unclexiaole@gmail.com>
---
 security/integrity/ima/ima_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9ef748ea829f..03bef720ab44 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -482,7 +482,7 @@ int ima_bprm_check(struct linux_binprm *bprm)
 }
 
 /**
- * ima_path_check - based on policy, collect/store measurement.
+ * ima_file_check - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured
  * @mask: contains MAY_READ, MAY_WRITE, MAY_EXEC or MAY_APPEND
  *
-- 
2.25.1

