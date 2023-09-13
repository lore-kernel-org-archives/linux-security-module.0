Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578E5EDEC7A
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Sep 2023 15:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbjIMPXp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Sep 2023 11:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbjIMPXl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Sep 2023 11:23:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 281FD1724
        for <linux-security-module@vger.kernel.org>; Wed, 13 Sep 2023 08:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694618570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TIhG5T2KIKMdZjw60PIq0vQttf6HwO/EKV4ZJ8HdZ78=;
        b=C1FOQ2k9WNQeFoapB6Ov7fjtdZFOnkvpemndXQp71XkE5GNgkWXnptvFc4SG2t1I63qXGw
        lIURANhAw42/C/HyEk1pFD5dxog2aMzCaitHhp4caILkMOK3EnyzrpbwW2HiU57u8nmtvz
        Iu2MUDUMAt3O6J4F4zUTbFd8OXWXWFQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-kXq4ehMsMz2RIRYQBeN1jw-1; Wed, 13 Sep 2023 11:22:48 -0400
X-MC-Unique: kXq4ehMsMz2RIRYQBeN1jw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-993eeb3a950so483171666b.2
        for <linux-security-module@vger.kernel.org>; Wed, 13 Sep 2023 08:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694618567; x=1695223367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIhG5T2KIKMdZjw60PIq0vQttf6HwO/EKV4ZJ8HdZ78=;
        b=VGj4SQpq8TXltyfmNUjUKKTvuGZyseiSQbaNZmis96+COhDMGM1PIBXSohkFMIyaZa
         KGSqaKklrtxnCKlrQ18qbA812KQJbpQE4eIdXkn1TAhZjU9uTbyqHp5ZPNf5C5TjkAoT
         od2rc+EqrSRY+RTtf/fd7XKAxS0jYhctGaAXaDOZ9K4L3N7t8u9dUUUO5qg67H0gueNe
         MY1OOmqK1yzX5Ztr1/2kG9dDMQOE2pIxguewYT3QugAuluUUlIvewHRHov7u3xAcuXIR
         Mfr3sgC0wMmVAofpd61vdCvwW0t9SXFE1rxrDbxDOGT82I3YkbxZr3TC2S5WnuDqqJ/C
         thJg==
X-Gm-Message-State: AOJu0YzD5voB9BqSpWUxLAlmmJTWO3/4mosN4Cwoxe3kyyWeocQ4MGC1
        EV/KtnablTQr4YsvdyBOFUfvASL3GGZkb4YaoUdTmXtsj/mrHIatG5sjwapb80Ytorewl6XkRGO
        MTWfLRcGzNbLsLb3Knd+qzixkxHoGo69ztknY
X-Received: by 2002:a17:906:20dd:b0:9a6:5696:388e with SMTP id c29-20020a17090620dd00b009a65696388emr2105314ejc.77.1694618567061;
        Wed, 13 Sep 2023 08:22:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUbVOcJrl/IQ8dCV2GLwgGWT9XogEbtVBr/RtvLl6AfXCidW8q9QonDLUeH+Pc13/vJ+qjnA==
X-Received: by 2002:a17:906:20dd:b0:9a6:5696:388e with SMTP id c29-20020a17090620dd00b009a65696388emr2105305ejc.77.1694618566882;
        Wed, 13 Sep 2023 08:22:46 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (79-120-253-96.pool.digikabel.hu. [79.120.253.96])
        by smtp.gmail.com with ESMTPSA id q18-20020a170906a09200b0099b8234a9fesm8640663ejy.1.2023.09.13.08.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:22:45 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [RFC PATCH 3/3] add listmnt(2) syscall
Date:   Wed, 13 Sep 2023 17:22:36 +0200
Message-ID: <20230913152238.905247-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913152238.905247-1-mszeredi@redhat.com>
References: <20230913152238.905247-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add way to query the children of a particular mount.  This is a more
flexible way to iterate the mount tree than having to parse the complete
/proc/self/mountinfo.

Lookup the mount by the old (32bit) or new (64bit) mount ID.  If a mount
needs to be queried based on path, then statx(2) can be used to first query
the mount ID belonging to the path.

Return an array of new (64bit) mount ID's.  Without privileges only mounts
are listed which are reachable from the task's root.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 fs/namespace.c                         | 51 ++++++++++++++++++++++++++
 include/linux/syscalls.h               |  2 +
 include/uapi/asm-generic/unistd.h      |  5 ++-
 4 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 6d807c30cd16..0d9a47b0ce9b 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -376,6 +376,7 @@
 452	common	fchmodat2		sys_fchmodat2
 453	64	map_shadow_stack	sys_map_shadow_stack
 454	common	statmnt			sys_statmnt
+455	common	listmnt			sys_listmnt
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/fs/namespace.c b/fs/namespace.c
index 088a52043bba..5362b1ffb26f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4988,6 +4988,57 @@ SYSCALL_DEFINE5(statmnt, u64, mnt_id,
 	return err;
 }
 
+static long do_listmnt(struct vfsmount *mnt, u64 __user *buf, size_t bufsize,
+		      const struct path *root)
+{
+	struct mount *r, *m = real_mount(mnt);
+	struct path rootmnt = { .mnt = root->mnt, .dentry = root->mnt->mnt_root };
+	long ctr = 0;
+
+	if (!capable(CAP_SYS_ADMIN) &&
+	    !is_path_reachable(m, mnt->mnt_root, &rootmnt))
+		return -EPERM;
+
+	list_for_each_entry(r, &m->mnt_mounts, mnt_child) {
+		if (!capable(CAP_SYS_ADMIN) &&
+		    !is_path_reachable(r, r->mnt.mnt_root, root))
+			continue;
+
+		if (ctr >= bufsize)
+			return -EOVERFLOW;
+		if (put_user(r->mnt_id_unique, buf + ctr))
+			return -EFAULT;
+		ctr++;
+		if (ctr < 0)
+			return -ERANGE;
+	}
+	return ctr;
+}
+
+SYSCALL_DEFINE4(listmnt, u64, mnt_id, u64 __user *, buf, size_t, bufsize,
+		unsigned int, flags)
+{
+	struct vfsmount *mnt;
+	struct path root;
+	long err;
+
+	if (flags)
+		return -EINVAL;
+
+	down_read(&namespace_sem);
+	mnt = lookup_mnt_in_ns(mnt_id, current->nsproxy->mnt_ns);
+	err = -ENOENT;
+	if (mnt) {
+		get_fs_root(current->fs, &root);
+		err = do_listmnt(mnt, buf, bufsize, &root);
+		path_put(&root);
+	}
+	up_read(&namespace_sem);
+
+	return err;
+}
+
+
 static void __init init_mount_tree(void)
 {
 	struct vfsmount *mnt;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1099bd307fa7..5d776cdb6f18 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -411,6 +411,8 @@ asmlinkage long sys_fstatfs64(unsigned int fd, size_t sz,
 asmlinkage long sys_statmnt(u64 mnt_id, u64 mask,
 			    struct statmnt __user *buf, size_t bufsize,
 			    unsigned int flags);
+asmlinkage long sys_listmnt(u64 mnt_id, u64 __user *buf, size_t bufsize,
+			    unsigned int flags);
 asmlinkage long sys_truncate(const char __user *path, long length);
 asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length);
 #if BITS_PER_LONG == 32
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 640997231ff6..a2b41370f603 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -826,8 +826,11 @@ __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
 #define __NR_statmnt   454
 __SYSCALL(__NR_statmnt, sys_statmnt)
 
+#define __NR_listmnt   455
+__SYSCALL(__NR_listmnt, sys_listmnt)
+
 #undef __NR_syscalls
-#define __NR_syscalls 455
+#define __NR_syscalls 456
 
 /*
  * 32 bit systems traditionally used different
-- 
2.41.0

