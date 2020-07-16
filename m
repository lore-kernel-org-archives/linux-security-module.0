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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24389C433E3
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8FB42074B
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7lVPDZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgGPKSq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgGPKSp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jul 2020 06:18:45 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491D7C061755
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:18:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z13so6479092wrw.5
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0MKnmfFInl1OgZTiFvBgHkHHCTJlDGqRuJxICpPlVC0=;
        b=H7lVPDZXkR0YksJ4bvHBmYMBpf40Kcm+Gz7+jOlUQMSJ2kifQMz7LMk+URuoRKQCvz
         mvdZv7yyKX5qfU25fn4zeTBtNbBTLQxsG+Ti+85o7LnUn0vQER8HJaqZWOEATrxfmW1f
         ByeEedcyOQR7X3NZ+0tNPUhqK2bQdRlOGreXM9oZPiS1PY5AFb28u6msR3J+7qAu58Vx
         MxMdI28sMWECTHiVikw2gwnuf8OtE+SiLiAGHums+n4pFQovtRoBecs08TC28l4Va1+p
         MuA2o+NcnU5/G8vgzkB6F8jfNWM+fn2prmP1hiuZoB02JdIQf78nJoDAsBxIJeYkPi7o
         cs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0MKnmfFInl1OgZTiFvBgHkHHCTJlDGqRuJxICpPlVC0=;
        b=bHA80HkPOOeGypjpPVqRs0NpoLSXmTvTVoQzFWiF0ltMosJmjdpd2816s52wFyLhGT
         gjdPl8QA1tQCZuf1XENc8vS3W75eNkUeXUYajLeZ9PHav/+XOmaVtUNyBAcUM94RWTlp
         H1sxDpcjAZI64OMvvXSZ4/kTrpVV8wzQryE++MxPKHCL9PyqkdneFpVSnz3mh7niKF2y
         uTHSNYjpF93mDmGCHV+lqNXS8U3AxnE1XM6AQRc/W8xV2I2tVYErGYDJwH8LEd/mKOPh
         pQAsVLNMfzYTgYZfDu40sesWC5GS5MGInPMet+yYp70YeTglWEYjLDypOc4Z2D3jDS4O
         Q2wQ==
X-Gm-Message-State: AOAM533CZ4gB/h2QvdmGGLMwkdlqKtyor7KssEi+nSkS2Rzizt8FTeH0
        JXBaE/kFRD//ctXNsMQ6mIw=
X-Google-Smtp-Source: ABdhPJwt/UbZ7ei8vCjHp/NXp23SDFB2HMr6bvM/DBQ32daplUQ3823yRF/YbOCF12ZbMNlTQFdTaQ==
X-Received: by 2002:adf:b608:: with SMTP id f8mr4653530wre.363.1594894724047;
        Thu, 16 Jul 2020 03:18:44 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id v3sm8292584wrq.57.2020.07.16.03.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 03:18:43 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, "Andrew G . Morgan" <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 04/16] Manual pages: cap_from_text.3: typo fix
Date:   Thu, 16 Jul 2020 12:18:15 +0200
Message-Id: <20200716101827.162793-4-mtk.manpages@gmail.com>
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
 doc/cap_from_text.3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/cap_from_text.3 b/doc/cap_from_text.3
index 455a52d..e59ca59 100644
--- a/doc/cap_from_text.3
+++ b/doc/cap_from_text.3
@@ -172,7 +172,7 @@ The example program below demonstrates the use of
 .BR cap_from_text ()
 and
 .BR cap_to_text ().
-The following shell session shows a some example runs:
+The following shell session shows some example runs:
 .nf
 
 $ ./a.out "cap_chown=p cap_chown+e"
-- 
2.26.2

