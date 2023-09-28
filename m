Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF229E732C0
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Sep 2023 11:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjI1LWM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Sep 2023 07:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjI1LVh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Sep 2023 07:21:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A092630EE;
        Thu, 28 Sep 2023 04:05:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A97C116CB;
        Thu, 28 Sep 2023 11:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899154;
        bh=r5SK+jr3EBI0menL2V5UmA+6WeqJoTdE3YJ7XmcoehI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ucrCe/jlvNXPJgL05R1SUNtmRqPO/P0DUsQXZJBddiWRi7Blb7Q+kFkwNaB5OMmj0
         tYVo61uaHGMTilnFpPAJX+i2JDQ8SAlezHEXEKJVzFijwYV73XS5FDkalLNESrCDpq
         M1LXP4gH2JXl9gR/ME/Or0KJQxPD/5KPoOwikmk0Bc1PHLKF0UZaKZlqvPkQxXes6R
         aMDtJ/A//ISOlIRyD8kgS4Ntx2pZ5CJX01s3dDwVv8x5T9znkp5jExXdqXUWYChbi0
         6ytCJGCt01Ht13uHEllSyXZwN72ja6OZpoOIl0eGOdWkC7ocUiTJWURwEOWwvkNfNe
         4lqGuONxgu5WA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org
Subject: [PATCH 84/87] security: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:33 -0400
Message-ID: <20230928110413.33032-83-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 security/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/inode.c b/security/inode.c
index 3aa75fffa8c9..9e7cde913667 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -145,7 +145,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 
 	inode->i_ino = get_next_ino();
 	inode->i_mode = mode;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_private = data;
 	if (S_ISDIR(mode)) {
 		inode->i_op = &simple_dir_inode_operations;
-- 
2.41.0

