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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740E1C433EC
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C4222074B
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwV7Fqcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGPKTS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgGPKTS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jul 2020 06:19:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA79C061755
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:19:17 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so6466878wru.6
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TQyGMp8luW/B/HIvUl/779z54J5/OP1qRU1QTUe8f4k=;
        b=qwV7FqcnF0M+QjfaXlDt1fZZIMwSPiJ/WJSE8ZQVDy8xPJlZbLY0GB78tHWztmS5NL
         PaQXGRbxyLUH/aGm8hWtAtEtEaj7MdI0xZ7KjdMlO5MjMa6V//NuBqUhN31/Yr3P+JsG
         MYjp5/VqxYz7V6HGjQ8f/etgLPWiAWVNh3oxR2E7yrV2ib+pxXk7NNwAjYBlOSRM7dqo
         LDBV/GC/nrOoRsXhPtw/TR/PzhmT/P9DxlRBFexISUcIq2PWDt5aTW+sofGMFuZZMO7n
         UAhgUgtAj0JmJ37J5Cl3vbsA6zVs5qlLR6l2tcb/lWcnDB7SMsAqJfrtxgvwpSWZg5Yo
         Misw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TQyGMp8luW/B/HIvUl/779z54J5/OP1qRU1QTUe8f4k=;
        b=LXN1YN9OT//v5j0qXrOOTISSy1Qto90u7qzcHF3wNs5W1QcNYcfuWKglqKvucZbkPC
         tJp7IF9Xq5MrnF8RNG8NLcWwlGouFS6pmLvDqJe1M0Vx2pqz+/0a5gNWilNI2IlKWCJs
         diz8ACRnaB79iPWZ9wERO4xGTyOVrVw+hJmApYU/LwUBxDpqsR0RlGY2gR2yNus2SfD1
         cK3nwwk8jxc7cXW5wUnb+hi5f/qSLBHAOnoxKcWrMOjhmtrBPzDEL/mZadOXguvSoMv4
         I6Eyn5hRQQD5mOj9GA/WArEiXyxALHLCCmls2ZHdrw7er7/bM1Zc2l9zsIEhCehsRBCu
         zUBQ==
X-Gm-Message-State: AOAM530UN/d8XqukYNxqE4+GbpZXpxQrzzReWMG/Fbk1c8vi8UT5eB3/
        ff74izxtwUdlvcn6bjxOWmzHHbF6
X-Google-Smtp-Source: ABdhPJzRHzLajS+UJZFaKwvOoYqv9Z5mekz2SjINwseFK/Hd2KlU5OHsR18ldlTCTqJvEhwK+vQMOw==
X-Received: by 2002:adf:ce8d:: with SMTP id r13mr4711334wrn.392.1594894756557;
        Thu, 16 Jul 2020 03:19:16 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id q7sm8456329wra.56.2020.07.16.03.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 03:19:16 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, "Andrew G . Morgan" <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 11/16] Manual pages: capsh.1: Correct/update the Cap field example for /proc/PID/status
Date:   Thu, 16 Jul 2020 12:18:22 +0200
Message-Id: <20200716101827.162793-11-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200716101827.162793-1-mtk.manpages@gmail.com>
References: <20200716101827.162793-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The /proc/1/status output shown for --decode=N is bogus
(e.g., ffffffffffffffff == 64 capability bits). Furthermore,
showing CAP_SETPCAP as missing from CapEff is historical,
and ceased to be actual more than 10 years ago.

Replace with a more current example, and also add the CapAmb field.

This change renders some of the following text obsolete;
that will be fixed in the next patch.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/capsh.1 | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/doc/capsh.1 b/doc/capsh.1
index 522e719..916353a 100644
--- a/doc/capsh.1
+++ b/doc/capsh.1
@@ -198,10 +198,11 @@ This is a convenience feature. If you look at
 there are some capability related fields of the following form:
 .nf
 
- CapInh:	0000000000000000
- CapPrm:	ffffffffffffffff
- CapEff:	fffffffffffffeff
- CapBnd:	ffffffffffffffff
+CapInh:	0000000000000000
+CapPrm:	0000003fffffffff
+CapEff:	0000003fffffffff
+CapBnd:	0000003fffffffff
+CapAmb:	0000000000000000
 
 .fi
 This option provides a quick way to decode a capability vector
-- 
2.26.2

