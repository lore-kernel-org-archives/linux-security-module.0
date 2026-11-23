Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432500;
	b=InMk3PAylf6JjQTtQqhnnN5GseSl3uLgk/8KwMyEGlloqLxUP9AXa7DwjVuap+9Nz/xG
	 2zgT+zAwcUCeVObvLRZD1MbdvCfsHn+O2hoawqLmy0dmZTHD+jK9xC6Tfl51+kAckXQhN
	 +ytrKJ+IhE2G8v7iKEavksJDiA1nfDJE/rL2iBY+irdTgwWDrZ1x8BmfYL4BYJO2CzkLI
	 Z64VRzR5GFUVHyem3k4uSk9ffU106lh3jkRAK/r+MCP4IIVjZ7LidjWLVoDuy9w6CCpLj
	 TJ3+AQG8zlFrsDDzO/fUZui8RIaPZSfoBDZHJ007KcniF20lkrN8sOY3EDlFqHZrl7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kvxCAFGhBWC5zf+uvhs+QtIakQF9t3AdFIsHU9D4+O4=;
	b=4Q71FvdyjMBVsEschnNTyUeLi9ITcd/tug8OLl8f91wdGl86KXUuE05ti/sZ2op9S2Qi
	 VKz13DTg0bOljVsW6C9k8xd4FhYP/NbFdQjo6tp8efkYqYzB4u1VhivKOiHJJxB/Zr8e/
	 PGp/NI+1YiVCUNjkamkJ+gQvL6jvxPgmNfWFUxuonyiVLNQQzUkOS9VDTocc759exR7Td
	 pD+MseIxAJlkoYdyYwgmH40hxoGfu5LvTuM1Yg6N2DLQFlk2MVx07QowdUfGgTc8UdaQ5
	 hkNFRRDU0+vHQ1kNNm/Sak+PbHJvHrZLS8ZB5Fv+oi1yZn3NsCIExaA+IUuydoLR+ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wEuQYgd9;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCED606A31F
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 11:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FCED606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wEuQYgd9
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso1520027a91.2
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 03:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795432498; x=1796037298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kvxCAFGhBWC5zf+uvhs+QtIakQF9t3AdFIsHU9D4+O4=;
        b=wEuQYgd9aTMaRZMu8Fc8uQ9+z8eQzvLYLuJRlLT7wIS7NWQ/wbFslmzkdbAmHbleFV
         w8KhFw2ZOd1rLauzizxyN/Q1sVkP9Hlku2rgQs63qAipnTqBr+GiOUkS4IF8Jlcz6A4U
         O2b/U7NmMQfVWpCjvZGK0QBmjLTg2yMbsd1Ar0m6fTyLnVbXWpldKB/8rKnh9ifygbP/
         x1DWX8gGyFeMxmsX9AmtaFoZWjjAUlwEDv9j33EYV9x8Tdcv5ktG3OriZNmXyNeK2vTl
         cPOzYd9xyQqae2bVqgqKzZstPwew4pN5OP8zL/JnzLKLW/gnJlidhE5g//FY4dAeySXI
         M3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795432498; x=1796037298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kvxCAFGhBWC5zf+uvhs+QtIakQF9t3AdFIsHU9D4+O4=;
        b=tplmjc7ORYz898ZwxnWHJcM3lpCXAih3Bde30FzcRy+K8jgTA3mV6EsqWUevc33cgF
         SqROWH9FOJ1kkR0LMBf9HCt2ovvLpbot1FQpdLZPpsI7k+r3gKDthKBLd6OHQACuPRi/
         S6OlMlt4hsxBlHtoxu5ZjRAMKF5Mw9v2ntbMSXKCf3D2EuJgzvUIGH5K4oWkVPNq6EVQ
         2XjBZVr74bwvmtfs3NoKUtyRSZDv2pC9d+ecMQ4O6BHvgef8luIS66Zx0d3c/JT2HODw
         +KnBdTeBERD+styyrGzfen183QYkGryayML0lm8FV501Ks2CswkmSYjOpf2pRYfBm7+g
         SzOw==
X-Forwarded-Encrypted: i=1; AL+hErH4MKTEHQL6fa2Oq4TBlz8xN+aApGI2ckbIJ9Rja6mjr30ZHgpDm2JV37zEQO1h2VbvrbLOAMu/GeKj94WpFOCgD9dDoo4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8eCu/9fKwp3QEAl230ps2Sv+uuE8KgYcCGkLcJtaqwyMPCWyq2
	bhb/zuVgwlZa0vnnKhbvxRc9uYkgUTLFjRNfe3p1j4xR+Ac2ef8nO0ed
X-Gm-Gg: AZFdTZcAM7r5qeWdF1ThNWzUQboxTWwsm6EA4XPCJl4AVzyyVl2TCQF/18Wevfh5MDQ
	SlSDlbdY9ZxpuHNqqqXvP5H6qEdrordIZaLW/8MrZDNSscpJNkhZfx5x0Vr9o+ObqJQE1NW1Udd
	vywOXfiNjlA3PjBIvPhlAm/pDbjJHiMwG56qcI+CdxeI8KV+Aj5X4fGf434Bsa0n2aQdAW+/hhP
	EH3PxgDIkcURhTvqVF0+onG77aUKMIHanz9KylliCEktt1t2iIZ2PkcqpBhsLMbUgAbhQ8jG+YR
	iUeMuwd7/AuQM7b1z3mEThPwuIqwpYc9YzZ+h69MlNSwybUAj6rXvZX5/t7bJh05rmhQpkpjUHS
	4lJfNDz9cUWhncsCx1kS+1y2O71ME8BpgBA/G8DFngIjjgRXcYnwg3kokLn4Kq0vY2q0XHo9wYc
	mMh2CPCJM9IPeJOvlMyWiVbq87zPlefgAX4fSY8Fsj1FGdvIEud02QIY5Wcl/GS0Zw729MhpJp7
	r8xcwg6h4V0VH97oP59uVKUubLbeNoQl4Hgm5JC5hnAd9AZVX92aEyzHvncartzHaffivsrIwIv
	IEn0WdXQ0xAv0X6u9gW+V3+m09GulQ==
X-Received: by 2002:a17:90b:3d4d:b0:3a4:fe48:d410 with SMTP id 98e67ed59e1d1-3b41c92cfe2mr10003902a91.30.1795432498380;
        Mon, 23 Nov 2026 03:14:58 -0800 (PST)
Received: from thangnn-ASUS.. ([2a09:bac5:d452:16c8::245:e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad8ef99sm18070874a91.12.2026.11.23.03.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:14:58 -0800 (PST)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+deb8af81d91415fabac1@syzkaller.appspotmail.com
Subject: [PATCH] ima: key iint mutex lockdep class per filesystem type
Date: Mon, 23 Nov 2026 18:14:52 +0700
Message-ID: <20261123111452.237422-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports a circular locking dependency between the iint mutex,
a 9p inode's i_rwsem and the sb_writers of the cachefiles backing fs:

  sb_writers#12 --> &ima_iint_mutex_key[depth] --> &sb->s_type->i_mutex_key#25

The three edges are:

  backing fs O_TRUNC open:  sb_writers(backing) -> iint(backing inode)
  9p open + IMA hash:       iint(9p inode)      -> i_rwsem(9p inode)
  9p truncate/writeback:    i_rwsem(9p inode)   -> sb_writers(backing)

The last one is inherent to netfs: it writes to its cachefiles backing
file under its own inode lock. The cycle only closes because the iint
mutex is keyed by s_stack_depth alone, so the 9p and backing fs iints,
both at depth 0, share one lockdep class. They are different inodes
and nothing waits on a netfs iint while holding the backing fs's
sb_writers, so this is a false positive.

Key the iint mutex per filesystem type as well as depth, as is done for
i_rwsem with s_type->i_mutex_key. The overlayfs case covered by the
depth annotation is unchanged.

Fixes: e044374a8a0a ("ima: annotate iint mutex to avoid lockdep false positive warnings")
Reported-by: syzbot+deb8af81d91415fabac1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=deb8af81d91415fabac1
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Tested in QEMU on v7.4-rc4 (syzbot config, ima_policy=tcb): cachefiles
bound on an ext4 disk, 9p over virtio with cache=fscache, then 50 rounds
of write + O_RDONLY|O_TRUNC open on 9p and on the backing fs, followed by
20 IMA-measured O_TRUNC opens through an overlayfs on the backing fs.

  unpatched: "possible circular locking dependency detected", same chain
  patched:   no lockdep report, debug_locks still 1; the syzbot C repro
             also ran 90s with no report

 include/linux/fs.h                |  3 +++
 security/integrity/ima/ima_iint.c | 11 +++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5b3a100aba77b..dab32eea21fc7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2325,6 +2325,9 @@ struct file_system_type {
 	struct lock_class_key i_mutex_dir_key;
 
 	struct lock_class_key d_lookup_key;
+#ifdef CONFIG_IMA
+	struct lock_class_key ima_iint_key[FILESYSTEM_MAX_STACK_DEPTH + 1];
+#endif
 };
 
 #define MODULE_ALIAS_FS(NAME) MODULE_ALIAS("fs-" NAME)
diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
index 00b249101f98d..bb964847af149 100644
--- a/security/integrity/ima/ima_iint.c
+++ b/security/integrity/ima/ima_iint.c
@@ -39,19 +39,22 @@ struct ima_iint_cache *ima_iint_find(struct inode *inode)
  * files both on overlayfs and on underlying fs, we need to annotate the iint
  * mutex to avoid lockdep false positives related to IMA + overlayfs.
  * See ovl_lockdep_annotate_inode_mutex_key() for more details.
+ *
+ * Depth alone is not enough: a netfs inode writes to its cachefiles backing
+ * fs under its own i_rwsem, and both are at depth 0. So, like i_rwsem, key
+ * the mutex per filesystem type too.
  */
 static inline void ima_iint_lockdep_annotate(struct ima_iint_cache *iint,
 					     struct inode *inode)
 {
 #ifdef CONFIG_LOCKDEP
-	static struct lock_class_key ima_iint_mutex_key[IMA_MAX_NESTING];
-
-	int depth = inode->i_sb->s_stack_depth;
+	struct super_block *sb = inode->i_sb;
+	int depth = sb->s_stack_depth;
 
 	if (WARN_ON_ONCE(depth < 0 || depth >= IMA_MAX_NESTING))
 		depth = 0;
 
-	lockdep_set_class(&iint->mutex, &ima_iint_mutex_key[depth]);
+	lockdep_set_class(&iint->mutex, &sb->s_type->ima_iint_key[depth]);
 #endif
 }
 
-- 
2.43.0

