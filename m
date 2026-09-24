Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF5B45FFD0;
	Thu, 24 Sep 2026 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244161; cv=none; b=OQ/Xy+4sqxqPqESmtMj3cUVVLm7YUCZJBWjpph2hl+TkiMvqwi5PKO0pT0BWjg8/i37wnMwZT7k/Y6UAcJklUdsYqBatdxiabDbS/Ytxp0ra+P41pe8dK/hLEddQzHbul3SMFsIf5j3g1YBXzYCSqiohIr7HHFmk4gNFMnzsKpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244161; c=relaxed/simple;
	bh=GQ48VFT/4iDnIs9T5r2L9cI3nsiDUQaqivsQUdQkZiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rPS035sP3oFsAYqRTsGWpPlMWY5LJU2fXBk5HEz1WJmuvybqXWW+dO7aey1oGgrbwMjd2ZM9TOknfGzG3ZrMtMzWYmmAbvHjbY1kzV2Mnwr9bCaDyW2m1kfKSL4prnXnAlgTyIbfranwRQjDiSmFDC/y+TntW8VHVOEn/2fKs1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowABnajgg9bRqrumVCA--.9312S2;
	Thu, 24 Sep 2026 18:02:08 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: fahimitahera@gmail.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] landlock: Fix domain leak on concurrent F_SETOWN and file release
Date: Thu, 24 Sep 2026 10:02:06 +0000
Message-Id: <20260924100206.173523-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABnajgg9bRqrumVCA--.9312S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWkXr4ktry3AFyUGry8Zrb_yoWxXr4kpF
	WYga15Kr48JF40ka17GFs7ZFyavw4rtr47WFZ3GrWfJa4ayF18Za1xur129F45Gr4kAr4Y
	qr1UKFZ09FWDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx
	0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
	IFyTuYvjxUg5r4UUUUU
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/

The Landlock domain reference recorded by hook_file_set_fowner() was only
dropped by hook_file_free_security(), which runs from security_file_free()
without holding file->f_owner->lock.  hook_file_set_fowner() itself runs
under that lock (since commit 26f204380a3c ("fs: Fix file_set_fowner LSM
hook inconsistencies")), so the get-side and the put-side of the same
storage slot were not mutually exclusive.

If the final fput()/__fput() of a file runs concurrently with an
in-flight F_SETOWN on another CPU, the free path can drain the blob
(dropping the previously recorded domain) before the set path stores a
freshly acquired domain reference into it.  The new reference is then
orphaned: hook_file_free_security() has already run, so nothing will
ever drop it, and the whole domain (struct landlock_ruleset, its
landlock_hierarchy and its landlock_details) leaks.  kmemleak reports
this as a "memory leak in landlock_merge_ruleset" with the leaked
hierarchy showing usage=1 and parent=NULL.

Add a file_release hook, called by __fput() before
file_f_owner_release() (i.e. while the fown_struct and its lock are
still alive), which takes file->f_owner->lock, snapshots and clears the
recorded fown_subject/fown_tg references, and drops them outside the
lock.  This serializes the recorded reference lifecycle with
hook_file_set_fowner(), closing the store-after-put window in both
directions (the reverse interleaving would have been a double-put).
hook_file_free_security() stays as a no-op safety net for files without
a fown_struct.

Cc: stable@vger.kernel.org
Fixes: 54a6e6bbf3bef ("landlock: Add signal scoping")
Assisted-by: OpenCode:DeepSeek-V4-Flash
Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
---
 security/landlock/fs.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index f7e5e4ef9eac3..8261aa55b0127 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1971,8 +1971,49 @@ static void hook_file_set_fowner(struct file *file)
 	put_pid(prev_tg);
 }
 
+/*
+ * Drops the Landlock references saved by hook_file_set_fowner(), in a
+ * critical section serialized with it thanks to file->f_owner->lock, and
+ * before file_f_owner_release() frees this lock.  Without this mutual
+ * exclusion, a concurrent F_SETOWN could store a new domain reference into a
+ * file being released (the last fput() made it unreachable to future F_SETOWN
+ * users), which would then never be dropped, leaking the whole domain.
+ */
+static void hook_file_release(struct file *file)
+{
+	struct landlock_ruleset *prev_dom;
+	struct pid *prev_tg;
+	struct fown_struct *fown;
+
+	fown = file_f_owner(file);
+	if (!fown)
+		/* No owner was ever recorded, cf. hook_file_set_fowner(). */
+		return;
+
+	/*
+	 * __fput() calls this hook before file_f_owner_release(), so the
+	 * fown_struct is still alive here.
+	 */
+	write_lock_irq(&fown->lock);
+	prev_dom = landlock_file(file)->fown_subject.domain;
+	prev_tg = landlock_file(file)->fown_tg;
+	landlock_file(file)->fown_subject.domain = NULL;
+	landlock_file(file)->fown_tg = NULL;
+	write_unlock_irq(&fown->lock);
+
+	/* May be called in an RCU read-side critical section. */
+	landlock_put_ruleset_deferred(prev_dom);
+	put_pid(prev_tg);
+}
+
 static void hook_file_free_security(struct file *file)
 {
+	/*
+	 * hook_file_release() already dropped and cleared these references if
+	 * they were ever recorded.  Keep a defensive cleanup for files without
+	 * a fown_struct (e.g. never owning files), which hook_file_release()
+	 * skips.
+	 */
 	put_pid(landlock_file(file)->fown_tg);
 	landlock_put_ruleset_deferred(landlock_file(file)->fown_subject.domain);
 }
@@ -2003,6 +2044,7 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(file_ioctl, hook_file_ioctl),
 	LSM_HOOK_INIT(file_ioctl_compat, hook_file_ioctl_compat),
 	LSM_HOOK_INIT(file_set_fowner, hook_file_set_fowner),
+	LSM_HOOK_INIT(file_release, hook_file_release),
 	LSM_HOOK_INIT(file_free_security, hook_file_free_security),
 };
 
-- 
2.34.1


Crash report (memory_leak_in_landlock_merge_ruleset_SyzGPT_20260917_162959_7d54763d, kernel 7.2-v3, appended below for reference; everything after the "-- " signature is discarded by git am):

---
BUG: memory leak
unreferenced object 0xffff88810fd82cc0 (size 96):
  comm "syz.1.2048", pid 20078, jiffies 4295170985
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 08 a4 0d 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace (crc 5533466b):
    kmemleak_alloc_recursive home/zzzrrll/tmp/kf_src/linux-7.2.3/include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook home/zzzrrll/tmp/kf_src/linux-7.2.3/mm/slub.c:4597 [inline]
    slab_alloc_node home/zzzrrll/tmp/kf_src/linux-7.2.3/mm/slub.c:4917 [inline]
    __do_kmalloc_node home/zzzrrll/tmp/kf_src/linux-7.2.3/mm/slub.c:5333 [inline]
    __kmalloc_noprof+0x210/0x4d0 home/zzzrrll/tmp/kf_src/linux-7.2.3/mm/slub.c:5359
    _kmalloc_noprof home/zzzrrll/tmp/kf_src/linux-7.2.3/include/linux/slab.h:992 [inline]
    _kzalloc_noprof home/zzzrrll/tmp/kf_src/linux-7.2.3/include/linux/slab.h:1309 [inline]
    create_ruleset home/zzzrrll/tmp/kf_src/linux-7.2.3/security/landlock/ruleset.c:36 [inline]
    landlock_merge_ruleset+0x8b/0x5d0 home/zzzrrll/tmp/kf_src/linux-7.2.3/security/landlock/ruleset.c:565
    __do_sys_landlock_restrict_self home/zzzrrll/tmp/kf_src/linux-7.2.3/security/landlock/syscalls.c:599 [inline]
    __se_sys_landlock_restrict_self+0x180/0x330 home/zzzrrll/tmp/kf_src/linux-7.2.3/security/landlock/syscalls.c:526
    do_syscall_x64 home/zzzrrll/tmp/kf_src/linux-7.2.3/arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0x154/0x3b0 home/zzzrrll/tmp/kf_src/linux-7.2.3/arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f


<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>


---

