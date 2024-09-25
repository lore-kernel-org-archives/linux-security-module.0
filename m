Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEDC15C121;
	Wed, 25 Sep 2024 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265435; cv=none; b=ISGizsyEaZZCi0zScvQZxK6brs8SHjjzR3VteVh1SkUmXG2J8cH2jAvmGHk/jicIyvybMdDwH2I6GNUOZqbWNWKyl/pPHb61MhFNF2UP63UjkkZ7cf1Z8rmiPGNZiQG1Ub7V2NC04L71gz4U2p7bnGIygTR523eDayN7TpufmNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265435; c=relaxed/simple;
	bh=yi1RlJbQdSv6pVneD1OvcKh7gexi9Orss4sw5tT5dnw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k09MzMohLTc0KalItVOIiYByCjSfS+rqtAo/aynmIZrQtVNRowRScHnCyX+UZAKgr0p4Zb/cZzEwbyf/PcLG6AE8rnmAYT4MLa8SwPB8JHW1imIe9EF6tLJfadmOzXhgijfff9ieHULthavfqOQspQFC+dV5H8Kx2raZbqiT8tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mtksfjc4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mtksfjc4"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2059204f448so57421635ad.0;
        Wed, 25 Sep 2024 04:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727265433; x=1727870233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2kVeDhwyp3qq2JlkrO+2laFA9/t+LTVrg2fHPuiA8mM=;
        b=Mtksfjc4dVxTLHCaKZICmPBuqiAetk38tYOimH7hCsDkuRJEGQPS1NAsJydGVoOWYy
         hZciqQcVYQKy1AY0/zHVJG5MtpcPIyB1I1iYmR+/F5coRuWjR5OycFhk/6Y395jl0qd/
         lojdc5WBWEzuV6tizAnfmuHLW2ait5FhH1VTwApkzr1Crm/JfQurjpZcfd+StMRdPzN6
         s2fznM37RqpC/bZcBh0pkTrFTaf6nw85rmGUDrMXD4tTvI+CpGx+MgBUkzeG0XQ0eSsD
         tj092/dghz+kG/lYLZ1EL76RNSdzi0XllIJXWGTh+nS/tptcMqqWrZbaDP4EF5/RajWr
         puUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727265433; x=1727870233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kVeDhwyp3qq2JlkrO+2laFA9/t+LTVrg2fHPuiA8mM=;
        b=SF3NSZoC1mrnGyI4umSu08TgphTF3xXYWSVWYnBznenPZdnAH6XCrVQcolcK4UwBGV
         a/cZcnR0HqQlpRcjAfapSHPTKOEZHA9kM8s4y2VQEsQkUNIfFnPC4V2jm3E5kVopdJh8
         YgLiDzeNRcPHNkOp+yy9Se1nyb3QsxATIiAl6bjH4DFSKgt0RVZvt+o70Kev+c7YrtMo
         ekoIqidUmcDd96ui1AMD12vtphRohCgvigiz6D0wKPDNMz2dy8mjoSUgh07yckgE9F2Q
         1nHzrL5n5BVbFSOpjbzjjN5zkHahZyqhvV4NNASYw6QAsLSvT5nVjWMNezOphoO0ZjhJ
         DzZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXOVH/DCe/oNyPrdT6/kKUdHKkkvHZcAdpq7h4U7sLCz9a0hUpfMV6HA+9pSrYjZf5ulPDbwBTiru6nEpfFkzTRc/Vd6z6@vger.kernel.org, AJvYcCX9f5Cbt30Buu5eNkoNJjZiYQxfhZ0K0XWGj0b2ZXttChZGgq7NH7U1FOwQhDgPCscmcKEp+Wv1rEfjSPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdDz1rSxhc6yeYpRVwcvmp52Tv+5zekzOBhkAy13gLfVxflbRj
	ZYpt+pGlHSLWpHk0sl9TKOx64qM+UbCvcXJ9wEDhgjrE5+HrblYc
X-Google-Smtp-Source: AGHT+IEk8pPYrms9s27HbZBRf9WGxJI4CcOZxynSGdGZzlqeTJ4SAtNVpNTKec9qDw+CqpSLwR/QuQ==
X-Received: by 2002:a17:903:24c:b0:206:9693:7d5b with SMTP id d9443c01a7336-20afc641ad4mr32952595ad.55.1727265432830;
        Wed, 25 Sep 2024 04:57:12 -0700 (PDT)
Received: from localhost.localdomain ([20.37.103.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17e2dc9sm23565585ad.135.2024.09.25.04.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 04:57:12 -0700 (PDT)
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
Subject: [PATCH RFC v2] mm: move security_mmap_file() back into do_mmap()
Date: Wed, 25 Sep 2024 19:57:01 +0800
Message-Id: <20240925115701.73-1-ebpqwerty472123@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch moves the security_mmap_file() back into do_mmap(), which
revert(It is conceptually a revert of the commit(revert the feature
change in the commit), but not in the git sense(revert lines))
the commit 8b3ec6814c83d76b85bd13badc48552836c24839
("take security_mmap_file() outside of ->mmap_sem"). Below is the reason.

Some logic may call do_mmap() without calling security_mmap_file(),
without being aware of the harm this poses to LSM.
For example, CVE-2016-10044[1] was reported many years ago, but the
remap_file_pages() can still bypass the W^X policy enforced by SELinux[2]
for a long time.

Adding checks is easy(and has been done in all required call sites for
the current version), but there may have more calls to do_mmap() in the
future. Moving security_mmap_file() back into do_mmap() can avoid
forgetting, and avoid repeated logic for whether READ_IMPLIES_EXEC should
add PROT_EXEC for the mapping or not(In current, the !MMU case won't
imply exec if the file's mmap_capabilities is not exist, but the
security check logic is different).

It is noteworthy that moving the security check in do_mmap() will let it
in the mmap_write_lock, which slows down the performance and even have
deadlocks if someone depends on it(Since security_file_mprotect() is
already in the lock, this possibility is tiny), which requires LSM modules
to check.

Link: https://project-zero.issues.chromium.org/issues/42452389 [1]
Link: https://lore.kernel.org/all/20240919080905.4506-2-paul@paul-moore.com/ [2]
Signed-off-by: Shu Han <ebpqwerty472123@gmail.com>
---
V2: Add RFC tag as lorenzo.stoakes@oracle.com suggested, and refine the
comment in patch.
V1: https://lore.kernel.org/all/20240925081628.408-1-ebpqwerty472123@gmail.com/
Alternatives:
1. mm: move the check of READ_IMPLIES_EXEC out of do_mmap()
2. Add sufficient comments for do_mmap()
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

