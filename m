Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D271EB64DD
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Aug 2023 17:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbjHCROb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 3 Aug 2023 13:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbjHCRO2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Aug 2023 13:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C193C38
        for <linux-security-module@vger.kernel.org>; Thu,  3 Aug 2023 10:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691082819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NwboMpndKcSVwHb15bn2zb0MUP8wKG5ZpPY0Hw7kAC8=;
        b=GEEhkYhiRQNXL9BgUR0kbbmjV9dKKQx7ZVc/FaQZFS2Oft2bpYhYxiW7rq9oeSfc6yQtM8
        HJqgWjzeVKXBzRJvReOPf1HdQtwvDufEcb8481DR6K6fq8IiuatpppMMyBwrF3jATjfDZh
        BLVi40kr4p9le33V2BM10P7sv3PvSYI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-JrasZZNjM3mDGgFrfS1szg-1; Thu, 03 Aug 2023 13:13:33 -0400
X-MC-Unique: JrasZZNjM3mDGgFrfS1szg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1CD83C0C4A9;
        Thu,  3 Aug 2023 17:13:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 657C9200C0EF;
        Thu,  3 Aug 2023 17:13:21 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     linux-security-module@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH RFC 2/3] security: two more call_int_hook_ignore_default use-cases
Date:   Thu,  3 Aug 2023 19:12:41 +0200
Message-ID: <d48c8c4f84acac7536b8b48e44574c81a96e5cdc.1691082677.git.pabeni@redhat.com>
In-Reply-To: <cover.1691082677.git.pabeni@redhat.com>
References: <cover.1691082677.git.pabeni@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Quite similar to the previous commit, the hooks:

inode_setxattr
inode_removexattr

don't allow the LSM to tell the core to ignore it's return code.
The main difference it that the above mentioned hooks explicitly check
for a non zero return value from the hook to perform the default action.

Changing the LSM_RET_DEFAULT to 1 and using call_int_hook_ignore_default
allows LSM returning the LSM_RET_DEFAULT value will become no-op for the
mentioned hooks.

All the exiting LSM except BPF never use 1 as return value, so no
functional change is expected.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/lsm_hook_defs.h | 4 ++--
 security/security.c           | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index c9032e20d0b3..49f1f9bed958 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -136,14 +136,14 @@ LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inode *inode,
 LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
 LSM_HOOK(int, 0, inode_setattr, struct dentry *dentry, struct iattr *attr)
 LSM_HOOK(int, 0, inode_getattr, const struct path *path)
-LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
+LSM_HOOK(int, 1, inode_setxattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name, const void *value,
 	 size_t size, int flags)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_setxattr, struct dentry *dentry,
 	 const char *name, const void *value, size_t size, int flags)
 LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
 LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
+LSM_HOOK(int, 1, inode_removexattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name)
 LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
diff --git a/security/security.c b/security/security.c
index b9a7b15e269e..0528cbef0624 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2158,8 +2158,8 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
 	 * SELinux and Smack integrate the cap call,
 	 * so assume that all LSMs supplying this call do so.
 	 */
-	ret = call_int_hook(inode_setxattr, 1, idmap, dentry, name, value,
-			    size, flags);
+	ret = call_int_hook_ignore_default(inode_setxattr, 1, idmap, dentry, name,
+					   value, size, flags);
 
 	if (ret == 1)
 		ret = cap_inode_setxattr(dentry, name, value, size, flags);
@@ -2321,7 +2321,8 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
 	 * SELinux and Smack integrate the cap call,
 	 * so assume that all LSMs supplying this call do so.
 	 */
-	ret = call_int_hook(inode_removexattr, 1, idmap, dentry, name);
+	ret = call_int_hook_ignore_default(inode_removexattr, 1, idmap, dentry,
+					   name);
 	if (ret == 1)
 		ret = cap_inode_removexattr(idmap, dentry, name);
 	if (ret)
-- 
2.41.0

