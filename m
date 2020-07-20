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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0998C433FB
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F6282080D
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7fuV2jR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgGTJOc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgGTJOc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 05:14:32 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FC3C061794
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:31 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o8so21501651wmh.4
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TQD9WNkofnPQBa2RWhECI/xI2EodkzfZH+akEIki+5o=;
        b=j7fuV2jRSNRGjgS4S7UZWcX+t9RkW3BNzQA5J/9QehMoc671FnR2WlPZEevV1KtjnX
         OhUd++8/x0T11pFKZ6B7tgAa6HFmAYfBKGimTdjUb93Yymkk13yhgm5uh59ypz9MeFKY
         WbGCpjz2YBzTous3oREN7pIDGjO49NmdssqJLQhHTl39CYvkhw8J3XdowWzMlhtlKkqk
         sOMyepaYd8RLoJT46pUCNoaaKddbFCO+MmLsJXNBQ05u3m6TrA/lxa96ODRkbtPXHcuS
         8oRHgKOXXRxGAZpWsE10kAUjkhx4AZmWQxi3kSWyQw1CRoWEaZC12M54xNHFrS7wal8V
         UL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TQD9WNkofnPQBa2RWhECI/xI2EodkzfZH+akEIki+5o=;
        b=dr3oUYy3iJWuy4FxHfeylhK/0qi7esQUtaIrkAKu62uTWofxDTyUM+6Zyp5Sx/4RLi
         RmoRm3SaOEfem1HBIytjXGtDdnfTHEHpPef8CXPNJviDX0Jm+klEzLw5bVcoE1Jor943
         /s7nM3A3VD81fjjyrIc4T2Zi31FgdgyJ3yLYU2se+olEU+v6/c8kZ5esrQsAIJzvfJjX
         fdR/9IcEKoEeMw8ziEuHhb6XDQQvwKd/9EBzdgCyYWa4ceYB2ZN6J0WNtcvnvykK+vtU
         ikxrLRoZEUoOBV9XSbAJil0ShvfR40z5L4WLOR7FfaaPe/HdzET5ugoWLaAMloXerK/P
         lxtg==
X-Gm-Message-State: AOAM530dPKlC1vk+KFUJJjLIyV3Ig+/WvkSSddoEYVujDI5aFaTH+ICa
        Uxc+WBfQFO48K7asQ/n8gPc79fYo
X-Google-Smtp-Source: ABdhPJxdJN20MQK+tPFSVeHLK1QRIU3CwqPEj9dd/5hynR4EtmgMSV6pTIMeypMpUS0kKRbVY+22ww==
X-Received: by 2002:a1c:4987:: with SMTP id w129mr20539457wma.9.1595236470499;
        Mon, 20 Jul 2020 02:14:30 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id j16sm32736748wrt.7.2020.07.20.02.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:14:29 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Andrew Morgan <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 10/15] Manual pages: getpcaps.8: SEE ALSO: fix section number for capsh
Date:   Mon, 20 Jul 2020 11:13:23 +0200
Message-Id: <20200720091328.290336-11-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720091328.290336-1-mtk.manpages@gmail.com>
References: <20200720091328.290336-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

capsh is in Section 1, not Section 8. Also, reformat the SEE ALSO list
in a more conventional way.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/getpcaps.8 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/doc/getpcaps.8 b/doc/getpcaps.8
index dadd365..d519357 100644
--- a/doc/getpcaps.8
+++ b/doc/getpcaps.8
@@ -34,8 +34,10 @@ Displays output in a somewhat ugly legacy format.
 Displays usage in a legacy-like format but not quite so ugly in modern
 default terminal fonts.
 .SH SEE ALSO
+.BR capsh (1),
 .BR capabilities (7),
-.BR capsh "(8), " setcap "(8) and " getcap (8).
+.BR getcap (8),
+.BR setcap (8)
 .SH AUTHOR
 This manual page was originally written by Robert Bihlmeyer
 <robbe@debian.org>, for the Debian GNU/Linux system (but may be used
-- 
2.26.2

