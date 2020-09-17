Return-Path: <SRS0=t07G=C2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57348C2BBD1
	for <linux-security-module@archiver.kernel.org>; Thu, 17 Sep 2020 14:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED8F52078D
	for <linux-security-module@archiver.kernel.org>; Thu, 17 Sep 2020 14:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zfzwax3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbgIQOMt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 17 Sep 2020 10:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbgIQN6l (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Sep 2020 09:58:41 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD55FC0610D6
        for <linux-security-module@vger.kernel.org>; Thu, 17 Sep 2020 06:47:44 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d19so1174017pld.0
        for <linux-security-module@vger.kernel.org>; Thu, 17 Sep 2020 06:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+R0CfwNbMgOaTG4ScznT7OJX0b8ugIojVEfeSnnqNTc=;
        b=zfzwax3PpdhSOHwd1Dziyh/EVuvLFMJgWgUyuNomMMIfOy+ltMgttpjv2PkG0QUrMg
         VQ4tkC9yB0StxHOspic8lBEaytG89CvgXfNpG01BM65wRcafv1kgrlPLj2GCQY94wTgE
         zMNTKBDl6YPTGmySD1a74bYQ5eCzuSljS+Xze4jq2M4G23zm2MM6oTyfwCwJdDnwWzFS
         hSRNWA3rzc6ZJT5GuNLKkUue9ferEZlkW82DuXD+E8Su8oaJCTy5uj93w/vR2eM1e+LZ
         OdZsqPF0JYLGzk0yeFhD0uDG4zhhs/QSWomdvTcDXSvQQtWEbM9IysNVgavJZt0qoVNB
         SByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+R0CfwNbMgOaTG4ScznT7OJX0b8ugIojVEfeSnnqNTc=;
        b=VjqigLlDFllLPNGKWvbsva+FRcVLy/r70mfTyq7w0eQ3tLIUJcoDwzc6zifEZzfhKN
         m+XQh9pPotnNfPoWOtcO0CqSLkpbzRKayMrxsiSscIkVc89KWoY2bo7fV4xbo+nGPd+u
         oYuEw+BkE5exA6AOpy0J2UZNlhk5ftV0UjWhKAz75xMq4/8TBRog7FRBOVuR6kce5HbK
         MIw7DIAbGNafNikFugG05Djd3hi2qpHxccJ0HgdJPFX1h35qTwYwYhm0couBHx3XFVx1
         bNW5SzPEZKj+0C/4klHzFnIN7GKGPoI6PC+BKmjOdbx3S/mD+/OBYe72WeIZCEUIiY4T
         Tx7w==
X-Gm-Message-State: AOAM5302e1rJPqm5zLw0yna1UPgWz4xwWHzI4HaHbrV1CQswaQtr6yiN
        47MlDlDx4//GHUQUJVDFSVT+eg==
X-Google-Smtp-Source: ABdhPJyvy8jjWm23ZilkLS4jB5OQY9gVJSrgQpws0JzwxO3vK5veKrElGyPGUmVKb+AhTbMGL/UX9g==
X-Received: by 2002:a17:902:8305:b029:d1:cbfc:79b7 with SMTP id bd5-20020a1709028305b02900d1cbfc79b7mr17679996plb.33.1600350464395;
        Thu, 17 Sep 2020 06:47:44 -0700 (PDT)
Received: from localhost.localdomain ([117.252.66.163])
        by smtp.gmail.com with ESMTPSA id i73sm6821120pfe.67.2020.09.17.06.47.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 06:47:43 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jejb@linux.ibm.com
Cc:     dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, lhinds@redhat.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 4/4] MAINTAINERS: Add entry for TEE based Trusted Keys
Date:   Thu, 17 Sep 2020 19:16:38 +0530
Message-Id: <1600350398-4813-5-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600350398-4813-1-git-send-email-sumit.garg@linaro.org>
References: <1600350398-4813-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add MAINTAINERS entry for TEE based Trusted Keys framework.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d0862b..0a913ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9668,6 +9668,14 @@ F:	include/keys/trusted-type.h
 F:	include/keys/trusted_tpm.h
 F:	security/keys/trusted-keys/
 
+KEYS-TRUSTED-TEE
+M:	Sumit Garg <sumit.garg@linaro.org>
+L:	linux-integrity@vger.kernel.org
+L:	keyrings@vger.kernel.org
+S:	Supported
+F:	include/keys/trusted_tee.h
+F:	security/keys/trusted-keys/trusted_tee.c
+
 KEYS/KEYRINGS
 M:	David Howells <dhowells@redhat.com>
 M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
-- 
2.7.4

