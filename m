Return-Path: <SRS0=LdBn=BC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC00EC433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jul 2020 09:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5035206F4
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jul 2020 09:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPT5mZxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgGWJSb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgGWJSb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 Jul 2020 05:18:31 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ACBC0619DC
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2020 02:18:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a15so4424170wrh.10
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2020 02:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TiaF9yZmK5+sgrX1t1c5eARfK7AmJfoIpovTqRcXvoY=;
        b=WPT5mZxJti35gSW4Lg4v8xFpqAdAyed1zqHP3kMaJUBJ5iQPdE/aG3wNd3Q7WQwqlh
         QqeIlX26abK2M7lanmEJ3o0qGtCUU2FXsYHj37TAMlw5UQ8YYx9sDsxVG8OS97hdnA4p
         pW0SVpmi9Gm82nrW42IcwNkXN7neeAoMMKPvrP3jkfHPSw+00Yk0odVVY1djJF6yExv7
         F/o4WjnEliz26aTxLuUR3MNoYbFs8AFcULKNy7zQQS0g3co5wm5cI6jyRFO0YcDcGs97
         +bjDKFCVP3xaXIS59ddkY0uvyZNnrLiIsqYscKLEB/Zxbwl854a87PJvh5VMizLyLK7j
         WiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TiaF9yZmK5+sgrX1t1c5eARfK7AmJfoIpovTqRcXvoY=;
        b=jg2C74HHjmNkaWcxH4atsdaEqqeJhUmTIM9cynRUe77aEqMWF4bvIOldbsnGhuJmUl
         nURw+C0wm/jGvg4/qYBYDFuKqGCHOeg+aT7m0dxyoqZRz5wa9mPp5k5YBYjLH/YbBhBg
         aIcaYcEaZse03EgMERQ77A6/nfEaEcBrQxn/C4nxcgOxHkg7Dwq1byU2xggRXG1DVqZ1
         VNle2x6e9hErNR3eJ9UeW6fV0ffReubMSI4UzmjeWZTICazbISv/tksb1Dez2qi6dXby
         ym5p+nMWLoM0/XeEleRVCVWFOl3pydwOIz32MEn7rkD8K693TIz0Ul4nqOMwF7zC3U0O
         iNog==
X-Gm-Message-State: AOAM532LDz1ZLzJGGPBbvxyzXZhmr2YK+Hxcibcave3C5LQcQLrIhOIz
        H+uJvtmM7tY40nU+zurNJJ0=
X-Google-Smtp-Source: ABdhPJwl4G7mmOrVqOnFrDy7KbXxvnjQ/FdaSsPcn6iVhDDqZSlcJCh8AH/XOG/GdSINjclwx4nS3A==
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr3174828wrs.78.1595495909153;
        Thu, 23 Jul 2020 02:18:29 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id f12sm2988466wrj.48.2020.07.23.02.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 02:18:28 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, "Andrew G . Morgan" <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH] Manual pages: use "root user ID" rather than "rootid"
Date:   Thu, 23 Jul 2020 11:18:18 +0200
Message-Id: <20200723091818.494712-1-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The capabilities(7) page has for quite some time used the term "root user ID",
which is, I think, a little more precise and expressive than "rootid".
I think it would be good if libcap used the same terminology,

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/cap_get_file.3 | 6 +++---
 doc/getcap.8       | 3 ++-
 doc/setcap.8       | 8 ++++----
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/doc/cap_get_file.3 b/doc/cap_get_file.3
index ceacbaf..3f73734 100644
--- a/doc/cap_get_file.3
+++ b/doc/cap_get_file.3
@@ -18,7 +18,7 @@ manipulation on files
 .sp
 .BI "uid_t cap_get_nsowner(cap_t " caps );
 .sp
-.BI "int cap_set_nsowner(cap_t " caps ", uid_t " rootid );
+.BI "int cap_set_nsowner(cap_t " caps ", uid_t " rootuid );
 .sp
 Link with \fI\-lcap\fP.
 .SH DESCRIPTION
@@ -66,13 +66,13 @@ capability in its effective capability set.  The effects of writing the
 capability state to any file type other than a regular file are
 undefined.
 .PP
-A capability set held in memory can be associated with the rootid in
+A capability set held in memory can be associated with the root user ID in
 use in a specific user namespace. It is possible to get and set this value
 (in the memory copy) with
 .BR cap_get_nsowner ()
 and
 .BR cap_set_nsowner ()
-respectively. The rootid is ignored by the libcap library in all cases
+respectively. The root user ID is ignored by the libcap library in all cases
 other than when the capability is written to a file. Only if the value
 is non-zero will the library attempt to include it in the written file
 capability set.
diff --git a/doc/getcap.8 b/doc/getcap.8
index 2ad8092..04b601c 100644
--- a/doc/getcap.8
+++ b/doc/getcap.8
@@ -13,7 +13,8 @@ displays the name and capabilities of each specified file.
 prints quick usage.
 .TP 4
 .B \-n
-prints any non-zero user namespace rootid value found to be associated with
+prints any non-zero user namespace root user ID value
+found to be associated with
 a file's capabilities.
 .TP 4
 .B \-r
diff --git a/doc/setcap.8 b/doc/setcap.8
index 582c781..463752d 100644
--- a/doc/setcap.8
+++ b/doc/setcap.8
@@ -2,7 +2,7 @@
 .SH NAME
 setcap \- set file capabilities
 .SH SYNOPSIS
-\fBsetcap\fP [\-q] [\-n <rootid>] [\-v] {\fIcapabilities|\-|\-r} filename\fP [ ... \fIcapabilitiesN\fP \fIfileN\fP ]
+\fBsetcap\fP [\-q] [\-n <rootuid>] [\-v] {\fIcapabilities|\-|\-r} filename\fP [ ... \fIcapabilitiesN\fP \fIfileN\fP ]
 .SH DESCRIPTION
 In the absence of the
 .B \-v
@@ -13,13 +13,13 @@ sets the capabilities of each specified
 to the
 .I capabilities
 specified.  The optional
-.B \-n <rootid>
+.B \-n <rootuid>
 argument can be used to set the file capability for use only in a
-user namespace with this rootid owner. The
+user namespace with this root user ID owner. The
 .B \-v
 option is used to verify that the specified capabilities are currently
 associated with the file. If \-v and \-n are supplied, the
-.B \-n <rootid>
+.B \-n <rootuid>
 argument is also verified.
 .PP
 The
-- 
2.26.2

