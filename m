Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9EE3B634E;
	Tue, 28 Jul 2026 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242189; cv=none; b=e5IbYpn9WsLav0X/9hehIhyZ0ByOZgCVqQQn4uvBekndT7CisX6lk1ELHOzOHEOt0VretwG0ak98Tu3HI4/fWSxvOD9WXi2A600iefY1OmSb73CvwPWgSC+VvEfYUBc1fL+nQKFwrU4OgOQHlqcdFtnF6k48oTcPt/O9Fx3xPW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242189; c=relaxed/simple;
	bh=kOG3AVBkZxk3B75iRQwRDvUYo1TF5H078U6MxMvzwac=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F5qgi6X75p4x2A0UPvdBZBtdJNmJSUfyAvvN0tQTqLHTlLie7Utl8SrjEtoGcomNaRTFVk9t29Umbv57pGh7m7hYVlIm+iCbR4Cwrd2htnCwpT6WuP7f0Jar4PNAuaW9yenc4RpAqdF8pcW2HgWBJrSF2g/w2N/05XkoBaYdxUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oZSUqz+U; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="oZSUqz+U"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=R3k+m4FDV5iHvOr6sHonDGuihmRyKD4FT+xt3E6oGEI=;
	b=oZSUqz+U7TDeFC0Z0dweDpZJUWnWhlxQXHgkRj0fyIci6DfdAVb+feibjjUAj4fcTZtfqIbm4
	AjIPQhdSzJvhlKmkcuUgT4MxtJAaA2z649UtLnwyWtwFeMw+6PvxamjrMZeIAUhe2kiWQZrTT7A
	Fg6oAijSWJE7tvuUJk2k4gw=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4h8ZTS0Xynz1T4Fq;
	Tue, 28 Jul 2026 20:26:52 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CF614057F;
	Tue, 28 Jul 2026 20:36:21 +0800 (CST)
Received: from kwepemq500013.china.huawei.com (7.202.195.103) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Jul 2026 20:36:21 +0800
Received: from dggphis33418.huawei.com (10.244.148.83) by
 kwepemq500013.china.huawei.com (7.202.195.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Jul 2026 20:36:20 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <cuigaosheng1@huawei.com>, <lujialin4@huawei.com>, <zohar@linux.ibm.com>,
	<roberto.sassu@huawei.com>, <dmitry.kasatkin@gmail.com>,
	<eric.snowberg@oracle.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>
CC: <linux-integrity@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: [PATCH -next,v3] ima: add cond_resched() in ima_calc_file_hash_tfm loop
Date: Tue, 28 Jul 2026 20:33:50 +0800
Message-ID: <20260728123350.2751590-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq500013.china.huawei.com (7.202.195.103)

When hashing large files, the while loop in ima_calc_file_hash_tfm
processes PAGE_SIZE chunks without any scheduling point, which can
cause soft lockup warnings:
watchdog: BUG: soft lockup - CPU#0 stuck for 50s!
Call Trace:
  _sha256_update+0x12d/0x1a0
  ima_calc_file_hash_tfm+0xfb/0x150
  ima_calc_file_hash+0x6e/0x160
  ima_collect_measurement+0x202/0x340
  process_measurement+0x3a9/0xb30
  ima_file_check+0x56/0xa0
  do_open+0x11b/0x250
  path_openat+0x10b/0x1d0
  do_filp_open+0xa9/0x150
  do_sys_openat2+0x223/0x2a0
  __x64_sys_openat+0x54/0xa0
  do_syscall_64+0x59/0x110
  entry_SYSCALL_64_after_hwframe+0x78/0xe2

Call cond_resched() every 4MB to yield the CPU when needed, rather
than at every loop iteration, to reduce overhead.

Using IS_ALIGNED(offset, SZ_4M) to trigger cond_resched() is fragile
because integrity_kernel_read() -> __kernel_read() can return fewer
bytes than requested (short read). Short reads can occur across
various filesystems — while common on remote (NFS, CIFS) and FUSE
filesystems, they are also possible in edge cases on local
filesystems (e.g., reading near EOF). Once a short read occurs,
the offset becomes permanently misaligned and cond_resched() may
never be called again for the remainder of the file. Replace the
alignment check with a cumulative byte counter that tracks the
actual data hashed since the last reschedule point, which is robust
regardless of short read behavior.

Fixes: 3323eec921ef ("integrity: IMA as an integrity service provider")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 security/integrity/ima/ima_crypto.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 0d72b48249ee..55f9a5642ebc 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -195,6 +195,7 @@ static int ima_calc_file_hash_tfm(struct file *file,
 				  struct crypto_shash *tfm)
 {
 	loff_t i_size, offset = 0;
+	unsigned int bytes_hashed = 0;
 	char *rbuf;
 	int rc;
 	SHASH_DESC_ON_STACK(shash, tfm);
@@ -233,6 +234,12 @@ static int ima_calc_file_hash_tfm(struct file *file,
 		rc = crypto_shash_update(shash, rbuf, rbuf_len);
 		if (rc)
 			break;
+
+		bytes_hashed += rbuf_len;
+		if (bytes_hashed >= SZ_4M) {
+			cond_resched();
+			bytes_hashed = 0;
+		}
 	}
 	kfree(rbuf);
 out:
-- 
2.43.0

