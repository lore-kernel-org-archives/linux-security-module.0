Return-Path: <SRS0=iYml=C3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E67C43463
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Sep 2020 02:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5DF5235F8
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Sep 2020 02:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600397586;
	bh=Ck6fc4SttpI6j9QYpn6//UUfsHchD6fGEC7acmbMEqY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DHQ6p9TvtWAou93HQDIT9X3XDEhleSQum53V5onGkkTIzbOu/j4aVTLTkmb2VNjG9
	 aHKSo5nkWtt5hnpAqOgcY8s+7gkuqxEJVavU47Do4A7vQb/EjtlRz3EepNhYX9on7v
	 ZJM/jEtJBQ+I8/j9RdG1h8qQed2yI5fyVMWhVf60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgIRCw5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:52:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbgIRCIF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Sep 2020 22:08:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 075A423770;
        Fri, 18 Sep 2020 02:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600394884;
        bh=Ck6fc4SttpI6j9QYpn6//UUfsHchD6fGEC7acmbMEqY=;
        h=From:To:Cc:Subject:Date:From;
        b=INXt6hFkJ8Gikce6p7QV+rtyyW08RNMjZlLzIP47yvljFax+dqTm9ThzJjTtuI+7H
         RkHl+cUlwZSQUa2fb2DZSMu2uqBfNcnYAOSQgyDqR6O7nl8iOrNThj5wKNLupG4A/C
         2pKys7vZffLNBRQISGqxMu7UsE5EVIK2UyROeGlE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jonathan Lebon <jlebon@redhat.com>,
        Victor Kamensky <kamensky@cisco.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 001/206] selinux: allow labeling before policy is loaded
Date:   Thu, 17 Sep 2020 22:04:37 -0400
Message-Id: <20200918020802.2065198-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Jonathan Lebon <jlebon@redhat.com>

[ Upstream commit 3e3e24b42043eceb97ed834102c2d094dfd7aaa6 ]

Currently, the SELinux LSM prevents one from setting the
`security.selinux` xattr on an inode without a policy first being
loaded. However, this restriction is problematic: it makes it impossible
to have newly created files with the correct label before actually
loading the policy.

This is relevant in distributions like Fedora, where the policy is
loaded by systemd shortly after pivoting out of the initrd. In such
instances, all files created prior to pivoting will be unlabeled. One
then has to relabel them after pivoting, an operation which inherently
races with other processes trying to access those same files.

Going further, there are use cases for creating the entire root
filesystem on first boot from the initrd (e.g. Container Linux supports
this today[1], and we'd like to support it in Fedora CoreOS as well[2]).
One can imagine doing this in two ways: at the block device level (e.g.
laying down a disk image), or at the filesystem level. In the former,
labeling can simply be part of the image. But even in the latter
scenario, one still really wants to be able to set the right labels when
populating the new filesystem.

This patch enables this by changing behaviour in the following two ways:
1. allow `setxattr` if we're not initialized
2. don't try to set the in-core inode SID if we're not initialized;
   instead leave it as `LABEL_INVALID` so that revalidation may be
   attempted at a later time

Note the first hunk of this patch is mostly the same as a previously
discussed one[3], though it was part of a larger series which wasn't
accepted.

[1] https://coreos.com/os/docs/latest/root-filesystem-placement.html
[2] https://github.com/coreos/fedora-coreos-tracker/issues/94
[3] https://www.spinics.net/lists/linux-initramfs/msg04593.html

Co-developed-by: Victor Kamensky <kamensky@cisco.com>
Signed-off-by: Victor Kamensky <kamensky@cisco.com>
Signed-off-by: Jonathan Lebon <jlebon@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/hooks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 452254fd89f87..250b725f5754c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3304,6 +3304,9 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 		return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
 	}
 
+	if (!selinux_state.initialized)
+		return (inode_owner_or_capable(inode) ? 0 : -EPERM);
+
 	sbsec = inode->i_sb->s_security;
 	if (!(sbsec->flags & SBLABEL_MNT))
 		return -EOPNOTSUPP;
@@ -3387,6 +3390,15 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 		return;
 	}
 
+	if (!selinux_state.initialized) {
+		/* If we haven't even been initialized, then we can't validate
+		 * against a policy, so leave the label as invalid. It may
+		 * resolve to a valid label on the next revalidation try if
+		 * we've since initialized.
+		 */
+		return;
+	}
+
 	rc = security_context_to_sid_force(&selinux_state, value, size,
 					   &newsid);
 	if (rc) {
-- 
2.25.1

