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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296E5C433E5
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF56120775
	for <linux-security-module@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iO9eReih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgGPKTA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgGPKS7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jul 2020 06:18:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A24FC061755
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:18:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so6479744wrw.5
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jul 2020 03:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CQc5oYthyIHgrA0b+wGSIPuxi+870IhMLwsMYznbmq8=;
        b=iO9eReihmr0Vz8A6cWVI3bxL6d0Uc7G6BuA0+hJvm+gKXgWeHecVpjDkq9n+SE5RjU
         /28b8ub5d7TRZIc/QHZVpy+NBxs23EVP7DRIpnTHA1mG38J/nTqCjh1Xk0l4vJpoTEh9
         YJzhqaytJpMdYTbhdNY7Lnpqefn7IxzG7jOmqj8DR48f/i6KxHD6cEHWCpHnYEcXTKnA
         nLDJrlY+LQHmz4JYze5/OY/jyVzvzha0dV4rfetUJBY4MU4ITbuNpMJb2jiclYfw+bjh
         MJPaCA8GEFlOhq66YAtJnUcqpW4xPfsWWwNX6seO1Nce3PLcmfYd0iC8jiquY2oXnUb8
         qCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CQc5oYthyIHgrA0b+wGSIPuxi+870IhMLwsMYznbmq8=;
        b=Db8Pqd7KeIO6BRdcXpBFri52TAHqHc2XQH9Ko952S049OcHW1nOPjKuxEhN6AaxFay
         Kkf4eU2gND+QUtMJjkaKfMIOn0pDg3pHjwnQpoNlFUdsY+2tTfSWqtnupqku0WtEkKJK
         KpKYNOdOOtpm9Q7DjPcSfEduHE3ucnM488f1Y/ceeyrEcwbCaY1H2b6RbN/aLn0zDoiQ
         7e/yQg6xi8a1CYKpaYj0st+dLh7J8DUsb9F/9RLZxPf9ZY8/wADQRjKlXIjwhZwoopLT
         zQqxsfE4tmg0i3Q3Qn2c+s3M67IqDTCTuKgKFhvOKFG12sGyP28AXTUHzQH5xmFyUf1X
         UuGQ==
X-Gm-Message-State: AOAM5307PK9x+BBHiBRNAS6yK7l9eaxg8hUaQYs9usGRtziup7cZ9q74
        Nf74f3ah2btmkueaw6WTjNzqpR9f
X-Google-Smtp-Source: ABdhPJzGHDKwFRtA+//gDaNgPPqZT4FL7Jra49snIMTYTZP9vobti3jf5nPBBZTHJQihHlab9a6D8w==
X-Received: by 2002:a5d:5647:: with SMTP id j7mr4254917wrw.242.1594894738240;
        Thu, 16 Jul 2020 03:18:58 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id b23sm8598210wmd.37.2020.07.16.03.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 03:18:57 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, "Andrew G . Morgan" <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 07/16] Manual pages: cap_get_proc.3: s/UNCERTAIN/CAP_MODE_UNCERTAIN/
Date:   Thu, 16 Jul 2020 12:18:18 +0200
Message-Id: <20200716101827.162793-7-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200716101827.162793-1-mtk.manpages@gmail.com>
References: <20200716101827.162793-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Use the proper name of the constant in DESCRIPTION.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/cap_get_proc.3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/cap_get_proc.3 b/doc/cap_get_proc.3
index b0a61d1..ded1491 100644
--- a/doc/cap_get_proc.3
+++ b/doc/cap_get_proc.3
@@ -168,7 +168,7 @@ returns
 which
 .BR cap_get_name ()
 declares as
-.IR "UNCERTAIN" .
+.BR CAP_MODE_UNCERTAIN .
 Supported modes are:
 .BR CAP_MODE_NOPRIV ", " CAP_MODE_PURE1E_INIT " and " CAP_MODE_PURE1E .
 .PP
-- 
2.26.2

