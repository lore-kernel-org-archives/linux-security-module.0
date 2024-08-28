Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF90315958D
	for <linux-security-module@vger.kernel.org>; Wed, 28 Aug 2024 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847413; cv=none; b=Sm9lTyVKYAwEbHgxCfoMTS7uA3q3NErshiI8QCi5Iw4yzOe5U5jGHOjHwhi8wRaeVX1sGKK1pWN3NyzzU9r8flPy8E9NxmpRrxfrhyN6QM7S2luv8bCwH0t/tdFhlaVBj+r2SYNP6AOH1TxOuwBM9t+FjSb6g8bb6TQFJ94a1Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847413; c=relaxed/simple;
	bh=NxnQdjW+LrD/et8Tw4sG0M6wydIpNF1+T/UwCShLOH0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q4Wv/Wu4TBubQFLR1C6DHtx2aqvyPXcp/cjqtMBbiwDWCM6EZAooNQIcYPkX/EfZiL/t/To0AvMEwRUCrwvxAeX6ubo5HYYRGGVNfJH4zS3OfwpsyDMu77Z6a/mg7OvEFn9dST72hRO15L4f/lfW7A32WuXnggB2PX2FFuFw4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wv3Dv2zFtzQqmR;
	Wed, 28 Aug 2024 20:11:59 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 499F818010B;
	Wed, 28 Aug 2024 20:16:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 20:16:49 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC: <linux-security-module@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next] lsm: Use IS_ERR_OR_NULL() helper function
Date: Wed, 28 Aug 2024 20:24:50 +0800
Message-ID: <20240828122450.3697314-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Use the IS_ERR_OR_NULL() helper instead of open-coding a
NULL and an error pointer checks to simplify the code and
improve readability.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 security/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/inode.c b/security/inode.c
index f21847badb7d..da3ab44c8e57 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -296,7 +296,7 @@ void securityfs_remove(struct dentry *dentry)
 {
 	struct inode *dir;
 
-	if (!dentry || IS_ERR(dentry))
+	if (IS_ERR_OR_NULL(dentry))
 		return;
 
 	dir = d_inode(dentry->d_parent);
-- 
2.34.1

