Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EEC3C0C;
	Sat, 28 Sep 2024 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727546460; cv=none; b=FGIu00IIHYDv6TzUIVDdl0UZqBHiqq2HSVq8i6fGa9D7vJoO8iqRK7dv04kWYm2OmUU7bXqHDECTEk1fNx6P1dOkczl2KgphA0czdJggDXXK5MRq2nEpRgBpt/rfJkNT7D5VojG11jC1Gz6CTrafKvZ++XuSnpXYGrAZKldO3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727546460; c=relaxed/simple;
	bh=Ql4dS6CSU59YDPuYlaVujLhGtSQ8kBFRWZShXVtAATo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ofXTwxifERBBO+af6F9q5eqi3egJfxQiJkBZGExujWMC0EtBVEhmg2Lu0Rsr6W5p4vpvNzydu4Swz0EXaqAvEbeK8q4Eugq2pqAJKX0xZK4+wXhZWJINAz9V2enG4etoid6EmxSU74ri4sKgVAVzHQW6DNBFgndLnD7tMO705/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hd7OfI5H; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hd7OfI5H"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6e7b121be30so2120515a12.1;
        Sat, 28 Sep 2024 11:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727546458; x=1728151258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U2+GsiuIKpICD0jp4J/MwRwjOL4N458aVUdezvXmH88=;
        b=hd7OfI5H9U0WeyUR6F+hJdx0XlFe73HMcmLM/QjRZ+WRzaWRTVD4i8NXY5+AehmnoU
         92Qk8PEnXPUQf8HwqlH3LIvjVBZ4CiGVdIE9EDIINIdtw2I78t7cTqpwFVxFtFO89j6E
         uOr/b8k/LUAV+GgqmoxUCoODun13XFSOo+vUsaweNxEotVGn9NckSTnnzn06+2hWux9M
         fus0xoVZFdHTVrdfS2ZQ6cIjtceDFG7DeOzx7c5Vizv5DS1VCWUf/EKqOiOTU0nGFxkD
         R4R7LIrhKvQHE/O8/LrhrZMF8uqa4jw1aRIIAaH0N568TtqOkm6QVBAvoRNTX1rq9iOs
         DamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727546458; x=1728151258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2+GsiuIKpICD0jp4J/MwRwjOL4N458aVUdezvXmH88=;
        b=KkH0Ye6Mj9HrfhJE+DtUaU3Nsyu+ssmdXCSq4rK02NTiwNej0xak23oeoi5udnekW4
         EV7IkL+CK0/YPUknr4HCDxNwPsA/8HLq8CPuf3n9gQ7itvvEt4+JGN6H/Jp8gpC4oFQx
         mi++wpYXza9oakW3A2lg7K3gI4otJZDG5tp+JZJOBJoNLQENorPtep4iDKodl+xMNOy8
         Rgb4wZeQQKy29U98twEMs8vzCW7H04/R32pZMqrS7YwMJehmNY2U9+m87D+Y+iwR9QWy
         landbejKSfYllyx6+QFD07IV05tEV/iabv5Koy4yWWo+Dsoo5PVnIEK7isksvtBZMO2h
         nR+w==
X-Forwarded-Encrypted: i=1; AJvYcCVrTpy4fudJ4Bvwu3UB7CfQhTklS/hsIBMkQXMsN4fdF4PEO/TiVbGdD4Rmkbd5dZsrypJpRDnIh4KTf/8Fokf+A05QK+93@vger.kernel.org, AJvYcCX2W+fgPiqPovhfYCsuXDqrCn5zHkPQVAg1/RJPoXuQyqIIxwP3xbWl2RSoPYC0YCKB1sMmc+puLgmjP9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVsV70f6GmiHCihYeaFVABO5gheLPJSUzw0yWeE0MZbEjrhIfs
	Il99XJs+b2GZERiY2RoMRSUfnPh/kmw+OiYaMMeG21MJSSPyU8Qv
X-Google-Smtp-Source: AGHT+IEVmr91INafLLcN+NX6rAWIWchNBGjB3qLEDxQMYuCAirU2pxQYk8LGqwVkkAqHmGlM/Yd82w==
X-Received: by 2002:a05:6a21:710a:b0:1cf:51a1:8e89 with SMTP id adf61e73a8af0-1d4fa815ec4mr10490782637.47.1727546457353;
        Sat, 28 Sep 2024 11:00:57 -0700 (PDT)
Received: from localhost.localdomain ([20.37.103.148])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db605029sm3513516a12.81.2024.09.28.11.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 11:00:56 -0700 (PDT)
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
	linux-security-module@vger.kernel.org,
	syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
Subject: [RFC PATCH v4] mm: move the check of READ_IMPLIES_EXEC out of do_mmap()
Date: Sun, 29 Sep 2024 02:00:44 +0800
Message-Id: <20240928180044.50-1-ebpqwerty472123@gmail.com>
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
do_mmap() with a non-private file or have both PROT_WRITE|PROT_EXEC flags,
which is mentioned in the comment of do_mmap(). mmap_region() is in the
same state.

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

Solving the problem 2 in [2] by this way can remove the check introduced
in the original patch(done in this patch) is also solving the deadlock
mentioned in [3].

Link: https://project-zero.issues.chromium.org/issues/42452389 [1]
Link: https://lore.kernel.org/all/20240919080905.4506-2-paul@paul-moore.com/ [2]
Link: https://lore.kernel.org/linux-mm/66f7b10e.050a0220.46d20.0036.GAE@google.com/ [3]

Reported-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/66f7b10e.050a0220.46d20.0036.GAE@google.com/
Fixes: ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in remap_file_pages()")
Signed-off-by: Shu Han <ebpqwerty472123@gmail.com>
---
May require a better name for mmap_check_prot().
v4: Take mmap_region into consideration, which is found by
    lorenzo.stoakes@oracle.com, and refine the comment in the patch, and
    add the deadlock reason.
v3: Send only one version as lorenzo.stoakes@oracle.com suggested and
    rewrite the description more clearly.
    https://lore.kernel.org/all/20240925145249.50-1-ebpqwerty472123@gmail.com/
v2: Add RFC tag as lorenzo.stoakes@oracle.com suggested, and refine
    the comment in the patch.
    https://lore.kernel.org/all/20240925120940.309-1-ebpqwerty472123@gmail.com/
v1: The original.
    https://lore.kernel.org/all/20240925063034.169-1-ebpqwerty472123@gmail.com/
Alternatives mentioned in v3 may not worked well, but this patch is still:
1. Add sufficient comments for do_mmap() without code changes.
   This method remains problem 1 unsolved.
   Hard to solve the remap_file_pages() issue properly.
2. Move security_mmap_file() back into do_mmap().
   i.e. revert
   8b3ec6814c83("take security_mmap_file() outside of ->mmap_sem")
   which may also cause the deadlock mentioned in [3].
---
 include/linux/mm.h       |  2 ++
 include/linux/security.h |  8 +++----
 ipc/shm.c                |  2 +-
 mm/mmap.c                | 51 +++++++++++++++++++++++++++++-----------
 mm/nommu.c               | 49 +++++++++++++++++++++++++++++---------
 mm/util.c                |  2 +-
 security/security.c      | 41 ++++----------------------------
 7 files changed, 87 insertions(+), 68 deletions(-)

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
index 18fddcce03b8..3722c7f38a5a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1249,8 +1249,39 @@ static inline bool file_mmap_ok(struct file *file, struct inode *inode,
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
+ * The caller must consider to call mmap_check_prot or
+ * security_mmap_file before if
+ * (file && !IS_PRIVATE(file_inode(file)) || (
+ *  ((prot & PROT_EXEC) || (vm_flags & VM_EXEC)) &&
+ *  ((prot & PROT_WRITE) || (vm_flags & VM_WRITE)))).
  */
 unsigned long do_mmap(struct file *file, unsigned long addr,
 			unsigned long len, unsigned long prot,
@@ -1266,16 +1297,6 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
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
@@ -2846,6 +2867,12 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
 }
 
+/*
+ * The caller must write-lock current->mm->mmap_lock.
+ * The caller must consider to call security_mmap_file before if
+ * ((file && !IS_PRIVATE(file_inode(file))) ||
+ *  (vm_flags & VM_EXEC) && (vm_flags & VM_WRITE)).
+ */
 unsigned long mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
@@ -3198,12 +3225,8 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
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

