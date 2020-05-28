Return-Path: <SRS0=XUZh=7K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCF9C433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 12:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF3721548
	for <linux-security-module@archiver.kernel.org>; Thu, 28 May 2020 12:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590667539;
	bh=prOMc/RStpaK3YUH4KzHyr5ESVXotKLWP1/xmvu8a7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GzZZ8uQfdTRONEHVNursYhKmoLom+1J4rrU5COFQHKI29bZzupZjeXJbu9aEytVDu
	 CMc7oQknzzGvp9ptRMxs6qU44TvdhI0NawTZqlVmTPlZjQgU+K7oDdxHw4wtzC/l4E
	 HzH1/cCu7mfUk3sRB/MzQEO3De5MgsNBoWI6djJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389309AbgE1MFb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 May 2020 08:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388746AbgE1L47 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 May 2020 07:56:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1ED32158C;
        Thu, 28 May 2020 11:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590667018;
        bh=prOMc/RStpaK3YUH4KzHyr5ESVXotKLWP1/xmvu8a7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ew3Hp2CiAAFPfGhjVISk9gRB1awnu9QBcOqXAAhWyNy7954ADKWkcrtBPi22F28ne
         /fTisDf45FRPOtkVvVyYvWdyc918DYDKQgakk/kzQodh5Eb7AiqNQzqC57P67iYhkK
         TY90Vzf+syJL/WlX6fmixk/tCIoyE0mWfjQEE44M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        kernel test robot <lkp@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-ima-devel@lists.sourceforge.net,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 03/26] evm: Fix RCU list related warnings
Date:   Thu, 28 May 2020 07:56:31 -0400
Message-Id: <20200528115654.1406165-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528115654.1406165-1-sashal@kernel.org>
References: <20200528115654.1406165-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

[ Upstream commit 770f60586d2af0590be263f55fd079226313922c ]

This patch fixes the following warning and few other instances of
traversal of evm_config_xattrnames list:

[   32.848432] =============================
[   32.848707] WARNING: suspicious RCU usage
[   32.848966] 5.7.0-rc1-00006-ga8d5875ce5f0b #1 Not tainted
[   32.849308] -----------------------------
[   32.849567] security/integrity/evm/evm_main.c:231 RCU-list traversed in non-reader section!!

Since entries are only added to the list and never deleted, use
list_for_each_entry_lockless() instead of list_for_each_entry_rcu for
traversing the list.  Also, add a relevant comment in evm_secfs.c to
indicate this fact.

Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org> (RCU viewpoint)
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/evm/evm_crypto.c | 2 +-
 security/integrity/evm/evm_main.c   | 4 ++--
 security/integrity/evm/evm_secfs.c  | 9 ++++++++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index cc826c2767a3..fbc2ee6d46fc 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -209,7 +209,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 	data->hdr.length = crypto_shash_digestsize(desc->tfm);
 
 	error = -ENODATA;
-	list_for_each_entry_rcu(xattr, &evm_config_xattrnames, list) {
+	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
 		bool is_ima = false;
 
 		if (strcmp(xattr->name, XATTR_NAME_IMA) == 0)
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index f9a81b187fae..a2c393385db0 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -99,7 +99,7 @@ static int evm_find_protected_xattrs(struct dentry *dentry)
 	if (!(inode->i_opflags & IOP_XATTR))
 		return -EOPNOTSUPP;
 
-	list_for_each_entry_rcu(xattr, &evm_config_xattrnames, list) {
+	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
 		error = __vfs_getxattr(dentry, inode, xattr->name, NULL, 0);
 		if (error < 0) {
 			if (error == -ENODATA)
@@ -230,7 +230,7 @@ static int evm_protected_xattr(const char *req_xattr_name)
 	struct xattr_list *xattr;
 
 	namelen = strlen(req_xattr_name);
-	list_for_each_entry_rcu(xattr, &evm_config_xattrnames, list) {
+	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
 		if ((strlen(xattr->name) == namelen)
 		    && (strncmp(req_xattr_name, xattr->name, namelen) == 0)) {
 			found = 1;
diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index c11c1f7b3ddd..0f37ef27268d 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -234,7 +234,14 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
 		goto out;
 	}
 
-	/* Guard against races in evm_read_xattrs */
+	/*
+	 * xattr_list_mutex guards against races in evm_read_xattrs().
+	 * Entries are only added to the evm_config_xattrnames list
+	 * and never deleted. Therefore, the list is traversed
+	 * using list_for_each_entry_lockless() without holding
+	 * the mutex in evm_calc_hmac_or_hash(), evm_find_protected_xattrs()
+	 * and evm_protected_xattr().
+	 */
 	mutex_lock(&xattr_list_mutex);
 	list_for_each_entry(tmp, &evm_config_xattrnames, list) {
 		if (strcmp(xattr->name, tmp->name) == 0) {
-- 
2.25.1

