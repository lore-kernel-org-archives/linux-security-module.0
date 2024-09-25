Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5DD13AA26;
	Wed, 25 Sep 2024 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727252205; cv=none; b=LJr4B4n4bbzycRClpPMXvfhkjGTlLQanN8M5H1bGY/+LxJqoQdGa7S5Lw3HFKrCMt2gg3JPOtYXOpHB+3jSU01pk74Q3agm8DEE+NJXjpRQJ6bx8hLhV5bhac5vW62tAqpULVDQsNDPmy/NnorvX4V70XeBsDqnMjVH8ZmVwiIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727252205; c=relaxed/simple;
	bh=nDHsMmoxUxyDNohFz/+8O7PtcnI0tOkSGfxeDI/bHDY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZcFJgPUtjFHwf8LByzQvIPapgxNQCTCnJNmD5y2sqIrkt9DnRMObIoTmdIZHe1cgTI8gcM/L5bphQc+QKGipSD8KPMp7d7jtLKwPAM9kXWZAvZnkZh+SnUCwJt3+TEIxH9Uo+iAm4b2zvIHfoOf2YhBWjgGeM3RvcIKeDanwMPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpwo/VaR; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpwo/VaR"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e06f5d4bc7so335025a91.2;
        Wed, 25 Sep 2024 01:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727252203; x=1727857003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fRyT55ab4R2A+65MrHS5Vqlg7xItZ53sZIU1oLGBkYE=;
        b=cpwo/VaRywbtZ2/ZF88qqZCwU4DmBpua81oJVpGv5Vnru15b6WujUsQDXwRtTfoeG7
         2YoFnAooEw2ZAICL8YWx4BLsoXMn0PFkFEPz44k7f4+FTZeG5YX5PlV9lHbLYhA92PO/
         WhWh6xW7J46IuzkDY+Dvs3bf8xg0jwldMAge2UwppDRP/P1iag4CxTQ+ze2wsSoniybX
         hX+mauhSp3f98/kdFWbt9VtZeMEAlJDGI5dofk7ezhFWj8bjutX/dD/oyN3CoJ82LwXw
         Fe+/0O7bA+BR65af7kn0kP+0xkeddxLryZrwIxTJgzdFBILEtlNMCwLM5mWqvFfpiXqB
         CbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727252203; x=1727857003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fRyT55ab4R2A+65MrHS5Vqlg7xItZ53sZIU1oLGBkYE=;
        b=vuvyfecOjlP4nCfWFhuWu00aSqLEQVFJJDOLufrUktBeIi+wIsEw/ckv1KL7Fmfwsc
         rPpVturgRbMgUH7gAxnIhCGuZI97yftvRQyIJxH5nogmA0Td3oixH1QmMlhoc0Q2MCVU
         wZ5hlByd0B/z+KjIeyfjBb1rOyqvtVOIMS8lpzpMiUuz9sjZYmyGwZWAIhzxu5T+tYM8
         aT2xPnt4Zctwdl+XwpylcD5IIaOvp8qqAxs5cNzs8VjGj+6UikSWar9A+o8pPSHqVOOz
         mk2InMOvXBP5kgLO0gNyqxemKw/vOSnr0Ons9ELOVTybVjfeBADND48tlfRZUXkm6qmJ
         jazg==
X-Forwarded-Encrypted: i=1; AJvYcCVzYgTIHumyqalgsH9kpdZEF6TBfBmOdWSeH4aEnFNG6WK/Hkpk+lMBjruJ/JJylNm2p5vB4XxrbfxJkpXMO1o47Jvp9L38@vger.kernel.org, AJvYcCWNa7M1HSuKDncHDKAKfptAw4eqNXiac8CRdJ4O7h09FEnkdr5A4Hyqk9dJcWovtfIw/w+/l1MIYpXOpxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBKi2GrGa/MhudibOB/GjiTlmYqjJokRGeL+0fJ4/+cY846Kl2
	k1Ai1IeKOvDGbNIRCtlFjkM+n4ppHTJGHuVTxryj+wZQmY2UYly7XeqhYA==
X-Google-Smtp-Source: AGHT+IGZS9xjGJwPRz1ykf4pT7W+CzzPG0n3AZrZoCrp3A7RbLnNkCT0Ba3xqVKn6D1cKa5HT2lahA==
X-Received: by 2002:a17:90b:2ec8:b0:2d8:9c97:3c33 with SMTP id 98e67ed59e1d1-2e06afc4197mr2134089a91.28.1727252203186;
        Wed, 25 Sep 2024 01:16:43 -0700 (PDT)
Received: from localhost.localdomain ([20.37.103.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e2bbecasm925215a91.46.2024.09.25.01.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 01:16:42 -0700 (PDT)
From: Shu Han <ebpqwerty472123@gmail.com>
To: akpm@linux-foundation.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH] mm: move security_file_mmap() back into do_mmap()
Date: Wed, 25 Sep 2024 16:16:28 +0800
Message-Id: <20240925081628.408-1-ebpqwerty472123@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch moves the security_file_mmap() back into do_mmap(), which
revert the commit 8b3ec6814c83d76b85bd13badc48552836c24839
("take security_mmap_file() outside of ->mmap_sem"). Below is the reason.

Some logic may call do_mmap() without calling security_file_mmap(),
without being aware of the harm this poses to LSM.

For example, CVE-2016-10044[1] has reported many years ago, but the
remap_file_pages() can still bypass the W^X policy enforced by SELinux[2]
for a long time.

Add a check is easy, but there may have more calls to do_mmap() in the
future. Moving security_file_mmap() back into do_mmap() can avoid
forgetting, and avoid repeated logic for whether READ_IMPLIES_EXEC should
add PROT_EXEC for the mapping or not(In current, the !MMU case won't
imply exec if the file's mmap_capabilities is not exist, but the
security check logic is different).

It is noteworthy that moving the security check in do_mmap() will let it
in the mmap_write_lock, which slows down the performance and even have
deadlocks if someone depends on it(Since security_file_mprotect() is
already in the lock, this possibility is tiny).

Link: https://project-zero.issues.chromium.org/issues/42452389 [1]
Link: https://lore.kernel.org/all/20240919080905.4506-2-paul@paul-moore.com/ [2]
Signed-off-by: Shu Han <ebpqwerty472123@gmail.com>
---
An alternative method is moving the check of READ_IMPLIES_EXEC out of
do_mmap() and calling the LSM hooks at the same time, which has better
performance and compatibility but may introduce some complexity. It has
been proposed in [3], which cannot be applied at the same time with
this patch.
Link: https://lore.kernel.org/all/20240925063034.169-1-ebpqwerty472123@gmail.com/ [3]
---
 include/linux/security.h |  8 ++++----
 ipc/shm.c                |  4 ----
 mm/mmap.c                |  9 +++++----
 mm/nommu.c               |  5 ++++-
 mm/util.c                | 19 ++++++++-----------
 security/security.c      | 41 ++++------------------------------------
 6 files changed, 25 insertions(+), 61 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index c37c32ebbdcd..e061bc9a0331 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -423,8 +423,8 @@ void security_file_free(struct file *file);
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int security_file_ioctl_compat(struct file *file, unsigned int cmd,
 			       unsigned long arg);
-int security_mmap_file(struct file *file, unsigned long prot,
-			unsigned long flags);
+int security_mmap_file(struct file *file, unsigned long reqprot,
+		       unsigned long prot, unsigned long flags);
 int security_mmap_addr(unsigned long addr);
 int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 			   unsigned long prot);
@@ -1077,8 +1077,8 @@ static inline int security_file_ioctl_compat(struct file *file,
 	return 0;
 }
 
-static inline int security_mmap_file(struct file *file, unsigned long prot,
-				     unsigned long flags)
+static inline int security_mmap_file(struct file *file, unsigned long reqprot,
+				     unsigned long prot, unsigned long flags)
 {
 	return 0;
 }
diff --git a/ipc/shm.c b/ipc/shm.c
index 3e3071252dac..ce02560b856f 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1636,10 +1636,6 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 	sfd->vm_ops = NULL;
 	file->private_data = sfd;
 
-	err = security_mmap_file(file, prot, flags);
-	if (err)
-		goto out_fput;
-
 	if (mmap_write_lock_killable(current->mm)) {
 		err = -EINTR;
 		goto out_fput;
diff --git a/mm/mmap.c b/mm/mmap.c
index 18fddcce03b8..56f9520f85ab 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1260,6 +1260,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	int pkey = 0;
+	unsigned long reqprot = prot, err;
 
 	*populate = 0;
 
@@ -1276,6 +1277,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		if (!(file && path_noexec(&file->f_path)))
 			prot |= PROT_EXEC;
 
+	err = security_mmap_file(file, reqprot, prot, flags);
+	if (err)
+		return err;
+
 	/* force arch specific MAP_FIXED handling in get_unmapped_area */
 	if (flags & MAP_FIXED_NOREPLACE)
 		flags |= MAP_FIXED;
@@ -3198,12 +3203,8 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 		flags |= MAP_LOCKED;
 
 	file = get_file(vma->vm_file);
-	ret = security_mmap_file(vma->vm_file, prot, flags);
-	if (ret)
-		goto out_fput;
 	ret = do_mmap(vma->vm_file, start, size,
 			prot, flags, 0, pgoff, &populate, NULL);
-out_fput:
 	fput(file);
 out:
 	mmap_write_unlock(mm);
diff --git a/mm/nommu.c b/mm/nommu.c
index 7296e775e04e..e632f3105a5a 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -681,7 +681,7 @@ static int validate_mmap_request(struct file *file,
 				 unsigned long pgoff,
 				 unsigned long *_capabilities)
 {
-	unsigned long capabilities, rlen;
+	unsigned long capabilities, rlen, reqprot = prot;
 	int ret;
 
 	/* do the simple checks first */
@@ -818,6 +818,9 @@ static int validate_mmap_request(struct file *file,
 	}
 
 	/* allow the security API to have its say */
+	ret = security_mmap_file(file, reqprot, prot, flags);
+	if (ret < 0)
+		return ret;
 	ret = security_mmap_addr(addr);
 	if (ret < 0)
 		return ret;
diff --git a/mm/util.c b/mm/util.c
index bd283e2132e0..47345e927a8f 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -581,17 +581,14 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 	unsigned long populate;
 	LIST_HEAD(uf);
 
-	ret = security_mmap_file(file, prot, flag);
-	if (!ret) {
-		if (mmap_write_lock_killable(mm))
-			return -EINTR;
-		ret = do_mmap(file, addr, len, prot, flag, 0, pgoff, &populate,
-			      &uf);
-		mmap_write_unlock(mm);
-		userfaultfd_unmap_complete(mm, &uf);
-		if (populate)
-			mm_populate(ret, populate);
-	}
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+	ret = do_mmap(file, addr, len, prot, flag, 0, pgoff, &populate,
+		      &uf);
+	mmap_write_unlock(mm);
+	userfaultfd_unmap_complete(mm, &uf);
+	if (populate)
+		mm_populate(ret, populate);
 	return ret;
 }
 
diff --git a/security/security.c b/security/security.c
index 4564a0a1e4ef..25556629f588 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2927,42 +2927,10 @@ int security_file_ioctl_compat(struct file *file, unsigned int cmd,
 }
 EXPORT_SYMBOL_GPL(security_file_ioctl_compat);
 
-static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
-{
-	/*
-	 * Does we have PROT_READ and does the application expect
-	 * it to imply PROT_EXEC?  If not, nothing to talk about...
-	 */
-	if ((prot & (PROT_READ | PROT_EXEC)) != PROT_READ)
-		return prot;
-	if (!(current->personality & READ_IMPLIES_EXEC))
-		return prot;
-	/*
-	 * if that's an anonymous mapping, let it.
-	 */
-	if (!file)
-		return prot | PROT_EXEC;
-	/*
-	 * ditto if it's not on noexec mount, except that on !MMU we need
-	 * NOMMU_MAP_EXEC (== VM_MAYEXEC) in this case
-	 */
-	if (!path_noexec(&file->f_path)) {
-#ifndef CONFIG_MMU
-		if (file->f_op->mmap_capabilities) {
-			unsigned caps = file->f_op->mmap_capabilities(file);
-			if (!(caps & NOMMU_MAP_EXEC))
-				return prot;
-		}
-#endif
-		return prot | PROT_EXEC;
-	}
-	/* anything on noexec mount won't get PROT_EXEC */
-	return prot;
-}
-
 /**
  * security_mmap_file() - Check if mmap'ing a file is allowed
  * @file: file
+ * @reqprot: protection requested by user
  * @prot: protection applied by the kernel
  * @flags: flags
  *
@@ -2971,11 +2939,10 @@ static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_mmap_file(struct file *file, unsigned long prot,
-		       unsigned long flags)
+int security_mmap_file(struct file *file, unsigned long reqprot,
+		       unsigned long prot, unsigned long flags)
 {
-	return call_int_hook(mmap_file, file, prot, mmap_prot(file, prot),
-			     flags);
+	return call_int_hook(mmap_file, file, reqprot, prot, flags);
 }
 
 /**

base-commit: f89722faa31466ff41aed21bdeb9cf34c2312858
-- 
2.34.1

