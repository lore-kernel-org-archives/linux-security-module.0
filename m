Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED71319871;
	Tue,  7 Jul 2026 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412609; cv=none; b=ZIYxa86eOdyzGPcAtpaXryKJvh58cS3+hgMJpm+YLamBmyVvAEQRuVvqxfdkzqLlQOtlpCROyA3xFPz/+7agrSDHZ37rXga9njhOooY0PPazQuCbZ4nSAIokCwiwYxRhkbEmysDCtaGncDVa/F3oUfGo2Jv9LsDGwpF54q+DEL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412609; c=relaxed/simple;
	bh=ICEeEu/xd+EQZVOiv1k5Ewwmsz0+76HXH2PfU8aUhus=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DSW0ICy0OPgrUkrE9SIQGPXMbsKKJvGeD910Dwq5CQS84Imh2LiYHVhCQ+VHL1fUrd60T2LmHYl724/R5z+kP9nz9SPaGhjdt37IUkA12HLIGmy9XtZKG0Jb8PMTUB7rCS5ab6TAl9SyNi6dqOlU8tWp7qwNnuYapQSfprHcYwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zDlUq9zD; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="zDlUq9zD"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pV+7hqNaCnPM4/BuiWqJrNvn9fiB6+VP409P+EmkCcc=;
	b=zDlUq9zDJcgY05b5rKCelP2o/9bipFkxjfrTa/vuuUd/bMYz/CkztgyzYC8WOnIX/l4gzfqja
	33O0YYB7wWmZI2libPB7r6NYkrOBbd66fRE+uSdYk9SQSgtMmV1RJEBT+tesRVpgPPgbWksgZ3z
	z9JMNz6tNoizNBVQzWeA/40=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gvYsp6Hgxz1T4kT;
	Tue,  7 Jul 2026 16:14:22 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 1FF494058C;
	Tue,  7 Jul 2026 16:23:22 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Jul 2026 16:23:21 +0800
Received: from hulk-vt.huawei.com (10.67.174.72) by
 kwepemq200017.china.huawei.com (7.202.195.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Jul 2026 16:23:21 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<amir73il@gmail.com>, <brauner@kernel.org>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH v2 -next 0/2] security: Fix call security_backing_file_free second time
Date: Tue, 7 Jul 2026 08:06:13 +0000
Message-ID: <20260707080615.1235830-1-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq200017.china.huawei.com (7.202.195.228)

v2: Move the call_void_hook(backing_file_free, ...) call in
security_backing_file_free() into the if-statment true block before we
set the backing file's LSM blob pointer to NULL and free the LSM blob.

I found the following path:

alloc_empty_backing-file
    init_file(&ff->file, xxx)
        -> file_ref_init(&f->f_ref, 1); // only 1
    error = init_backing_file
        -> security_backing_file_alloc
        -> rc = call_int_hook(backing_file_alloc, ...)
           if (unlikely(rc))
                security_backing_file_free(backing_file); // first call
    if (unlikely(error)) {
        fput(&ff->file);
         -> if (unlikely(file_ref_put(&file->f_ref))) // zero
                __fput_deferred(file);
                 -> ____fput -> __fput -> file_free(file);
                 -> backing_file_free(backing_file(f));
                 -> security_backing_file_free(&ff->file); // second call

Currently, only SELinux has the lsm backing_file_alloc hook, and it always
return 0. When security_backing_file_free is called for the first time,
the blobs pointer is set to NULL. Therefore, double free will not occur in
the code.

Cai Xinchen (2):
  security: Delete dumplicate assignment
  security: Fix call security_backing_file_free second time

 security/lsm_init.c | 1 -
 security/security.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

-- 
2.34.1

