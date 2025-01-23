Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B0C1B86D5
	for <linux-security-module@vger.kernel.org>; Thu, 23 Jan 2025 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661281; cv=none; b=fSxZcqPF/r1R4kJZVUK0SG99NCjQoeRQXsFf6Izjo1znKjLIWjceAbiPKA93jQzeGsz2rzqBV9pPsab1KV7BMEbDCqnbZa23q34D8UszkugxG//x4/MRMxWv97QVQL5WDeQaAlabGwrEJO2hi5DNEVj00PPIiYijlZOG7rSL5bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661281; c=relaxed/simple;
	bh=8Rex1jue2v4oXkNDV+SsESvmvUW9hToBize8zaIzoh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Akf6WbE8HaTMDfwNi3aRyyoWgRLddv3mRTq6BoWk31YUcpeMkLWQ/WNLK3bQMmwAr61pwycwz71XC4kcazg4/L24F4aqtRt3Mxl0Lmy48VyeAAOh2rixtbg/sARMHmtvIXAA3EoBbQzs7hZxZwAfU+VJ3x7NzUWSjH7fI7aCVT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DbNoBuoA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbNoBuoA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737661279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVWBJyMVn3pq9QMtoCCB0cgOGlE9eZyl9LQ5JXqGeCA=;
	b=DbNoBuoA19mM6XSgTRsoMqpTQxBA5RhzeuwZrlZ9u22tsDVPJjdZk/gmSbQToUjp5+aYk1
	lZGib+udR/z46gVEZPqn1bl1scp62bMyKHBtQ8sI5HxGRPxGVWEo15unKQSAlm5V/tEXs4
	Ba/pJ8w8d9hCZuWHPrYJHNlVR8j/NCM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-7PmMWVVrO-Kw6MbfHYeYFA-1; Thu, 23 Jan 2025 14:41:17 -0500
X-MC-Unique: 7PmMWVVrO-Kw6MbfHYeYFA-1
X-Mimecast-MFC-AGG-ID: 7PmMWVVrO-Kw6MbfHYeYFA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e00ebb16so499119f8f.3
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jan 2025 11:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737661276; x=1738266076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVWBJyMVn3pq9QMtoCCB0cgOGlE9eZyl9LQ5JXqGeCA=;
        b=Qwoc7trl4oQgAk4ZyVYBshWj1SjCLKxaU1b0g5iYD9lONBiB2vOnMI65kANgQqsa5V
         jgbHFKZsze9UmAXnrZRupiIXD9RsLNiY9vUf3k0FOkNCXC2MvHTU30WL2Z99RPirNSIP
         LgNwXaw0ndkA5zDDW8MQ9KQtMCey6HT5i6RA/+0uPfhofG99BTe7j3FM0eWBMkq0YKVk
         fCGPQw38vpU3Suzw2mBh8ey5JL2ABHTqeAMA0uyYkeLg0sbzB8WhxJWVa2jfw0msWqaW
         qCjpHp4QM8UmSVBoqodIebT52oD5pWmbrfwB68rHpYCnQC/89IjuKyKhQ1EKHpMXdnfK
         x81g==
X-Forwarded-Encrypted: i=1; AJvYcCUPAVNFwRAfBUt/GQRlLhAV/MI2KwX8rn50Vpt98KfFB7rdW0L6cL3vXVhDJPuecDhipe9JqyOwuI1qV7JdTo00HtmMsnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRmw/wTKAe3d7NFdS+m6VZnNQmdWY6Td5XnslBa/sKSprN5NuH
	3rUhsITj2Yl8w3EmRcWecRzNdWfd8huxOIM8JMu23bA/xjTjWxBUOTILna0JzQrzatw+2+p6UUP
	bai8LIS8Yr9ubWTwxrxAJiqg+CzUInzpktvoZcWfqO9wCz4Mt4Do5jhef2HieAcVFddDRhiVOuQ
	==
X-Gm-Gg: ASbGnctGc6fK6aZgrkZs5COJS6VgivotdMzupxr6R2n8U9eoAKQ/vvnqC+0QvoctuDD
	1csLBEABlpE1xD8ueEB5gVb50gCjIYHbFHhUA8Jagcw9jwwwQIp24llxx+j5oW2yzwhHt7BAzdf
	lvhGCc2r720Dxyp23XrlAr6TYU3McOATx284JyfpEeugbzNTAllmIFegYukdIOEzCvUh5G+c/65
	hogLhtPVwuj3pCkYIxF40LLXaKZpT2PFYfXnKSrHm5TKbOGoittrp+Y/9392r0aPLg1KP6/yVgx
	VwG8dtAoyVSXAUJWf4VrPRzDDKozwClT8qA7N+97Bj6beg==
X-Received: by 2002:a05:6000:1863:b0:385:df2c:91aa with SMTP id ffacd0b85a97d-38bf565579fmr22252053f8f.7.1737661276521;
        Thu, 23 Jan 2025 11:41:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCwYvNPnsOpcrz/YUWLahtCRlJYVF7u4D+kUx15s09iLwHMLIFq/9r+tNumdffqIr6q0gPGA==
X-Received: by 2002:a05:6000:1863:b0:385:df2c:91aa with SMTP id ffacd0b85a97d-38bf565579fmr22252032f8f.7.1737661276130;
        Thu, 23 Jan 2025 11:41:16 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-183-41.pool.digikabel.hu. [91.82.183.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd507e46sm1687245e9.21.2025.01.23.11.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:41:15 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Karel Zak <kzak@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH v4 4/4] vfs: add notifications for mount attribute change
Date: Thu, 23 Jan 2025 20:41:07 +0100
Message-ID: <20250123194108.1025273-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123194108.1025273-1-mszeredi@redhat.com>
References: <20250123194108.1025273-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l7kh4Ik8rqaS3ebFqomKXzs-IjWyWM1PyDwjEuOEGqc_1737661277
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Notify when mount flags, propagation or idmap changes.

Just like attach and detach, no details are given in the notification, only
the mount ID.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c                   | 27 +++++++++++++++++++++++++++
 fs/notify/fanotify/fanotify.c    |  2 +-
 fs/notify/fanotify/fanotify.h    |  2 +-
 fs/notify/fsnotify.c             |  2 +-
 include/linux/fanotify.h         |  2 +-
 include/linux/fsnotify.h         |  5 +++++
 include/linux/fsnotify_backend.h |  5 ++++-
 include/uapi/linux/fanotify.h    |  1 +
 8 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 948348a37f6c..9b9b13665dce 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2807,6 +2807,9 @@ static int do_change_type(struct path *path, int ms_flags)
 		change_mnt_propagation(m, type);
 	unlock_mount_hash();
 
+	for (m = mnt; m; m = (recurse ? next_mnt(m, mnt) : NULL))
+		fsnotify_mnt_change(m->mnt_ns, &m->mnt);
+
  out_unlock:
 	namespace_unlock();
 	return err;
@@ -3089,6 +3092,12 @@ static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
 	unlock_mount_hash();
 	up_read(&sb->s_umount);
 
+	if (!ret) {
+		down_read(&namespace_sem);
+		fsnotify_mnt_change(mnt->mnt_ns, &mnt->mnt);
+		up_read(&namespace_sem);
+	}
+
 	mnt_warn_timestamp_expiry(path, &mnt->mnt);
 
 	return ret;
@@ -3141,6 +3150,13 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 		up_write(&sb->s_umount);
 	}
 
+	if (!err) {
+		down_read(&namespace_sem);
+		fsnotify_mnt_change(mnt->mnt_ns, &mnt->mnt);
+		up_read(&namespace_sem);
+	}
+
+
 	mnt_warn_timestamp_expiry(path, &mnt->mnt);
 
 	put_fs_context(fc);
@@ -4708,6 +4724,8 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 				return err;
 			}
 		}
+	} else {
+		down_read(&namespace_sem);
 	}
 
 	err = -EINVAL;
@@ -4743,10 +4761,19 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 out:
 	unlock_mount_hash();
 
+	if (!err) {
+		struct mount *m;
+
+		for (m = mnt; m; m = kattr->recurse ? next_mnt(m, mnt) : NULL)
+			fsnotify_mnt_change(m->mnt_ns, &m->mnt);
+	}
+
 	if (kattr->propagation) {
 		if (err)
 			cleanup_group_ids(mnt, NULL);
 		namespace_unlock();
+	} else {
+		up_read(&namespace_sem);
 	}
 
 	return err;
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index b1937f92f105..c7ddd145f3d8 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -934,7 +934,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 23);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 24);
 
 	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
 					 mask, data, data_type, dir);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index f1a7cbedc9e3..8d6289da06f1 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -471,7 +471,7 @@ static inline bool fanotify_is_error_event(u32 mask)
 
 static inline bool fanotify_is_mnt_event(u32 mask)
 {
-	return mask & (FAN_MNT_ATTACH | FAN_MNT_DETACH);
+	return mask & FANOTIFY_MOUNT_EVENTS;
 }
 
 static inline const struct path *fanotify_event_path(struct fanotify_event *event)
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 2b2c3fd907c7..5872dd27172d 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -660,7 +660,7 @@ static __init int fsnotify_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 25);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 26);
 
 	ret = init_srcu_struct(&fsnotify_mark_srcu);
 	if (ret)
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index fc142be2542d..61e112d25303 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -100,7 +100,7 @@
 /* Events that can only be reported with data type FSNOTIFY_EVENT_ERROR */
 #define FANOTIFY_ERROR_EVENTS	(FAN_FS_ERROR)
 
-#define FANOTIFY_MOUNT_EVENTS	(FAN_MNT_ATTACH | FAN_MNT_DETACH)
+#define FANOTIFY_MOUNT_EVENTS	(FAN_MNT_ATTACH | FAN_MNT_DETACH | FAN_MNT_CHANGE)
 
 /* Events that user can request to be notified on */
 #define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index ea998551dd0d..ba3e05c69aaa 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -483,4 +483,9 @@ static inline void fsnotify_mnt_move(struct mnt_namespace *ns, struct vfsmount *
 	fsnotify_mnt(FS_MNT_MOVE, ns, mnt);
 }
 
+static inline void fsnotify_mnt_change(struct mnt_namespace *ns, struct vfsmount *mnt)
+{
+	fsnotify_mnt(FS_MNT_CHANGE, ns, mnt);
+}
+
 #endif	/* _LINUX_FS_NOTIFY_H */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 6c3e3a4a7b10..54e01803e309 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -58,6 +58,8 @@
 
 #define FS_MNT_ATTACH		0x01000000	/* Mount was attached */
 #define FS_MNT_DETACH		0x02000000	/* Mount was detached */
+#define FS_MNT_CHANGE		0x04000000	/* Mount was changed */
+
 #define FS_MNT_MOVE		(FS_MNT_ATTACH | FS_MNT_DETACH)
 
 /*
@@ -106,7 +108,8 @@
 			     FS_EVENTS_POSS_ON_CHILD | \
 			     FS_DELETE_SELF | FS_MOVE_SELF | \
 			     FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED | \
-			     FS_ERROR | FS_MNT_ATTACH | FS_MNT_DETACH)
+			     FS_ERROR | \
+			     FS_MNT_ATTACH | FS_MNT_DETACH | FS_MNT_CHANGE )
 
 /* Extra flags that may be reported with event or control handling of events */
 #define ALL_FSNOTIFY_FLAGS  (FS_ISDIR | FS_EVENT_ON_CHILD | FS_DN_MULTISHOT)
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 69340e483ae7..256fc5755b45 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -27,6 +27,7 @@
 #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
 #define FAN_MNT_ATTACH		0x01000000	/* Mount was attached */
 #define FAN_MNT_DETACH		0x02000000	/* Mount was detached */
+#define FAN_MNT_CHANGE		0x04000000	/* Mount was changed */
 
 #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
-- 
2.47.1

