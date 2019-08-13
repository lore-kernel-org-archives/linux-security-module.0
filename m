Return-Path: <SRS0=o9Ra=WJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211D4C433FF
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Aug 2019 19:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A0B205F4
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Aug 2019 19:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="auN+J9iy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfHMTVg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Aug 2019 15:21:36 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:46712 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfHMTVg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Aug 2019 15:21:36 -0400
Received: by mail-pg1-f202.google.com with SMTP id u1so67047994pgr.13
        for <linux-security-module@vger.kernel.org>; Tue, 13 Aug 2019 12:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sHYpjjOSj3cKsZS8LNbuqU4iflCegvGo0YeYfpsqvjM=;
        b=auN+J9iyrf5OGT56LOVxjtJish8Eymt2JZXIc5dyN7DK1GC267QiVFEHpvxz/rh+6C
         11D6krWY8TfxuU1h0UThVJJXHmIc8IXt7EKs07xS+44ziHE2VUbaO5s2wBUQ1knAjY/V
         RBCDLj8oADYUyy2+x8jyM1ATuUxDqkHnITKzn3qlb6a9dODjW5DDxn+1i4LZWzZ6f3lg
         YNdrgs/T08SSGATVY4mDfiCB2/afZTOYwttVKuKr6HXWuy9sw281eZUwZ2f8IXGedt8K
         uVHXRzbUKEgp+ac+qyPDqPMXc37jS6g3r9AVF+THw4SqD5FJvbn6nLAoU2j9hsCJCUl8
         lFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sHYpjjOSj3cKsZS8LNbuqU4iflCegvGo0YeYfpsqvjM=;
        b=bc/75XHEXaOy+gYNOMnNho4loUDgfAnnR5MwguloInPG+n9jMVuHekQTABN8z9F/dt
         OWAWPOIdPXvPXAWadHkvu/4YJ9PQKZD5AuRTa4Yzpwh0CGgkGxjDvGpJzQGtyLaJ/OyX
         0s8KnutM2AGhv3A0gcx3wWAK2RgJ1TZUMhqX8JVEEyuKbH2evWn6u66m6bd97jE2J1rB
         IGpgxaAgSVY837eb3eAPYPa8/oVJd/NPV/xHpxXto0Tshs36ajbAFyau/EfQyEoiHJp8
         2eX7hpTKEqdUdkA72ZifbnFpaqHE/qsUa8+Q/xaHU6Pr8kgppIaMToxfhVJfdlQ1v29P
         1/ig==
X-Gm-Message-State: APjAAAWUQrcMRgkyxbA7lWR0x0k7VcfFa+JV8eDke2AwAoQMsyonjRPc
        eus6LCZD7OnyQ17vIt0liiiGYCZHyq/qxniBgegQhw==
X-Google-Smtp-Source: APXvYqwtV/c0ur98YG3sspSS/O1ZIrocbgw2IcEyWMI67fI9fUxJOer3VnMhmBoQKCxa8tTAsmuL7ypg/grobp7Y6ySz4A==
X-Received: by 2002:a65:514c:: with SMTP id g12mr35833280pgq.76.1565724095535;
 Tue, 13 Aug 2019 12:21:35 -0700 (PDT)
Date:   Tue, 13 Aug 2019 12:21:22 -0700
In-Reply-To: <20190813192126.122370-1-matthewgarrett@google.com>
Message-Id: <20190813192126.122370-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190813192126.122370-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 2/6] early_security_init() needs a stub got !CONFIG_SECURITY
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Stephen Rothwell <sfr@canb.auug.org.au>

An arm multi_v7_defconfig fails like this:

init/main.c: In function 'start_kernel':
init/main.c:596:2: error: implicit declaration of function 'early_security_init'; did you mean 'security_init'? [-Werror=implicit-function-declaration]
  early_security_init();
  ^~~~~~~~~~~~~~~~~~~
  security_init

Fixes: 45d29f9e9b8b ("security: Support early LSMs")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/security.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5748ccc2a42e..429f9f03372b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -473,6 +473,11 @@ static inline int security_init(void)
 	return 0;
 }
 
+static inline int early_security_init(void)
+{
+	return 0;
+}
+
 static inline int security_binder_set_context_mgr(struct task_struct *mgr)
 {
 	return 0;
-- 
2.23.0.rc1.153.gdeed80330f-goog

