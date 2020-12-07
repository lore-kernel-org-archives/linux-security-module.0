Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67B1C2BBD5
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Dec 2020 16:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96D03238EA
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Dec 2020 16:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgLGQeo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Dec 2020 11:34:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36673 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727786AbgLGQen (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RE0m3vgq1/OaRAwZjvKOK2ey/mE38mR/q+wtN6wib9s=;
        b=Qzytzw8vjJDV98dN0C5Eu/5I1z/cNMLl4F+ISK6FIXPx9cHutqMZ6vmbdF9M7HGL0u4MwC
        kfgiZuUse3Ndn1yiunTqjkFesgchdVEcK6EXinrTYlMzQ9+rRLEVh+ZWZZKSroOjeJgo/N
        5gEZXpzKezYeozmqp0qAv7CsfykxCjs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-xB9HqcBQP2GXFBLO3A54zA-1; Mon, 07 Dec 2020 11:33:16 -0500
X-MC-Unique: xB9HqcBQP2GXFBLO3A54zA-1
Received: by mail-ed1-f69.google.com with SMTP id ca7so6045946edb.12
        for <linux-security-module@vger.kernel.org>; Mon, 07 Dec 2020 08:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RE0m3vgq1/OaRAwZjvKOK2ey/mE38mR/q+wtN6wib9s=;
        b=mV20PZk1bb0qbLIL05S9l/Uj7KaKwYqAdu/BZ+/uKLjkPfe0E1pH2CRSP7Q1SNaBKe
         2yvUnU/oE1yIf5OIEpccg2wBWnT2HRX0zmc1Z4bJstek1JmfmB0M6xx2D09SC9iGVZHa
         NhPyxpzLXI+CPI2jr7kvA7zheHjt4m9m1yBkYK7hgiFDtfcGm/G4twJ/Px4il3zxGEQZ
         jdJhgmO9klZAuqGQx0lOhzbfQVnNlYoCQRZmhSMzGUOCJ3ltQQVtp+bktRZcoKdraGjI
         3yD/PmWkV2JXb4ceHTwBuflmJEOz5+rwtXoT7EKAoaj0d0MzuW5k1WSvRxzDjY3WQ+4B
         gfzA==
X-Gm-Message-State: AOAM532uW7hZEpqgFaYFlc8by12+bDwCu/L9ibsMEiI+KVvK2LX2qPHr
        gsJuamfT1rQqEvDtQ+T5neyenw/l26z/agrn3yRANpwugwtkCnv4x5eyGklolB1TO2UmU5JTOMT
        3utzuoqGZ0G1WuTypdMWpkZFPFiKUfTWv6P/r
X-Received: by 2002:a50:d74c:: with SMTP id i12mr20512777edj.236.1607358793437;
        Mon, 07 Dec 2020 08:33:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZo9cLo2B/sr3LytBzOfhCP7NvepbgDDGPqp8OuSqAKVtWfqlfy6nWwFOViRsEnP4mLzJm9A==
X-Received: by 2002:a50:d74c:: with SMTP id i12mr20512764edj.236.1607358793260;
        Mon, 07 Dec 2020 08:33:13 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:12 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/10] ovl: unprivieged mounts
Date:   Mon,  7 Dec 2020 17:32:55 +0100
Message-Id: <20201207163255.564116-11-mszeredi@redhat.com>
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

Enable unprivileged user namespace mounts of overlayfs.  Overlayfs's
permission model (*) ensures that the mounter itself cannot gain additional
privileges by the act of creating an overlayfs mount.

This feature request is coming from the "rootless" container crowd.

(*) Documentation/filesystems/overlayfs.txt#Permission model

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 189380b946be..019e6f1834b0 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -2073,6 +2073,7 @@ static struct dentry *ovl_mount(struct file_system_type *fs_type, int flags,
 static struct file_system_type ovl_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "overlay",
+	.fs_flags	= FS_USERNS_MOUNT,
 	.mount		= ovl_mount,
 	.kill_sb	= kill_anon_super,
 };
-- 
2.26.2

