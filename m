Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433E0C3526D
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Dec 2020 16:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20391238E7
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Dec 2020 16:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgLGQer (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Dec 2020 11:34:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26821 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726989AbgLGQeq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PLCQKZfzWqBvZ3fNsIg7ssx6JJEt23zVLXYENI3nPr8=;
        b=XoRmRV1WFlFP0ibUANPo3GUVFFyxpiGr+0f6l8UvW1ye74TCKLFFp/uWCuFuOiWm24VTCC
        KVCbbKniwpAxXRSOqDh0RxcW0kPR5D7SnlohQeGcKdjvZwp8WWz9JhJ6ca0Vv1VdI/nFjT
        oa/jzA6cdd3RQQLEKwMqOTzlrvJFXl4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-zF-bMYniOGOxvdBOW_wb2g-1; Mon, 07 Dec 2020 11:33:13 -0500
X-MC-Unique: zF-bMYniOGOxvdBOW_wb2g-1
Received: by mail-ej1-f71.google.com with SMTP id u10so4054934ejy.18
        for <linux-security-module@vger.kernel.org>; Mon, 07 Dec 2020 08:33:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLCQKZfzWqBvZ3fNsIg7ssx6JJEt23zVLXYENI3nPr8=;
        b=MrgHiM7rGXp5RmCLlr/Oy1fodjOEMIVaUAwSEH8dCcsp6iSBOu4seumEGSKY44nJ33
         3KGIQ25lLnF2DpKE9RlzuR/Y30QTfDZPSJx9WadwQVPZybRIjqngIswwZ2IoKxeAXnZw
         KYsMSUR2LN+dwyNxaHu5nqEOnSKN04jlZLqyBpvBRV5i6MHj2YDWfRtJBZRyvPIB+I5+
         iecfsT2j0Q/P1UoKy81yqHyUzUGdzG8NbS1Z2fztSD4JJeI4BEn+BMF56MWhJUbvVR02
         D3ADv3VxKYtcgwh+znKKEts8t5p+HXuy60NiNNg0x9v1FHMH6G6iQQC08bm2X9BNzt/4
         grnA==
X-Gm-Message-State: AOAM533uncpKAqTNei2TNbBvRzCofCHyQBK7rqbiP9eRtKzUrUFclryp
        sAF9VACZufwp6234J9ATd9PpwWR/eWAFZVtLkyHesVhHg6ZHRysTtVH/t8I7vmiMy8mPkM36LPT
        9MYlC3ceiHLZtdGdnoFIc2AYb6Lx6NvMY41oX
X-Received: by 2002:a50:9f4a:: with SMTP id b68mr20511327edf.296.1607358792115;
        Mon, 07 Dec 2020 08:33:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcfXNOTxIA60QUdAr/l6040dD7T0L3kweELtDlwwC95Xbikn5wQvx9TnMAECGb3KS/JY4RKA==
X-Received: by 2002:a50:9f4a:: with SMTP id b68mr20511314edf.296.1607358791932;
        Mon, 07 Dec 2020 08:33:11 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:11 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/10] ovl: do not get metacopy for userxattr
Date:   Mon,  7 Dec 2020 17:32:54 +0100
Message-Id: <20201207163255.564116-10-mszeredi@redhat.com>
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

When looking up an inode on the lower layer for which the mounter lacks
read permisison the metacopy check will fail.  This causes the lookup to
fail as well, even though the directory is readable.

So ignore EACCES for the "userxattr" case and assume no metacopy for the
unreadable file.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/util.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 66eaf4db027f..703c6e529f39 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -880,6 +880,13 @@ int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct dentry *dentry)
 	if (res < 0) {
 		if (res == -ENODATA || res == -EOPNOTSUPP)
 			return 0;
+		/*
+		 * getxattr on user.* may fail with EACCES in case there's no
+		 * read permission on the inode.  Not much we can do, other than
+		 * tell the caller that this is not a metacopy inode.
+		 */
+		if (ofs->config.userxattr && res == -EACCES)
+			return 0;
 		goto out;
 	}
 
-- 
2.26.2

