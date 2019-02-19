Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AE2C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B63B21738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfBSQah (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:30:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728984AbfBSQag (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:30:36 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6519813150C;
        Tue, 19 Feb 2019 16:30:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EB6C4C4;
        Tue, 19 Feb 2019 16:30:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 16/43] vfs: Add LSM hooks for the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:30:34 +0000
Message-ID: <155059383419.12449.6522023890948977248.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 19 Feb 2019 16:30:36 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add LSM hooks for use by the new mount API and filesystem context code.
This includes:

 (1) Hooks to handle allocation, duplication and freeing of the security
     record attached to a filesystem context.

 (2) A hook to snoop source specifications.  There may be multiple of these
     if the filesystem supports it.  They will to be local files/devices if
     fs_context::source_is_dev is true and will be something else, possibly
     remote server specifications, if false.

 (3) A hook to snoop superblock configuration options in key[=val] form.
     If the LSM decides it wants to handle it, it can suppress the option
     being passed to the filesystem.  Note that 'val' may include commas
     and binary data with the fsopen patch.

 (4) A hook to perform validation and allocation after the configuration
     has been done but before the superblock is allocated and set up.

 (5) A hook to transfer the security from the context to a newly created
     superblock.

 (6) A hook to rule on whether a path point can be used as a mountpoint.

These are intended to replace:

	security_sb_copy_data
	security_sb_kern_mount
	security_sb_mount
	security_sb_set_mnt_opts
	security_sb_clone_mnt_opts
	security_sb_parse_opts_str

[AV -- some of the methods being replaced are already gone, some of the
methods are not added for the lack of need]

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-security-module@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 include/linux/lsm_hooks.h |   14 ++++++++++++++
 include/linux/security.h  |   10 ++++++++++
 security/security.c       |    5 +++++
 3 files changed, 29 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9a0bdf91e646..47ba4db4d8fb 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -76,6 +76,17 @@
  *	changes on the process such as clearing out non-inheritable signal
  *	state.  This is called immediately after commit_creds().
  *
+ * Security hooks for mount using fs_context.
+ *	[See also Documentation/filesystems/mounting.txt]
+ *
+ * @fs_context_parse_param:
+ *	Userspace provided a parameter to configure a superblock.  The LSM may
+ *	reject it with an error and may use it for itself, in which case it
+ *	should return 0; otherwise it should return -ENOPARAM to pass it on to
+ *	the filesystem.
+ *	@fc indicates the filesystem context.
+ *	@param The parameter
+ *
  * Security hooks for filesystem operations.
  *
  * @sb_alloc_security:
@@ -1459,6 +1470,8 @@ union security_list_options {
 	void (*bprm_committing_creds)(struct linux_binprm *bprm);
 	void (*bprm_committed_creds)(struct linux_binprm *bprm);
 
+	int (*fs_context_parse_param)(struct fs_context *fc, struct fs_parameter *param);
+
 	int (*sb_alloc_security)(struct super_block *sb);
 	void (*sb_free_security)(struct super_block *sb);
 	void (*sb_free_mnt_opts)(void *mnt_opts);
@@ -1800,6 +1813,7 @@ struct security_hook_heads {
 	struct hlist_head bprm_check_security;
 	struct hlist_head bprm_committing_creds;
 	struct hlist_head bprm_committed_creds;
+	struct hlist_head fs_context_parse_param;
 	struct hlist_head sb_alloc_security;
 	struct hlist_head sb_free_security;
 	struct hlist_head sb_free_mnt_opts;
diff --git a/include/linux/security.h b/include/linux/security.h
index dbfb5a66babb..1cc4d7a3d6fa 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -53,6 +53,9 @@ struct msg_msg;
 struct xattr;
 struct xfrm_sec_ctx;
 struct mm_struct;
+struct fs_context;
+struct fs_parameter;
+enum fs_value_type;
 
 /* If capable should audit the security request */
 #define SECURITY_CAP_NOAUDIT 0
@@ -220,6 +223,7 @@ int security_bprm_set_creds(struct linux_binprm *bprm);
 int security_bprm_check(struct linux_binprm *bprm);
 void security_bprm_committing_creds(struct linux_binprm *bprm);
 void security_bprm_committed_creds(struct linux_binprm *bprm);
+int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param);
 int security_sb_alloc(struct super_block *sb);
 void security_sb_free(struct super_block *sb);
 void security_free_mnt_opts(void **mnt_opts);
@@ -517,6 +521,12 @@ static inline void security_bprm_committed_creds(struct linux_binprm *bprm)
 {
 }
 
+static inline int security_fs_context_parse_param(struct fs_context *fc,
+						  struct fs_parameter *param)
+{
+	return -ENOPARAM;
+}
+
 static inline int security_sb_alloc(struct super_block *sb)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index f1b8d2587639..e5519488327d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -374,6 +374,11 @@ void security_bprm_committed_creds(struct linux_binprm *bprm)
 	call_void_hook(bprm_committed_creds, bprm);
 }
 
+int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	return call_int_hook(fs_context_parse_param, -ENOPARAM, fc, param);
+}
+
 int security_sb_alloc(struct super_block *sb)
 {
 	return call_int_hook(sb_alloc_security, 0, sb);

