Return-Path: <SRS0=RuUe=A3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE2CC433F2
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD05A20775
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jailz0If"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgGPKTc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgGPKTb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jul 2020 06:19:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47446C061755
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:19:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l2so11080178wmf.0
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gFZLRP1ZuHliqT17Fc4txXqGOPABF9itQWuE10KMBSE=;
        b=jailz0Iffcdg/t5bCkanGzstjqiouIm+URRVHtua+DDyDFBDmze+p2WmZ+LHCBt3qv
         GYB6IT6q+yPal1D3mNma04d7hWhtzBduuNnL8q78GVj0sWhetn6MOfrllsdQSc/F/OVo
         MSls4ohOSZW6GIRoGO8V4mqeiEyenSWAXEag8lyn4uxCE3RMQmsrNkJgRCSj/FwPK31f
         FxZ/gsRQOuxEQuJx6JeMEbVlxquu8AufWWUwb/yxIZlGnSBilbDG9R16XlejpJy7hovo
         RpgmFlXMsYtmT7+3tSzgcW0F3AtdcP04gy0/PAa8xu2sb6HC5Yb1IQZrOXP28rPkuJZ3
         vRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gFZLRP1ZuHliqT17Fc4txXqGOPABF9itQWuE10KMBSE=;
        b=d6fFc/nS1BsqK8icc/vZ49pIr3pFNIvJve3HVkpvHKUCWlQ73yIGG5ka5GWD/x1PEf
         9u/bxq4046c8OcneFMy3FD3GzRDr8EMjjKtP5sl8HiNXXBFbK4VjlY7Wv5Ijw0R/PUTR
         nrv9j6leWKjiQZpKza6mVLlKxukCzT4Wpjt7SqCdbOPutZjzvTqV8gWSsKPRokSYYDj0
         Ho2wBK8B03ZVIV7zCx6lK/SM1utQMhlz7hCtsevre/LD0stTJeIWAhEVUD0F8fRGEINR
         HaMMCC3vE7jEu0FBgj8+pop0WEr/pDpHfMEELuXotEWp+GOE73Gp8eoD9vWg0Mku4wN0
         mLeg==
X-Gm-Message-State: AOAM530uReVBn008M+Qk2pEdiMZ6yC6vTzvCPiaCmkw1MMlcJIByIqDy
        w8M3oSJYHVsgshYo1wAoAeg=
X-Google-Smtp-Source: ABdhPJwWTPoXueg+y38IOZ+15VW+CLlcnDrw/n9CDllWYeUV7D29Jp+ZK2hW0duGONkQW5s/atE4OA==
X-Received: by 2002:a7b:cc91:: with SMTP id p17mr3904343wma.90.1594894770018;
        Thu, 16 Jul 2020 03:19:30 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id t15sm7770058wmj.14.2020.07.16.03.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 03:19:29 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, "Andrew G . Morgan" <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 14/16] pam_cap.c: Spelling fix in output string
Date:   Thu, 16 Jul 2020 12:18:25 +0200
Message-Id: <20200716101827.162793-14-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200716101827.162793-1-mtk.manpages@gmail.com>
References: <20200716101827.162793-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 pam_cap/pam_cap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pam_cap/pam_cap.c b/pam_cap/pam_cap.c
index 3030692..6927f7b 100644
--- a/pam_cap/pam_cap.c
+++ b/pam_cap/pam_cap.c
@@ -321,7 +321,7 @@ int pam_sm_authenticate(pam_handle_t *pamh, int flags,
 
     } else {
 
-	D(("there are no capabilities restrctions on this user"));
+	D(("there are no capabilities restrictions on this user"));
 	return PAM_IGNORE;
 
     }
-- 
2.26.2

