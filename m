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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED48C433E2
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C44E21775
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJO3d82H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgGTJOl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgGTJOk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 05:14:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE58C061794
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:40 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so24379751wmi.4
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nd5MRrfc4FbCz2nNbnQ3jrH4N68Vrj6ya5355SWWcsg=;
        b=mJO3d82HOX7escqUNf/bjOZNOI/7cbzcr4kKKXurp/8Rqy8cD0Rths4LRAvcsnQxTl
         7wR5DGZ1Cu8FeU49YCwYl+YyDlGWJY3hxxCEYRkQqjue/34vuI3r4Qd4Zk5zhUv3kWyh
         ijSpDwmhir+UaFjgs3bjPavfr0o1Fb40ohsgv/G9xCGksivbt4V1+wIY1xuLjxTVuGWV
         qeZUtzpdTemhHu+TRIshZlq1PORXslbzmgpOQrCKGn/3tv1K7UgnPHeGGtEC/4vpzPrL
         un8V/1GtSmBHTOWUY4MljHu5qUbZC1fMmSoQSGTB1weUQ8sPdnQn8Yb1KQIdZwkC/8Jz
         E5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nd5MRrfc4FbCz2nNbnQ3jrH4N68Vrj6ya5355SWWcsg=;
        b=gqYmPhGoaw/j0rbcS0nx0SUGcdLRJT4YRor3DMEBtVtfqfDUggizwZOUE3aJxHXsaI
         ZrlhrPhZ7BDv9DmHw4ipvSxRPhHCQBabIrwyya6DgPSOTv+HOLK7nLN8AJHjHsFeRgdB
         E3tWOiX6rbYOs6dazIb0YrNrXS14Ni3UklEU7Z4XrGrETmomfbPMyxvKMSh5PLdVEhSM
         iT1zjbCgI3xfdP/UveRu3IIaNHDO4HbF60iiqhDyO/d6NBd8yWNbjO8zPP2aUpz7ZPUJ
         hI3eZHZL4A4HSW8s6GeX8BeBI4DHXR3U+ODlya5yShv4GxvCrZVoIWSAGBnPd27DWkMS
         3etQ==
X-Gm-Message-State: AOAM531T+rBa9Amdh0kl5b6qwNM9c3ezEPP3CJXN7tzSDaefUWq1mwQG
        pG4MrukNbcrYqZUH5kN3UinFj/RV
X-Google-Smtp-Source: ABdhPJyLgxUtySV7KdCjEcZYwQ9nnzS0H95/AUhCeTdsbBAi1YN2lzrOlGh56xV6rjgzjwVJVzxG+w==
X-Received: by 2002:a1c:f616:: with SMTP id w22mr19845011wmc.44.1595236479251;
        Mon, 20 Jul 2020 02:14:39 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id c24sm6036215wrb.11.2020.07.20.02.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:14:38 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Andrew Morgan <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 12/15] Manual pages: cap_get_file.3: NOTES: note the effect of the Ambient set
Date:   Mon, 20 Jul 2020 11:13:25 +0200
Message-Id: <20200720091328.290336-13-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720091328.290336-1-mtk.manpages@gmail.com>
References: <20200720091328.290336-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The addition of Ambient capabilities in Linux 4.3 rendered the text on
the effect of the Effective bit during execve(2) out-of-date. Fix that.
Also add a couple of paragraph breaks to improve readability.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/cap_get_file.3 | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/doc/cap_get_file.3 b/doc/cap_get_file.3
index ceacbaf..dc7b571 100644
--- a/doc/cap_get_file.3
+++ b/doc/cap_get_file.3
@@ -103,13 +103,18 @@ or
 These functions are specified by withdrawn POSIX.1e draft specification.
 .SH NOTES
 Support for file capabilities is provided on Linux since version 2.6.24.
-
+.PP
 On Linux, the file Effective set is a single bit.
 If it is enabled, then all Permitted capabilities are enabled
 in the Effective set of the calling process when the file is executed;
-otherwise, no capabilities are enabled in the process's Effective set
+otherwise, the process's Ambient capabilities
+(or, before the Linux 4.3 addition of Ambient capabilities, no capabilities)
+are enabled in the process's Effective set
 following an
-.BR execve (2).
+.BR execve (2)
+(see
+.BR capabilities (7)).
+.PP
 Because the file Effective set is a single bit,
 if any capability is enabled in the Effective set of the
 .I cap_t
-- 
2.26.2

