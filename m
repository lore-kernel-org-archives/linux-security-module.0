Return-Path: <SRS0=MEX0=A7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EC9C433F1
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD9FB2080D
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRFly6is"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgGTJOX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgGTJOW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 05:14:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01BFC0619D2
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:22 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l2so24439129wmf.0
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fPZvTaCiahAPdjFb+17oWG371m27PZyMBdW5TOckVTo=;
        b=fRFly6isaWXsVuJJTlE2lDMzNPRbP/8BXdtfLqVDK739uaoljlx+LRCHbBdpjDZIaC
         cxbJuuEhkvr5FRrYFjsBBx7DaDOqbj4cP3rJhrsR32BTBLwmeVJ6WKO2dvn73bzZoBd/
         SmKfuzzE2/M3LSY5Q+0L3tgb1JaCqnY+/ncTOjJnVbu5+2UF8/hxU2jsDAW9k4DqUONL
         S1L/sylA1JO8wKMKGNw8k3maTm+widNnQZtHs9FVKplYt13+If/Zs6+GFDRmgg56BFO1
         LA1WQGny/s41Df/szFCctnY2YSXAG0khp9AV5qFPaZGR9oQCHgoi7Cjm7s1+9/LyLsCn
         9Bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPZvTaCiahAPdjFb+17oWG371m27PZyMBdW5TOckVTo=;
        b=FHw9AUTZ9wR+qvm7ES7gVjxPRox/kQ1oeOSMYH/8mICNwLPq9T3YPQ4NT10QqQXahn
         fHgPZ4mA6dZJw75maYrY8zkfGZK/XAQwXsy3x61xmaB4vIWo15gNNTac9foVoiTe+9yR
         1H8uGGim5u1o8PSWl5PxZyIS83eRZRuZNa6d0A3Afw6jyPA5jiCK3Jr9tCOgV1M+OAV0
         WdkB+E6Vk5w3JMstRuFRwlgbvIsagu85sokWJz8ZXQamQRQKFdHHdQfMsXuc6yCLRTUF
         R32fUv/O6bCLPFUyBFMrkPYhWJrh+L4iF12KEhwuaRI+ULu7Nnr583hP5xnICBtL9AKn
         34FA==
X-Gm-Message-State: AOAM530j69jhKo+4mpnajjr3v0QBMfpRbArN1PUj1FcPIHEI68blZ6xY
        vU46XEhsIUfiiWLno7ctk48=
X-Google-Smtp-Source: ABdhPJyiGxiYcVL7IMYuU7LqNPwmakZu+Qg/18P8bvuhvY4TS2SEu7ZFbcOjmzL2XH08OmF+hbgH+w==
X-Received: by 2002:a05:600c:c1:: with SMTP id u1mr21095184wmm.48.1595236461389;
        Mon, 20 Jul 2020 02:14:21 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id 31sm12152560wrp.87.2020.07.20.02.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:14:20 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Andrew Morgan <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 08/15] Manual pages: getpcaps.8: Format options as a hanging list
Date:   Mon, 20 Jul 2020 11:13:21 +0200
Message-Id: <20200720091328.290336-9-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720091328.290336-1-mtk.manpages@gmail.com>
References: <20200720091328.290336-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Make the options list more readable.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/getpcaps.8 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/getpcaps.8 b/doc/getpcaps.8
index 7b73e86..fb3bc65 100644
--- a/doc/getpcaps.8
+++ b/doc/getpcaps.8
@@ -23,13 +23,13 @@ the
 format.
 .PP
 Optional arguments:
-.PP
+.TP
 .BR \-\-help " or " \-\-usage
 Displays usage information and exits.
-.PP
+.TP
 .BR \-\-ugly " or " \-\-legacy
 Displays output in a somewhat ugly legacy format.
-.PP
+.TP
 .B \-\-verbose
 Displays usage in a legacy-like format but not quite so ugly in modern
 default terminal fonts.
-- 
2.26.2

