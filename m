Return-Path: <SRS0=+HMg=R5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EC3C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6541F2084B
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 18:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oz9kzY7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732672AbfCZS2T (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:28:19 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:36995 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732661AbfCZS2T (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:19 -0400
Received: by mail-qt1-f201.google.com with SMTP id f89so14452336qtb.4
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2019 11:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UWUYbOZniscPzPib57I8cPwH1j1zNPSziYufzU02lOY=;
        b=Oz9kzY7d3lv55fVkI6Kb0Gzd3zJwJVSAVP1ulUaw9XyfUgwUTFQ69SW1TpPJkSkz4I
         8NUL2BguYiSmd8NFIwTgZKd7UB7lU8F2hm+SV82c1BpjE00Nve3eEAV5dCvYM6U0Adft
         8cHrLisTQIpYkEfVr7pSsB7vKPAWYQArSJSuLNv7EWxW+QmxHN7LZdgApdkQI107/Ow2
         GZ3GQday6ZqELcHEK3ZUIq2VgMJhr6I6/cma2bxfcIUaCW826/CfZVTmkThJ3vczr5og
         R+xZyn2RY8eloJabWhb+3U23suPmtoBLFDiFAW2oz2cFDyDctnrk/MCbULdQ+P4rFbUa
         32UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UWUYbOZniscPzPib57I8cPwH1j1zNPSziYufzU02lOY=;
        b=j+8Fd9C+yFnK7ryZrkIOvIgqHJs8muRktFflnfK+aPOOSNOQBAT1wzKlCxcQPq1DQM
         K0J7Brt2/6Xp1fD7M+mDdgfb2l/KxrdZ5XktKoQQoFsNg7Ymg4cYmTcnnQIXH2Yrl3rN
         nalw00sPglDWlTm7QyLQelEUvK0KjSeuRIv96GUKa51Yijk4Y27DhQOe05BkDcOH37Lj
         Fix/LUvHQMV9t3ov8RNUmI0Ze+gBEJq7yYfSnvfIJdLI2EzPnSvKxt4u45jqfYvVR50l
         d2u+/XkPxWMsMRGs+iy3I83dtqEZ27lD/h8ggKU8AuDqoC2Sd5fQqXDg/RYutxbAJYJA
         XAWg==
X-Gm-Message-State: APjAAAXya7s3FEyKeje+gmVMr1agT8giVGh3TUM1+41D7WhBsG45l6IR
        uiZrvxwOjG+vniMOubk5XKWCiJy+rMUCwRS9q6rEiA==
X-Google-Smtp-Source: APXvYqy8T5iMSU8bRAJDeiOYdZ+vf7wI+oEKQds8Wx9UYe7VIOiL7DRxsniEJLG6jiM0ADBnIZ62Ujuch6uEFVoBA5UeiQ==
X-Received: by 2002:ac8:1091:: with SMTP id a17mr25977158qtj.135.1553624898035;
 Tue, 26 Mar 2019 11:28:18 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:25 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-10-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 09/25] uswsusp: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>, linux-pm@vger.kernel.org,
        pavel@ucw.cz, rjw@rjwysocki.net
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Matthew Garrett <mjg59@srcf.ucam.org>

uswsusp allows a user process to dump and then restore kernel state, which
makes it possible to modify the running kernel.  Disable this if the kernel
is locked down.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: linux-pm@vger.kernel.org
Cc: pavel@ucw.cz
Cc: rjw@rjwysocki.net
---
 kernel/power/user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 2d8b60a3c86b..99e13fd13237 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -52,6 +52,9 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	if (!hibernation_available())
 		return -EPERM;
 
+	if (kernel_is_locked_down("/dev/snapshot", LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	lock_system_sleep();
 
 	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
-- 
2.21.0.392.gf8f6787159e-goog

