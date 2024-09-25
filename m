Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37AB13D891;
	Wed, 25 Sep 2024 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275983; cv=none; b=AHVek/dIel6be8UliAf3s+RoTp6geVm5JgaFeByeZGzwM+z2fYb0sUubeTrioKD1SlxnvTxwXZ8jC4Xxd+cswACk3NPEZOiu6HTc9rUaqK+1QoBSmMlhNepAxOwxhrl9SzUqobFWBbFcdO8MsYA4Bb0nuKVvthMJVkPyV9Va36M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275983; c=relaxed/simple;
	bh=hLCric22CNEYkbsVVF9vR+LHrwmbplFSrUXbWrG3z0g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GAppJ3P61P6ML6vGOP2z/R/EG4aKtKubmfp9P4HfCuqB61NSEBErFuY16IJ5CP2nvn09p0yl2a05acjtu8VnrDXRAypPIGr4Lo6Hm6vgEHgPM+lkono6cY3KNll01QYph+sVo70CgeE0xvR4W6AvK494tgyTTkdfL8+w5hua8nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT5RF/Jk; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT5RF/Jk"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2dee71e47c5so3178114a91.0;
        Wed, 25 Sep 2024 07:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727275981; x=1727880781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=URux+BlQKOTmnPYbOPO7cMHEzkvt3JkZ4l1c9KS0fJs=;
        b=UT5RF/JkcDGLFl0jp4FO+f92NdD18EosG+jH15uv1oATAY4W+ouxKRXNz3dmIG/gBr
         IytbyyrwVp3589K2KcTi+044UfTAb+a5j9fYGVZKyTWkAVU+8yc6BCXlkCK297x11GM2
         01RU+WQqtsEWUW8HlBjPcefCl7Z6J3tfULM1HntpDFB4DmJcIZPettjWnoSrHcw/T0BX
         ovI4XTiTXavSynMDKB+7si/NnEqcUM+quhiFOQJoo0Ri8PUsJEQlMZmLpduFvguCqo0N
         jMzJOH89YSQ4BIMJVmLuoES+mgjdShosUut4p5Wa054rS0VyCmHZRPKeMudKtE9vIa52
         U4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727275981; x=1727880781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URux+BlQKOTmnPYbOPO7cMHEzkvt3JkZ4l1c9KS0fJs=;
        b=DSbf7hncia6V7otVxDaVRSBB+hatj5rCD97wEa3S8sHTFLTFOoBSD/OvyBReywrkQc
         ar09Ud+q1ZDuwDFwSpD6jqSdH5FotZQ3a7Dg+FZ3YTZ82naOMM1h++nwJhE5iGi6NpDr
         EIW2ZmbZCnO9eTLqqBTeuedwtCnxegrMs3sA5718LT8r7/etbw9md4Okyq8i5uJMn2QO
         RFTEyizr4V7lV4lgrwGeB5/hQjWarGs4M76TNBMwiTgGkX8ZhzD+Vfq4ICdHRioyBzCq
         E/6OSLV858/dZ71K2gfYRx2EG1t+O9WjP9ONcHlkzpoMcufeocFvkTXeigEGzeLwPDwG
         KyDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMmE9WHGYSP7rcw8bT4+6Jw9yVvP0VWI/n+YwrQ8NfvtiJlod32n2d5HCwo8c5jvTMqULQxHO+INrvGOI=@vger.kernel.org, AJvYcCXkFcrn9zHIiig1fEM/1PGlIhx61dkSsjZPhQseyQTVCPYCWhKYWGTEYf75CwU06Bb8876WgU+Ag3Lyb0e8jfh0yYs0PZHx@vger.kernel.org
X-Gm-Message-State: AOJu0YzztZ03ujLv9cdrrC6M9NzcREFAOMTE6vxy0uKuDf5PLtUbmMgF
	iMCkysyEResqZM75mdfmrQ4dpMDkf10sApaIAPz1eTgG28F7eXwu
X-Google-Smtp-Source: AGHT+IGhPUQZ+n7yszk/KE8RG3Zymew7SBluMpTMIvTEWbClRv5v274GFfjA4XG98dYXWJBNZDsnmg==
X-Received: by 2002:a17:90b:4a4f:b0:2d8:aa9c:e386 with SMTP id 98e67ed59e1d1-2e06ae5e76dmr3991797a91.14.1727275981094;
        Wed, 25 Sep 2024 07:53:01 -0700 (PDT)
Received: from localhost.localdomain ([20.37.103.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1fedadsm1622558a91.28.2024.09.25.07.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 07:53:00 -0700 (PDT)
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
Subject: [PATCH RFC v3] mm: move the check of READ_IMPLIES_EXEC out of do_mmap()
Date: Wed, 25 Sep 2024 22:52:49 +0800
Message-Id: <20240925145249.50-1-ebpqwerty472123@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch moves the check of READ_IMPLIES_EXEC out of do_mmap(), and
calls the LSM hooks at the same time. Below is the reason.

This patch is related to:

1. the personality flag READ_IMPLIES_EXEC, which can be changed in
   userspace and will add PROT_EXEC to prot in do_mmap() when it is set and
   some other conditions are met.
2. the LSM hook security_mmap_file, which requires the prot before and
   after 1.

For now, this is the mmap() logic that actually executes (only the part
we care):

1. call security_mmap_file()
1.1. calculate the final prot in mmap_prot()
1.2. call hooks by the original prot and the final prot
2. lock mmap_write_lock
3. call do_mmap()
3.1. calculate the final prot again according to the personality flag
     READ_IMPLIES_EXEC and other conditions
3.2. do the actual memory map with the final prot
4. unlock mmap_write_lock

There are 2 problems with them:
1. The final prot is calculated twice, which is redundant. And currently,
   the !MMU case won't imply exec if the file's mmap_capabilities do not
   exist in step 3.1, but step 1.1 is different.
2. Some other call sites call do_mmap() without step 1, which is still
   secure if there is no step 3.1 since they map an anonymous page or a
   private file without PROT_EXEC, which is not cared for by LSM. So, it
   is implied that it is call sites' duty to do step 1.1 or let step 3.1
   never take effect(let other conditions not be met, such as marking the
   mapped file as NO_EXEC).

Especially the implicit duty in problem 2 is rarely noticed by the caller,
which leads to some security issues(in aio[1] and remap_file_pages[2]).
It is believed that the future call sites to do_mmap() is easily to harm
the security if we don't take measures.

The measures in this patch are moving step 3.1 out of do_mmap(), into the
new function mmap_check_prot(), and calling the LSM hooks in the same
function. The function is out of the mmap_write_lock.

The measures remove the repeated logic in step 1.1 and let further call
sites have 2 choices:
1. call mmap_check_prot() before calling do_mmap(), which is equal to the
   current steps 1-4.
2. call do_mmap() directly, which is still secure since there is no
   step 3.1 in do_mmap() anymore.

The potential harm that remains without precedent is a new caller calls
do_mmap() with a non-private file and the PROT_EXEC flag, which is
mentioned in the comment of do_mmap().

The measures have a minor behavior change, which is:

If the call site selects choice 2 and the conditions for READ_IMPLIES_EXEC
are met, there will be no PROT_EXEC automatically added anymore.

This is all call sites currently and why they should clearly be fine:
1. mm/util.c: choice 1.
2. ipc/shm.c: choice 1.
3. fs/aio.c: the conditions for READ_IMPLIES_EXEC will never be met since
             the patch for [1] adds the noexec flag.
4. arch/x86/kernel/shstk.c: must not be intended to have PROT_EXEC, since
                            shadow stack is a stack that only store return
                            addresses, executing it is never required.
5. mm/mmap.c: in the history, remap_file_pages won't change prot, which is
              changed in the emulation version after the deprecated mark
              exists. the patch only revert the side effect introduced in
              the emulation version.

Link: https://project-zero.issues.chromium.org/issues/42452389 [1]
Link: https://lore.kernel.org/all/20240919080905.4506-2-paul@paul-moore.com/ [2]
Signed-off-by: Shu Han <ebpqwerty472123@gmail.com>
---
May require a better name for mmap_check_prot().
v3: Send only one version as lorenzo.stoakes@oracle.com suggested and
    rewrite the description more clearly.
    Sorry for the inconvenience caused by v1 and v2.
v2: Add RFC tag as lorenzo.stoakes@oracle.com suggested, and refine the comment in the patch.
    https://lore.kernel.org/all/20240925120940.309-1-ebpqwerty472123@gmail.com/
v1: The original.
    https://lore.kernel.org/all/20240925063034.169-1-ebpqwerty472123@gmail.com/
Alternatives:
1. Add sufficient comments for do_mmap() without code changes.
   This method remains problem 1 unsolved.
2. Move security_mmap_file() back into do_mmap().
   No cases should caller to be taken care anymore, but LSM modules should
   check their hook for mmap_file works fine in the mmap_write_lock.
   The detail is in(separating it should be a mistake)
   https://lore.kernel.org/all/20240925115701.73-1-ebpqwerty472123@gmail.com/
---
 include/linux/mm.h       |  2 ++
 include/linux/security.h |  8 +++----
 ipc/shm.c                |  2 +-
 mm/mmap.c                | 42 ++++++++++++++++++++++------------
 mm/nommu.c               | 49 +++++++++++++++++++++++++++++++---------
 mm/util.c                |  2 +-
 security/security.c      | 41 ++++-----------------------------
 7 files changed, 78 insertions(+), 68 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c4b238a20b76..83f334590b06 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3392,6 +3392,8 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 extern unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 	struct list_head *uf);
+extern int mmap_check_prot(struct file *file, unsigned long *prot,
+	unsigned long flags);
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
 	vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate,
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
index 3e3071252dac..f1095ee3796d 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1636,7 +1636,7 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 	sfd->vm_ops = NULL;
 	file->private_data = sfd;
 
-	err = security_mmap_file(file, prot, flags);
+	err = mmap_check_prot(file, &prot, flags);
 	if (err)
 		goto out_fput;
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 18fddcce03b8..b979a6055f8e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1249,8 +1249,36 @@ static inline bool file_mmap_ok(struct file *file, struct inode *inode,
 	return true;
 }
 
+int mmap_check_prot(struct file *file, unsigned long *prot,
+		    unsigned long flags)
+{
+	unsigned long req_prot = *prot;
+	unsigned long new_prot = req_prot;
+	int err;
+
+	/*
+	 * Does the application expect PROT_READ to imply PROT_EXEC?
+	 *
+	 * (the exception is when the underlying filesystem is noexec
+	 *  mounted, in which case we don't add PROT_EXEC.)
+	 */
+	if (((req_prot & (PROT_READ | PROT_EXEC)) == PROT_READ) &&
+	    (current->personality & READ_IMPLIES_EXEC) &&
+	    !(file && path_noexec(&file->f_path)))
+		new_prot |= PROT_EXEC;
+
+	err = security_mmap_file(file, req_prot, new_prot, flags);
+	if (err)
+		return err;
+
+	*prot = new_prot;
+	return 0;
+}
+
 /*
  * The caller must write-lock current->mm->mmap_lock.
+ * The caller must call mmap_check_prot before if
+ * (file && !IS_PRIVATE(file_inode(file)) && (prot & PROT_EXEC)).
  */
 unsigned long do_mmap(struct file *file, unsigned long addr,
 			unsigned long len, unsigned long prot,
@@ -1266,16 +1294,6 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	if (!len)
 		return -EINVAL;
 
-	/*
-	 * Does the application expect PROT_READ to imply PROT_EXEC?
-	 *
-	 * (the exception is when the underlying filesystem is noexec
-	 *  mounted, in which case we don't add PROT_EXEC.)
-	 */
-	if ((prot & PROT_READ) && (current->personality & READ_IMPLIES_EXEC))
-		if (!(file && path_noexec(&file->f_path)))
-			prot |= PROT_EXEC;
-
 	/* force arch specific MAP_FIXED handling in get_unmapped_area */
 	if (flags & MAP_FIXED_NOREPLACE)
 		flags |= MAP_FIXED;
@@ -3198,12 +3216,8 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
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
index 7296e775e04e..96761add1295 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -792,12 +792,6 @@ static int validate_mmap_request(struct file *file,
 		if (path_noexec(&file->f_path)) {
 			if (prot & PROT_EXEC)
 				return -EPERM;
-		} else if ((prot & PROT_READ) && !(prot & PROT_EXEC)) {
-			/* handle implication of PROT_EXEC by PROT_READ */
-			if (current->personality & READ_IMPLIES_EXEC) {
-				if (capabilities & NOMMU_MAP_EXEC)
-					prot |= PROT_EXEC;
-			}
 		} else if ((prot & PROT_READ) &&
 			 (prot & PROT_EXEC) &&
 			 !(capabilities & NOMMU_MAP_EXEC)
@@ -810,11 +804,6 @@ static int validate_mmap_request(struct file *file,
 		 * privately mapped
 		 */
 		capabilities = NOMMU_MAP_COPY;
-
-		/* handle PROT_EXEC implication by PROT_READ */
-		if ((prot & PROT_READ) &&
-		    (current->personality & READ_IMPLIES_EXEC))
-			prot |= PROT_EXEC;
 	}
 
 	/* allow the security API to have its say */
@@ -992,6 +981,44 @@ static int do_mmap_private(struct vm_area_struct *vma,
 	return -ENOMEM;
 }
 
+int mmap_check_prot(struct file *file, unsigned long *prot,
+		    unsigned long flags)
+{
+	unsigned long req_prot = *prot;
+	unsigned long new_prot = req_prot;
+	int err;
+
+	/*
+	 * Does the application expect PROT_READ to imply PROT_EXEC?
+	 *
+	 * (the exception is when the underlying filesystem is noexec
+	 *  mounted or the file does not have NOMMU_MAP_EXEC
+	 * (== VM_MAYEXEC), in which case we don't add PROT_EXEC.)
+	 */
+	if ((req_prot & (PROT_READ | PROT_EXEC)) != PROT_READ)
+		goto check;
+	if (!(current->personality & READ_IMPLIES_EXEC))
+		goto check;
+	if (!file) {
+		new_prot |= PROT_EXEC;
+		goto check;
+	}
+	if (file->f_op->mmap_capabilities) {
+		unsigned int caps = file->f_op->mmap_capabilities(file);
+
+		if (!(caps & NOMMU_MAP_EXEC))
+			goto check;
+		new_prot |= PROT_EXEC;
+	}
+check:
+	err = security_mmap_file(file, req_prot, new_prot, flags);
+	if (err)
+		return err;
+
+	*prot = new_prot;
+	return 0;
+}
+
 /*
  * handle mapping creation for uClinux
  */
diff --git a/mm/util.c b/mm/util.c
index bd283e2132e0..2eb4d6037610 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -581,7 +581,7 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 	unsigned long populate;
 	LIST_HEAD(uf);
 
-	ret = security_mmap_file(file, prot, flag);
+	ret = mmap_check_prot(file, &prot, flag);
 	if (!ret) {
 		if (mmap_write_lock_killable(mm))
 			return -EINTR;
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

