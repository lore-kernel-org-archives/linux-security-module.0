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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B83C433E1
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605662080D
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hewszE40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgGTJNw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgGTJNv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 05:13:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28692C061794
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:13:51 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f18so17095911wrs.0
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nYM8lhuIO+90nSea2a+iPtNF7ryh1E4kDMdV0kFEIiU=;
        b=hewszE40dXil9en5tvvBUP9rsmkzQ1u8Uf80lQG6bvMMQJh1Dnumulqc21vlK4hJ0C
         DpyEiOmnaokm/lfIWV81iLZXkof2FHIBHakLrHdyZTqrbhngEQrNHpwwc6ooijcVP20J
         W9DCi3FpUnpTnFvplh11TRKB7M1H+vA/6rWl0zxbLz031/ZzGeH+X8NFen/oj3u0bhvV
         AVNgv+f/JOfQjY+0MqYwht1MCwC5n1ZU4ZSj/LLeCIv7rGKf7OQdrGR+4HPRMwXXxvqX
         xP4pCuhYeWzKwe+rG2woLCvdtUOz1+m7vF92TXBzcEO6og5DWSTczWdaCk+EpYqqF7Kk
         pXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYM8lhuIO+90nSea2a+iPtNF7ryh1E4kDMdV0kFEIiU=;
        b=t1pUuyU+izJWjkjWTJIdaM76YrIYsUesfMfRfRCwbFDrqMYWo3GTVGYgTD3ADMVNIm
         2yapji2rg2jAweUe0CTzm39YRoT60J/JkEqtVBDD6lwv7p3rFFVrFNGZF6QTTjUmlF+Z
         7DwmfbX1wA0Fo31W3ZoFk/VYkNiC0a07FRZ9ZarXClC+RJWnq3iuVjI0ZiX/yCrv506A
         BhxYrbNGcoFRIczqoHXvFpNM7QUGCogp+vDQ35pQbhx5ZSsXfupAWu+8+k62qX6S8Wz7
         5eLg4N7xXJct034FByS3ysBpLSkSpk8lRn7M5c0nkXGLmszkZxu3w2LD6dBBX4zy/46a
         eRlg==
X-Gm-Message-State: AOAM531hFMaLm7AKMaXlQ5X25m43aOzJrTNNnUVUK3H4pSSnU9XNuyck
        Q675l7YPT7eNFtnsXJraXh+x2cAi
X-Google-Smtp-Source: ABdhPJy9DlIy4+Kbq5CCNpM+r3w/K7MNGYG//oa10Si7CY8TErhvQeJP6PlbzCDCpH6VzPh0Zvi5OA==
X-Received: by 2002:a5d:4401:: with SMTP id z1mr5248900wrq.305.1595236429827;
        Mon, 20 Jul 2020 02:13:49 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id i14sm794366wrc.19.2020.07.20.02.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:13:49 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Andrew Morgan <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 01/15] Manual pages: various pages: Use "\-" for real minus signs
Date:   Mon, 20 Jul 2020 11:13:14 +0200
Message-Id: <20200720091328.290336-2-mtk.manpages@gmail.com>
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
 doc/cap_get_proc.3 |  8 ++++----
 doc/capsh.1        | 14 +++++++-------
 doc/getpcaps.8     |  6 +++---
 doc/libpsx.3       |  6 +++---
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/doc/cap_get_proc.3 b/doc/cap_get_proc.3
index fda00e0..fce8f59 100644
--- a/doc/cap_get_proc.3
+++ b/doc/cap_get_proc.3
@@ -242,11 +242,11 @@ is packaged with a separate POSIX semantics system call library:
 If your program uses POSIX threads, to achieve meaningful POSIX
 semantics capability manipulation, you should link your program with:
 .sp
-.B ld ... -lcap -lpsx -lpthread --wrap=pthread_create
+.B ld ... \-lcap \-lpsx \-lpthread \-\-wrap=pthread_create
 .sp
 or,
 .sp
-.B gcc ... -lcap -lpsx -lpthread -Wl,-wrap,pthread_create
+.B gcc ... \-lcap \-lpsx \-lpthread \-Wl,\-wrap,pthread_create
 .sp
 When linked this way, due to linker magic, libcap uses
 .BR psx_syscall "(3) and " psx_syscall6 (3)
@@ -362,10 +362,10 @@ Note, the above sequence can be performed by the
 .B capsh
 tool as follows:
 .sp
-.B sudo /sbin/capsh --user=nobody --mode=NOPRIV --print
+.B sudo /sbin/capsh \-\-user=nobody \-\-mode=NOPRIV \-\-print
 .sp
 where
-.B --print
+.B \-\-print
 displays the resulting privilege state.
 .SH "SEE ALSO"
 .BR libcap (3),
diff --git a/doc/capsh.1 b/doc/capsh.1
index 0b987f0..242727c 100644
--- a/doc/capsh.1
+++ b/doc/capsh.1
@@ -107,7 +107,7 @@ preparations for setting the uid without dropping capabilities in the
 process. Following this command the prevailing effective capabilities
 will be lowered.
 .TP
-.BI \-\-is-uid= <id>
+.BI \-\-is\-uid= <id>
 Exit with status 1 unless the current
 .IR uid " equals " <id> .
 .TP
@@ -120,7 +120,7 @@ using the
 .BR setgid (2)
 system call.
 .TP
-.BI \-\-is-gid= <id>
+.BI \-\-is\-gid= <id>
 Exit with status 1 unless the current
 .IR gid " equals " <id> .
 .TP
@@ -129,7 +129,7 @@ Set the supplementary groups to the numerical list provided. The
 groups are set with the
 .BR setgroups (2)
 system call. See
-.B --user
+.B \-\-user
 for a more convenient way of doing this.
 .TP
 .BI \-\-keep= <0|1>
@@ -152,7 +152,7 @@ the current process. In all cases,
 is deactivated when an
 .BR exec ()
 is performed. See
-.B --secbits
+.B \-\-secbits
 for ways to disable this feature.
 .TP
 .BI \-\-secbits= N
@@ -225,18 +225,18 @@ will cause capsh to promptly exit with a status of 1 when run on
 kernel 2.6.27.  However, when run on kernel 2.6.38 it will silently
 succeed.
 .TP
-.BI \-\-has-p= xxx
+.BI \-\-has\-p= xxx
 Exit with status 1 unless the
 .I permitted
 vector has capability
 .B xxx
 raised.
 .TP
-.B \-\-has-ambient
+.B \-\-has\-ambient
 Performs a check to see if the running kernel supports ambient
 capabilities. If not, the capsh command exits with status 1.
 .TP
-.BI \-\-has-a= xxx
+.BI \-\-has\-a= xxx
 Exit with status 1 unless the
 .I ambient
 vector has capability
diff --git a/doc/getpcaps.8 b/doc/getpcaps.8
index 53d342e..7b73e86 100644
--- a/doc/getpcaps.8
+++ b/doc/getpcaps.8
@@ -24,13 +24,13 @@ format.
 .PP
 Optional arguments:
 .PP
-.BR --help " or " --usage
+.BR \-\-help " or " \-\-usage
 Displays usage information and exits.
 .PP
-.BR --ugly " or " --legacy
+.BR \-\-ugly " or " \-\-legacy
 Displays output in a somewhat ugly legacy format.
 .PP
-.B --verbose
+.B \-\-verbose
 Displays usage in a legacy-like format but not quite so ugly in modern
 default terminal fonts.
 .SH SEE ALSO
diff --git a/doc/libpsx.3 b/doc/libpsx.3
index 615fceb..a907d8b 100644
--- a/doc/libpsx.3
+++ b/doc/libpsx.3
@@ -11,9 +11,9 @@ psx_syscall3, psx_syscall6 \- POSIX semantics for system calls
 .sp
 Link with one of these:
 .sp
-.I   ld ... -lpsx -lpthread --wrap=pthread_create
+.I   ld ... \-lpsx \-lpthread \-\-wrap=pthread_create
 .sp
-.I   gcc ... -lpsx -lpthread -Wl,-wrap,pthread_create
+.I   gcc ... \-lpsx \-lpthread \-Wl,\-wrap,pthread_create
 .SH DESCRIPTION
 The
 .B libpsx
@@ -58,7 +58,7 @@ and
 functions.
 .SH RETURN VALUE
 The return value for system call functions is generally the value
-returned by the kernel, or -1 in the case of an error. In such cases
+returned by the kernel, or \-1 in the case of an error. In such cases
 .BR errno (3)
 is set to the detailed error value. The
 .BR psx_syscall3 " and " psx_syscall6
-- 
2.26.2

