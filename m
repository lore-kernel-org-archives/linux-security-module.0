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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D852CC433E7
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B9520775
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du/YJfgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgGPKS4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgGPKSz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jul 2020 06:18:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A0DC061755
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:18:54 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k6so6493737wrn.3
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tYLFK9MQZoeCsCBrEsDxeXYg5eoqikO7agT9zmA5iGo=;
        b=du/YJfgsgNK8OcMXijZiALrc1JcULNiUHq1xNF+AAKjVy+QyuNoOVLIH3loEKUFCN1
         3xxjOeC5315pFA+FL0rAHI3mQJ2XPtde0Ew++Mwbn+3B5UkLarI2Wx6IUeIGE8ieqz3A
         Afslo7cjqHzYGRT6vtBX0xqXdhZrE+OIqbOFwwGqPqAPawGJVnQLDcMed5B9yL6Cm7I0
         4QwJnJuZoypbNXb6tcWpxF7Rk8z7wXHFJM0RHjnIOB3SBEg6D2pBmyIEdvxyndBPD4Uo
         Z5ca83HEYyktq32tV0qh6GP+Vpt3bavwr6D3nT740hYq3kBTu2c7PWl4mB0gCI59phuN
         0Nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tYLFK9MQZoeCsCBrEsDxeXYg5eoqikO7agT9zmA5iGo=;
        b=Chw+HiNK/q6wz30Lja4j1iI3Zyca8WJnrHsA+jHDauaetS9+V6iH7gjr83c5yYmVCC
         tckGf1yLSAqdSI2n2x01d/KXHIZXWBrPLaEILJu+0DRcx/f/985djraI/u3FhwzFLZGA
         BQRGVQ1jjR/fHgU5EiCXwwCG3n4iXfE6gXJtEAHoQ30+lpWGwSaN7NCLa1zYpjjMeQgo
         r/GfH4y6LU2PZpbadWqyZ4oPJ86CyC2X6cRsiA4F5oMCjRu9CAOsi8op3WkI3J6w5sZO
         MWeyqz4DajRd7muN4JdjM6TV0N1ru6qWv88rn8iA6U11225uxLWeLmZRJCFlVRIdykCz
         2awQ==
X-Gm-Message-State: AOAM533Cwarqk0Neflx3GkYeZFlMdVg7xtPugjsBNGF61726UoAADjxn
        36BRtTdM0uBV2tJhuFJfnHg=
X-Google-Smtp-Source: ABdhPJw547dM2c50d8Kr50B+XXMI/Dw+vfXDBpacFtpZlmzQ08FXXOLc1TJ8eoEaZ4E0duiBSvGzfA==
X-Received: by 2002:adf:ec88:: with SMTP id z8mr4329877wrn.395.1594894732751;
        Thu, 16 Jul 2020 03:18:52 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id j75sm9036150wrj.22.2020.07.16.03.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 03:18:52 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, "Andrew G . Morgan" <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 06/16] Manual pages: cap_get_file.3: Remove stray macros that have no effect
Date:   Thu, 16 Jul 2020 12:18:17 +0200
Message-Id: <20200716101827.162793-6-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200716101827.162793-1-mtk.manpages@gmail.com>
References: <20200716101827.162793-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

These macros give warnings from 'mandoc -T lint'.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/cap_get_file.3 | 2 --
 1 file changed, 2 deletions(-)

diff --git a/doc/cap_get_file.3 b/doc/cap_get_file.3
index 42255ee..c028148 100644
--- a/doc/cap_get_file.3
+++ b/doc/cap_get_file.3
@@ -6,8 +6,6 @@
 cap_get_file, cap_set_file, cap_get_fd, cap_set_fd \- capability
 manipulation on files
 .SH SYNOPSIS
-.B
-.sp
 .B #include <sys/capability.h>
 .sp
 .BI "cap_t cap_get_file(const char *" path_p );
-- 
2.26.2

