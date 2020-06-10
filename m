Return-Path: <SRS0=uCN1=7X=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8678AC433E2
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Jun 2020 06:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6091220801
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Jun 2020 06:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeNL46Bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgFJG5z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgFJG5y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Jun 2020 02:57:54 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA3DC08C5C1
        for <linux-security-module@vger.kernel.org>; Tue,  9 Jun 2020 23:57:53 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x14so946801wrp.2
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jun 2020 23:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MNhV0IFzScQ15TZZtgXV6VCFSZHajLQMnYJCaTkA5Ok=;
        b=BeNL46Bchb3Yc7ofHCHp5D4RABtjbpELHkY2eeSlXilyKHSujdSBCa9XHcXmeTlWiQ
         Nu/GwvlB5wNedab4DFtGOfJYK1iNnoCrzfyLsAKkvhDmVgxgN0YhWEkExPFkD+hv7Y2W
         wgcTleDHvDYVofHLfYG8W/1ad+DITqgX2/pDtEETI/PgzXCqdRgZwNWJooyWtknca8S2
         cOJNGxIWNvTOFeyMA4UNAfobe94mFlicPT4Cq9+QkMVMDNqB4Fq4eNfL55Bz3jm/4Gfb
         RgusWZoI9Ym4M911R2Ee/QF50O92sTt96+pAaAAAN8+1G426d+NYMLzYb/V9Tw8FNoBh
         tntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MNhV0IFzScQ15TZZtgXV6VCFSZHajLQMnYJCaTkA5Ok=;
        b=UANzXMALdZGu7RxT7hS5v1PFFpkNTT+PYeYotSSYlBNsur788gYaTFVsOVO9lMQ5rz
         kyfF7FJuz/EYY6rHmETcqg1sNnzoZLqgocJ7CmtKcYd6P19QtcsmE9qxG24gmhkAr9Hq
         Sbf46eZQL8Zn/mKHgaiRpLynXyUxquUzu4BOvEM+MRteCUEc9oMZxYinpkLYgkPJXwRz
         k34OP8LlzA9a19Ag9wWRZ5J+H+cxeCXSRi9a2FJTg77mELPgrKFyT/qgwnAk/rfL1HCC
         PqJnPqo0OZdqs+i/F1yE588pFVZpvuLNkPXOASXQ9X9NkoV+KhB7pihHqN7rFtnQrcMI
         2wsA==
X-Gm-Message-State: AOAM531bHT4Fnh3TpFztajAHRD2h+eVilNFYYEgQpiUEkPmvVUO51jZP
        FSWHPdEe92oQSyOt3NhWD1w=
X-Google-Smtp-Source: ABdhPJxO3cQIoOGqXKsWGsuHwN4Gzmg7BIlz/3m6TNtD0z7SbRuDrb1+E5g+WWeTyqyLJ7eVHIcjuQ==
X-Received: by 2002:a5d:50c9:: with SMTP id f9mr1964845wrt.9.1591772272460;
        Tue, 09 Jun 2020 23:57:52 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:253c:8201:b2fb:3ef8:ca:1604])
        by smtp.gmail.com with ESMTPSA id g18sm5889977wme.17.2020.06.09.23.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 23:57:52 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Andrew Morgan <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 3/4] getpcaps.8: Note that pid==0 displays capabilities of getpcaps itself
Date:   Wed, 10 Jun 2020 08:57:34 +0200
Message-Id: <20200610065735.3975740-3-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610065735.3975740-1-mtk.manpages@gmail.com>
References: <20200610065735.3975740-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

When experimenting with capabilities, it's useful to know that
pid==0 causes getpcaps to display its own capabilities.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/getpcaps.8 | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/doc/getpcaps.8 b/doc/getpcaps.8
index be9935f..aaaf0a2 100644
--- a/doc/getpcaps.8
+++ b/doc/getpcaps.8
@@ -10,7 +10,14 @@ getpcaps \- display process capabilities
 .B getpcaps
 displays the capabilities on the processes indicated by the
 .I pid
-value(s) given on the commandline. The capabilities are displayed in
+value(s) given on the command line.
+A
+.I pid
+of 0 displays the capabilities of the process that is running
+.B getpcaps
+itself.
+.PP
+The capabilities are displayed in
 the
 .BR cap_from_text (3)
 format.
-- 
2.26.2

