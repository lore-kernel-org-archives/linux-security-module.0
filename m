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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900D2C4345A
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F11321775
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrUGZLGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgGTJO4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgGTJOy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 05:14:54 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDFDC061794
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:54 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so17099208wrs.0
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dF76uqJM2CM/2J0mqmxABMRZvJOzxZK+RejceFf4EE8=;
        b=JrUGZLGWxyqaUyZsISXnLY5KLkpBj++/mxsn+kUuxsMW+xozGt22Bi/IPPXvmD0X+M
         AuJ8yX4Zg6MEiNyI0Lpr0DBGExUdsmMXcMOtw806fhFNWdB5nFiK1ePoHbcs+GjqF6Sn
         preYahYqTe+rb6PBs1FtBmBfYZHuHftnBQrZRgNOML0dkkH568CKOHBkdA0xmPCNeq2f
         cZDWdjBAB3MD7/IXzIEHzXHf+TRdQv3gUSCq2uhLoJYOTpkOoOIORFnwNtrXPbQOvxYK
         EhYxg1DjGIBgyw/xwGY/Q3HnCraMQWISmEMqs7NucLZLKZhLNHaRyCygD8zZIG1P0U9J
         v9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dF76uqJM2CM/2J0mqmxABMRZvJOzxZK+RejceFf4EE8=;
        b=M+x7dij7PlAOQuzaUZ8hsUZA8XKAWNKXIvHHdfbkXv7BxJ/mPuUqKIrcTvh1Etz50+
         TNVxBKpQijfcDO7ILEY3hU6piCzIY8HFVG7D3IkYFuoyPTORoe0KcswHp3cKe11Hjocl
         2vBrkQIh616vsRL7Oi+u/NafjDjMIn9N95aPc1Ih54bWrd/1wzTOgayfJJSTdYgxyJm1
         6yDZaJZCgko4P/Ftkeu5Xxh5Q+eLDJi90NSlCayqQPo2qBQz0sHXvx+Zh8vVNJEZYM7r
         nBk7ovwunwrd9UTcT1Eq9GD+AbjCsm0QvWyfxeGRGHoXfHfV9gCZJM89SHqBaZDLgrmU
         bwPg==
X-Gm-Message-State: AOAM530gVIKMYRrjGh3YkjyJkKY3yCD0VfDvfMgIfqEtNM3z3EoLWLFR
        egoNE/A613cVNmP1LkVErAU=
X-Google-Smtp-Source: ABdhPJzkJpbMTo1kvo/0zthpd9mrpN623rsXpHDcLUiZTZuC05cX8lvphKB5Ej2Umbxkrmdfi2s5xQ==
X-Received: by 2002:a5d:688d:: with SMTP id h13mr20735636wru.303.1595236493372;
        Mon, 20 Jul 2020 02:14:53 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id f15sm30401827wrx.91.2020.07.20.02.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:14:53 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Andrew Morgan <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 15/15] Manual pages: capsh.1: Change .TP indent to the default
Date:   Mon, 20 Jul 2020 11:13:28 +0200
Message-Id: <20200720091328.290336-16-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720091328.290336-1-mtk.manpages@gmail.com>
References: <20200720091328.290336-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Currently, the long list of options in this page is formatted as a
hanging list with a very deep indent (22), which causes the rendered
text to be rather narrow. That's uncomfortable when viewing on
something other than an 80 column display, and also causes some
ugliness in line breaks and line filling. Change to the more
traditional default indentation for .TP.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/capsh.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/capsh.1 b/doc/capsh.1
index d124889..b02793b 100644
--- a/doc/capsh.1
+++ b/doc/capsh.1
@@ -13,7 +13,7 @@ debugging features useful for summarizing capability state.
 .B capsh
 takes a number of optional arguments, acting on them in the
 order they are provided. They are as follows:
-.TP 22
+.TP
 .B \-\-help
 Display the list of commands supported by
 .BR capsh .
-- 
2.26.2

