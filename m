Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B1A155A59
	for <linux-security-module@vger.kernel.org>; Thu, 23 Jan 2025 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661276; cv=none; b=s8VUdiNr0a033LeOUSw9O48GwUuCpt6FBNcjab/eQmaB8uLPIOUQ13oukSYPhKzIsSx5OxCmGr3HE5CNagCPx1tKb1zmjAQpu8szI6doUBtBbC401dfTqVFpAqw8CNKDXu3oQ00ASCzoA9Yo4F0s6GSk9R9ArMsnyDXqKpKe+X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661276; c=relaxed/simple;
	bh=crfRQrn6rJNEgnAzDpUaAC4avkLkEg1kUUwBWVgapks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=KA0uxcCgd/JQOVGclmD1PHBfQn/aqAo7HYqzK69Ufhvs2VQYzg+sVtHAzO7yHSA6i7m3M0iXzoQHXG3gabPV47FLR58drzbYE8CgiN1FcBOKfknc8Aoz8G+EEHOzBBO6POWErcWUCDUURlIYbkWxmQu418lsgRa9vjvgm41TyaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWPmHVVh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWPmHVVh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737661273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pMjEfd15YaPnS3m1kK+tJc0UvrQqQ2bQdv285PmS/eo=;
	b=ZWPmHVVhOeO9Y8eEC1eA7UEEJ7R+QN5h1HukBHw9nQ8MJzQ9TZbgDQDB0EV/gxxsEkI74h
	zbespgX914qWnHGVjudRdJmOwDjhx5J/ko1QeNTIH4auk9MLkz0e7qKa6siLFN1afhodfa
	4PUUA8ZKlueiNa6dPMkPCUAcZZqpFkc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-3sxpKFDMPI2KNN9oZNQIiw-1; Thu, 23 Jan 2025 14:41:12 -0500
X-MC-Unique: 3sxpKFDMPI2KNN9oZNQIiw-1
X-Mimecast-MFC-AGG-ID: 3sxpKFDMPI2KNN9oZNQIiw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-436289a570eso9520165e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jan 2025 11:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737661271; x=1738266071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMjEfd15YaPnS3m1kK+tJc0UvrQqQ2bQdv285PmS/eo=;
        b=hl7MjMBCpIdEeD4LXIg0QSHZuzxrH5cdDVBQBg6yeglYFbGVZMimRXnYt1RvyMrNjA
         /ZhRbmo75CrWnA4dWjrWJHc0XfMhbOBuLAH/M8juLXs/5vFMKfP79ksD0yOtAa/YCd1p
         tq5uyFJX4rnd5KMbAITWqC6ZnGHRxw8RNjQofN2HAedibTTLJjhLcdFxqFCWMkIAasbA
         xRkqh2PMLPgUVd0NXI1f1AtTspVtOlBBqlhgvJ/VF2RztIx7aFqYi2hjmLJRgu4Pnwqe
         92H+S24/2pIuiGOV7B9YttmnkLquNMtOb2PPsvSLRotID8jpKPgYXMlitKb/JY7o7oL2
         gy1g==
X-Forwarded-Encrypted: i=1; AJvYcCU/ib4lMso7P3gEX8o0/ursEpvWMRWnlDMdeM16yPb8yFWsOseaLhPADHXVsmQatqktevtcw9/BOAwmn7TLuH85XekQdsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWXeQvNIvHnUFPcmZTYYQ/O5IoLqc4H9ehx+kbPrWBXvzm/1YS
	DK1BayMCX9CTBPKb3wqJmd4V9MrJxhh9Iwou37FbfDD0d0J0yKzXAmF2epZZfKBQ7SIZHCvjYFV
	dClOdrGC4Yatcs8QAFMLX907GuH38g9NxA8ffvqhNsyntmqFhhy75Q6Zcq+ijVnzOGguEKRf14g
	==
X-Gm-Gg: ASbGnct8ZUJNZRJ6DWuDk6UXryfDQ1WBIfc3WCyIpqnWJzGkLhB3DHedULHZ007URDC
	zlQYol5wOVdjqPUqQZI4+4iX53F4qpXdoLhn7Ep+DwoBJiN41CRF1f1znlKfwZNdhUgawuOUZ1J
	KSbY6ZODfUvXUrU1x6P7Gl2CF/INp/8I6fkMO/yFm54g4Z+0tssLiRRcukdzjDnjt/QaiQuXKCY
	GSGRkB+FyNCRsMRLh/SRPQcw0ELJFcoiw8eN3BEgYQpP99T+Ngp2Oj55XMDDd+8jMpcxeGUSwiH
	2f93fAQzlTMZh3VYj1B3uMinN8SeViAVaLA6w63bYYElGw==
X-Received: by 2002:a05:600c:1386:b0:434:f739:7cd9 with SMTP id 5b1f17b1804b1-438913cf349mr240199855e9.9.1737661270710;
        Thu, 23 Jan 2025 11:41:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoz2j+PwNk/UXtmsGls7bCH6WnDcHXmR9rN/MaKVJjM3lXOBp6m6yVukwzhUxjrjYNsdB93A==
X-Received: by 2002:a05:600c:1386:b0:434:f739:7cd9 with SMTP id 5b1f17b1804b1-438913cf349mr240199745e9.9.1737661270368;
        Thu, 23 Jan 2025 11:41:10 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-183-41.pool.digikabel.hu. [91.82.183.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd507e46sm1687245e9.21.2025.01.23.11.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:41:09 -0800 (PST)
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
Subject: [PATCH v4 0/4] mount notification
Date: Thu, 23 Jan 2025 20:41:03 +0100
Message-ID: <20250123194108.1025273-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -RBt_J8s9elR6W-6l22AehYi17lL9ZPembr8llaV3Fs_1737661271
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Addressed all comments, and split up patch into three pieces (fsnotify,
fanotify, namespace) and added a fourth patch for mount changes.

There's only one FIXME remaining in selinux_path_notify().  The path passed
to fanotify_mark() and subsequently to ->path_notify() is a namespace file,
and comes from nsfs (i.e. /proc/$$/ns/mnt).  Does this need to be handled
specially by selinux?

Paul, can you please review this change?

Thanks,
Miklos

---
v4:
  - add notification on attribute change
  - deal with two FIXMEs
  - move data and code to #ifdef CONFIG_FSNOTIFY regions
  - function renames for more consistentcy (Christian)
  - explanation comment in umount_tree() (Christian)
  - style cleanups in fanotify (Amir, Jan)
  - changed FAN_MNT_* values (Amir)

v3:
  - use a global list protected for temporarily storing (Christian)
  - move fsnotify_* calls to namespace_unlock() (Christian)
  - downgrade namespace_sem to read for fsnotify_* calls (Christian)
  - add notification for reparenting in propagate_umount (Christian)
  - require nsfs file (/proc/PID/ns/mnt) in fanotify_mark(2) (Christian)
  - cleaner check for fsnotify being initialized (Amir)
  - fix stub __fsnotify_mntns_delete (kernel test robot)
  - don't add FANOTIFY_MOUNT_EVENTS to FANOTIFY_FD_EVENTS (Amir)

v2:
  - notify for whole namespace as this seems to be what people prefer
  - move fsnotify() calls outside of mount_lock
  - only report mnt_id, not parent_id


Miklos Szeredi (4):
  fsnotify: add mount notification infrastructure
  fanotify: notify on mount attach and detach
  vfs: add notifications for mount attach and detach
  vfs: add notifications for mount attribute change

 fs/mount.h                         |  26 +++++++
 fs/namespace.c                     | 120 ++++++++++++++++++++++++++++-
 fs/notify/fanotify/fanotify.c      |  38 ++++++++-
 fs/notify/fanotify/fanotify.h      |  18 +++++
 fs/notify/fanotify/fanotify_user.c |  86 +++++++++++++++++----
 fs/notify/fdinfo.c                 |   5 ++
 fs/notify/fsnotify.c               |  47 +++++++++--
 fs/notify/fsnotify.h               |  11 +++
 fs/notify/mark.c                   |  14 +++-
 fs/pnode.c                         |   4 +-
 include/linux/fanotify.h           |  12 ++-
 include/linux/fsnotify.h           |  25 ++++++
 include/linux/fsnotify_backend.h   |  43 ++++++++++-
 include/uapi/linux/fanotify.h      |  11 +++
 security/selinux/hooks.c           |   4 +
 15 files changed, 428 insertions(+), 36 deletions(-)

-- 
2.47.1

