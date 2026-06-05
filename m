Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C162494F0;
	Fri,  5 Jun 2026 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680234; cv=none; b=pttp5v6etGrlpfoHLhXp23Zdvh0xn6UtVmfh3hxaANwPpAdUU9AsTx90BMz/aZQdQksCvVxSNr/zYOqctOUKmWrPWQuO92/OM+oVaaquPDQNZf37S9Svo8MjmXqpDudpSK4xwqWJ9DsYL2Re9TFhtxMhhUo5qIa+7ei7erkgPaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680234; c=relaxed/simple;
	bh=kwWFz/mirnCJD2wMiUROXV7CE+zEUlUkVnOSOLUeIso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLZxVGuAROIOLlaKeNxu4N4nFoITeKtmw44/p7HowckR8sHGppUCcYWZCXq9QgQqpbszaWF8/vXjERPOaCgM3kBjYI8Pjniga+5cfrulc2FpKysRWrYLqu9Lx6mVJ/5emvCj0nO0xP7yZFO/eiLSgG4ugZxCgG9wdj1qAUGHORc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4gX7SV0bNSzpV2C;
	Sat,  6 Jun 2026 01:18:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id D86D24056F;
	Sat,  6 Jun 2026 01:23:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBHV43pBSNqZAhlAA--.46721S8;
	Fri, 05 Jun 2026 18:23:49 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	skhan@linuxfoundation.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	gregorylumen@linux.microsoft.com,
	chenste@linux.microsoft.com,
	nramas@linux.microsoft.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v7 06/12] ima: Mediate open/release method of the measurements list
Date: Fri,  5 Jun 2026 19:22:30 +0200
Message-ID: <20260605172236.2042045-7-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605172236.2042045-1-roberto.sassu@huaweicloud.com>
References: <20260605172236.2042045-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwBHV43pBSNqZAhlAA--.46721S8
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4kuF1ruFy3WF13XF4fKrg_yoW7WFWDpa
	9ak3y8Cr18tr4xWFn7G3W7Zr4F9ayrGa13Wr1DJa4fZF1rAr9F9F4Yyry2krs8tryrGr1I
	qw4qqrW5Was0yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
	v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07UZTmfUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBGoiO0QKbQACsY

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce the ima_measure_users counter, to implement a semaphore-like
locking scheme where the binary and ASCII measurements list interfaces can
be concurrently opened by multiple readers, or alternatively by a single
writer. In addition, allow the same writer to open the other interfaces for
write or read/write, so that it can see the same measurement state across
all the interfaces.

A semaphore cannot be used because the kernel cannot return to user space
with a lock held.

Introduce the ima_measure_lock() and ima_measure_unlock() primitives, to
respectively lock/unlock the interfaces (safely with the ima_measure_users
counter, without holding a lock).

Finally, introduce _ima_measurements_open() to lock the interface before
seq_open(), and call it from ima_measurements_open() and
ima_ascii_measurements_open(). And, introduce ima_measurements_release(),
to unlock the interface.

Require CAP_SYS_ADMIN if the interface is opened for write (not possible
for the current measurements interfaces, since they only have read
permission).

No functional changes: multiple readers are allowed as before.

Link: https://github.com/linux-integrity/linux/issues/1
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_fs.c | 102 ++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index dcdc4cb8fa0f..91bd831d070f 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -25,6 +25,10 @@
 #include "ima.h"
 
 static DEFINE_MUTEX(ima_write_mutex);
+static DEFINE_MUTEX(ima_measure_mutex);
+static long ima_measure_users;
+static struct task_struct *measure_writer;
+static long measure_writer_extra_writes;
 
 bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
@@ -209,16 +213,105 @@ static const struct seq_operations ima_measurments_seqops = {
 	.show = ima_measurements_show
 };
 
+static int ima_measure_lock(bool write)
+{
+	mutex_lock(&ima_measure_mutex);
+	/* Overflow check. */
+	if (!write && ima_measure_users == LONG_MAX) {
+		mutex_unlock(&ima_measure_mutex);
+		return -ENFILE;
+	}
+
+	/* Same writer can do additional writes or read/writes. */
+	if (write && current == measure_writer) {
+		measure_writer_extra_writes++;
+		mutex_unlock(&ima_measure_mutex);
+		return 0;
+	}
+
+	/*
+	 * ima_measure_users: > 0 open readers
+	 * ima_measure_users: == -1 open writer
+	 */
+	if ((write && ima_measure_users != 0) ||
+	    (!write && ima_measure_users < 0)) {
+		mutex_unlock(&ima_measure_mutex);
+		return -EBUSY;
+	}
+
+	if (write) {
+		ima_measure_users--;
+		/* Pointer valid, no reuse while the file descriptor is open. */
+		measure_writer = current;
+	} else {
+		ima_measure_users++;
+	}
+	mutex_unlock(&ima_measure_mutex);
+	return 0;
+}
+
+static void ima_measure_unlock(bool write)
+{
+	mutex_lock(&ima_measure_mutex);
+	/* Decrement additional writes or read/writes. */
+	if (write && current == measure_writer &&
+	    measure_writer_extra_writes != 0) {
+		measure_writer_extra_writes--;
+		mutex_unlock(&ima_measure_mutex);
+		return;
+	}
+	if (write) {
+		ima_measure_users++;
+		measure_writer = NULL;
+	} else {
+		ima_measure_users--;
+	}
+	mutex_unlock(&ima_measure_mutex);
+}
+
+static int _ima_measurements_open(struct inode *inode, struct file *file,
+				  const struct seq_operations *seq_ops)
+{
+	bool write = (file->f_mode & FMODE_WRITE);
+	int ret;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	ret = ima_measure_lock(write);
+	if (ret < 0)
+		return ret;
+
+	ret = seq_open(file, seq_ops);
+	if (ret < 0)
+		ima_measure_unlock(write);
+
+	return ret;
+}
+
 static int ima_measurements_open(struct inode *inode, struct file *file)
 {
-	return seq_open(file, &ima_measurments_seqops);
+	return _ima_measurements_open(inode, file, &ima_measurments_seqops);
+}
+
+static int ima_measurements_release(struct inode *inode, struct file *file)
+{
+	bool write = (file->f_mode & FMODE_WRITE);
+	int ret;
+
+	/* seq_release() always returns zero. */
+	ret = seq_release(inode, file);
+
+	ima_measure_unlock(write);
+
+	return ret;
 }
 
 static const struct file_operations ima_measurements_ops = {
 	.open = ima_measurements_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = seq_release,
+	.release = ima_measurements_release,
 };
 
 void ima_print_digest(struct seq_file *m, u8 *digest, u32 size)
@@ -283,14 +376,15 @@ static const struct seq_operations ima_ascii_measurements_seqops = {
 
 static int ima_ascii_measurements_open(struct inode *inode, struct file *file)
 {
-	return seq_open(file, &ima_ascii_measurements_seqops);
+	return _ima_measurements_open(inode, file,
+				      &ima_ascii_measurements_seqops);
 }
 
 static const struct file_operations ima_ascii_measurements_ops = {
 	.open = ima_ascii_measurements_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = seq_release,
+	.release = ima_measurements_release,
 };
 
 static ssize_t ima_read_policy(char *path)
-- 
2.43.0

