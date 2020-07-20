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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25C4C433E5
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F1B622B4E
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Jul 2020 09:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hugiiYax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgGTJOK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgGTJOJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Jul 2020 05:14:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56660C0619D2
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f7so17070307wrw.1
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2020 02:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D2nQooP4o+BuZxfzQ8Tr4E2ZORfz0zIXUzVB4dg40AM=;
        b=hugiiYaxnU8M+Yrd+BVixY3vqdkOanQKHHBvPdATMGmW1OXNJM7mIUekPuPTbTjDjy
         5YQY3kMa51KcutH6TOPVxqKfbbJEU2kNCua9qNkHkqRk6NsDuFvg6R7aPeYyps/+aw/C
         b5PVO9r0LuV2nO6O+SHQQ9If7s1HyxEKiKdYFNmMCCXHaX3Or6tEJLPACY746787/sz2
         1MyJjnc4Yuzc60SI+f7Ykjs8woJPW8Addsti2H+egK53mxbS/rtlvbCMOv4US5AlPov6
         PqptAj3+KO4oEO6LttDwnCkyVpXywvDGcpg0SziAFD4pFBASa5tUoB7PS+SGsdEJhY22
         tiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D2nQooP4o+BuZxfzQ8Tr4E2ZORfz0zIXUzVB4dg40AM=;
        b=IlCwphum4/8RvIZ3+kgr91xJkL9xSPvw3bZFLWY5+S6hKsDTAwNgUYYfdY9UnDS4ae
         P3BMRqyjXhsEZz1kguHCW9g0cVGm4GHoQpEplAqpjjS/vu1SVRZ0absPyLbATX0jzqtu
         3+beQqCQCH5DwHUYqomx1v7sybytyIN7XWAp6vjA6avPcH97cudizB+HcHjpshlczYAp
         vsoPHTjFyXo4GXbewM3tYJNRPBRqweP7j+9FzZjOUnZH6MoRlMsqVeD2Ycq//vS8MCYq
         5uDlBXCUnzSLkunPEF0zlX63iAVAs58hQQoevoo4v9lRq+3EuJSaxI152WtgE0lT/rQG
         OMoQ==
X-Gm-Message-State: AOAM5301UwfADBWukS6d593EMniQIxa7hl/FlNmI70oEFggxcdW606sL
        RKLEK01F9QtaSy/nwrGcX88=
X-Google-Smtp-Source: ABdhPJxKGHYrS0gJ3F9oZFk12hUnijlFqHltniuPTQc/vDWCUH9upfJNO2u+CChjY6Lnoi+2i3PrZA==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr21046473wrj.273.1595236448044;
        Mon, 20 Jul 2020 02:14:08 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id n18sm2339485wrw.45.2020.07.20.02.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:14:07 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Andrew Morgan <morgan@kernel.org>
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 05/15] Manual pages; cap_get_file.3: Fix some clumsily worded text
Date:   Mon, 20 Jul 2020 11:13:18 +0200
Message-Id: <20200720091328.290336-6-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720091328.290336-1-mtk.manpages@gmail.com>
References: <20200720091328.290336-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Make the text a bit easier to read, and also fix the terms used.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 doc/cap_get_file.3 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/cap_get_file.3 b/doc/cap_get_file.3
index c028148..ceacbaf 100644
--- a/doc/cap_get_file.3
+++ b/doc/cap_get_file.3
@@ -57,12 +57,12 @@ A NULL value for
 .IR cap_p
 is used to indicate that capabilities for the file should be deleted.
 For these functions to succeed, the calling process must have the
-effective capability,
-.BR CAP_SETFCAP ,
-enabled and either the effective user ID of the process must match the
+.BR CAP_SETFCAP
+capability in its effective set
+and either the effective user ID of the process must match the
 file owner or the calling process must have the
 .B CAP_FOWNER
-flag in its effective capability set.  The effects of writing the
+capability in its effective capability set.  The effects of writing the
 capability state to any file type other than a regular file are
 undefined.
 .PP
-- 
2.26.2

