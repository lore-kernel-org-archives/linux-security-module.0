Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71E6C433DB
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Mar 2021 11:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A042264F2A
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Mar 2021 11:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhCRLEr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Mar 2021 07:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhCRLEj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Mar 2021 07:04:39 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA26C06174A;
        Thu, 18 Mar 2021 04:04:39 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v8so1115759plz.10;
        Thu, 18 Mar 2021 04:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qMVThv4V0sNp06UYCqQLK/Nt9IrZvgb1o8tqU6k08IQ=;
        b=L7A4jA1pV2ZgTdpNxB03DQJos5/nuVFKsCC7DuskrAD8am+ywPt4M3lA92FpX0Cf7Q
         FLu1OiQpBmhVGumE+V/wyRhWhw61fydr7G10GKH4A5yVYdGpVEaZbUTXFoRcJ6A126v4
         ER7va/9MhvpYWxgjjRNoHuaZOLZDtrMJBjCNI7OuhlA91HHyUvgptbJpIMnyE15VMkxb
         C+1vXxF5tg4Hgmjtl+BMTtLucWJN5IBB/J34oJVeNcVIp6dweq7YpPcGMNFO6F4P9JWl
         1SEuVJCevrNfMwk/l9MrYLQZrIL9oIzZEIdYCWCc8lfu/wPuWktFHrPtNqTU6OQMhEei
         B9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qMVThv4V0sNp06UYCqQLK/Nt9IrZvgb1o8tqU6k08IQ=;
        b=fuySlbZqXtqji2c4OFSiMEYWBJgq/XtECR9ksrOtWxBut856uY6TPyWaRaL+waO9Es
         7vL6th26Gl1NqtZzNy4LKUtnwD63kefpHCbP4DlKcDHRXPKJDv1Kklm7z+vDa+lqJ9Lp
         RoIZ1JsC3TkReg8ykb3po56bBYRcD1wbswGVlqO0WiNJMMUAm5VUsF09GxYhJvJLx5mt
         E67rcg3pdR8z6qZJ1E4NxgK6w3ouqfTcmDCiBltKoOwisGnwPbQRiyO4OGUQRbqa2EV+
         mrl1XkiAim5AcvyDbME8lYviWdgoFpEWpCYQRCjUL0O+mc3RecDv0R/PYAgLHwPLxKM8
         aTZw==
X-Gm-Message-State: AOAM530v7n7mLluiRHbepybMNkzjdkI3YEVWFlEcNKh0JAtMcxkw0DEU
        a73uOmrTTnzs6Y6DwFhonHdz3QpJknY=
X-Google-Smtp-Source: ABdhPJzW7uaDCySjyegzrJcvOTclS53dtGKuFpbtVGU+FEW/zPc/k3fAavwVRYDGCiVKnaJzPovuNg==
X-Received: by 2002:a17:90b:1198:: with SMTP id gk24mr3759251pjb.73.1616065478600;
        Thu, 18 Mar 2021 04:04:38 -0700 (PDT)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id fh19sm2076535pjb.33.2021.03.18.04.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 04:04:38 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: xiong.zhenwu@zte.com.cn
To:     jmorris@namei.org
Cc:     casey@schaufler-ca.com, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
Subject: [PATCH] security/smack/: fix misspellings using codespell tool
Date:   Thu, 18 Mar 2021 04:04:31 -0700
Message-Id: <20210318110431.471678-1-xiong.zhenwu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>

A typo is found out by codespell tool in 383th line of smackfs.c:

$ codespell ./security/smack/
./smackfs.c:383: numer  ==> number

Fix a typo found by codespell.

Signed-off-by: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
---
 security/smack/smackfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 22ded2c26089..66f3c539d504 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -380,7 +380,7 @@ static int smk_parse_rule(const char *data, struct smack_parsed_rule *rule,
  * @data: string to be parsed, null terminated
  * @rule: Will be filled with Smack parsed rule
  * @import: if non-zero, import labels
- * @tokens: numer of substrings expected in data
+ * @tokens: number of substrings expected in data
  *
  * Returns number of processed bytes on success, -ERRNO on failure.
  */
-- 
2.25.1

