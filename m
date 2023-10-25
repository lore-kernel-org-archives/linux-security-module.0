Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73110C0032E
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Oct 2023 14:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbjJYODt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Oct 2023 10:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbjJYODt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Oct 2023 10:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC502186
        for <linux-security-module@vger.kernel.org>; Wed, 25 Oct 2023 07:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698242532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rktb275++autG2dBh3wJ1wvqmgDO3Aq+V8t/EjWFz4M=;
        b=Ps4aFeao8VWfDix9AK2JmVeE0bO9SV+xhXDriQGtPbZNm/lQLPm1ueXp9S9O/TeCYNn8kq
        m9uWXwCSZAie9Xggv5Ok+zcVFNxKvJ7gc8uGBroN3ZbgVgR5RgS81s0nDwk9b9RxUBIThE
        uLFgD5Urfw7V7PgRBxBSWs5XX8aY/MM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-rcBehD-uOCyvQqqporC8nw-1; Wed, 25 Oct 2023 10:02:10 -0400
X-MC-Unique: rcBehD-uOCyvQqqporC8nw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9b274cc9636so356055366b.0
        for <linux-security-module@vger.kernel.org>; Wed, 25 Oct 2023 07:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698242529; x=1698847329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rktb275++autG2dBh3wJ1wvqmgDO3Aq+V8t/EjWFz4M=;
        b=gBQ8rLOxXoIu1YtmLV4Yn3fAKmM7ndvB2FGYxKT8YHlLfWzE5jzSCzJ1DuVq/k/EKa
         Qvhqj+dcRyw1yljMHhHoaUZJZBpFEkjPaTwC3ap/G5UDa7VDgTJRnn34202spkOzqRDB
         BIFIjjG19YueOUTdE69wuwaYE08wxRxmcuvcMGNJ2KVaHdxDGzVEGLh0WanSRPwav8nJ
         8Fu4+idUmBLK4Ag9czPmpnfLIWihoI/IBbgRVEEB+NnLaKGgDPZQWUSHlkcXysIkiRrg
         0w9FQ5tZPL0VHVkyvdBrroHeL9YOuf3mkHxgRkxBSwnOeVPjom8VLn4jJViZMFFxkrjW
         RwWQ==
X-Gm-Message-State: AOJu0YzoPAWLU2tcgDC5M9fWELdWKtAqXFrifpTNOi/IK/jxr20NLFu3
        V1viCXGLFzQoDDG2DnusAPd2B4cBKnu95S2iZ1ybRH/UukYkF+PdkNjJs9+t3g6iE0OuRIR/YBf
        KIUNN1IEWg8D65TtyZPD5jIBzVI16VVw3AXj2
X-Received: by 2002:a17:907:da3:b0:9c6:7ec2:e14e with SMTP id go35-20020a1709070da300b009c67ec2e14emr14335794ejc.50.1698242529020;
        Wed, 25 Oct 2023 07:02:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+8SDOqqdIbWYcTzs6rDMO30AFnhMq2M9Jv3S4dbLlbYvENSTjg76T9Wfx8VJm7Ip4DabhCA==
X-Received: by 2002:a17:907:da3:b0:9c6:7ec2:e14e with SMTP id go35-20020a1709070da300b009c67ec2e14emr14335764ejc.50.1698242528629;
        Wed, 25 Oct 2023 07:02:08 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (92-249-235-200.pool.digikabel.hu. [92.249.235.200])
        by smtp.gmail.com with ESMTPSA id vl9-20020a170907b60900b00989828a42e8sm9857073ejc.154.2023.10.25.07.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:02:08 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 1/6] add unique mount ID
Date:   Wed, 25 Oct 2023 16:01:59 +0200
Message-ID: <20231025140205.3586473-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025140205.3586473-1-mszeredi@redhat.com>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

If a mount is released then its mnt_id can immediately be reused.  This is
bad news for user interfaces that want to uniquely identify a mount.

Implementing a unique mount ID is trivial (use a 64bit counter).
Unfortunately userspace assumes 32bit size and would overflow after the
counter reaches 2^32.

Introduce a new 64bit ID alongside the old one.  Initialize the counter to
2^32, this guarantees that the old and new IDs are never mixed up.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/mount.h                | 3 ++-
 fs/namespace.c            | 4 ++++
 fs/stat.c                 | 9 +++++++--
 include/uapi/linux/stat.h | 1 +
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 130c07c2f8d2..a14f762b3f29 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -72,7 +72,8 @@ struct mount {
 	struct fsnotify_mark_connector __rcu *mnt_fsnotify_marks;
 	__u32 mnt_fsnotify_mask;
 #endif
-	int mnt_id;			/* mount identifier */
+	int mnt_id;			/* mount identifier, reused */
+	u64 mnt_id_unique;		/* mount ID unique until reboot */
 	int mnt_group_id;		/* peer group identifier */
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	struct hlist_head mnt_pins;
diff --git a/fs/namespace.c b/fs/namespace.c
index e157efc54023..e02bc5f41c7b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -68,6 +68,9 @@ static u64 event;
 static DEFINE_IDA(mnt_id_ida);
 static DEFINE_IDA(mnt_group_ida);
 
+/* Don't allow confusion with old 32bit mount ID */
+static atomic64_t mnt_id_ctr = ATOMIC64_INIT(1ULL << 32);
+
 static struct hlist_head *mount_hashtable __read_mostly;
 static struct hlist_head *mountpoint_hashtable __read_mostly;
 static struct kmem_cache *mnt_cache __read_mostly;
@@ -131,6 +134,7 @@ static int mnt_alloc_id(struct mount *mnt)
 	if (res < 0)
 		return res;
 	mnt->mnt_id = res;
+	mnt->mnt_id_unique = atomic64_inc_return(&mnt_id_ctr);
 	return 0;
 }
 
diff --git a/fs/stat.c b/fs/stat.c
index d43a5cc1bfa4..77878ae48a0f 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -243,8 +243,13 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 
 	error = vfs_getattr(&path, stat, request_mask, flags);
 
-	stat->mnt_id = real_mount(path.mnt)->mnt_id;
-	stat->result_mask |= STATX_MNT_ID;
+	if (request_mask & STATX_MNT_ID_UNIQUE) {
+		stat->mnt_id = real_mount(path.mnt)->mnt_id_unique;
+		stat->result_mask |= STATX_MNT_ID_UNIQUE;
+	} else {
+		stat->mnt_id = real_mount(path.mnt)->mnt_id;
+		stat->result_mask |= STATX_MNT_ID;
+	}
 
 	if (path.mnt->mnt_root == path.dentry)
 		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 7cab2c65d3d7..2f2ee82d5517 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -154,6 +154,7 @@ struct statx {
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
 #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
 #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
+#define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
-- 
2.41.0

