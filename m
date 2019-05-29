Return-Path: <SRS0=daWi=T5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419D0C04AB3
	for <linux-security-module@archiver.kernel.org>; Wed, 29 May 2019 03:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E5E21721
	for <linux-security-module@archiver.kernel.org>; Wed, 29 May 2019 03:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpTMAoXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfE2Dio (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 28 May 2019 23:38:44 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46980 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfE2Dio (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 May 2019 23:38:44 -0400
Received: by mail-qt1-f194.google.com with SMTP id z19so849277qtz.13
        for <linux-security-module@vger.kernel.org>; Tue, 28 May 2019 20:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=zg5iad9+ttaKx7RIvzbdvPSvLP46c3oHIiVSbPrBq1U=;
        b=JpTMAoXX9MvPMLijRuGJAclskBtActKW/aH4s/6fQCBZsibxfCc/Ai9xjnFoz+ZOwF
         kjf11mTP/DVeXfHbx3sJ4li2Y7BnGxPXUTws9dkguawzQk/nnDytIlc2Pl4L+oLahS9S
         0bL9oGcn4R8FyVKSdT81stSyl0l29Cqo/y6eEwkdOi/oJXoivLkTY694lZiziL6OWOCI
         2UCO+jl6ggX5TM4l27ydIw/b80Nk9AxAYGQkorJkRxpkhVhKN1SW387yNrubXV1PvUXU
         w/f/NgGV9EqDN62nqChLn8S2MkxSXb3y4/nm2BiNL/KLLEyLzK/ZcPf7cY8WeycCTnyD
         kiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=zg5iad9+ttaKx7RIvzbdvPSvLP46c3oHIiVSbPrBq1U=;
        b=Z+EeOymqosD2ASrvW5O+hhLttRPjXTrBglBwWU6oNN2/VjQ6ffwTdpHvL9cEGiMBcK
         DkXVsQbraWfMwLlGHLHqXEMjYNtj6J0gmhSRFVt62ZQniE2Wq50dhINn0ufgwDiX2aaL
         c6LCHgldw18j6hu/3dRnhr5j1D6EC65+0au9r6dYVhikIUgLoW5+XjXAnlLecVl7Ny4w
         RClEp/9QKhfyi2RxQG2bRiFsksaNTxHuK0TaMu1My4Dsw841TT7UdrEH451NH9o9j3Mh
         h7lZi0IuOQx72oACwz5r3LsfgvQ/Abfo+u0FmCMxkoego/v24FzRxmYGGpc+i2szqSVe
         4hqg==
X-Gm-Message-State: APjAAAVtJ9wZkKCR+re9Uz/wnvN22S1SiK9QMt1u1R+jv570r3flOyJ0
        np/fsZ+KaDbxLtrZIMnyxKbfErK4gv4W9gyk7svsksIa
X-Google-Smtp-Source: APXvYqwGicJWLnEQ3Q9LhUZNTj0rqu2+cOJ4lViDnnCeMud/AnAPLHMbtFzEyG8XCWg9vJEHYcimxg+0JNFOj3m/778=
X-Received: by 2002:ac8:32e9:: with SMTP id a38mr8197087qtb.245.1559101122712;
 Tue, 28 May 2019 20:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190527110702.3962-1-zyan@redhat.com> <20190527110702.3962-2-zyan@redhat.com>
In-Reply-To: <20190527110702.3962-2-zyan@redhat.com>
From:   "Yan, Zheng" <ukernel@gmail.com>
Date:   Wed, 29 May 2019 11:38:31 +0800
Message-ID: <CAAM7YAmePc=13YU77PExAmbpy5dYGBY9JsntkDG2+iXpdSuJZQ@mail.gmail.com>
Subject: Fwd: [PATCH 2/2] ceph: add selinux support
To:     LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

---------- Forwarded message ---------
From: Yan, Zheng <zyan@redhat.com>
Date: Mon, May 27, 2019 at 7:11 PM
Subject: [PATCH 2/2] ceph: add selinux support
To: <ceph-devel@vger.kernel.org>
Cc: <idryomov@redhat.com>, <jlayton@redhat.com>, Yan, Zheng <zyan@redhat.com>


When creating new file/directory, uses dentry_init_security() to prepare
selinux context for the new inode, then sends openc/mkdir request to MDS,
together with selinux xattr.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/Kconfig |  12 +++++
 fs/ceph/caps.c  |   1 +
 fs/ceph/dir.c   |  12 +++++
 fs/ceph/file.c  |   3 ++
 fs/ceph/inode.c |   1 +
 fs/ceph/super.h |  19 +++++++
 fs/ceph/xattr.c | 141 ++++++++++++++++++++++++++++++++++++++++++------
 7 files changed, 172 insertions(+), 17 deletions(-)

diff --git a/fs/ceph/Kconfig b/fs/ceph/Kconfig
index 52095f473464..5a665c126a7c 100644
--- a/fs/ceph/Kconfig
+++ b/fs/ceph/Kconfig
@@ -35,3 +35,15 @@ config CEPH_FS_POSIX_ACL
          groups beyond the owner/group/world scheme.

          If you don't know what Access Control Lists are, say N
+
+config CEPH_FS_SECURITY_LABEL
+       bool "CephFS Security Labels"
+       depends on CEPH_FS && SECURITY
+       help
+         Security labels support alternative access control models
+         implemented by security modules like SELinux. This option
+         enables an extended attribute handler for file security
+         labels in the Ceph filesystem.
+
+         If you are not using a security module that requires using
+         extended attributes for file security labels, say N.
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 7754d7679122..50409d9fdc90 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3156,6 +3156,7 @@ static void handle_cap_grant(struct inode *inode,
                        ci->i_xattrs.blob = ceph_buffer_get(xattr_buf);
                        ci->i_xattrs.version = version;
                        ceph_forget_all_cached_acls(inode);
+                       ceph_security_invalidate_secctx(inode);
                }
        }

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 14d795e5fa73..b282d076dc9e 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -839,6 +839,9 @@ static int ceph_mknod(struct inode *dir, struct
dentry *dentry,
        err = ceph_pre_init_acls(dir, &mode, &as_ctx);
        if (err < 0)
                goto out;
+       err = ceph_security_init_secctx(dentry, mode, &as_ctx);
+       if (err < 0)
+              goto out;

        dout("mknod in dir %p dentry %p mode 0%ho rdev %d\n",
             dir, dentry, mode, rdev);
@@ -884,6 +887,7 @@ static int ceph_symlink(struct inode *dir, struct
dentry *dentry,
        struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
        struct ceph_mds_client *mdsc = fsc->mdsc;
        struct ceph_mds_request *req;
+       struct ceph_acl_sec_ctx as_ctx = {};
        int err;

        if (ceph_snap(dir) != CEPH_NOSNAP)
@@ -894,6 +898,10 @@ static int ceph_symlink(struct inode *dir, struct
dentry *dentry,
                goto out;
        }

+       err = ceph_security_init_secctx(dentry, S_IFLNK | S_IRWXUGO, &as_ctx);
+       if (err < 0)
+              goto out;
+
        dout("symlink in dir %p dentry %p to '%s'\n", dir, dentry, dest);
        req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_SYMLINK, USE_AUTH_MDS);
        if (IS_ERR(req)) {
@@ -919,6 +927,7 @@ static int ceph_symlink(struct inode *dir, struct
dentry *dentry,
 out:
        if (err)
                d_drop(dentry);
+       ceph_release_acl_sec_ctx(&as_ctx);
        return err;
 }

@@ -953,6 +962,9 @@ static int ceph_mkdir(struct inode *dir, struct
dentry *dentry, umode_t mode)
        err = ceph_pre_init_acls(dir, &mode, &as_ctx);
        if (err < 0)
                goto out;
+       err = ceph_security_init_secctx(dentry, mode, &as_ctx);
+       if (err < 0)
+              goto out;

        req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
        if (IS_ERR(req)) {
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5975345753d7..a7080783fe20 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -453,6 +453,9 @@ int ceph_atomic_open(struct inode *dir, struct
dentry *dentry,
                err = ceph_pre_init_acls(dir, &mode, &as_ctx);
                if (err < 0)
                        return err;
+               err = ceph_security_init_secctx(dentry, mode, &as_ctx);
+               if (err < 0)
+                       goto out_ctx;
        }

        /* do the open */
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 30d0cdc21035..125ac54b5841 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -891,6 +891,7 @@ static int fill_inode(struct inode *inode, struct
page *locked_page,
                               iinfo->xattr_data, iinfo->xattr_len);
                ci->i_xattrs.version = le64_to_cpu(info->xattr_version);
                ceph_forget_all_cached_acls(inode);
+               ceph_security_invalidate_secctx(inode);
                xattr_blob = NULL;
        }

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index d7520ccf27e9..9c82d213a5ab 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -932,6 +932,10 @@ struct ceph_acl_sec_ctx {
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
        void *default_acl;
        void *acl;
+#endif
+#ifdef CONFIG_CEPH_FS_SECURITY_LABEL
+       void *sec_ctx;
+       u32 sec_ctxlen;
 #endif
        struct ceph_pagelist *pagelist;
 };
@@ -950,6 +954,21 @@ static inline bool
ceph_security_xattr_wanted(struct inode *in)
 }
 #endif

+#ifdef CONFIG_CEPH_FS_SECURITY_LABEL
+extern int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
+                                    struct ceph_acl_sec_ctx *ctx);
+extern void ceph_security_invalidate_secctx(struct inode *inode);
+#else
+static inline int ceph_security_init_secctx(struct dentry *dentry,
umode_t mode,
+                                           struct ceph_acl_sec_ctx *ctx)
+{
+       return 0;
+}
+static inline void ceph_security_invalidate_secctx(struct inode *inode)
+{
+}
+#endif
+
 void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx);

 /* acl.c */
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 518a5beed58c..fea70696f375 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -8,6 +8,7 @@
 #include <linux/ceph/decode.h>

 #include <linux/xattr.h>
+#include <linux/security.h>
 #include <linux/posix_acl_xattr.h>
 #include <linux/slab.h>

@@ -17,26 +18,9 @@
 static int __remove_xattr(struct ceph_inode_info *ci,
                          struct ceph_inode_xattr *xattr);

-static const struct xattr_handler ceph_other_xattr_handler;
-
-/*
- * List of handlers for synthetic system.* attributes. Other
- * attributes are handled directly.
- */
-const struct xattr_handler *ceph_xattr_handlers[] = {
-#ifdef CONFIG_CEPH_FS_POSIX_ACL
-       &posix_acl_access_xattr_handler,
-       &posix_acl_default_xattr_handler,
-#endif
-       &ceph_other_xattr_handler,
-       NULL,
-};
-
 static bool ceph_is_valid_xattr(const char *name)
 {
        return !strncmp(name, XATTR_CEPH_PREFIX, XATTR_CEPH_PREFIX_LEN) ||
-              !strncmp(name, XATTR_SECURITY_PREFIX,
-                       XATTR_SECURITY_PREFIX_LEN) ||
               !strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN) ||
               !strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN);
 }
@@ -1196,6 +1180,110 @@ bool ceph_security_xattr_deadlock(struct inode *in)
        spin_unlock(&ci->i_ceph_lock);
        return ret;
 }
+
+#ifdef CONFIG_CEPH_FS_SECURITY_LABEL
+int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
+                          struct ceph_acl_sec_ctx *as_ctx)
+{
+       struct ceph_pagelist *pagelist = as_ctx->pagelist;
+       const char *name;
+       size_t name_len;
+       int err;
+
+       err = security_dentry_init_security(dentry, mode, &dentry->d_name,
+                                           &as_ctx->sec_ctx,
+                                           &as_ctx->sec_ctxlen);
+       if (err < 0) {
+               err = 0; /* do nothing */
+               goto out;
+       }
+
+       err = -ENOMEM;
+       if (!pagelist) {
+               pagelist = ceph_pagelist_alloc(GFP_KERNEL);
+               if (!pagelist)
+                       goto out;
+               err = ceph_pagelist_reserve(pagelist, PAGE_SIZE);
+               if (err)
+                       goto out;
+               ceph_pagelist_encode_32(pagelist, 1);
+       }
+
+       /*
+        * FIXME: Make security_dentry_init_security() generic. Currently
+        * It only supports single security module and only selinux has
+        * dentry_init_security hook.
+        */
+       name = XATTR_NAME_SELINUX;
+       name_len = strlen(name);
+       err = ceph_pagelist_reserve(pagelist,
+                                   4 * 2 + name_len + as_ctx->sec_ctxlen);
+       if (err)
+               goto out;
+
+       if (as_ctx->pagelist) {
+               /* update count of KV pairs */
+               BUG_ON(pagelist->length <= sizeof(__le32));
+               if (list_is_singular(&pagelist->head)) {
+                       le32_add_cpu((__le32*)pagelist->mapped_tail, 1);
+               } else {
+                       struct page *page = list_first_entry(&pagelist->head,
+                                                            struct page, lru);
+                       void *addr = kmap_atomic(page);
+                       le32_add_cpu((__le32*)addr, 1);
+                       kunmap_atomic(addr);
+               }
+       } else {
+               as_ctx->pagelist = pagelist;
+       }
+
+       ceph_pagelist_encode_32(pagelist, name_len);
+       ceph_pagelist_append(pagelist, name, name_len);
+
+       ceph_pagelist_encode_32(pagelist, as_ctx->sec_ctxlen);
+       ceph_pagelist_append(pagelist, as_ctx->sec_ctx, as_ctx->sec_ctxlen);
+
+       err = 0;
+out:
+       if (pagelist && !as_ctx->pagelist)
+               ceph_pagelist_release(pagelist);
+       return err;
+}
+
+void ceph_security_invalidate_secctx(struct inode *inode)
+{
+       security_inode_invalidate_secctx(inode);
+}
+
+static int ceph_xattr_set_security_label(const struct xattr_handler *handler,
+                                   struct dentry *unused, struct inode *inode,
+                                   const char *key, const void *buf,
+                                   size_t buflen, int flags)
+{
+       if (security_ismaclabel(key)) {
+               const char *name = xattr_full_name(handler, key);
+               return __ceph_setxattr(inode, name, buf, buflen, flags);
+       }
+       return  -EOPNOTSUPP;
+}
+
+static int ceph_xattr_get_security_label(const struct xattr_handler *handler,
+                                   struct dentry *unused, struct inode *inode,
+                                   const char *key, void *buf, size_t buflen)
+{
+        if (security_ismaclabel(key)) {
+               const char *name = xattr_full_name(handler, key);
+               return __ceph_getxattr(inode, name, buf, buflen);
+       }
+       return  -EOPNOTSUPP;
+}
+
+static const struct xattr_handler ceph_security_label_handler = {
+        .prefix = XATTR_SECURITY_PREFIX,
+        .get    = ceph_xattr_get_security_label,
+        .set    = ceph_xattr_set_security_label,
+};
+#endif
 #endif

 void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
@@ -1203,7 +1291,26 @@ void ceph_release_acl_sec_ctx(struct
ceph_acl_sec_ctx *as_ctx)
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
        posix_acl_release(as_ctx->acl);
        posix_acl_release(as_ctx->default_acl);
+#endif
+#ifdef CONFIG_CEPH_FS_SECURITY_LABEL
+       security_release_secctx(as_ctx->sec_ctx, as_ctx->sec_ctxlen);
 #endif
        if (as_ctx->pagelist)
                ceph_pagelist_release(as_ctx->pagelist);
 }
+
+/*
+ * List of handlers for synthetic system.* attributes. Other
+ * attributes are handled directly.
+ */
+const struct xattr_handler *ceph_xattr_handlers[] = {
+#ifdef CONFIG_CEPH_FS_POSIX_ACL
+       &posix_acl_access_xattr_handler,
+       &posix_acl_default_xattr_handler,
+#endif
+#ifdef CONFIG_CEPH_FS_SECURITY_LABEL
+       &ceph_security_label_handler,
+#endif
+       &ceph_other_xattr_handler,
+       NULL,
+};
--
2.17.2
