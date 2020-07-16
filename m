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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB9FC433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C31D52074B
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdQD+F5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgGPKTJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgGPKTI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jul 2020 06:19:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9613DC061755
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:19:08 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z13so6480303wrw.5
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3XnL7iqGjxKA17qRzoDq/KQ6FTyi5sd0zk5glsQAWco=;
        b=TdQD+F5dHTF1qo9dlUeGThMW665msNyKquNB7yzjZo2YoH8jnc/+84/hOwwp29d/us
         3ELcdrW5fHpQxnAl62bac8QbYdnyJar8hBh9g88w5tOuMpXvIxslaK+srdyp3NWTFW+U
         xtI6XoW3qwDGr+LPkZiMBzCURrdxdyT6UxXZPwtK0HFw2o6nV/Sob6VG0IfE5lksLt2f
         MFC0VjOMz+7qO3ofixoidolPvP4hY5DxBfkdNw+2aG3Gyi4dACc4+gSzqijlSkSVNj44
         JKVQmHbGj6mUkC+O1KLxgKBWNIsODcniXj4wgyPRw/Ok4Yt4k7YaqwxT3pM42fZpn8ft
         9ygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XnL7iqGjxKA17qRzoDq/KQ6FTyi5sd0zk5glsQAWco=;
        b=BgjeJ7iDF1nb3b0CWbljB4hZsANNL533tl7hpOpDU4iIfu6eQblH/mhkH7nOuGk5W/
         fC25wqZ/VgDGf4Y5iK9DrvQUKM3oEWKthqrPikByN2ESLvdxwOGh/PB0Px0Sq0iAisqT
         ZHxmjjggk67ERV1YJIqeAUzbTWxGuhAyuCZhQqyoj+AkO8kSerDXCgbT3uGNcUmsOM+X
         awqUpfEQkUrV3Nd8riyVYA8zkqEaAof//lohnM+V9JgDikGAqeKghExcSk8GBT0/5Qks
         EUH2ac3NAF4Nhpvq6U7moKXyzukhZyofW7qpc02IeVdAGLqHd/IgZH8OoEiEjnju3ez5
         fbHw==
X-Gm-Message-State: AOAM5315OkMKVOM3T9iqwCe5IxFouRkVHvL8LaDScS0kMBXkcjt2XbWB
        dMWhnb4q1LAEGHi3skHhGOU=
X-Google-Smtp-Source: ABdhPJxaK3VKQAM0vy+YaW3u7UUd+6z7zAT++aIRHrbYEzB6xeW9FqMfrA/Q70q4honmY9GO92eg2g==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr4471323wrq.189.1594894747269;
        Thu, 16 Jul 2020 03:19:07 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id f12sm8200777wrj.48.2020.07.16.03.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 03:19:06 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, "Andrew G . Morgan" <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 09/16] Manual pages: capsh.1: spelling fixes
Date:   Thu, 16 Jul 2020 12:18:20 +0200
Message-Id: <20200716101827.162793-9-mtk.manpages@gmail.com>
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
 doc/capsh.1 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/capsh.1 b/doc/capsh.1
index cd30dc3..24e80b7 100644
--- a/doc/capsh.1
+++ b/doc/capsh.1
@@ -103,7 +103,7 @@ effective set.
 use the
 .BR cap_setuid (3)
 function to set the uid of the current process. This performs all
-prepations for setting the uid without dropping capabilities in the
+preparations for setting the uid without dropping capabilities in the
 process. Following this command the prevailing effective capabilities
 will be lowered.
 .TP
@@ -242,7 +242,7 @@ vector has capability
 raised.
 .TP
 .BI \-\-addamb= xxx
-Adds the specificed ambient capability to the running process.
+Adds the specified ambient capability to the running process.
 .TP
 .BI \-\-delamb= xxx
 Removes the specified ambient capability from the running process.
-- 
2.26.2

