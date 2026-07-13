Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFA5384CC1;
	Mon, 13 Jul 2026 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941161; cv=none; b=fFzCmv1pkbTt8CwUWV+zGW0KiAz+7aCTtsz6dmu+ezQrNo2pCospNj6uiXjpwtxTgPPuY4hofdzH7ShT01L0rQZ6sKb//TJhQxj8O6ekXg9msogyzRDuTw+BTPuJbzwkeu3dXLc1aRTt9bhDs9/PrkPA3RQaAJaIxvLhygLfibM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941161; c=relaxed/simple;
	bh=/LEwZu0nVlFLjjuEKAwtWdMZc2cAwOWqQmtRzdBkmv4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QpR+4Wvhgf8zErv6eouxxoEWuOPX+QykVWzPK94a/hstR3f0M3qVa05S+REDYq8RIQmAvUuO0vssFu7AIRtrU1WVUL2cHTARIY07SbgGXhWwZPmDkng637CHXeMbaZi1nFYnv6JP3+4mQ2+DwnLrNtEJvtQnWpYAzwRPBC/eEsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WyGidEPk; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WyGidEPk"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SkYn1QevCBV1TQn7JAT50Cu2bm2tezyILCl4VkFQAVU=;
	b=WyGidEPkWXrBDs37ft2q4YHUP8aipQAokhsAX3ji+xn0mhvdNr7KZ3aKez9ZTVmvYacKsLX7s
	IF7tQWFZkf4Lx62Bj1if/4udFwmgbPaaWt3bG1+m2w3JFGEXHynzI1aRvxIbDrL9G1D4ApcwhiZ
	A0PPm5EfNfnzkXIG7EeOgkE=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gzKKt0lJSzmV6m;
	Mon, 13 Jul 2026 19:03:14 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 72AB540572;
	Mon, 13 Jul 2026 19:12:31 +0800 (CST)
Received: from kwepemq500013.china.huawei.com (7.202.195.103) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Jul 2026 19:12:31 +0800
Received: from dggphis33418.huawei.com (10.244.148.83) by
 kwepemq500013.china.huawei.com (7.202.195.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Jul 2026 19:12:30 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <cuigaosheng1@huawei.com>, <lujialin4@huawei.com>, <zohar@linux.ibm.com>,
	<roberto.sassu@huawei.com>, <dmitry.kasatkin@gmail.com>,
	<eric.snowberg@oracle.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>
CC: <linux-integrity@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: [PATCH -next] ima: add cond_resched() in ima_calc_file_hash_tfm loop
Date: Mon, 13 Jul 2026 11:10:22 +0000
Message-ID: <20260713111022.2418849-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

Add cond_resched() at the end of each loop iteration to voluntarily
yield the CPU when needed.

Fixes: 3323eec921ef ("integrity: IMA as an integrity service provider")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 security/integrity/ima/ima_crypto.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 0d72b48249ee..3b7d41a9fd18 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -233,6 +233,8 @@ static int ima_calc_file_hash_tfm(struct file *file,
 		rc = crypto_shash_update(shash, rbuf, rbuf_len);
 		if (rc)
 			break;
+
+		cond_resched();
 	}
 	kfree(rbuf);
 out:
-- 
2.43.0

