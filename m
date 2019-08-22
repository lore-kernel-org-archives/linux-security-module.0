Return-Path: <SRS0=h0Om=WS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AE9C3A5A2
	for <linux-security-module@archiver.kernel.org>; Thu, 22 Aug 2019 05:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC2E20856
	for <linux-security-module@archiver.kernel.org>; Thu, 22 Aug 2019 05:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566453312;
	bh=UXY5aSHm+byRBUM+ls6z3ZUmsPSiWC0HIn3XjjSXQHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CkxSgl1DKznBzT8O4eS3+UBku8fvc3IfnpdoMVNWGviUxhyMmqVzmrXD1H7/qDUjz
	 oxJGNuJ2pjw7WBHJ3M3e65lDP5jFjcMGGt4I69R3Fym+qk6I3KCp5xX3UAz959HVTr
	 x/CIVY6WC4KfvXQl6KPrENGKAGHmcUX3u2W4d4C8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfHVFzM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 22 Aug 2019 01:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbfHVFzM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 22 Aug 2019 01:55:12 -0400
Received: from zzz.localdomain (unknown [67.218.105.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7A93233A1;
        Thu, 22 Aug 2019 05:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566453310;
        bh=UXY5aSHm+byRBUM+ls6z3ZUmsPSiWC0HIn3XjjSXQHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DWGyHVwoPgH4hOCD6UmuFrBV6xmOLF+eJqeyfFje+WyO8JrfqqC5ieRpBSYkTQUjF
         ZyPLNlfHM3ErgLg+NsQUO3HZRV5T82ODnvCWB0GOq4NITw9ohediCTH4IQJzXppQYm
         1Rllhs0AGp+vPzf4vXaNXZqfCOTipJ8gCHpXp0U8=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot+0eefc1e06a77d327a056@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: [PATCH] smack: use GFP_NOFS while holding inode_smack::smk_lock
Date:   Wed, 21 Aug 2019 22:54:41 -0700
Message-Id: <20190822055441.20569-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <CACT4Y+aGjkmq4cEaQXagd_YqjE4a1HoNgcEzqeNj-g0Hg_hQHw@mail.gmail.com>
References: <CACT4Y+aGjkmq4cEaQXagd_YqjE4a1HoNgcEzqeNj-g0Hg_hQHw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

inode_smack::smk_lock is taken during smack_d_instantiate(), which is
called during a filesystem transaction when creating a file on ext4.
Therefore to avoid a deadlock, all code that takes this lock must use
GFP_NOFS, to prevent memory reclaim from waiting for the filesystem
transaction to complete.

Reported-by: syzbot+0eefc1e06a77d327a056@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/smack/smack_access.c | 6 +++---
 security/smack/smack_lsm.c    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index f1c93a7be9ec..38ac3da4e791 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -465,7 +465,7 @@ char *smk_parse_smack(const char *string, int len)
 	if (i == 0 || i >= SMK_LONGLABEL)
 		return ERR_PTR(-EINVAL);
 
-	smack = kzalloc(i + 1, GFP_KERNEL);
+	smack = kzalloc(i + 1, GFP_NOFS);
 	if (smack == NULL)
 		return ERR_PTR(-ENOMEM);
 
@@ -500,7 +500,7 @@ int smk_netlbl_mls(int level, char *catset, struct netlbl_lsm_secattr *sap,
 			if ((m & *cp) == 0)
 				continue;
 			rc = netlbl_catmap_setbit(&sap->attr.mls.cat,
-						  cat, GFP_KERNEL);
+						  cat, GFP_NOFS);
 			if (rc < 0) {
 				netlbl_catmap_free(sap->attr.mls.cat);
 				return rc;
@@ -536,7 +536,7 @@ struct smack_known *smk_import_entry(const char *string, int len)
 	if (skp != NULL)
 		goto freeout;
 
-	skp = kzalloc(sizeof(*skp), GFP_KERNEL);
+	skp = kzalloc(sizeof(*skp), GFP_NOFS);
 	if (skp == NULL) {
 		skp = ERR_PTR(-ENOMEM);
 		goto freeout;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 50c536cad85b..7e4d3145a018 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -288,7 +288,7 @@ static struct smack_known *smk_fetch(const char *name, struct inode *ip,
 	if (!(ip->i_opflags & IOP_XATTR))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	buffer = kzalloc(SMK_LONGLABEL, GFP_KERNEL);
+	buffer = kzalloc(SMK_LONGLABEL, GFP_NOFS);
 	if (buffer == NULL)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.22.1

