Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B10146D6D;
	Wed, 25 Sep 2024 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727245852; cv=none; b=k/yhyDx740uu2Nv0ZezRvm5bmhuTG18uCq8+3OMYfpPbIkz2XJD1D8wQT7jwH+3v4KEtiOOaGs7EYGuw5cZSmwLgTh/tShiewwPrmD6VKvirEkirDBIWyY9uUUaiMMEZ9PDCQGmEz7rstR1raLlb1hE0Qp/4URuv/uOsQ7ItNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727245852; c=relaxed/simple;
	bh=a4El2J/CGkwgdE6VDB5SDWd54wapJPfeB16OgCrbxzk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CzBEYW/LveeBQ59C+aTc+Fido7+BN4ktNTqTdd9glaO0LyRh81hdqa0dedJpN4Ns+gFf612ixfcZ35pGhVcS+l4308jDqQBf1LTkz0aP/6M06ozI9JSQJLjGSMLxa0xOMftkusOOGrAjVyXM2DXLnsgmGCfwE5Fq6Pg622vDtes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePLSFp6P; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePLSFp6P"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7db12af2f31so5249223a12.1;
        Tue, 24 Sep 2024 23:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727245850; x=1727850650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TEgjym0TtI38Qrfj1UEKJYqreTTTMFphxHtKrT+D23c=;
        b=ePLSFp6P7ZDGq+p2CsfusWinL0Q9iKslGNeQEWSZT3nEzODkDzg9JH5rHPCGxJuoHS
         hknctIsTcKUo1X823vG1f6/F1mnU50SHg9ukiSad07gFwDkHY7QYPCqyf+ajLPwHODfU
         0YyMRYGGn7mP++sTKFgfWz1aha3VFM5FwkR5JqQzsPJnA7iX02QuE16BE2gAjSw+3Igm
         BaLiVPK4FBuCNtlfMsL52kGSbS00zalERbDm2Z16pbwJQl7Ly4q86AL+ZTWj7iMAtY6Q
         Hbp/oAE4kNFH4T0ip7eJ3NgAmUEaJCzXOudCh5DXRyq6xr4Av+V+hJKE5TcUkYTfk4Ik
         o+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727245850; x=1727850650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TEgjym0TtI38Qrfj1UEKJYqreTTTMFphxHtKrT+D23c=;
        b=EPs38JibnVouliDqbGuP7n0n90xykrkYtHX+RR9xLybXRqh6Kct+mpGNzMd6E4k2Qf
         lh2fEujqx2LEycIZ/aLedKhzobdlIkgXK+x2Now2JjfA1PYF4fAd/zh70ZIOFDcVSclC
         XaXB9+j9pzq5eGhB89Tygc1VRzJde0GYO0RB4b8K/ACUJNrcDUISO2vowoMOo9GNWRPv
         E/9ymxTTlM289cs0W7lKeYcGjuTG81bhXtvkJiuni06FjCmHvbRbid45HG3U9N/XOpOM
         SuxZm7SD9SD3hws8X7QJZ0ACbRptufbgZZQMSqzZXMZn1Y2at+0huPpaiToFoLXiLdyK
         z4CA==
X-Forwarded-Encrypted: i=1; AJvYcCVhJ70AW6O61KFK604SfyDksuVw0L9Xyw4+uC5mLnK958n8tpKvTboRFNUYX1iIvjLk023wKQ0ut01bHYN1uIbJqy8JK1MD@vger.kernel.org, AJvYcCXAnYKuHNS92DC7yT7TpalBPGEFXee7vvfAnSzvP6+1jDxMkjblWt2rF1OwT7O66ctzox+saejML7rWlAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEUyY4C7eYrExTYY4LBK+fjef7XjStCqclzztslfWGER3SdDRD
	LJmzKLYphbaSAGjQx7p+oli53pn7tlJ86ulu0Xsl1XzIEb35oyD+anzqSQ==
X-Google-Smtp-Source: AGHT+IGkXk5G726B1bvlVw1YnfU7Z8q/7HoDlL0ZukpUfuuT9sk6ReokRRqVgJQPh6wRbW7t/yMP7Q==
X-Received: by 2002:a17:90a:e41:b0:2d8:b43b:6ecc with SMTP id 98e67ed59e1d1-2e06ae27935mr2301917a91.4.1727245850255;
        Tue, 24 Sep 2024 23:30:50 -0700 (PDT)
Received: from localhost.localdomain ([20.37.103.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1e5ac1sm692402a91.34.2024.09.24.23.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 23:30:49 -0700 (PDT)
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
Subject: [PATCH] mm: move the check of READ_IMPLIES_EXEC out of do_mmap()
Date: Wed, 25 Sep 2024 14:30:34 +0800
Message-Id: <20240925063034.169-1-ebpqwerty472123@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch moves the check of READ_IMPLIES_EXEC out of do_mmap(), and
calls the LSM hooks at the same time. The below is reason.

Some logic may want to call do_mmap(), but they are not aware of
the harm this poses to LSM.

For example, CVE-2016-10044[1] has reported many years ago, but the
remap_file_pages() can still bypass W^X policy enforced by SELinux[2].

Add a check is easy, but there may have more calls to do_mmap() in the
furture. And move the security check in do_mmap() will let it in the
mmap_write_lock, which slow down the performance and even have deadlocks
if someone depends on it.

Moving the check of READ_IMPLIES_EXEC out of do_mmap() can keep the LSM
hook is called out of the mmap_write_lock, and avoid repeated logic for
whether READ_IMPLIES_EXEC should add PROT_EXEC for the mapping or not(In
current, the !MMU case won't implies exec if file's mmap_capabilities is
not exist, but the security check logic is different). And all known cases
that call do_mmap() become secure and anyone want to apply the
READ_IMPLIES_EXEC logic will call the LSM hook correctly.

Current call sites to do_mmap():
arch/x86/kernel/shstk.c: must not want to PROT_EXEC in any case.
fs/aio.c: have ensured never have PROT_EXEC in the fix of CVE-2016-10044.
mm/util.c and ipc/shm.c: the common case
mm/mmap.c: in the history, remap_file_pages won't care about the
READ_IMPLIES_EXEC. this side effect is introduced in the emulation
version, after the deprecated mark exist.

Link: https://project-zero.issues.chromium.org/issues/42452389 [1]
Link: https://lore.kernel.org/all/20240919080905.4506-2-paul@paul-moore.com/ [2]
Signed-off-by: Shu Han <ebpqwerty472123@gmail.com>
---
An alternative method is moving security_file_mmap() back into do_mmap(),
i.e. revert the commit 8b3ec6814c83d76b85bd13badc48552836c24839
("take security_mmap_file() outside of ->mmap_sem"), which is simpler,
but it will affect performance.
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

