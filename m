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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68927C433E4
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419492080D
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mz3s/4Kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgGTJOA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgGTJOA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 05:14:00 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D830C061794
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:00 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f139so24407622wmf.5
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bF9hzSMekhnYTvDWrdjETwLqrkTUGZdsErU4TckjJv4=;
        b=mz3s/4KrHoVYtfGXuTkFtAEa2Z6FukqbeV/8bAKCtDHTd+aX/ahcGojeNkbeB01fQn
         UZpH5IPiUXymoPKJF9jABf9EJHshxGFRWTMblBtw+qd6wUW/A+zKVOWeHRbhns/6R3mN
         fv+0EFC+pmOCcevwvH1DohSUunUG325dH9DmbZ4w2t5jJCQPXvcb54uVQGnCPxNcKbNt
         AxARgZ7dY+mUh0QcDKJ0tmE9aScbScYd7WvpokZR40Kcn/k5Yo1wjvfQ47T+e33X0jDX
         R77od2uTrfz4BvoNq4+akjiFx34lacP6h3Xi5SHIPxWiDFVHRGrxKBALhKjJQUPQ3Lai
         Z8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bF9hzSMekhnYTvDWrdjETwLqrkTUGZdsErU4TckjJv4=;
        b=TQtuuAZHa0EF2KrPNizJGMN/UzvQ2J+xuGoiFNP0LAWpflcVDtR2TcLRXzcWfKisLw
         rKTDgCdj0ph21+xCvj0rGOKAREjMATWC8y/VFIDnFqux8q6QiEr3HJtEQFbpthxhnzG2
         u+A+Kv7cjRA9UVgAi95RdHxe8ly/x0ToOOrax81mL9DNEjMeaKovDdVwGzT93g5brU/A
         nH7clKSlczsBjGwHAWu2X2exvq/MMwbWxXvSAWEc8Re6ljY+uTWYn/V3pZm/XOO+ov+4
         s8fj3O+4OEqVsagPljdiCW5pOMCDVuMYVM7qbBG7UPQeOgD5T7u0Fiwh5YJIwYdQK4dQ
         kGiw==
X-Gm-Message-State: AOAM532F749vHBULNCW1jNrYxq8Mkxfd0lKyOKTe7/MZ7axVCNIrBWJb
        b1lwpRbePYbl2HxCYPoqMr4=
X-Google-Smtp-Source: ABdhPJzb8zEGIOJXHUpHlSWsajTPt1prapTTmkj9YwK5o01BD1Rv7ub8RxeEdgaf4Z/NHp5EY3F7Jw==
X-Received: by 2002:a1c:48d7:: with SMTP id v206mr19899115wma.145.1595236438960;
        Mon, 20 Jul 2020 02:13:58 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id y189sm34486552wmd.27.2020.07.20.02.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:13:58 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Andrew Morgan <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 03/15] Manual pages: capsh.1: Various minor wording and formatting fixes
Date:   Mon, 20 Jul 2020 11:13:16 +0200
Message-Id: <20200720091328.290336-4-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720091328.290336-1-mtk.manpages@gmail.com>
References: <20200720091328.290336-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/capsh.1 | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/doc/capsh.1 b/doc/capsh.1
index 242727c..f19a3ea 100644
--- a/doc/capsh.1
+++ b/doc/capsh.1
@@ -10,7 +10,8 @@ this tool. This tool provides a handy wrapper for certain types
 of capability testing and environment creation. It also provides some
 debugging features useful for summarizing capability state.
 .SH OPTIONS
-The tool takes a number of optional arguments, acting on them in the
+.B capsh
+takes a number of optional arguments, acting on them in the
 order they are provided. They are as follows:
 .TP 22
 .B \-\-help
@@ -30,7 +31,7 @@ for specific commands.
 .B ==
 Execute
 .B capsh
-again with remaining arguments. Useful for testing
+again with the remaining arguments. Useful for testing
 .BR exec ()
 behavior.
 .TP
@@ -44,11 +45,12 @@ is a text-representation of capability state as per
 .TP
 .BI \-\-drop= cap-list
 Remove the listed capabilities from the prevailing bounding set. The
-capabilities are a comma separated list of capabilities as recognized
+capabilities are a comma-separated list of capabilities as recognized
 by the
 .BR cap_from_name (3)
-function. Use of this feature requires that the capsh program is
-operating with
+function. Use of this feature requires that
+.B capsh
+is operating with
 .B CAP_SETPCAP
 in its effective set.
 .TP
@@ -57,7 +59,9 @@ Set the inheritable set of capabilities for the current process to
 equal those provided in the comma separated list. For this action to
 succeed, the prevailing process should already have each of these
 capabilities in the union of the current inheritable and permitted
-capability sets, or the capsh program is operating with
+capability sets, or
+.B capsh
+should be operating with
 .B CAP_SETPCAP
 in its effective set.
 .TP
@@ -73,7 +77,7 @@ and set them all using
 and
 .BR cap_setgroups (3).
 Following this command, the effective capabilities will be cleared,
-but the permitted set will not be so the running program is still
+but the permitted set will not be, so the running program is still
 privileged.
 .TP
 .B \-\-modes
@@ -87,7 +91,9 @@ security mode. This is a set of securebits and prevailing capability
 arrangement recommended for its pre-determined security stance.
 .TP
 .BR \-\-inmode= <mode>
-Confirm that the prevailing mode is so named, or exit with a status 1.
+Confirm that the prevailing mode is that specified in
+.IR <mode> ,
+or exit with a status 1.
 .TP
 .BI \-\-uid= id
 Force all
@@ -156,9 +162,12 @@ is performed. See
 for ways to disable this feature.
 .TP
 .BI \-\-secbits= N
-Set the security-bits for the program, this is via
-.BR prctl "(2), " PR_SET_SECUREBITS
-API, and the list of supported bits and their meaning can be found in
+Set the security-bits for the program.
+This is done using the
+.BR prctl (2)
+.B PR_SET_SECUREBITS
+operation.
+The list of supported bits and their meaning can be found in
 the
 .B <sys/secbits.h>
 header file. The program will list these bits via the
@@ -221,7 +230,9 @@ $ \fBcapsh \-\-decode=3\fP
 As the kernel evolves, more capabilities are added. This option can be used
 to verify the existence of a capability on the system. For example,
 .BI \-\-supports= cap_syslog
-will cause capsh to promptly exit with a status of 1 when run on
+will cause
+.B capsh
+to promptly exit with a status of 1 when run on
 kernel 2.6.27.  However, when run on kernel 2.6.38 it will silently
 succeed.
 .TP
@@ -234,7 +245,9 @@ raised.
 .TP
 .B \-\-has\-ambient
 Performs a check to see if the running kernel supports ambient
-capabilities. If not, the capsh command exits with status 1.
+capabilities. If not,
+.B capsh
+exits with status 1.
 .TP
 .BI \-\-has\-a= xxx
 Exit with status 1 unless the
@@ -252,8 +265,12 @@ Removes the specified ambient capability from the running process.
 .B \-\-noamb
 Drops all ambient capabilities from the running process.
 .SH "EXIT STATUS"
-Following successful execution the tool exits with status 0. Following
-an error, the tool immediately exits with status 1.
+Following successful execution,
+.B capsh
+exits with status 0. Following
+an error,
+.B capsh
+immediately exits with status 1.
 .SH AUTHOR
 Written by Andrew G. Morgan <morgan@kernel.org>.
 .SH "REPORTING BUGS"
-- 
2.26.2

