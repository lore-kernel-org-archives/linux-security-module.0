Return-Path: <SRS0=N8uA=4E=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB896C3B1BF
	for <linux-security-module@archiver.kernel.org>; Sun, 16 Feb 2020 07:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B751220729
	for <linux-security-module@archiver.kernel.org>; Sun, 16 Feb 2020 07:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZXyE1Lpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgBPHR3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 16 Feb 2020 02:17:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56024 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgBPHR3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 16 Feb 2020 02:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=GRmxcuiStJNK4Se+yV7ZvCjHXpXLLJWJh8lGPi6S3os=; b=ZXyE1LpgzMadB62tAzvZ/IYhVC
        p+YNY4HRyFXiBrBRr7WDUPiELX/6hgoknHqAjQd/iF90Jg1Gua4qHeNtANiGtUbVP/Tc0JC1679IQ
        RbXUZ9hMjWYF7vJo61idEQTesjc8+9ZhJoQqDXkYV+HXUNY3VXCwONC9iy0SieSx8V2A1rMQTXTPQ
        9t7Sq1GzzpYUv6bFniCU0gRuHcBPTwRrzYjwB12ksI27m0hgl/dWOMX6YGAupImxYhX392nlhZ2Tx
        +9retKZBwdmP/bCQDdX4SsNn2Z9kDWaUQAp9E21gP7IrEhHdeApU/rx9jvAGVxB6yKZC0oA5e5S2D
        /A3/yvDA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3EBB-00017A-GY; Sun, 16 Feb 2020 07:17:25 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc:     Micah Morton <mortonm@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] MAINTAINERS: use tabs for SAFESETID
Message-ID: <2bb2e52a-2694-816d-57b4-6cabfadd6c1a@infradead.org>
Date:   Sat, 15 Feb 2020 23:17:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Use tabs for indentation instead of spaces for SAFESETID.
All (!) other entries in MAINTAINERS use tabs (according to
my simple grepping).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Micah Morton <mortonm@chromium.org>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 MAINTAINERS |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- lnx-56-rc1.orig/MAINTAINERS
+++ lnx-56-rc1/MAINTAINERS
@@ -14582,10 +14582,10 @@ F:	drivers/media/pci/saa7146/
 F:	include/media/drv-intf/saa7146*
 
 SAFESETID SECURITY MODULE
-M:     Micah Morton <mortonm@chromium.org>
-S:     Supported
-F:     security/safesetid/
-F:     Documentation/admin-guide/LSM/SafeSetID.rst
+M:	Micah Morton <mortonm@chromium.org>
+S:	Supported
+F:	security/safesetid/
+F:	Documentation/admin-guide/LSM/SafeSetID.rst
 
 SAMSUNG AUDIO (ASoC) DRIVERS
 M:	Krzysztof Kozlowski <krzk@kernel.org>

