Return-Path: <SRS0=sdO6=QG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C171C282D7
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Jan 2019 15:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D36921473
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Jan 2019 15:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aBzGM2wL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfA3P4v (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:56:51 -0500
Received: from mail-pf1-f197.google.com ([209.85.210.197]:48581 "EHLO
        mail-pf1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfA3P4v (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Jan 2019 10:56:51 -0500
Received: by mail-pf1-f197.google.com with SMTP id t2so20085618pfj.15
        for <linux-security-module@vger.kernel.org>; Wed, 30 Jan 2019 07:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tE4/vBoC776i3m8V+UnNM01bbi2iekMemhSPnzcnxAk=;
        b=aBzGM2wLxAFW6qFRF5EnooSR+W5g3rrtmgtm2zXhJxsJb4gqi02c1luCDPxEHdoAej
         S/C37rdR0RZbwd7+znmbOUvYutYVI66Tfv2gF3rqNyov9YGofnNEl+CMwC+mNO39aTzM
         qh0N41Jwj1TtLaXrRamnXql+ySqcSiPyTs7L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tE4/vBoC776i3m8V+UnNM01bbi2iekMemhSPnzcnxAk=;
        b=GbI3HsSjuIc89XFuMLAE9OTuSxKqi6VtS0jurx/z/nZ/9lbKxxuwxnYDZRdC9dPI2I
         AwJg6UzbByE76s1qoPTNbovnsMhC2Vr8d6BD/kqp46lUNtWuoYJR7XU+wErNuN4aZbX1
         ODCOloEzdj+xPPYeLbc3Y4YqPx58ub06bPFGPEoN1yb9w7HHB2EYisy0XFJB4j1tGjqb
         4PiZ01DaroKbuag49Db5P26Eozevi8tXvbbYV9hM3XsOiQcvYre8rv3j9yVowiHB5VTh
         Fcmqhwa9c0gC+NeRp4vvDJKT0CLb1pgc6+Yr0RIQh2MZDiSdE6GUb+Tdta8sc9v0rLue
         A7ZA==
X-Gm-Message-State: AHQUAuaQ4cSiY0+8AGdZjvHFTQx8meijK1/5WrF0HZBdx2aom+3oz9ly
        ZwXoERUlIVSchNCxDoLwZ1y9CsKLEbDxK3IS
X-Google-Smtp-Source: AHgI3IYZ/hZQYU+fKnxN77FpsLZuL/I3IoK+AizQBoxmw2xlfe6wW70LNHSJWBt4P6Niv+JPh8BUTelpqSfskyQz
X-Received: by 2002:a17:902:3a1:: with SMTP id d30mr3498962pld.41.1548863810662;
 Wed, 30 Jan 2019 07:56:50 -0800 (PST)
Date:   Wed, 30 Jan 2019 07:56:43 -0800
In-Reply-To: <201901300828.TveZbnBP%fengguang.wu@intel.com>
Message-Id: <20190130155643.167055-1-mortonm@chromium.org>
Mime-Version: 1.0
References: <201901300828.TveZbnBP%fengguang.wu@intel.com>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
Subject: [PATCH] LSM: SafeSetID: remove unused include
From:   mortonm@chromium.org
To:     kbuild-all@01.org, linux-security-module@vger.kernel.org,
        james.morris@microsoft.com
Cc:     Micah Morton <mortonm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Micah Morton <mortonm@chromium.org>

The include for asm/syscall.h was needed in a prior version of lsm.c
that checked return values of syscall_get_nr, but since we did away with
that part of the code this include is no longer necessary. Take out this
include since it breaks builds for certain architectures. We no longer
have any arch-specific code in SafeSetID.

Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 security/safesetid/lsm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 282a242beb86..cecd38e2ac80 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -14,7 +14,6 @@
 
 #define pr_fmt(fmt) "SafeSetID: " fmt
 
-#include <asm/syscall.h>
 #include <linux/hashtable.h>
 #include <linux/lsm_hooks.h>
 #include <linux/module.h>
-- 
2.20.1.495.gaa96b0ce6b-goog

