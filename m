Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C8EC41621
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B51522DD3
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbhASQ2V (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Jan 2021 11:28:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49166 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731543AbhASQXl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Jan 2021 11:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611073334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e0d34g0cQgU3pUUMcwk4mh+TGyc8uh3BJ8u4e70DhUc=;
        b=c37IaQJrzRu3X0VKX/MYeRMARPkkh9WGbVuytAJXIRyrwZts4xMdrLrRtknbOgdAKBbRNa
        93iaxlhxcB5+QOk9KwOxIdo0/7XVA6p1eyFVl6dKjBgovi2+R1Ts/NgKfZtFoccc3c1wNW
        7MsQxf4cIM0vvl0sn2WceBEpbD7utYo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-25DKFb6CP8C4fB-GfLd82w-1; Tue, 19 Jan 2021 11:22:10 -0500
X-MC-Unique: 25DKFb6CP8C4fB-GfLd82w-1
Received: by mail-ej1-f71.google.com with SMTP id x22so6482330ejb.10
        for <linux-security-module@vger.kernel.org>; Tue, 19 Jan 2021 08:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e0d34g0cQgU3pUUMcwk4mh+TGyc8uh3BJ8u4e70DhUc=;
        b=EEjoXqqsAvrRvD200CaOm7ZTAjvnhQzYk354LLEhzC0S/Yl/+yPmgtc7xtdN8X5/0T
         DmTgeDoAbQGIrAqITN6pD9JUAB8MZYdnw9BcqmUtRvH9ZcGOFvRJv5X7r/XYo7qDAKC+
         whwFNxxN7Zwouvir+YpdoCUOVO8evO5dAInDel9lqgS/LFLqm7Yjx21FV2H6GKrSPlQ0
         SVSrh9cqLLNTbrR0ilOhbIJV6CSwCe0OzxLErLBqEWBqJmd3H6+PB2UF6YxfIzvJEH4I
         /3ebLV2O7ZPYzr/F1+2gLMTwgm2rnhdn2gNiyfc+j0XIVDUANVXswn2Ayds1pXNV462k
         EHew==
X-Gm-Message-State: AOAM532NOaRAJ9eRXE52YjxwqEOcIj5GdE8f4oEKjDn3zBOHU7UsCE2+
        ezXSVsa6E6f4IBTkRrPSsoqH7Edsq18yqtFSssmvgVjpLgcBg8wNzcC0OsatRC1pjyFByzdN0v2
        7amAOguBBr1Fa22zAByPwC05iGm5XhIAIRCMo
X-Received: by 2002:a17:906:f18c:: with SMTP id gs12mr3548357ejb.422.1611073329719;
        Tue, 19 Jan 2021 08:22:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJywCQ8WKQ39LO/s3JpVfU0aRZ0r35Z4MSS7hLGLYpfP7iPEPDe7nnjVqIqyXKcESLiLAw5Qaw==
X-Received: by 2002:a17:906:f18c:: with SMTP id gs12mr3548339ejb.422.1611073329537;
        Tue, 19 Jan 2021 08:22:09 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id f22sm2168066eje.34.2021.01.19.08.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:22:09 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <code@tyhicks.com>
Subject: [PATCH 1/2] ecryptfs: fix uid translation for setxattr on security.capability
Date:   Tue, 19 Jan 2021 17:22:03 +0100
Message-Id: <20210119162204.2081137-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210119162204.2081137-1-mszeredi@redhat.com>
References: <20210119162204.2081137-1-mszeredi@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mszeredi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Prior to commit 7c03e2cda4a5 ("vfs: move cap_convert_nscap() call into
vfs_setxattr()") the translation of nscap->rootid did not take stacked
filesystems (overlayfs and ecryptfs) into account.

That patch fixed the overlay case, but made the ecryptfs case worse.

Restore old the behavior for ecryptfs that existed before the overlayfs
fix.  This does not fix ecryptfs's handling of complex user namespace
setups, but it does make sure existing setups don't regress.

Reported-by: Eric W. Biederman <ebiederm@xmission.com>
Cc: Tyler Hicks <code@tyhicks.com>
Fixes: 7c03e2cda4a5 ("vfs: move cap_convert_nscap() call into vfs_setxattr()")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/ecryptfs/inode.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index e23752d9a79f..58d0f7187997 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1016,15 +1016,19 @@ ecryptfs_setxattr(struct dentry *dentry, struct inode *inode,
 {
 	int rc;
 	struct dentry *lower_dentry;
+	struct inode *lower_inode;
 
 	lower_dentry = ecryptfs_dentry_to_lower(dentry);
-	if (!(d_inode(lower_dentry)->i_opflags & IOP_XATTR)) {
+	lower_inode = d_inode(lower_dentry);
+	if (!(lower_inode->i_opflags & IOP_XATTR)) {
 		rc = -EOPNOTSUPP;
 		goto out;
 	}
-	rc = vfs_setxattr(lower_dentry, name, value, size, flags);
+	inode_lock(lower_inode);
+	rc = __vfs_setxattr_locked(lower_dentry, name, value, size, flags, NULL);
+	inode_unlock(lower_inode);
 	if (!rc && inode)
-		fsstack_copy_attr_all(inode, d_inode(lower_dentry));
+		fsstack_copy_attr_all(inode, lower_inode);
 out:
 	return rc;
 }
-- 
2.26.2

