Return-Path: <SRS0=OQ6N=Q5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2DFC10F0B
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Feb 2019 14:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07902086C
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Feb 2019 14:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfBVO5x (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:57:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34790 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfBVO5w (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Feb 2019 09:57:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id f14so2725496wrg.1
        for <linux-security-module@vger.kernel.org>; Fri, 22 Feb 2019 06:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7n/70NaWl0BIWsrw4Nf9QtXYHdDHEAFx5YuB2+JlALg=;
        b=nacvT0dLnS276u6yS5mPxuGPQkbeJXK4indKUJPJknKeaTrfSylL4jTWw2oC2P0S1m
         X5rUnsM8F5pTYCKk9r7ilUGKwaH+mlMXsabUUkDCj6FgCQiNlUYzcq4JY9g33/649bp3
         E8zXibPjCZmJZ9K78W9EoM2ZYhD4f/0Cu0WjZ0HpaV4c4RTLIrplUbcquNbc6ZYAbRpV
         MmdcuG7xAEck3bTJSleT7QIMlRwKrw30i8dkmn6pDJG7q0dbn96PQzjS2DcYE2iMjCD/
         DHqW8/Jj2Ij88oRWkUgkfI1n3aXww3qGFhzWLlNIYjaAPktyeNPxC+3Qo6U80guzWC+S
         lAPg==
X-Gm-Message-State: AHQUAuZiFX8LyDRNAy3cpzilv/M0r9ebvWGNecfTl+f++aZ2ZasxXF8S
        vJ5e6KR6hzXgca9cPO6vpNl+7w==
X-Google-Smtp-Source: AHgI3IbmtHK+lnP7Dljpl1l5VaePLL7sxhmizTelgs7gUNpQQvXAR4jRwoQad6d+gSsubj1f7mv2rA==
X-Received: by 2002:adf:ff81:: with SMTP id j1mr3324885wrr.261.1550847470086;
        Fri, 22 Feb 2019 06:57:50 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 203sm1503912wme.30.2019.02.22.06.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 06:57:49 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v7 2/7] kernfs: do not alloc iattrs in kernfs_xattr_get
Date:   Fri, 22 Feb 2019 15:57:13 +0100
Message-Id: <20190222145718.5740-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222145718.5740-1-omosnace@redhat.com>
References: <20190222145718.5740-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This is a read-only operation, so we can simply return -ENODATA if
kn->iattr is NULL.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/kernfs/inode.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index ffd1ef962728..7a7985961bbf 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -31,14 +31,14 @@ static const struct inode_operations kernfs_iops = {
 	.listxattr	= kernfs_iop_listxattr,
 };
 
-static struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
+static struct kernfs_iattrs *__kernfs_iattrs(struct kernfs_node *kn, int alloc)
 {
 	static DEFINE_MUTEX(iattr_mutex);
 	struct kernfs_iattrs *ret;
 
 	mutex_lock(&iattr_mutex);
 
-	if (kn->iattr)
+	if (kn->iattr || !alloc)
 		goto out_unlock;
 
 	kn->iattr = kzalloc(sizeof(struct kernfs_iattrs), GFP_KERNEL);
@@ -60,6 +60,16 @@ out_unlock:
 	return ret;
 }
 
+static struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
+{
+	return __kernfs_iattrs(kn, 1);
+}
+
+static struct kernfs_iattrs *kernfs_iattrs_noalloc(struct kernfs_node *kn)
+{
+	return __kernfs_iattrs(kn, 0);
+}
+
 int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
 	struct kernfs_iattrs *attrs;
@@ -306,9 +316,9 @@ static int kernfs_xattr_get(const struct xattr_handler *handler,
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_iattrs *attrs;
 
-	attrs = kernfs_iattrs(kn);
+	attrs = kernfs_iattrs_noalloc(kn);
 	if (!attrs)
-		return -ENOMEM;
+		return -ENODATA;
 
 	return simple_xattr_get(&attrs->xattrs, name, value, size);
 }
-- 
2.20.1

