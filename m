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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28356C433E0
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Jun 2020 06:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04ECC2081A
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Jun 2020 06:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddLRfwzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgFJG55 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgFJG5z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Jun 2020 02:57:55 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0B7C03E96B
        for <linux-security-module@vger.kernel.org>; Tue,  9 Jun 2020 23:57:54 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id p5so916384wrw.9
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jun 2020 23:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pobv6r5LIc/Sd0wEhG16fzhnOAOk2VjDCWplMb577X4=;
        b=ddLRfwzPXNoxfe3VO0mqTSrQK47USq90tvqnlgHEeEidcoKAA+uYgKh2UAY9xDTxMB
         LijpchiQC0rtYmQ0SMFm+iGStHtIS+nSbQ0HvVPvRlJT7+S/KQeNO7OcX5e9nr9uKVxd
         chTVHOEai816FH+lElh6dpyw841D4IGSW+gCDgy4GsgxPYsILPLgZj+b5Lc1gQZlA9B4
         usAaEb9SfNQMCdez47Ix5zx3o3Me8qxnM5wRb5gu9LQZo4CQXgubgpVzSOo+ug6wcDGx
         WODGLYbRLmJUld739JnmLdguTDP/DFPD4BRf9dE8mW3L3AITdUSjIggLLRWcktXFnU02
         PKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pobv6r5LIc/Sd0wEhG16fzhnOAOk2VjDCWplMb577X4=;
        b=UHdHuBq+IwGD5y08c8VmRBP9f61iLqFl/CI9il79+zqpwSv+ZG390FrhgoDis8Em5Q
         4rzwiaAYzQxr1NaV7Zsnhhgn2UNauxSB8kSgvRonfIqXA4tjSkgEdciiQkht//ogFf+p
         lvF5WyHPwUOK2hSF2x9NwWo6+D3sWH6+XZL9O5P6xkiSKDIx8p+XtkuvGeDGonrBxV62
         7s/FY43sjnXzchv8fkBFbjwRjE940f1twTb8yQhgTvXJnDRQ/yO5nb6KK8Y+vSSTmi+O
         meR+3UI5mpDw44xbEOvFP3j6oVADEA4VmeER3EFSNH7fPLKuepn0DAotw+5ZVGWrOAg8
         9MGw==
X-Gm-Message-State: AOAM5318YBFHcpQx5ltadA19cdkNSEwT3blvDDZd1Hfjy7fMdolwyIvz
        rkofBOC+CeyBVwYGEO5GtLOS54iUGEsF7Q==
X-Google-Smtp-Source: ABdhPJzFZsnYmDYUVArSRtbW8NTXUKOpxjDxsY89LnG/TbreI0HJx9efp9KmToVT2n0bZaq89FgnyA==
X-Received: by 2002:adf:f84d:: with SMTP id d13mr1759982wrq.99.1591772273452;
        Tue, 09 Jun 2020 23:57:53 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:253c:8201:b2fb:3ef8:ca:1604])
        by smtp.gmail.com with ESMTPSA id g18sm5889977wme.17.2020.06.09.23.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 23:57:53 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Andrew Morgan <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 4/4] cap_get_proc.3: change "current process" to "calling process"
Date:   Wed, 10 Jun 2020 08:57:35 +0200
Message-Id: <20200610065735.3975740-4-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610065735.3975740-1-mtk.manpages@gmail.com>
References: <20200610065735.3975740-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The term "current process" is kernel-developer speak that is often not
understood by user-space programmers. Change to "calling process",
which is clearer.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/cap_get_proc.3 | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/doc/cap_get_proc.3 b/doc/cap_get_proc.3
index 0238601..b0a61d1 100644
--- a/doc/cap_get_proc.3
+++ b/doc/cap_get_proc.3
@@ -89,7 +89,7 @@ file.
 with a
 .I  cap
 as an argument returns the current value of this bounding set
-capability flag in effect for the current process. This operation is
+capability flag in effect for the calling process. This operation is
 unprivileged. Note, a macro function
 .BR "CAP_IS_SUPPORTED(cap_value_t " cap )
 is provided that evaluates to true (1) if the system supports the
@@ -122,11 +122,11 @@ capability set must have a raised
 .BR CAP_SETPCAP .
 Further, to raise a specific ambient capability the
 .IR inheritable " and " permitted
-sets of the current process must contain the specified capability, and
+sets of the calling process must contain the specified capability, and
 raised ambient bits will only be retained as long as this remains true.
 .PP
 .BR cap_reset_ambient ()
-resets all of the ambient capabilities for the current process to
+resets all of the ambient capabilities for the calling process to
 their lowered value. To complete successfully, the prevailing
 .I effective
 capability set must have a raised
@@ -139,12 +139,12 @@ changes to the inheritable set by the program code without explicitly
 fixing up the ambient set can also drop ambient bits.
 .PP
 .BR cap_get_secbits ()
-returns the securebits of the current process. These bits affect the
-way in which the current process implements things like setuid-root
+returns the securebits of the calling process. These bits affect the
+way in which the calling process implements things like setuid-root
 fixup and ambient capabilities.
 .PP
 .BR cap_set_secbits ()
-attempts to modify the securebits of the current process. Note
+attempts to modify the securebits of the calling process. Note
 .B CAP_SETPCAP
 must be in the effective capability set for this to be effective. Some
 settings lock the sub-states of the securebits, so attempts to set values
@@ -274,13 +274,13 @@ attempts to set the capabilities of some other process(es),
 If
 .I pid
 is positive it refers to a specific process;  if it is zero, it refers
-to the current process; \-1 refers to all processes other than the
-current process and process '1' (typically 
+to the calling process; \-1 refers to all processes other than the
+calling process and process '1' (typically 
 .BR init (8));
 other negative values refer to the
 .I \-pid
 process group.  In order to use this function, the kernel must support
-it and the current process must have
+it and the calling process must have
 .B CAP_SETPCAP
 raised in its Effective capability set. The capabilities set in the
 target process(es) are those contained in
@@ -288,7 +288,7 @@ target process(es) are those contained in
 Kernels that support filesystem capabilities redefine the semantics of
 .B CAP_SETPCAP
 and on such systems this function will always fail for any target not
-equal to the current process.
+equal to the calling process.
 .BR capsetp ()
 returns zero for success, and \-1 on failure.
 
-- 
2.26.2

