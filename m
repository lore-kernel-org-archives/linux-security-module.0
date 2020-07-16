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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D331C433E2
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B53E20775
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8IbH/UL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgGPKSl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgGPKSl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jul 2020 06:18:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CF1C061755
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:18:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so6484498wrm.4
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hwYJlQJTWFv4AtMgV7te7t46Z+LFjZ2qJ2kbUgXrFfQ=;
        b=j8IbH/ULwIZTPJXhcYDZMdz0HN6uEzebxxHQS3cZ6hcopG7/wXmpMnARPAl8eaptK+
         EbL1eBiGVRg6V2clwzzlHyM4qYhkCjqSJSP/4bkDhGAITnCZsobZ50f/u+UW1bFLSpcM
         3KFTg3I0tnKRjxNY5V5mS4SXPeTXHdDp0tL8wkfTgXYCjJNOH+SORlO6dg5g0AuRa0zA
         IWRfAfebgSUGEKh3UMPEPrs7CYZB6cDtHbFThEtoROSiaAsB5ulQat5ge0gXa1pw/rl/
         jtDZ31Nz21U6mzi/HrJyncFobYYJb9USn94o5w0fnEYqT1RKjw5V8+wI6yqYXPXdP8v8
         G+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hwYJlQJTWFv4AtMgV7te7t46Z+LFjZ2qJ2kbUgXrFfQ=;
        b=fVfomDcinzNTYJ3E5x3gWTU4a3YQxJokkuK7jAST7OerVUvlYPLxzQQD4qOWi+f89m
         OXwnXN6ztFEbqbY010/L4mmQTEXC5KvKi7AY0wIyqTqgRfSIymr6h7Y/P3VCfNwV6jdT
         GKr45xCdIeWCnZvAKrzQsB77mtP4aQRr5CDRtC9YWDTCWiAEmFW4kT6P9y5yYJjEKMG6
         zsU31P7FoBtobrFqcLf07eP03Qaa0sDW/ybJkfesxRBkV8RzumCrw+KwiIoCJQmzXSmT
         eiUAZX5KCyXYNnypt+/mzNjwpBGnZuMnavoLZu5ZXP2sgz2tyRhs3ZZd0VqqVIXZJDax
         3jsQ==
X-Gm-Message-State: AOAM533KaY+nB8wNCUTobguyxQNOrD0UWu8HYauC79RNGJ4F0ioM3nG+
        XS/x8M30xAQtwmpF1ZnuB7k=
X-Google-Smtp-Source: ABdhPJxp33ubWQsiFvTON9qoQiQBtIMwqGIaF9ZAcOvmKNnBIbaapCyGp3O6IxMBdAf4XHkoHeTCUw==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr4493277wrq.104.1594894719644;
        Thu, 16 Jul 2020 03:18:39 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id w7sm7503996wmc.32.2020.07.16.03.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 03:18:39 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, "Andrew G . Morgan" <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 03/16] Manual pages: setcap.8: Formatting fix: use bold for function name
Date:   Thu, 16 Jul 2020 12:18:14 +0200
Message-Id: <20200716101827.162793-3-mtk.manpages@gmail.com>
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
 doc/setcap.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/setcap.8 b/doc/setcap.8
index 99e3c36..90aa13f 100644
--- a/doc/setcap.8
+++ b/doc/setcap.8
@@ -25,7 +25,7 @@ argument is also verified.
 The
 .I capabilities
 are specified in the form described in
-.IR cap_from_text (3).
+.BR cap_from_text (3).
 .PP
 The special capability string,
 .BR '\-' ,
-- 
2.26.2

