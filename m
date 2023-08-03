Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8259AEB64DD
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Aug 2023 17:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbjHCROP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 3 Aug 2023 13:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbjHCROL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Aug 2023 13:14:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C2E3C16
        for <linux-security-module@vger.kernel.org>; Thu,  3 Aug 2023 10:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691082804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YiA6TsqHwe73wZwOUb7qdSWZF8mWFolXm7MMmc8GrsI=;
        b=FnQ+eOOSv0L7dFEr0eng2vPgD/CxTuEqA/LRsE8tO+yc7hflzqDgMS3nduLuKej2xxODfI
        oBJNTeO8+KlsLx74rPIXM0Am3PDY85WCqh09qWrYu8H4ohnnP7ZlmF7X87cazqkLApT61F
        BSnA35qJ2QK/WTg2a6IQ0JvAYQPoLlM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-JDFrQwn0Pya9QVAi0XjWhw-1; Thu, 03 Aug 2023 13:13:21 -0400
X-MC-Unique: JDFrQwn0Pya9QVAi0XjWhw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C3518DC664;
        Thu,  3 Aug 2023 17:13:21 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB5C2200A7CA;
        Thu,  3 Aug 2023 17:13:18 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     linux-security-module@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH RFC 1/3] security: introduce and use call_int_hook_ignore_default()
Date:   Thu,  3 Aug 2023 19:12:40 +0200
Message-ID: <7bfe86eb0a0e3ec15af0a93c329d2aca72fb0bdc.1691082677.git.pabeni@redhat.com>
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

The following hooks currently don't allow the LSM module to tell the
core to ignore its return code:

sb_set_mnt_opts
inode_init_security
inode_getsecctx
socket_getpeersec_stream
socket_getpeersec_dgram

because the return value for the security function when no LSMs are
loaded is non zero, and LSMs use the current LSM_RET_DEFAULT() (zero)
to represent "success".

Introduce a new variant of the call_int_hook() macros the explicitly
ignores the return code from the LSM when equal to LSM_RET_DEFAULT,
use it for the above hooks, and change the default to 1.

All the exiting LSM except BPF don't use such return value, so no
functional change is expected.

After this change, LSM returning the LSM_RET_DEFAULT value will become
a no-op for the mentioned hooks.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/lsm_hook_defs.h | 10 ++++-----
 security/security.c           | 42 ++++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 4f2621e87634..c9032e20d0b3 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -73,7 +73,7 @@ LSM_HOOK(int, 0, sb_mount, const char *dev_name, const struct path *path,
 LSM_HOOK(int, 0, sb_umount, struct vfsmount *mnt, int flags)
 LSM_HOOK(int, 0, sb_pivotroot, const struct path *old_path,
 	 const struct path *new_path)
-LSM_HOOK(int, 0, sb_set_mnt_opts, struct super_block *sb, void *mnt_opts,
+LSM_HOOK(int, 1, sb_set_mnt_opts, struct super_block *sb, void *mnt_opts,
 	 unsigned long kern_flags, unsigned long *set_kern_flags)
 LSM_HOOK(int, 0, sb_clone_mnt_opts, const struct super_block *oldsb,
 	 struct super_block *newsb, unsigned long kern_flags,
@@ -111,7 +111,7 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
 	 unsigned int obj_type)
 LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
 LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
-LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
+LSM_HOOK(int, 1, inode_init_security, struct inode *inode,
 	 struct inode *dir, const struct qstr *qstr, const char **name,
 	 void **value, size_t *len)
 LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
@@ -272,7 +272,7 @@ LSM_HOOK(void, LSM_RET_VOID, release_secctx, char *secdata, u32 seclen)
 LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
 LSM_HOOK(int, 0, inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen)
 LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen)
-LSM_HOOK(int, 0, inode_getsecctx, struct inode *inode, void **ctx,
+LSM_HOOK(int, 1, inode_getsecctx, struct inode *inode, void **ctx,
 	 u32 *ctxlen)
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
@@ -308,9 +308,9 @@ LSM_HOOK(int, 0, socket_getsockopt, struct socket *sock, int level, int optname)
 LSM_HOOK(int, 0, socket_setsockopt, struct socket *sock, int level, int optname)
 LSM_HOOK(int, 0, socket_shutdown, struct socket *sock, int how)
 LSM_HOOK(int, 0, socket_sock_rcv_skb, struct sock *sk, struct sk_buff *skb)
-LSM_HOOK(int, 0, socket_getpeersec_stream, struct socket *sock,
+LSM_HOOK(int, 1, socket_getpeersec_stream, struct socket *sock,
 	 sockptr_t optval, sockptr_t optlen, unsigned int len)
-LSM_HOOK(int, 0, socket_getpeersec_dgram, struct socket *sock,
+LSM_HOOK(int, 1, socket_getpeersec_dgram, struct socket *sock,
 	 struct sk_buff *skb, u32 *secid)
 LSM_HOOK(int, 0, sk_alloc_security, struct sock *sk, int family, gfp_t priority)
 LSM_HOOK(void, LSM_RET_VOID, sk_free_security, struct sock *sk)
diff --git a/security/security.c b/security/security.c
index 2dfc7b9f6ed9..b9a7b15e269e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -784,6 +784,23 @@ static int lsm_superblock_alloc(struct super_block *sb)
 	RC;							\
 })
 
+#define call_int_hook_ignore_default(FUNC, IRC, ...) ({		\
+	int TRC, RC = IRC;					\
+	do {							\
+		struct security_hook_list *P;			\
+								\
+		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
+			TRC = P->hook.FUNC(__VA_ARGS__);	\
+			if (TRC != LSM_RET_DEFAULT(FUNC))	\
+				continue;			\
+			RC = TRC;				\
+			if (RC != 0)				\
+				break;				\
+		}						\
+	} while (0);						\
+	RC;							\
+})
+
 /* Security operations */
 
 /**
@@ -1405,9 +1422,9 @@ int security_sb_set_mnt_opts(struct super_block *sb,
 			     unsigned long kern_flags,
 			     unsigned long *set_kern_flags)
 {
-	return call_int_hook(sb_set_mnt_opts,
-			     mnt_opts ? -EOPNOTSUPP : 0, sb,
-			     mnt_opts, kern_flags, set_kern_flags);
+	return call_int_hook_ignore_default(sb_set_mnt_opts,
+					    mnt_opts ? -EOPNOTSUPP : 0, sb,
+					    mnt_opts, kern_flags, set_kern_flags);
 }
 EXPORT_SYMBOL(security_sb_set_mnt_opts);
 
@@ -1612,11 +1629,13 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 		return 0;
 
 	if (!initxattrs)
-		return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
-				     dir, qstr, NULL, NULL, NULL);
+		return call_int_hook_ignore_default(inode_init_security,
+						    -EOPNOTSUPP, inode, dir,
+						    qstr, NULL, NULL, NULL);
 	memset(new_xattrs, 0, sizeof(new_xattrs));
 	lsm_xattr = new_xattrs;
-	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
+	ret = call_int_hook_ignore_default(inode_init_security, -EOPNOTSUPP,
+			    inode, dir, qstr,
 			    &lsm_xattr->name,
 			    &lsm_xattr->value,
 			    &lsm_xattr->value_len);
@@ -3973,7 +3992,8 @@ EXPORT_SYMBOL(security_inode_setsecctx);
  */
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 {
-	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ctxlen);
+	return call_int_hook_ignore_default(inode_getsecctx, -EOPNOTSUPP, inode,
+					    ctx, ctxlen);
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
@@ -4330,8 +4350,8 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
 				      sockptr_t optlen, unsigned int len)
 {
-	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
-			     optval, optlen, len);
+	return call_int_hook_ignore_default(socket_getpeersec_stream, -ENOPROTOOPT,
+					    sock, optval, optlen, len);
 }
 
 /**
@@ -4351,8 +4371,8 @@ int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
 int security_socket_getpeersec_dgram(struct socket *sock,
 				     struct sk_buff *skb, u32 *secid)
 {
-	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
-			     skb, secid);
+	return call_int_hook_ignore_default(socket_getpeersec_dgram, -ENOPROTOOPT,
+					    sock, skb, secid);
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
-- 
2.41.0

