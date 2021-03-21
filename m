Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (unknown [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA7DC433C1
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Mar 2021 03:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 838DF619A4
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Mar 2021 03:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCUDj1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 20 Mar 2021 23:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCUDi7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 20 Mar 2021 23:38:59 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39FBC061574;
        Sat, 20 Mar 2021 20:38:58 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id by2so7054925qvb.11;
        Sat, 20 Mar 2021 20:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=12bQcQuei9qklDt8Bo8n+CvJwVqQA6Mw+S2p2jEoi9w=;
        b=mMItgp5lkSLaFidNBahvvYY3fcLp+rpJSquUyuMd7D7n5Ys5Pyt5FuJUHxETJT/+Ln
         IKQRqJhC0GFx/YyXxAHzjOeS0suPHM+JD/jsBoraLRwZlrTbIBuAKxE4jTIJko7A8JUw
         o1dGsI1JVSP52v2RaZIKWJ+/JPV8mSKgVNYNwSZ9UBmI8BmVX+BjeK5MP9N/JilUQPD/
         /BdU/PcS2fLFiz+g+7r06H+vtVm3hrrgUJ8l/kMUhEbxaKrMVWQK/PiT2fw84UhD+YuL
         vrEJExdkj+IOCJbxPo9dbCwA20bgsl1T7i4q9jb2pWNWw3gSHvuUKexmvi59kcbr3OEJ
         TVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=12bQcQuei9qklDt8Bo8n+CvJwVqQA6Mw+S2p2jEoi9w=;
        b=XycVIHfGrL+CEXCI09eG1dHCG5ty2FWCkdprwIHlAxKYmBtzlGpCp++WR0oUDYUQzp
         WI4I7i6d67yXCP2shm0zEvS8T6G6A+6oDEfzCyBhCwx48OcGaa/Sn5OT8bIFo3QlfauM
         IQetgoY7vqeLmhgFQ2qIFnumAGli5hck3Jh0Hqf1fzioI4RleI7sClsCniUqJruL1R3D
         GnXnkMiOyP0bHq8hnBA8jZuPFNVgya+5kfe5Vazj3Yujfmm5NWFWoo31KhyOBz0H1IWZ
         tmICpcxfEJs/71YBCtFsdvLPwGR5ddYrB0Pw3O8msmKUbkKpChlpLdCimDvKIcUOPDYt
         GL8A==
X-Gm-Message-State: AOAM530ozi0yDRZx99OQYAhryY+KNk/XzcoXhcSgY5eujyIF/Riuz6i2
        amzWkNn/b7vxLoHbDi1eNZY64mO4BWIeIEh4
X-Google-Smtp-Source: ABdhPJxHAYsNSc0XEoBlU7v0LcNlAKceSzmO4eRTcT9oQPGS0OAczY6pB/zNs/54FmGQs/moce5E6w==
X-Received: by 2002:ad4:470c:: with SMTP id k12mr15916617qvz.9.1616297938305;
        Sat, 20 Mar 2021 20:38:58 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.26])
        by smtp.gmail.com with ESMTPSA id z5sm6881661qtc.42.2021.03.20.20.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 20:38:57 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] security: A typo fix
Date:   Sun, 21 Mar 2021 09:08:45 +0530
Message-Id: <20210321033845.13735-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


s/programers/programmers/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 security/lsm_audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 82ce14933513..ddcf572105be 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -212,7 +212,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 	char comm[sizeof(current->comm)];

 	/*
-	 * To keep stack sizes in check force programers to notice if they
+	 * To keep stack sizes in check force programmers to notice if they
 	 * start making this union too large!  See struct lsm_network_audit
 	 * as an example of how to deal with large data.
 	 */
--
2.20.1

