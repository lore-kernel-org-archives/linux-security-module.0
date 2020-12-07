Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F310C0018C
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Dec 2020 16:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D647F238E8
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Dec 2020 16:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgLGQee (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Dec 2020 11:34:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34738 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727685AbgLGQed (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wrGV7hqd0sY6Ndza0dri1YXg1lEmApvh0CGfKm2LK30=;
        b=FmO1iiLFgEBHI4OcONPXghQKl2A+ulevuWOeC0cq/5BhuYgEyUUPArObSz4lKpUlamlnNj
        ZmNpq0hbeACegyfQdkF7AHiwGYbcx+zlry2T5AjoM+HP7/za+UQcJ6+uu/FHkVQ+X5uw6i
        nhLy8ffpcfyjSjDVIiMvCfnjwaDbfbk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-K9FKU42NMyCZdirj6UtyyA-1; Mon, 07 Dec 2020 11:33:02 -0500
X-MC-Unique: K9FKU42NMyCZdirj6UtyyA-1
Received: by mail-ej1-f71.google.com with SMTP id n17so4051704eja.23
        for <linux-security-module@vger.kernel.org>; Mon, 07 Dec 2020 08:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wrGV7hqd0sY6Ndza0dri1YXg1lEmApvh0CGfKm2LK30=;
        b=l/wY4u2evm5X9e3H9TgUuBGQB7diL7iK+QLxR2+GWAInAeNoHg8Nx3gGb4CQeDrkbl
         affBNgwcuE2EzmnQSTmc17uVst5QQmCQQgrbnfG0ecrjD7o3S7b+ZDUMNHMhd/hFjmqd
         PbwNmaX1uGqZw7JFvl2hbs+WVf7+ErlXdhMUwXsE2QgPQgKlUReIyLWzUtEZCmyAcBng
         ob6zhQAXAQtUTaslf6o8ehJXgDNf74Ushgl+3M1H+ofGUXRZ5FTANnIxkh/wNKlNCvWJ
         h1yl+77OfHeiWi84kd6lXOgHYj78D6ZOc9XmrjlaBPWgWTHWmkXmfbE54rIMoCQ10Q5/
         ofvQ==
X-Gm-Message-State: AOAM530GnbfjDe0F9BGoBFTUbp1Cee9rNm1j1WUeN0kfyhWE2ii/HGvf
        fdGx0UXZ8e7ALb1ImYSxH15HCbOWO90kOalNjU34TAxn8fvhvL5aQCj2trdgWmxY4FK8g7oPLS9
        Lqoy0uBWNoLYitIuEPWIpcgT+9SsSLN098kaX
X-Received: by 2002:a50:a694:: with SMTP id e20mr20629150edc.261.1607358781219;
        Mon, 07 Dec 2020 08:33:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzacwDTqVI9lhkLtXTTX/Z6WL5s00t1gChOyqFQ1tlVS8dmeqyNuXCDk11RK7mg8BFu3gh98Q==
X-Received: by 2002:a50:a694:: with SMTP id e20mr20629136edc.261.1607358781059;
        Mon, 07 Dec 2020 08:33:01 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:00 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/10] vfs: move cap_convert_nscap() call into vfs_setxattr()
Date:   Mon,  7 Dec 2020 17:32:46 +0100
Message-Id: <20201207163255.564116-2-mszeredi@redhat.com>
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

cap_convert_nscap() does permission checking as well as conversion of the
xattr value conditionally based on fs's user-ns.

This is needed by overlayfs and probably other layered fs (ecryptfs) and is
what vfs_foo() is supposed to do anyway.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/xattr.c                 | 17 +++++++++++------
 include/linux/capability.h |  2 +-
 security/commoncap.c       |  3 +--
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index cd7a563e8bcd..fd57153b1f61 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -276,8 +276,16 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 {
 	struct inode *inode = dentry->d_inode;
 	struct inode *delegated_inode = NULL;
+	const void  *orig_value = value;
 	int error;
 
+	if (size && strcmp(name, XATTR_NAME_CAPS) == 0) {
+		error = cap_convert_nscap(dentry, &value, size);
+		if (error < 0)
+			return error;
+		size = error;
+	}
+
 retry_deleg:
 	inode_lock(inode);
 	error = __vfs_setxattr_locked(dentry, name, value, size, flags,
@@ -289,6 +297,9 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 		if (!error)
 			goto retry_deleg;
 	}
+	if (value != orig_value)
+		kfree(value);
+
 	return error;
 }
 EXPORT_SYMBOL_GPL(vfs_setxattr);
@@ -537,12 +548,6 @@ setxattr(struct dentry *d, const char __user *name, const void __user *value,
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
 			posix_acl_fix_xattr_from_user(kvalue, size);
-		else if (strcmp(kname, XATTR_NAME_CAPS) == 0) {
-			error = cap_convert_nscap(d, &kvalue, size);
-			if (error < 0)
-				goto out;
-			size = error;
-		}
 	}
 
 	error = vfs_setxattr(d, kname, kvalue, size, flags);
diff --git a/include/linux/capability.h b/include/linux/capability.h
index 1e7fe311cabe..b2f698915c0f 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -270,6 +270,6 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 /* audit system wants to get cap info from files as well */
 extern int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data *cpu_caps);
 
-extern int cap_convert_nscap(struct dentry *dentry, void **ivalue, size_t size);
+extern int cap_convert_nscap(struct dentry *dentry, const void **ivalue, size_t size);
 
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/security/commoncap.c b/security/commoncap.c
index 59bf3c1674c8..bacc1111d871 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -473,7 +473,7 @@ static bool validheader(size_t size, const struct vfs_cap_data *cap)
  *
  * If all is ok, we return the new size, on error return < 0.
  */
-int cap_convert_nscap(struct dentry *dentry, void **ivalue, size_t size)
+int cap_convert_nscap(struct dentry *dentry, const void **ivalue, size_t size)
 {
 	struct vfs_ns_cap_data *nscap;
 	uid_t nsrootid;
@@ -516,7 +516,6 @@ int cap_convert_nscap(struct dentry *dentry, void **ivalue, size_t size)
 	nscap->magic_etc = cpu_to_le32(nsmagic);
 	memcpy(&nscap->data, &cap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
 
-	kvfree(*ivalue);
 	*ivalue = nscap;
 	return newsize;
 }
-- 
2.26.2

