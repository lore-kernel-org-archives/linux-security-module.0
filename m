Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C42C0044D
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C809822C9E
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbhASQYj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Jan 2021 11:24:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27320 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731586AbhASQXl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Jan 2021 11:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611073335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2tefehAb/S+Y499xem07UWHiVem08zQonUc+tFyoGtQ=;
        b=eUH3pXh1e5Zb3E3Jocts5JqLPigQQ8bwXiiTL238hxEQeNkHWtUqU3/5POwBCKCjRJlErX
        hf65ZoGaVErMczRIwGD5BaVImwLRQX4S/L19nadEw1KcL2Y/tQgCOwo5wQSMW7mchzx7En
        +RANin7hM1MzpZkL2JicHZN9em22tR8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-j4ISvHZzMdujGQRjgCSHKw-1; Tue, 19 Jan 2021 11:22:13 -0500
X-MC-Unique: j4ISvHZzMdujGQRjgCSHKw-1
Received: by mail-ej1-f72.google.com with SMTP id ox17so4629807ejb.2
        for <linux-security-module@vger.kernel.org>; Tue, 19 Jan 2021 08:22:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2tefehAb/S+Y499xem07UWHiVem08zQonUc+tFyoGtQ=;
        b=a7j4W+U734TAqV+vZm9t01KC6gpeFD21VTvk6QJbqMyK+S2yfYA1v792e6+RMxuDLK
         bEFeLKcaajfTZZ0IFbwjJYFiYpF245Hdq+sfDh2RaxdnGGChrLQyH9TGoNzgRglG+tG/
         e8/MIqbBlQWThjodeea5EJpUFMbpyF6dCSGC8ncK193wUXxNu58hHI68ezbNHTejUM+R
         YFH2UjhJTU/P+KDRYVm3cY7mT2Y9E9DF9XOUIIcvn5JZl0v8rITBrE+MX/7SDOoizhK8
         UkzOlJNacFBsOrmohHR40QSLqla6v/bSHzksEkRSTh2bGC/L2KNhS+GxyceXpfANvOlJ
         Um6A==
X-Gm-Message-State: AOAM533flvmKlSDoEN0fJpeBGsmhUCqv4S6V3Se2FTFi+sXTR/T6M0pK
        cwct+Jm4a6GZgmshkG79hTxOc6bcMmwUxgHhaJbawR0iHuvhNz2Jzbb4hp4Z2ZNOfbqm5RpwI+u
        eHo0BHSN3e/8vCD6jsFSgGTdYluoCYane92WF
X-Received: by 2002:a17:906:28d6:: with SMTP id p22mr3478723ejd.365.1611073332311;
        Tue, 19 Jan 2021 08:22:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfDgUkWdym2Ii227SbfpEBuWbMrSciJxkHOMTpPgqAwLgbdBZ6Oj9XcMQl1tHD2OB0qf91lg==
X-Received: by 2002:a17:906:28d6:: with SMTP id p22mr3478704ejd.365.1611073332109;
        Tue, 19 Jan 2021 08:22:12 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id f22sm2168066eje.34.2021.01.19.08.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:22:10 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>
Subject: [PATCH 2/2] security.capability: fix conversions on getxattr
Date:   Tue, 19 Jan 2021 17:22:04 +0100
Message-Id: <20210119162204.2081137-3-mszeredi@redhat.com>
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

If a capability is stored on disk in v2 format cap_inode_getsecurity() will
currently return in v2 format unconditionally.

This is wrong: v2 cap should be equivalent to a v3 cap with zero rootid,
and so the same conversions performed on it.

If the rootid cannot be mapped v3 is returned unconverted.  Fix this so
that both v2 and v3 return -EOVERFLOW if the rootid (or the owner of the fs
user namespace in case of v2) cannot be mapped in the current user
namespace.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 security/commoncap.c | 67 ++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index bacc1111d871..c9d99f8f4c82 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -371,10 +371,11 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 {
 	int size, ret;
 	kuid_t kroot;
+	__le32 nsmagic, magic;
 	uid_t root, mappedroot;
 	char *tmpbuf = NULL;
 	struct vfs_cap_data *cap;
-	struct vfs_ns_cap_data *nscap;
+	struct vfs_ns_cap_data *nscap = NULL;
 	struct dentry *dentry;
 	struct user_namespace *fs_ns;
 
@@ -396,46 +397,61 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 	fs_ns = inode->i_sb->s_user_ns;
 	cap = (struct vfs_cap_data *) tmpbuf;
 	if (is_v2header((size_t) ret, cap)) {
-		/* If this is sizeof(vfs_cap_data) then we're ok with the
-		 * on-disk value, so return that.  */
-		if (alloc)
-			*buffer = tmpbuf;
-		else
-			kfree(tmpbuf);
-		return ret;
-	} else if (!is_v3header((size_t) ret, cap)) {
-		kfree(tmpbuf);
-		return -EINVAL;
+		root = 0;
+	} else if (is_v3header((size_t) ret, cap)) {
+		nscap = (struct vfs_ns_cap_data *) tmpbuf;
+		root = le32_to_cpu(nscap->rootid);
+	} else {
+		size = -EINVAL;
+		goto out_free;
 	}
 
-	nscap = (struct vfs_ns_cap_data *) tmpbuf;
-	root = le32_to_cpu(nscap->rootid);
 	kroot = make_kuid(fs_ns, root);
 
 	/* If the root kuid maps to a valid uid in current ns, then return
 	 * this as a nscap. */
 	mappedroot = from_kuid(current_user_ns(), kroot);
 	if (mappedroot != (uid_t)-1 && mappedroot != (uid_t)0) {
+		size = sizeof(struct vfs_ns_cap_data);
 		if (alloc) {
-			*buffer = tmpbuf;
+			if (!nscap) {
+				/* v2 -> v3 conversion */
+				nscap = kzalloc(size, GFP_ATOMIC);
+				if (!nscap) {
+					size = -ENOMEM;
+					goto out_free;
+				}
+				nsmagic = VFS_CAP_REVISION_3;
+				magic = le32_to_cpu(cap->magic_etc);
+				if (magic & VFS_CAP_FLAGS_EFFECTIVE)
+					nsmagic |= VFS_CAP_FLAGS_EFFECTIVE;
+				memcpy(&nscap->data, &cap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
+				nscap->magic_etc = cpu_to_le32(nsmagic);
+			} else {
+				/* use allocated v3 buffer */
+				tmpbuf = NULL;
+			}
 			nscap->rootid = cpu_to_le32(mappedroot);
-		} else
-			kfree(tmpbuf);
-		return size;
+			*buffer = nscap;
+		}
+		goto out_free;
 	}
 
 	if (!rootid_owns_currentns(kroot)) {
-		kfree(tmpbuf);
-		return -EOPNOTSUPP;
+		size = -EOVERFLOW;
+		goto out_free;
 	}
 
 	/* This comes from a parent namespace.  Return as a v2 capability */
 	size = sizeof(struct vfs_cap_data);
 	if (alloc) {
-		*buffer = kmalloc(size, GFP_ATOMIC);
-		if (*buffer) {
-			struct vfs_cap_data *cap = *buffer;
-			__le32 nsmagic, magic;
+		if (nscap) {
+			/* v3 -> v2 conversion */
+			cap = kzalloc(size, GFP_ATOMIC);
+			if (!cap) {
+				size = -ENOMEM;
+				goto out_free;
+			}
 			magic = VFS_CAP_REVISION_2;
 			nsmagic = le32_to_cpu(nscap->magic_etc);
 			if (nsmagic & VFS_CAP_FLAGS_EFFECTIVE)
@@ -443,9 +459,12 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 			memcpy(&cap->data, &nscap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
 			cap->magic_etc = cpu_to_le32(magic);
 		} else {
-			size = -ENOMEM;
+			/* use unconverted v2 */
+			tmpbuf = NULL;
 		}
+		*buffer = cap;
 	}
+out_free:
 	kfree(tmpbuf);
 	return size;
 }
-- 
2.26.2

