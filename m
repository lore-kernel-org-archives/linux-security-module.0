Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66D11DF250
	for <linux-security-module@vger.kernel.org>; Wed, 29 Jan 2025 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169893; cv=none; b=DRAziczeAA5bnoyz6CrTpSMZUKkSxc2Yy7+q5W67yiIm62/9Qj3c9rlX0Hyij6zyJgEz4kBacgCgG3KDJtwKv4mDOADpAct4ZdKojIcM9HFhtTTr7YmGRZtlv5tdJqgXqfVA6mfaSuVoV4DoVMbbsmf04LFg3zFP/puUZtRhGwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169893; c=relaxed/simple;
	bh=JIWQ1QO7BCksiEGMetoA9lKc3PKsttFlXXgneRTjly4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=PtHOqgtcuK2ZgSDYeAo1c3M3O09uAGZIOBG09/xMOChUq9+RDVWT47xPHz+6SheqmHMtBGDenQVbpCjguy4TZyyhJc2ymWnGuYdC11BCuKhbaKZWWKeelMv1PLGu7vVCcFxQnynxAM9x700MkURQ18Ibuk798nwo9F6sUSAnEZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0DlUy1+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0DlUy1+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738169890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K47kaWwlvB0QgUEcbod96X79kXNV4c3e9UEBsXFBFcM=;
	b=F0DlUy1+qL4e2IePa5rEaFNbIXSafaqM5QWCWPdRzr0SZlSVMVmjBXxYpsGztjg3BDcDtc
	EpQI4CP46dog1JUzRdE+vJf47uKSu5COEBMUHlT2HJSuB2aOm9fa27fmiesTqscFpqsqX9
	p3OlKO8LWCF3M6zdPav1RyXjqHQibxI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-hDbKLrJ3NsGrTQAjNWvCcQ-1; Wed, 29 Jan 2025 11:58:07 -0500
X-MC-Unique: hDbKLrJ3NsGrTQAjNWvCcQ-1
X-Mimecast-MFC-AGG-ID: hDbKLrJ3NsGrTQAjNWvCcQ
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aaf8396f65fso715100866b.0
        for <linux-security-module@vger.kernel.org>; Wed, 29 Jan 2025 08:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738169886; x=1738774686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K47kaWwlvB0QgUEcbod96X79kXNV4c3e9UEBsXFBFcM=;
        b=HjEZHHOh6KEprd2q8x0/Q5xzaqu5NzvZR6QeyT6Ow/jmYUrS+iKtfywGC83qT/QIST
         OgpKdjk9uH4D7DXgc7YsjGSaIhk9PfdyMo3wTthDrRL7txi2ezUMCpH61iCfNJWKCZQk
         1Wd+0WpHV20Y8zqs2zrqjbzfuF9Dqbg3aF6gFF+UJT7zEE2XCkgreBDPtWSBW6m/xRSK
         fhYqLgQNHwBQB874WguTrUcEjHvBb6spXLTqUzL56mXAb4LimebUtBIjd1u3JUkCnCyE
         pLmn7mQdZTK/alwr9PrVV32Mhm+SHzFMl3Tt+Dl5FLfz/LIoBLvnt178/8eAYblHTCk9
         gfaw==
X-Forwarded-Encrypted: i=1; AJvYcCVHDXI/Tr7bvjduhgGsk9qQh1gQCFt6tF6MD6BoWOM+CYiNXR/qxCIpdqzKYeKWhMFB0NgQmn2cFDWa/evW6ZH2gw2EYRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtF4ss7zgrhwnqJxDRcfZyQ5706PQvZ4LTVsGnMOotSNFSkE5k
	OPjRNMLxFuiw9GJovSgyXImbOPXV/04ZsN5R8ptuyvGtYzJGh3Wfg+Ej90Y0BnHZeYm1DSUqyUA
	TJfxm8Dy2ndeI95KSaQpWT1JvTFoGm65qGUVo+QhrhL5XAZcmKEaytSG/QL5L5svPSzX7nWIzXQ
	==
X-Gm-Gg: ASbGncv5xkocovbFEgVcYNvIoJswyqZJrgMeEvOlglE1G7vWy8BgIGtTe2HhmV06gY0
	MdKd7FwYZCTurND7u5nkhezKWrnaCY+la0Tt8KX4YFDyQH+E1i+gANSbsfuRXaafP0itB0DTRmn
	/MST4Lp6M6VWkzAeI+MYMsKgV22I0LdNcIniNqC53mUwdfmAkZLB2iL2qP6VdK+XEEQHul/tIWM
	Suu54MkxnfnUbhqEgKm289tILd7Q6rOJSHVhaTLEevFifz/VlPZhmBcLZFnPDV5cB64kfTmRDK3
	GxqqcH18ZdnIO5fIkaDTXqxYP2ZobtzBHMxqWgXPkr+r2hPZ2UnPM2RE
X-Received: by 2002:a17:907:971f:b0:aa6:a844:8791 with SMTP id a640c23a62f3a-ab6cfe120e9mr362630466b.45.1738169885879;
        Wed, 29 Jan 2025 08:58:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3fQki93wvSIZNI2gPgUJncSMHks44LgIjMTqpIUAYXOgBM3KZNLb1wrvEfXMxgDFWGdYD3g==
X-Received: by 2002:a17:907:971f:b0:aa6:a844:8791 with SMTP id a640c23a62f3a-ab6cfe120e9mr362628766b.45.1738169885491;
        Wed, 29 Jan 2025 08:58:05 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-183-41.pool.digikabel.hu. [91.82.183.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e653c6sm1002813366b.64.2025.01.29.08.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 08:58:04 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Karel Zak <kzak@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux-refpolicy@vger.kernel.org
Subject: [PATCH v5 0/3] mount notification
Date: Wed, 29 Jan 2025 17:57:58 +0100
Message-ID: <20250129165803.72138-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZcqNm9GAtRxlWbb9QpGR9GMQuqz-x9AEk8UYznB0EKE_1738169886
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This should be ready for adding to the v6.15 queue.  I don't see the
SELinux discussion converging, so I took the simpler version out of the two
that were suggested.

Will work on adding selftests.

Thanks to everyone for the reviews!

Miklos

---
v5:
 - drop FS_MNT_CHANGE (Christian)
 - rebased on current mainline (Amir)
 - add FSNOTIFY_MNT_EVENTS (Amir)
 - change selinux permission check to FILE__WATCH_MOUNT (Paul)

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


Miklos Szeredi (3):
  fsnotify: add mount notification infrastructure
  fanotify: notify on mount attach and detach
  vfs: add notifications for mount attach and detach

 fs/mount.h                         | 26 +++++++++
 fs/namespace.c                     | 93 ++++++++++++++++++++++++++++--
 fs/notify/fanotify/fanotify.c      | 38 +++++++++++-
 fs/notify/fanotify/fanotify.h      | 18 ++++++
 fs/notify/fanotify/fanotify_user.c | 87 +++++++++++++++++++++++-----
 fs/notify/fdinfo.c                 |  5 ++
 fs/notify/fsnotify.c               | 47 ++++++++++++---
 fs/notify/fsnotify.h               | 11 ++++
 fs/notify/mark.c                   | 14 ++++-
 fs/pnode.c                         |  4 +-
 include/linux/fanotify.h           | 12 ++--
 include/linux/fsnotify.h           | 20 +++++++
 include/linux/fsnotify_backend.h   | 42 ++++++++++++++
 include/uapi/linux/fanotify.h      | 10 ++++
 security/selinux/hooks.c           |  4 ++
 15 files changed, 396 insertions(+), 35 deletions(-)

-- 
2.48.1

