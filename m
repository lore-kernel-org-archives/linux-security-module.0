Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355AF18BC19;
	Wed, 25 Sep 2024 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266194; cv=none; b=dGZwKVXuGWaoTiAKh5wW/0brfmm19N7vtlBRutrC5FAXCqUHJD0kVreVc/KURbCYLy5+gZIfUmX1v+tpQdPO7IJM5XspId3zF6uLi9QdxaiI7y8EInuj/v3sy3hkWPu78+ET5mQGjRl15HjCMe76KuN1pdypHGbqeAcn8ubN4fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266194; c=relaxed/simple;
	bh=zGQtWAciWNoy8RAoA/LH5lVzNbT0/+bOheO5Nqs+/zE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UZ7wJmow0Dpcc8A1arwUy7XGf5zcgXJWJfvCmpbjeGpOuZycU7z3ZHhSyUYQrkh7/IizkzkVTI3VbX3cgEKwvpnvwq+Sv4vMzpLq430K8xtg42b0kP7ccSm849lgE4hQ5WwsFHv0ALA52qppNqS00fmwvG0d/jMS+alhvsPQGno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yh7/+9aF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yh7/+9aF"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2054feabfc3so59631905ad.1;
        Wed, 25 Sep 2024 05:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727266192; x=1727870992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l2FisBVLQp+Mpp2gLe0+K2SdxwaKyaEx+US7Xl2Qlvk=;
        b=Yh7/+9aF95N0xER4jHZbKaD/PjHZfYsdd+E/NpCn5YUccQ/V4Hek9wDjTimU1aGaYk
         zqXUzn/sVv16alr7B5W1tP4VO00a+qbgHFj44pQI4fBSoSJTho7qh1butmgAYyANPSxA
         N7FdMZ5If+/c5E4AZUrbhytQMz2Xp9bUPTmPfAH5F2e/NLm+H3PsGWrqCT/8AYQFNGXo
         MrkpM9Lq6IDyMuHxgQ4a5Hsd/rdSO7syb8XDCYiInwanoC95CNVpncK5hxJMwGiZfu9c
         lEgGHNEHRdjnu4LZnKR+MWuOcIW95yIEV58xcqekjGvhpY/G1tDk+2tehdQQN5eL9K1e
         /H3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727266192; x=1727870992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2FisBVLQp+Mpp2gLe0+K2SdxwaKyaEx+US7Xl2Qlvk=;
        b=tcpsJ2TO2Sllr0y/6iC1/KNeFreifrcm7cIBRPNPbAGQE3RwIl6t8k3iCb9G2/Q+24
         b7rsvUSA9ykVNfQ7kA1xpX0va1pj1ut5fDhaDA76CFK2lW7UCYobXG4T+HAvScn8zcbZ
         M0Sbee/ME/Nyt/93ioK72aM/P9EueObdkhtH9XbNuBqbEFarGexVtca4r3uo5IDYAosD
         4/W3LzUEISNigzUC8rdP+TLlwIE5aRN0xunHGd7azlpJFlqDs5SZdzpM9mgesROWOQuA
         F0siryg+BRodrmerMEXJxWaQj2q5G6GpANs3H+6qN67LICZq9w9i6ChdxR8Elm06Hcwk
         AByQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3dwDEi7+z/fdWmFNfXguZEydA1zCgniGUvar0+svYdALSamlIJhe8fYP/9h/S/OHISKEdTxZl/1VhbiU=@vger.kernel.org, AJvYcCXGRN9X9l07FxpnyfS1lXSdHY9q6qwyE6laFlNq3LPrlVQn9AmQ3BGBrb/iDUwEd+QVWXEeH8+3sKCB7ldn6OROt/h6WCRf@vger.kernel.org
X-Gm-Message-State: AOJu0YxQM624C3bYPgFx8lLL1iIbt+TZY61z2BIz4o8JfWcNDaL3/tJK
	pzhqSvVAmG9Zm3YX4oES+Ca+5tSYbnzNKTyWb+91gtsV1wfena5/
X-Google-Smtp-Source: AGHT+IGWXYyYBWq7oMhjqosyqQ8QO24wRHge8W0P3gCGMEEoJNBxzafLWhP/hFeRitwp1xtW5F0klQ==
X-Received: by 2002:a17:902:eccc:b0:207:6e8:1d84 with SMTP id d9443c01a7336-20afc4d809dmr33236615ad.42.1727266192161;
        Wed, 25 Sep 2024 05:09:52 -0700 (PDT)
Received: from localhost.localdomain ([20.37.103.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af16e0340sm23547885ad.51.2024.09.25.05.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 05:09:51 -0700 (PDT)
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
Subject: [PATCH RFC v2] mm: move the check of READ_IMPLIES_EXEC out of do_mmap()
Date: Wed, 25 Sep 2024 20:09:40 +0800
Message-Id: <20240925120940.309-1-ebpqwerty472123@gmail.com>
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

Some logic may call do_mmap() which adding PROT_EXEC internally when the
user controlled READ_IMPLIES_EXEC flag is set, without being aware of the
harm this poses to LSM.
For example, CVE-2016-10044[1] was reported many years ago, but the
remap_file_pages() can still bypass the W^X policy enforced by SELinux[2]
for a long time.

Adding checks is easy(and has been done in all required call sites for
the current version), but there may have more calls to do_mmap() in the
future. And moving the security check in do_mmap() will let it in the
mmap_write_lock, which slows down the performance and even have deadlocks
if someone depends on it.

Moving the check of READ_IMPLIES_EXEC out of do_mmap() can keep the LSM
hook is called out of the mmap_write_lock, and avoid repeated logic for
whether READ_IMPLIES_EXEC should add PROT_EXEC for the mapping or not(In
current, the !MMU case won't implies exec if file's mmap_capabilities is
not exist, but the security check logic is different). And all known cases
that call do_mmap() become secure and anyone who want to apply the
READ_IMPLIES_EXEC logic will call the LSM hook correctly.

Some minor behavioral changes to call sites to do_mmap() and why they
should clearly be fine:
mm/util.c and ipc/shm.c: the common case, no changes in behavior.
fs/aio.c: have ensured never have PROT_EXEC in the fix of CVE-2016-10044,
so no changes in behavior.
arch/x86/kernel/shstk.c: must not want to PROT_EXEC in any case.
since shadow stack is a stack only store return addresses,
execute it is never required.
mm/mmap.c: in the history, remap_file_pages won't care about the
READ_IMPLIES_EXEC. this side effect is introduced in the emulation
version after the deprecated mark exists. The patch only remove the
side effect introduced.

Link: https://project-zero.issues.chromium.org/issues/42452389 [1]
Link: https://lore.kernel.org/all/20240919080905.4506-2-paul@paul-moore.com/ [2]
Signed-off-by: Shu Han <ebpqwerty472123@gmail.com>
---
V2: Add RFC tag as lorenzo.stoakes@oracle.com suggested, and refine the
comment in patch.
V1: https://lore.kernel.org/all/20240925063034.169-1-ebpqwerty472123@gmail.com/
Alternatives:
1. mm: move security_mmap_file() back into do_mmap()
https://lore.kernel.org/all/20240925115701.73-1-ebpqwerty472123@gmail.com/
2. Add sufficient comments for do_mmap()
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
index 18fddcce03b8..b8992ee202fe 100644
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
+ * The caller must ensure security check is not needed or
+ * call to mmap_check_prot before.
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

