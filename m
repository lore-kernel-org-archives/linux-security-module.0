Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E208CC2BBCA
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Dec 2020 16:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA8B3238E8
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Dec 2020 16:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgLGQfE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Dec 2020 11:35:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727745AbgLGQeh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=slnEJYBwmhqKOQO5uk6sWnTW5gdRX2VMxeSBeR8XW8Q=;
        b=N28kZg9Hw74mQJFlpn+2d62+Kt5inYewJvL6Ysh1eCER89LlGh2FnJ/ABrWGKlVRlAMPOp
        9QlGyWR3GpodDW4tmdwSQXU1tbrnWpCNugO6Cez7DYwgXapP+y5w2BDPJJqomw5mm3KwNx
        ePXsqse/r4rz+5V1QuKjcbZS50GlRsg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-4SRpmfpaO56GA8ikLcCIaA-1; Mon, 07 Dec 2020 11:33:09 -0500
X-MC-Unique: 4SRpmfpaO56GA8ikLcCIaA-1
Received: by mail-ed1-f70.google.com with SMTP id r16so6003228eds.13
        for <linux-security-module@vger.kernel.org>; Mon, 07 Dec 2020 08:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=slnEJYBwmhqKOQO5uk6sWnTW5gdRX2VMxeSBeR8XW8Q=;
        b=nmPMZ5ePurtUoUsJIelwNoyRpa5wgvoJU08xomhRS8ypI//1A3F+QLdUGJpeeYDA4P
         jBgs/y4mw9Cpq0YYoB9sDjpqf8YjCglEEs+SehIn2DSMv+N0CX3yl/x9fXSR6xxVAKvG
         qrWnFrtQfEGQ+/TKlH4yfB3kGwHCIjGBKNDQ8htMENuRHrD7n6vF4HCyg3zP9JQUvEeL
         +hB5YpY5ctHK+mScNRqnd6V86fNKJWl8Ouf6N4emxZZ5v5b+TYE0htLRCbHIpEPxS41O
         ouHdm81kHUwAkVIbTOAkDIPmTNiUbXt143oBUwuugo3tXIr4ofFhCUy4UTv1WZ5cxyQu
         tmew==
X-Gm-Message-State: AOAM532gQIVI0r5wujayDYbCoFBDSnOP45WDA8XUg6NgpQKpmxeNdCGO
        JF8c9pcv4XDDowhtl73eYLgwl6dQ25D+8T0bJmr8gkSKWumln+08fI1W3QCbJRDYsljYQbm6+9B
        yrJxN4AzfvsqOtwq7DsLho/jaQEpRuGs4/Lpt
X-Received: by 2002:a05:6402:1b1e:: with SMTP id by30mr19432220edb.75.1607358786631;
        Mon, 07 Dec 2020 08:33:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzx0eatSbnQFhmj8ZAY47IpBzt1G1gtOIufiyiAi4IqzHOg0Ye7dB87LiC49RkGGzdIWq8D8A==
X-Received: by 2002:a05:6402:1b1e:: with SMTP id by30mr19432206edb.75.1607358786499;
        Mon, 07 Dec 2020 08:33:06 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:06 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] ovl: simplify file splice
Date:   Mon,  7 Dec 2020 17:32:50 +0100
Message-Id: <20201207163255.564116-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201207163255.564116-1-mszeredi@redhat.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mszeredi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

generic_file_splice_read() and iter_file_splice_write() will call back into
f_op->iter_read() and f_op->iter_write() respectively.  These already do
the real file lookup and cred override.  So the code in ovl_splice_read()
and ovl_splice_write() is redundant.

In addition the ovl_file_accessed() call in ovl_splice_write() is
incorrect, though probably harmless.

Fix by calling generic_file_splice_read() and iter_file_splice_write()
directly.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c | 46 ++-------------------------------------------
 1 file changed, 2 insertions(+), 44 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 3cd1590f2030..dc767034d37b 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -397,48 +397,6 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	return ret;
 }
 
-static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
-			 struct pipe_inode_info *pipe, size_t len,
-			 unsigned int flags)
-{
-	ssize_t ret;
-	struct fd real;
-	const struct cred *old_cred;
-
-	ret = ovl_real_fdget(in, &real);
-	if (ret)
-		return ret;
-
-	old_cred = ovl_override_creds(file_inode(in)->i_sb);
-	ret = generic_file_splice_read(real.file, ppos, pipe, len, flags);
-	revert_creds(old_cred);
-
-	ovl_file_accessed(in);
-	fdput(real);
-	return ret;
-}
-
-static ssize_t
-ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
-			  loff_t *ppos, size_t len, unsigned int flags)
-{
-	struct fd real;
-	const struct cred *old_cred;
-	ssize_t ret;
-
-	ret = ovl_real_fdget(out, &real);
-	if (ret)
-		return ret;
-
-	old_cred = ovl_override_creds(file_inode(out)->i_sb);
-	ret = iter_file_splice_write(pipe, real.file, ppos, len, flags);
-	revert_creds(old_cred);
-
-	ovl_file_accessed(out);
-	fdput(real);
-	return ret;
-}
-
 static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	struct fd real;
@@ -732,8 +690,8 @@ const struct file_operations ovl_file_operations = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= ovl_compat_ioctl,
 #endif
-	.splice_read    = ovl_splice_read,
-	.splice_write   = ovl_splice_write,
+	.splice_read    = generic_file_splice_read,
+	.splice_write   = iter_file_splice_write,
 
 	.copy_file_range	= ovl_copy_file_range,
 	.remap_file_range	= ovl_remap_file_range,
-- 
2.26.2

