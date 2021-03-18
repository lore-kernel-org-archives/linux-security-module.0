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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1E9C433DB
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Mar 2021 11:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 898DC6186A
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Mar 2021 11:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhCRLKp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Mar 2021 07:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhCRLKc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Mar 2021 07:10:32 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD656C06174A;
        Thu, 18 Mar 2021 04:10:31 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso2927272pjb.3;
        Thu, 18 Mar 2021 04:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/3GlBYsBWOhEfNPMOeTbEC02ssqJu4/v6tbUqIoSloE=;
        b=Y9XyPVonavaqGn3DG9TZ6/5z6hluRApj9hDpub0BdswGVts3ZzqjaLX4WbnRSiJbyj
         4pgeG5IDNQK47DnEy6Bgkn55WhppmFd1XnzTRwwXM64hBpAIA6UwsWcHTMiBI+u8Ygcz
         ow/xVf/I4XGs/hZlFCEHgIvwbizpPAHPGDPOSYKmtPp4rYQBvdkKGikGJ+OCE/NSplXi
         KCpJ0r6hCY75WfVVL6KGnNnPYlv8ukSidfyBAMQpgxVVRXVWxM0Xq4BF/Qbco8M8ADTh
         egSw96cRW0jiqCw2fihPBtBjMVz7Qtno6fhIAuIBEVs/314Pw73XoyItH/fdacIehDOi
         RSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/3GlBYsBWOhEfNPMOeTbEC02ssqJu4/v6tbUqIoSloE=;
        b=SXApmKoT0ZpuAFq5KcEshEybfkKhFCf9d7aRyY+JgOSkwAhzZh9r01SVLCHih7D+Ur
         kBXEDVUeqFwtCLowY8+IHhxVUWzHMGz+WrDtldpKpSuoOZprU55HR9JEENOw2ux7vDJa
         m317Yi+uWZZkogP0Jup9g2msPHbHXqaMbay0Msdk90dEnXGO9v2St74QpKQUELDKqg/Z
         WYO796plH6ZzFX4uE+myeED1TzKib5IHcUnuD7LQpWTi1sf0f6UWMl/B7vrbfYrL1Way
         NaQZU9Ih7K9DJcCG99DUERZdD3B6B7snvphd4tNH2ESHs/9eCwKmsuxlJ9D/YrOBeG1J
         Gagw==
X-Gm-Message-State: AOAM530tHTAktkBRLk5LEKipY0HoBk3XwKz7e4JGhfCXAgCw2GJZogZH
        gjHjsjnX/rqhWTyHzBYUMnWGIOY9gWA=
X-Google-Smtp-Source: ABdhPJyGAfoYt6G5NxRT8JMFrZjtBOzEX8gJC3mkiNyp0nf6kO6CX+gul00HdvNfPy7A4bZKiHcUGA==
X-Received: by 2002:a17:902:b908:b029:e6:3e0a:b3cc with SMTP id bf8-20020a170902b908b02900e63e0ab3ccmr9295452plb.68.1616065831326;
        Thu, 18 Mar 2021 04:10:31 -0700 (PDT)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id t22sm2128707pjo.45.2021.03.18.04.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 04:10:30 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: xiong.zhenwu@zte.com.cn
To:     casey@schaufler-ca.com
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
Subject: [PATCH] security/smack: fix misspellings using codespell tool
Date:   Thu, 18 Mar 2021 04:10:24 -0700
Message-Id: <20210318111024.472126-1-xiong.zhenwu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>

A typo is found out by codespell tool in 116th line of smackfs.c:

$ codespell ./security/smack
./smackfs.c:116: lables  ==> labels

Fix a typo found by codespell.

Signed-off-by: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
---
 security/smack/smackfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 22ded2c26089..ef8625cb3f2a 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -113,7 +113,7 @@ struct smack_known *smack_syslog_label;
  * SMACK_PTRACE_DEFAULT    regular smack ptrace rules (/proc based)
  * SMACK_PTRACE_EXACT      labels must match, but can be overriden with
  *			   CAP_SYS_PTRACE
- * SMACK_PTRACE_DRACONIAN  lables must match, CAP_SYS_PTRACE has no effect
+ * SMACK_PTRACE_DRACONIAN  labels must match, CAP_SYS_PTRACE has no effect
  */
 int smack_ptrace_rule = SMACK_PTRACE_DEFAULT;
 
-- 
2.25.1

