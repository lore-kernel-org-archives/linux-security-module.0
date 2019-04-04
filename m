Return-Path: <SRS0=ir4w=SG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFFAC4360F
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B82E21734
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WD2fqHr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfDDAdt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:33:49 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:42951 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbfDDAdr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:47 -0400
Received: by mail-vk1-f201.google.com with SMTP id q135so442055vke.9
        for <linux-security-module@vger.kernel.org>; Wed, 03 Apr 2019 17:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i92ao4UQPXz3UyfztS9poQmhL/y3JHZOqS1ytGgJ0IM=;
        b=WD2fqHr0nDM4EQFGLbdjZzJ4OnQw5Ddxx68yzwL66IurjJUsv0Yb+gxKTO9lDeytxP
         nSWlzoRoFeHqKw66bCCz3HdUH6+GXH/g812nh8i+kEgTpnZSGeOIZqg3RbAEy5GXEWFV
         JfyHzIWeiBYbK+iKm01BQA7ViUxVDYh96kcMJtkOzrqaPm0bzYclshYaW/xjvX2JOFq/
         at7lM3kTiHHrRFWmjc61Vjk2X71jdUlkZ+EWTKvY2LdmCdxdqei30RkDY5CIDJGXgJYB
         X/UF7Ujc1cDOAOhHBLFtdAPOTxrR2CnKzowQMumOkT2uXSo3kKGchcsuxFGsWDG9tue4
         XjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i92ao4UQPXz3UyfztS9poQmhL/y3JHZOqS1ytGgJ0IM=;
        b=DKqOMgO838D+1kdGcygMvM6+vbvQKc+xw0OYkLupMOj5YZl0lKPkM6Gf+Z8OaBHiHI
         q8YjBnr/L4ZY6gl9e996Xh6OExy75H5ilRxqCEayMGj5TcT1nSvmEEtI4Uanc2FiwnAK
         4FaD9YBfyVcw8jH1IgRYm6QOO4Wt1aGtg1JUqb4+rZL9KfjVaWAbZhP7VdK8jOtzhRWE
         MLk7Apq+m81xCt8wie5gmWll35EPZK5ZmU7GxscMv7r6Ic8pEMnbBlHMoKhD0MTLS/3Q
         A+MU6BB1KUt0Ql2Ox5Nen3POVRhGwEccsyBkafMEql6E1TNXU+FBh1N+QVB5PcFIs/Vp
         b80g==
X-Gm-Message-State: APjAAAXNaCXcvZZlpky0EvS3CHsKv59GT8i+X+TUtaNdViVSyfKwACqz
        lOvQ/DEjb8j3w6wZluh+cC0gsu4dup9yvd/Q3pGLLA==
X-Google-Smtp-Source: APXvYqzjmy6IcMnQ8wpH9g+GYhfmT7QUPbLsfV4lkOMbxG0a3u7Cu+T3H2a78xceri8tS8cbdCa7GoAgpAkAPYJuzt3SJw==
X-Received: by 2002:a67:fdd1:: with SMTP id l17mr379136vsq.19.1554338026502;
 Wed, 03 Apr 2019 17:33:46 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:42 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-21-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 20/27] Lock down /proc/kcore
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Disallow access to /proc/kcore when the kernel is locked down to prevent
access to cryptographic data. This is limited to lockdown
confidentiality mode and is still permitted in integrity mode.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 fs/proc/kcore.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index bbcc185062bb..1c556a453569 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -518,6 +518,8 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 
 static int open_kcore(struct inode *inode, struct file *filp)
 {
+	if (kernel_is_locked_down("/proc/kcore", LOCKDOWN_CONFIDENTIALITY))
+		return -EPERM;
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
-- 
2.21.0.392.gf8f6787159e-goog

