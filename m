Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F20448E0D0
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944489; cv=none; b=c4Zxp9dDFS0fn2zZHqJ3OKW+UeYBAfT7v5wce2DYyhfREcBR4PdDM2GSgT0V9gUnMQbkQQhKevtoZr5OfWgWHfGLbXWJjahLYIbaHqoCiH92uSLG2wlds6BtSYXB72EzlECiGhQ+zjlAW2qrQBG9055H6waGsAUmnhQlVAE5KSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944489; c=relaxed/simple;
	bh=qIa/OOPRF8eUOfN7emCsEmTA8N7RP5NPcMNXTb2hiYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uTcQeGUVfEow4NatZ/k7et+FJbQiS4qqNjigAnP/IMu7WW5FN9jMjogA69cPS0QFs44602RfXh1iNGjdbbBPsRvGb+AkD/O4gydvGUk4UDtTF109vcwfKJxFgPD6h57itUqUahUmRfKWDtJ7w/F/MptP6OMvPGEp6ppgALsMtV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N5rexhK5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N5rexhK5"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ceab75934dso53671105ad.2
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 02:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944481; x=1789549281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oiZZoK2m1udHvSG78cGXbZoP5Fh5l1Q4IJu628L6gi0=;
        b=N5rexhK54hW8LkwJo0LqWrTWWjtA9BLi09Bux1+r2elIndwkZ8wlHwub/mMWWz0Lw0
         PMAD6gqlt8bTZBkgF7NNVagwqb6eiHfQbAPrvJFyFkpKzBKfhuooCpygYkj8zMTkKZTY
         OcOm5AfAj4crVdHHxzlBZqiG2C1nRxKoas3weyDzuJ6IszzobmrrgKhfuCIatH6B/RnD
         wTRIWM7UrRmo5a1sjFxrN1p5n8gH11MJIZBcoeigdpb5tPXe9yuzo0DWOvitBoauZHhg
         PgpEZTK3z2Iu6qIOZU5Dh9qRIijabFxOjP25rQZ9ThVycyhGovY9vc19Z1Dn9vszuhoG
         FEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944481; x=1789549281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oiZZoK2m1udHvSG78cGXbZoP5Fh5l1Q4IJu628L6gi0=;
        b=JzTE5UPHkADfaPHDC8Kmm30NugNSnvQQ5JlgOxJ28PDGndjeqcOFOViM2mkjYAmWBg
         YdjLyNz8iYFe1cDd+B3JmnHLv/sjlEJpC2+yrLiV0WlJe55HxSax1J//7eXOWDjpgtWR
         fbOVT3oxDFKFuT6beBBFczbaEF0c4C40n5UXK3PX4truHLLrNFLXAlf8goaRpkgNupbH
         W330wCR+WRbcAsg+PXUKw7sseQZeLDn+Vh6MzhcJnfGqSjON9x5bFzRSeL4mGo2lh7DP
         2t1sWMobFzQ+NwYFwXdLZFiNcenKBDXM+wn0e3KNmTiFUdfs8vUSK49Je/FWCxay6oPd
         PP0Q==
X-Forwarded-Encrypted: i=1; AKwUvBz9ZocZAQfNUFPO4VFhXpbLbw8G/ZHjFl4UBUoXC7M2780fBYuJUgK11xaiQr7guxS0FY56pXSFKKQRsHpkV1nqkubMnWc=@vger.kernel.org
X-Gm-Message-State: AFuF++nyVFLoleBJRmto24NFq/m/tyw2PV0PHhW2QTYlnfXGlltXk1G2
	H1qpEQLWs0nvcJH1+UuXaF24OkArYfiLk9sy8/uqPFegF0LchTgmU1bPQ33A19CN4Tc=
X-Gm-Gg: AYBFou2R8CZZdYoXfGu/smAZOMVeL271TwwZAeGyqjSTFet8+ojHJ3ah93Zz0uGebKY
	aNCp5/uVoWuedqvHjj3QSwv8u7yGRnX+RPqx6ZtfSffoNAJLqOtMlRcziYRHW9i0qvQJG3Ax2q2
	WC65kWk9LJeSdfDj8FmOK9fnq3tcelgNd+lXRl21IZ3rgUlHIu6sL25oH0Pxhu7dv0eSrexWc4b
	x4PYCFT07JCtdX32TzwrwjpTegoKjlks8ODppJkUkMrv4J6hlpbd8xZXTmkNc1jhGs++u/aOA4T
	dbOE1YXhI5sIrbXZWY5Ts4vqXMYH8pjaTO2lmtuUehlKRYuOL3RdkoxczpeZ6S4kKdMT+w9rMK4
	AL5cKTggjvIcWT6ssnLlizwH8SCkVcBXf0hrCAUvqz6wlo3yTznLzbIL/pDIqIO7/khAyu4AVc9
	qm+7CGNLIbKf067ctwDkc6q/ObB2IZsvYPJ2YmsxfZcyKeZyvcA2hPkNvSlJa0YFVKfl0+w0aHF
	vQ=
X-Received: by 2002:a17:90b:528e:b0:38e:ad9d:1161 with SMTP id 98e67ed59e1d1-39b25ee67f0mr51440982a91.0.1788944476217;
        Wed, 09 Sep 2026 02:01:16 -0700 (PDT)
Received: from localhost ([106.38.226.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b2612d3f1sm30763517a91.13.2026.09.09.02.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:15 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-security-module@vger.kernel.org
Cc: jack@suse.cz,
	agruenba@redhat.com,
	mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	aleksa@amutable.com,
	legion@kernel.org,
	djwong@kernel.org,
	ebiggers@kernel.org,
	sandeen@redhat.com
Subject: [PATCH 0/7] fs: preserve superblock inode walk positions across lock drops
Date: Wed,  9 Sep 2026 17:01:05 +0800
Message-Id: <20260909090112.790006-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Motivation]

We observed hung tasks in production during disk hotplug operations. A
kernel thread spends a long time in evict_inodes() while holding s_umount,
blocking other users of that lock and causing further stalls.

The problem is that evict_inodes() restarts its walk from the head of
sb->s_inodes every time it reschedules. When a large number of referenced
inodes remain near the head, each restart scans those inodes again without
making progress through that part of the list. The repeated scans can
delay eviction long enough to trigger hung-task reports. This is the same
problem that [1] attempted to address.

[Approach]

This series introduces sb_for_each_inodes() for two purposes:

  1. Consolidate open-coded s_inodes walks behind a common entry point.
  2. Retain each walk's position across drops of s_inode_list_lock.

The iterator mechanism follows the approach used by cgroup task iteration,
such as css_task_iter_next(). Active iterators are registered on a separate
list, sb->s_inodes_iters. Before removing an inode from s_inodes, the
removal path advances any iterator whose next position points to that
inode. These updates are protected by s_inode_list_lock, so a walker can
drop the lock and later resume from its saved position.

Existing walkers, such as drop_pagecache_sb() and add_dquot_ref(), already
contain their own position-preserving logic: they carry an inode reference
across iterations so that they can resume after dropping the list lock.
Moving that responsibility into sb_for_each_inodes() simplifies these
callers and lets their callbacks focus on the per-inode work.

Patch 1 removes trailing whitespace from include/linux/fs.h.
Patch 2 introduces sb_for_each_inodes().
The remaining patches convert existing walks to the new interface.
remove_dquot_ref() and nr_blockdev_pages() are left unchanged: their
walks are simple and do not require the inode->i_lock locking imposed
by the callback interface. Converting them would add an unnecessary
lock/unlock overhead for every inode.

[Testing]

I tested this series with approximately 20 hours of xfstests case
execution, repeatedly running the auto group on ext4 and XFS, no new
issues were observed. And with this patch applied, the hung task that
previously occurred on every run no longer occurs.

[1] https://lore.kernel.org/all/20241118114508.1405494-1-yebin@huaweicloud.com/

Julian Sun (7):
  fs: remove trailing whitespace from include/linux/fs.h
  fs: introduce sb_for_each_inodes().
  block: use sb_for_each_inodes() in sync_bdevs()
  fs: use sb_for_each_inodes() API.
  gfs2: use sb_for_each_inodes() for cooperative eviction
  quota: use sb_for_each_inodes() in add_dquot_ref()
  landlock: use sb_for_each_inodes() when detaching a superblock

 block/bdev.c                   |  85 +++++++++----------
 fs/drop_caches.c               |  44 +++++-----
 fs/gfs2/ops_fstype.c           |  38 ++++-----
 fs/inode.c                     | 142 +++++++++++++++++++++++--------
 fs/quota/dquot.c               |  72 ++++++----------
 fs/super.c                     |   1 +
 include/linux/fs.h             |  29 +++++--
 include/linux/fs/super_types.h |   3 +-
 security/landlock/fs.c         | 150 +++++++++++++--------------------
 9 files changed, 295 insertions(+), 269 deletions(-)

-- 
2.39.5

