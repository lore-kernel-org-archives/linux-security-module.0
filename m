Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8821FC8;
	Tue, 24 Jun 2025 01:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750728230; cv=none; b=JZtPPiVHorbGQ5gKWGZ1c2+j7vmFxLzsIvVzno6hVEOFjHS0OZxMrM9PaXmPDJeyTEtNy14Tufx6UrkEZO5ReWfPv7eBLQkM1jlmGGqmam4EfUqPxTiSKgUWXeAZqq8jTAXcIinnHK3OAx3g7fL32ZawnvQuUWW+Nkz/pxTpwgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750728230; c=relaxed/simple;
	bh=DMNoWcnSigHNG3C6iHz3Mk/Cj7TlS7A3PVCbUmeb4+c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bNlJVRo9qO2D619pyZfUNOSA7mHqIm9gz/tg4WVXhoyWZ5gwau07/7H1jrlqx49yv9QXB4CFq7yoALuF3XBAOTjlMzm/GujRB05Pu6FfyzZv3kvWTOuHuKexAltqZ1I59NxvFHDuPxsDwuM/OQDRLEQ5x6dmkxgiBktXEb2Zhnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bR6cd21Qhz29dlR;
	Tue, 24 Jun 2025 09:22:09 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 850591A0188;
	Tue, 24 Jun 2025 09:23:45 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Jun
 2025 09:23:44 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<casey@schaufler-ca.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH -next] security: Remove unused declaration cap_mmap_file()
Date: Tue, 24 Jun 2025 09:41:08 +0800
Message-ID: <20250624014108.3686460-1-yuehaibing@huawei.com>
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
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit 3f4f1f8a1ab7 ("capabilities: remove cap_mmap_file()")
removed the implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/security.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index dba349629229..e8d9f6069f0c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -193,8 +193,6 @@ int cap_inode_getsecurity(struct mnt_idmap *idmap,
 			  struct inode *inode, const char *name, void **buffer,
 			  bool alloc);
 extern int cap_mmap_addr(unsigned long addr);
-extern int cap_mmap_file(struct file *file, unsigned long reqprot,
-			 unsigned long prot, unsigned long flags);
 extern int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags);
 extern int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			  unsigned long arg4, unsigned long arg5);
-- 
2.34.1

