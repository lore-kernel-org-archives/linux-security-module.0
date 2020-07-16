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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F695C433ED
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D9320825
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+d0v7rS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgGPKT3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgGPKT1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jul 2020 06:19:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BA0C08C5CE
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:19:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so6467281wru.6
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B4dSB5KUOD8YyH126p2gHbAt4+JMtzeRy4E2WgZpl64=;
        b=r+d0v7rSQWCEw7wy6EWbXcDiXu2R2X+uCFc3ZZDIkGX+72dS68+rdDMnoRpuqR6ccO
         hBPOydL+fjv8GlppTnLRdjbouJoIiwtG6xH9JojPitUZ3EXU0kwmwtgNI5xcIHZgDfUe
         tWzYt3R4iXH8ZeJXhAL41/CrxwIS42HHmRHyTnl8uytLEDTFkfF4IT4phCAqdEXz/fa+
         cksVmCfSltlNuivK9htIbWTKylhvAF3A3/is0kxGkE5cBeNtSHfx0IgPU6s6mYzl9peq
         A3nhLN3q8d3qrgyx0R2pLCBdzcRW+kqozw2ohzZ1ycKDNXrrYeDjXa5m4EbZIiIPDFgn
         /b1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B4dSB5KUOD8YyH126p2gHbAt4+JMtzeRy4E2WgZpl64=;
        b=lZbOpNj+JgPzg7NbnBkod8TyNKt9DGXefzditm2++WLx+log6b6tuq1R/5avgw4MCF
         C5dHxWinErTDe2vx4wEhc1I4auOY1zzF5w4bEVlAHOvPB0b8/IL3UkCJC/DHUAKQYGWn
         6TEYnzKBr3GMRo83hEX0XJM19mJByKNFHdo4CIePV55ETa8F96D7fQydczFwgQY1wRkA
         HirwgmBa3kktzAWXrH/23HKjqeis1Hs0Pn5d8O9ALqWNGw7835PQWgD3Q3Pfmta8LafZ
         hyzU78NPuoCzRGlCdHN+ZksdRwEkdHg2JLn2erIyXKM2qmf5zoAufueehiSeeE47ag5q
         tq+g==
X-Gm-Message-State: AOAM532u48nE7jby/d7FxBg/zGDjpdxregM237JGTfIeNNLxmRkbNwCZ
        vOX6+Ha0mzzZbmM5+m48cY0=
X-Google-Smtp-Source: ABdhPJwHnVBPJ5ZJZZ89KZQpNewytDRrgpWbJ4YfOzRXr1SLYFf+OpmcCdI7hYnJOdOBb7Lo9RPf+w==
X-Received: by 2002:adf:f9c8:: with SMTP id w8mr4335473wrr.354.1594894765533;
        Thu, 16 Jul 2020 03:19:25 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id p25sm7420217wmg.39.2020.07.16.03.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 03:19:25 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, "Andrew G . Morgan" <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 13/16] Manual pages: capsh.1: Describe the argument of --secbits in more detail
Date:   Thu, 16 Jul 2020 12:18:24 +0200
Message-Id: <20200716101827.162793-13-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200716101827.162793-1-mtk.manpages@gmail.com>
References: <20200716101827.162793-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The page currently gives the reader no clue about the format of the
argument.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/capsh.1 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/capsh.1 b/doc/capsh.1
index fd6a5ba..0b987f0 100644
--- a/doc/capsh.1
+++ b/doc/capsh.1
@@ -164,6 +164,9 @@ the
 header file. The program will list these bits via the
 .B \-\-print
 command.
+The argument is expressed as a numeric bitmask,
+in any of the formats permitted by
+.BR strtoul (3).
 .TP
 .BI \-\-chroot= path
 Execute the
-- 
2.26.2

