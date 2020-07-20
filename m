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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B393CC43458
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9210D2080D
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czx3JB5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgGTJOv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgGTJOu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 05:14:50 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D8CC0619D2
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so24451793wmh.2
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mh4/AXI1HeH1sQ86GcpnBemZk/ksViCceFobWSa5iOA=;
        b=czx3JB5zTSSRSBHnIA9XqEy+FwlkPZAvrcKPxy1awM0C40gzSA2FygYRL12w1eOBzE
         /14hePdai7LBHVcfUHG2BnbtcVOka5dr2jMm0BHM5mapyMocUiEZWHiOFbWQX0QXXkKZ
         MXF4YDGmKVSBfh40obccXbIunf8awM0VIdl392H8Ov22eh5heGrAH4WkSR65GSpQZVo0
         akC0EvBstLake5kSHwdtZfrK7ZL602aB0+jwxGC3IRO79QF4QNVIH5WmQBso6ZWJgZLl
         eSejUEOSnN7lWTa5Fyov3kiyyl8UF3lIGybSlZqrQZ6iuQBPjGGb24/CxZklKJJNFeIs
         nXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mh4/AXI1HeH1sQ86GcpnBemZk/ksViCceFobWSa5iOA=;
        b=Z+3Pepc1r6JxlWhx2PFGJWxGoFBwHY+lJ5e39AYSYkTAi6sq5AKVTXyhFiiO9wDL44
         89OMa8jI8X8Dta64FzTJMyeQU37LR20z2OtS/leWlaNKvqhjwa+E5W5IumzzAvZIREKl
         FN4CDR8cvjwbn/n8It9RIc49Z+y1sE5HQ/4lDGFAenyfVqerwjRlDOOkaxHH/CqEWV8K
         pA4+mlGJELxX0D1SY2aqklPzckqI/MaVV77puBCfCWoeK7ReEr3kwZrOGlY95vyDYZIZ
         olg0pCRdWQvJgFOPEQnktF5muqRtRCWbycjUFaiwlE2scP4I6ZJz4EblXfUItq8JU4rN
         Er2g==
X-Gm-Message-State: AOAM531uG94nu42kFBe1+Ae4SYnlf9c7X/fPf62ZJhB6O6rkHd0Kscco
        afROR8m8Ioy1iXMDHR5G5sA=
X-Google-Smtp-Source: ABdhPJxMMf/I3JSvSHzPQFIBitUm/njjswgY/LnqcHRXEH8eI04DwqTeqUP9woQ9Z55tXVoPSHFOXA==
X-Received: by 2002:a1c:14e:: with SMTP id 75mr21963069wmb.151.1595236488912;
        Mon, 20 Jul 2020 02:14:48 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id w7sm29870391wmc.32.2020.07.20.02.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:14:48 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Andrew Morgan <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 14/15] Manual pages: cap_get_proc.3, capsh.1: Use "UID" and "GID" consistently
Date:   Mon, 20 Jul 2020 11:13:27 +0200
Message-Id: <20200720091328.290336-15-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720091328.290336-1-mtk.manpages@gmail.com>
References: <20200720091328.290336-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Replace terms such as "uid" and "use-id" with the more conventional
abbreviation UID.  Similarly for GID.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/cap_get_proc.3 |  2 +-
 doc/capsh.1        | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/doc/cap_get_proc.3 b/doc/cap_get_proc.3
index 40475fd..74e5e8c 100644
--- a/doc/cap_get_proc.3
+++ b/doc/cap_get_proc.3
@@ -349,7 +349,7 @@ effective capabilities for the caller:
 
 .fi
 Alternatively, to completely drop privilege in a program launched
-setuid-root but wanting to run as a specific user-id etc. in such a
+setuid-root but wanting to run as a specific user ID etc. in such a
 way that neither it, nor any of its children can acquire privilege
 again:
 .nf
diff --git a/doc/capsh.1 b/doc/capsh.1
index f19a3ea..d124889 100644
--- a/doc/capsh.1
+++ b/doc/capsh.1
@@ -67,7 +67,7 @@ in its effective set.
 .TP
 .BI \-\-user= username
 Assume the identity of the named user. That is, look up the user's
-.IR uid " and " gid
+UID and GID
 with
 .BR getpwuid (3)
 and their group memberships with
@@ -97,7 +97,7 @@ or exit with a status 1.
 .TP
 .BI \-\-uid= id
 Force all
-.B uid
+UID
 values to equal
 .I id
 using the
@@ -108,18 +108,19 @@ effective set.
 .BR \-\-cap\-uid= <uid>
 use the
 .BR cap_setuid (3)
-function to set the uid of the current process. This performs all
-preparations for setting the uid without dropping capabilities in the
+function to set the UID of the current process. This performs all
+preparations for setting the UID without dropping capabilities in the
 process. Following this command the prevailing effective capabilities
 will be lowered.
 .TP
 .BI \-\-is\-uid= <id>
 Exit with status 1 unless the current
-.IR uid " equals " <id> .
+UID equals
+.IR <id> .
 .TP
 .BI \-\-gid= <id>
 Force all
-.B gid
+GID
 values to equal
 .I id
 using the
@@ -128,7 +129,8 @@ system call.
 .TP
 .BI \-\-is\-gid= <id>
 Exit with status 1 unless the current
-.IR gid " equals " <id> .
+GIQ equals
+.IR <id> .
 .TP
 .BI \-\-groups= <gid-list>
 Set the supplementary groups to the numerical list provided. The
@@ -142,7 +144,7 @@ for a more convenient way of doing this.
 In a non-pure capability mode, the kernel provides liberal privilege
 to the super-user. However, it is normally the case that when the
 super-user changes
-.I uid
+UID
 to some lesser user, then capabilities are dropped. For these
 situations, the kernel can permit the process to retain its
 capabilities after a
-- 
2.26.2

