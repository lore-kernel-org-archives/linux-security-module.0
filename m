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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A78C433EB
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 689C82074B
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBuz8bBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgGPKTE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgGPKTE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jul 2020 06:19:04 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F67C061755
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:19:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so6430898wrs.11
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q2LrDzr98NUf9gsquNLZVCZZ6MwxCoD1rH1sNrjWwhs=;
        b=pBuz8bBx7MtHGpOUuyRejd32SfcXYvHv4p9SjOq1ayo2zYlU7qt6DF1pHOnjHTewMw
         onN9oIPiU3DywYKETjiSm5TfLe+eGq9XMEJJAH++uC/xT1bGKmxE1R2x5fzqBjidXpL9
         696qjfSUA5IEktl0AGxuqb+bgzUaFdmTc0Nar8HtUm2XFVFu3r64rVkTWtihn+gCHIlt
         VcVQI7zVcWtrMRQsa4U+3IzwpUcXyyyP2+w6iyqAqLBlIqCUhCcgqcgMbXNS7A83hScK
         mP7h5h2wDHR/fU61BVL3zHLi+DmXcdnpLIbE+x2pA6wn3j8k746O69ENsLaBxSa8mBNL
         GNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q2LrDzr98NUf9gsquNLZVCZZ6MwxCoD1rH1sNrjWwhs=;
        b=cszVOlsLYlA9ix8KxAR+PKYyR9tm85cYcOnPvAJqOTwu3LOnD8c30FQwUXhmtxCOhA
         KtOqs94MWcblb9WME89HjMx5+oplfwahechweMAcsDJDOuZ66on47VES4DJqDmYCoRQH
         iMWoyu71hckQbmJwDIuiUFWqiIUKnQhcH9jGFepJrxzk6WkzEwjLpMDQHxKVeKPQ/0VP
         61Q4B8q98jPyg8LGJ+pv1kcdR5VPD3H9tyQnIQd6j7++XLC7R+eSN5UNTUSZOyZsIlab
         5zWahIZ2wMYk1PvNr8ZTxkyZWQOID/Xd38G2KSsYamoY7CJAYti75fBnsLrCdycdUsXF
         Q1LA==
X-Gm-Message-State: AOAM532KXIKZ5pCrhSUfzkotlO9yY0KQMolOBDEX3TkKNQoNZ2j5rdXJ
        bNBGH22LcXVWBidHI5I9+tk=
X-Google-Smtp-Source: ABdhPJxTEGV5mgT5xJmiKVTVhJ9yv1CnBZNyF8gTlP7svkAt6rWBfS+JL1iUouA51U4Nka99SgHW+Q==
X-Received: by 2002:a5d:458a:: with SMTP id p10mr4332817wrq.184.1594894742713;
        Thu, 16 Jul 2020 03:19:02 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id w16sm9963329wrg.95.2020.07.16.03.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 03:19:02 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, "Andrew G . Morgan" <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 08/16] Manual pages: cap_get_proc.3: formatting fix
Date:   Thu, 16 Jul 2020 12:18:19 +0200
Message-Id: <20200716101827.162793-8-mtk.manpages@gmail.com>
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
 doc/cap_get_proc.3 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/cap_get_proc.3 b/doc/cap_get_proc.3
index ded1491..f90c4f5 100644
--- a/doc/cap_get_proc.3
+++ b/doc/cap_get_proc.3
@@ -261,7 +261,8 @@ The library also supports the deprecated functions:
 .BR capgetp ()
 attempts to obtain the capabilities of some other process; storing the
 capabilities in a pre-allocated
-.IR cap_d . See
+.IR cap_d .
+See
 .BR cap_init ()
 for information on allocating an empty capability set. This function,
 .BR capgetp (),
-- 
2.26.2

