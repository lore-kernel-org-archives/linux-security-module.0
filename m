Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792448944;
	b=VbSMJC0UR6qaT4ALApugTy4qBNM0WnL/91viDwSQUy0dG296S89zAr5JBfBkzVywIZVB
	 dDAUMectCSdlZBrRDQQxri25vpUS61zFa3QYu27/RiV6PfbaOjaa2UFaFuz10wO3ORhvZ
	 cAwY7ITEhUDuV88z7WGjssVqW52mpHfK3Tn/s9j38YBLNYdUy2gsKNfDvKbBdZb1RxDSc
	 DFM3gtpgYuUfe0kyWfwh5CKQiqmsl9YnJQXtcKmi8B4OU2cfH7Am7Le9MGoingwHTkGav
	 IjRYX9KJZisJkvLqCzG2SJcXCmMzy8sYV2ZFvCNs5NHftJUseci3Y3jQ8emUxcTCajQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792448944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=grPMzPcjuw5NknkchPGY17WHY+uOk9YxlvMRLz3jlQ8=;
	b=l0xft4RIbz5XuuA8YpclX9m7Y94+T/x1xfa7vVRIImpUYeU7DaiqolRJF2z+xJ+6oH3p
	 mRtNNFzITQE1gPjGZKAMDZTESKEMFzsbRAcpjMjr9iW4iA8fPvq8e2WDpENEe1OkvjQtN
	 rhZx4m8feGA+BHAkr6GT1ftW/koSJQ39TryQM36ywEzdTGI2SsKXhsHUMYU4c8xx16xCJ
	 zHqOQfDn83sVJIILW4K5YEo8JFLb68YB+JZAxWS1K0b+/sghF5de3fe5yeE3H3Whs2cf6
	 jbmbFLKR80wh4Xr0Qw7CKiPV5DfOR/UxMYn702zVD/HK/pA87Wqhi4TQrFBZ6iJrORg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pXYlgfS1;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718A5606A323
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 22:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 718A5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pXYlgfS1
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e00eee27dso1440491f8f.0
        for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 15:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792448943; x=1793053743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=grPMzPcjuw5NknkchPGY17WHY+uOk9YxlvMRLz3jlQ8=;
        b=pXYlgfS1gr29AG2ETT3tGp8vnAw3OYUwF9u9S1+h14H4z8PaaXwUwYa/x+kMzWr+iq
         L/6gWmUy8KCi6Xf1AeD7LCF7dYBG1BbslumTqj3delnhMmtqach4KBDHoin5bnHKDenD
         tKG8smktnJakoKQnD85begvJwgg4l9Kx+viAPm39Wj13vCiiOWelwE8wqJE9+snWNzSn
         dZ/uiQhXk+8Ng2j3TzBlZ3Cou8gBYsMp09SGwSmu2UBnVr9RSKR2kRHUf01wfisrRNYf
         xJjUuUUi68b0sPiUu2uHFedcSG3zdHG8yq6r2bD6tzeMqf7uOz+g+VJbUgwiQ7pHxlB1
         yMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792448943; x=1793053743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=grPMzPcjuw5NknkchPGY17WHY+uOk9YxlvMRLz3jlQ8=;
        b=NLw8yWDzBLxlydj/5GD1uO/wsKbZlAV7r5IZ9Cba/owRYcqhU/bWZ6Tk1SpbNEjesc
         nPHiKy+a2AD3mcfipHwiu+BYyPxWBOaX7srrsgtIy9LUNF1c2mGifKf7/Suf1T5xw2FH
         DaUVxs6vqZIoL+MH/EA0E4rE0c9056xR8nmpbwujLzd2vM4QKsSfH8zTrTWup8gvRjXN
         za0feDtwfIVFb9ct6ageaj3qdNxKpfpMqMHN6lQxlKsS8hdnozYqFIEaNrjKGLo0xHxc
         gqOf2Ya2L4QmG1kCuUQmh1rZdBlKPU5gwpxxjQFg39AvPQGG1sNc2BxKAY9IBtPxLETX
         MOCg==
X-Forwarded-Encrypted: i=1; AKwUvBxlzlTAsJ5EXJ+hb4X6NAMc7Jw5jomuugJ46qadnERDsfMbPFnH5JQaLml/I7KHGl1zjdjzcLcEx4CE0qDXmnAUjKFHuV0=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4MA5qfIWuSxoX1012vtM8nWb0CNdS8TQcZsc5iF7raYvhpz96
	yqyXEu7CrG60xXRV1XUjaS+O15n8xb/rNJwXv7XftEHZRnlJhdlte4Fg
X-Gm-Gg: AYBFou2P/ptK66LGpyXSWLN7/ED216hn4LZNJFXV+NMYVnkiK3FLspKmsuJwYOHP8+o
	JQr3V6Ch5mhqHg/AF7Smz5bL5EN4oHF8ttxnzVeR1+H+bSmIOIg1z6sl4xjdVc+EOIyB6NDL6m9
	e6qSpQY4ajTkKluX7+qdOBbEfJSym0R3Xg7gbxapGjWOYagY3ZWc8ES7k8xlTJtwZhlbnVFR/Sk
	8SArjB8/iYIE8BdPh5SmEuYOElkuImlR1FIlvMSBArgZtt/k2ndFTKDp/8InEwmigFKFpI1ye8C
	sQtHyvRFhdYxVKek/Y6C+eWSppavnLNXVRc5qo3vx4Fcz5/FH7zf/lx/FXjc8zdy3yQVxzcM3gI
	ONML5PQdYZe7PUV50GFexcBOrKyjlt/l4A1QE1/rIXUTpCKWHHCFP895q6aSbc4dcJJlkPmL3go
	1p7txfg0h2tSdiBTg5nm1/xMdlXc08E/elgRZCHF2iOiC7llM2if4Tqg2SDkpJGe9jxCQ1/mvNi
	d9HThAxh2Em3Qf3c2S86GrtLgYuSKBrjRzxgbnXrU58caD0kfI=
X-Received: by 2002:a5d:6b4c:0:b0:487:baa:aa6b with SMTP id ffacd0b85a97d-48e07fb1f63mr12709378f8f.43.1792448942577;
        Mon, 19 Oct 2026 15:29:02 -0700 (PDT)
Received: from DESKTOP-IR7J1S9.localdomain ([105.102.223.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d818d61sm1666544f8f.31.2026.10.19.15.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 15:29:02 -0700 (PDT)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com,
	neganhat@gmail.com,
	Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Subject: [PATCH] lsm: don't call d_path() when current->fs is NULL
Date: Mon, 19 Oct 2026 23:28:58 +0100
Message-ID: <20261019222858.1766-1-drifabdelmalekmohamedsaid@gmail.com>
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

When the last reference to a file is put from exit_task_work(), the task
has already run exit_fs(), so current->fs is NULL.

syzbot reported:

Unable to handle kernel paging request at virtual address dfff800000000002
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]

Call trace:
 kasan_mem_to_shadow include/linux/kasan.h:65 [inline] (P)
 kasan_byte_accessible+0xc/0x1c mm/kasan/generic.c:210 (P)
 kasan_check_byte include/linux/kasan.h:402 [inline]
 lock_acquire+0xa4/0x320 kernel/locking/lockdep.c:5916
 seqcount_lockdep_reader_access include/linux/seqlock.h:73 [inline]
 read_seqbegin+0x6c/0x144 include/linux/seqlock.h:838
 get_fs_root_rcu fs/d_path.c:244 [inline]
 d_path+0x224/0x4dc fs/d_path.c:287
 audit_log_d_path+0xdc/0x19c kernel/audit.c:2221
 audit_log_lsm_data+0xe0/0x12d0 security/lsm_audit.c:199
 dump_common_audit_data security/lsm_audit.c:421 [inline]
 common_lsm_audit+0x1d0/0x290 security/lsm_audit.c:451
 smack_log+0x1f4/0x264 security/smack/smack_access.c:400
 smk_tskacc+0x210/0x2ac security/smack/smack_access.c:255
 smack_file_open+0x1d0/0x230 security/smack/smack_lsm.c:2078
 security_file_open+0xec/0x258 security/security.c:2739
 do_dentry_open+0x2a8/0xfbc fs/open.c:973
 vfs_open+0x44/0x2dc fs/open.c:1101
 dentry_open+0x74/0xc0 fs/open.c:1124
 ima_calc_file_hash+0x120/0x5cc security/integrity/ima/ima_crypto.c:269
 ima_collect_measurement+0x420/0x874 security/integrity/ima/ima_api.c:300
 ima_update_xattr+0x160/0x230 security/integrity/ima/ima_appraise.c:617
 ima_check_last_writer security/integrity/ima/ima_main.c:227 [inline]
 ima_file_free+0x40c/0x528 security/integrity/ima/ima_main.c:251
 security_file_release+0x84/0x148 security/security.c:2424
 __fput+0x2c4/0x74c fs/file_table.c:506
 ____fput+0x20/0x30 fs/file_table.c:541
 task_work_run+0x1cc/0x25c kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x58c/0x1a74 kernel/exit.c:986
 do_group_exit+0x198/0x238 kernel/exit.c:1129
 __do_sys_exit_group kernel/exit.c:1140 [inline]
 __se_sys_exit_group kernel/exit.c:1138 [inline]
 pid_child_should_wake+0x0/0x104 kernel/exit.c:1138
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x19c/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:796
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:815
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606

d_path() renders a path relative to current->fs->root.  After exit_fs()
there is no such root, and no substitute root is meaningful: the
record's pid/comm describe a task that can no longer name the file, and
the file may have been opened by a different task entirely.  Falling
back to another root would produce a well-formed but misleading path,
so report the field as unknown instead, as exe=(null) and name=(null)
already do.

Handle this in audit_log_lsm_data(), where the meaning of the field is
known, for LSM_AUDIT_DATA_PATH (Smack file_open), LSM_AUDIT_DATA_FILE
(SELinux file_open), LSM_AUDIT_DATA_IOCTL_OP and the AF_UNIX path in
LSM_AUDIT_DATA_NET.

Alternative: omit " path=" as it is done for inode in audit_log_lsm_data.

Fixes: 4a9d4b024a31 ("switch fput to task_work_add")
Reported-by: syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=975ace299d6ba2eb1cea
Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
---
 security/lsm_audit.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 955b2e7b2c8e..5ed505d781bb 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -169,6 +169,15 @@ static inline void print_ipv4_addr(struct audit_buffer *ab, __be32 addr,
 		audit_log_format(ab, " %s=%d", name2, ntohs(port));
 }
 
+static inline void audit_log_lsm_path(struct audit_buffer *ab,
+									const struct path *path)
+{
+	if (current->fs)
+		audit_log_d_path(ab, " path=", path);
+	else
+		audit_log_format(ab, " path=(null)");
+}
+
 /**
  * audit_log_lsm_data - helper to log common LSM audit data
  * @ab : the audit buffer
@@ -196,7 +205,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
 	case LSM_AUDIT_DATA_PATH: {
 		struct inode *inode;
 
-		audit_log_d_path(ab, " path=", &a->u.path);
+		audit_log_lsm_path(ab, &a->u.path);
 
 		inode = d_backing_inode(a->u.path.dentry);
 		if (inode) {
@@ -209,7 +218,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
 	case LSM_AUDIT_DATA_FILE: {
 		struct inode *inode;
 
-		audit_log_d_path(ab, " path=", &a->u.file->f_path);
+		audit_log_lsm_path(ab, &a->u.file->f_path);
 
 		inode = file_inode(a->u.file);
 		if (inode) {
@@ -222,7 +231,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
 	case LSM_AUDIT_DATA_IOCTL_OP: {
 		struct inode *inode;
 
-		audit_log_d_path(ab, " path=", &a->u.op->path);
+		audit_log_lsm_path(ab, &a->u.op->path);
 
 		inode = a->u.op->path.dentry->d_inode;
 		if (inode) {
@@ -321,7 +330,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
 				if (!addr)
 					break;
 				if (u->path.dentry) {
-					audit_log_d_path(ab, " path=", &u->path);
+					audit_log_lsm_path(ab, &u->path);
 					break;
 				}
 				len = addr->len-sizeof(short);
-- 
2.43.0

