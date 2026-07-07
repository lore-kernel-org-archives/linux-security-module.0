Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11A531A057;
	Tue,  7 Jul 2026 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412610; cv=none; b=mgJamDHvNiOq99sKvbru4UEalUKSzm4UfWKFlCTHRnxIZGOnvFB9CXL713KKTyha9KdUhNVx4H6fGQrfPyrCYMhCWltq+MHYC6M2opyNwotFpvnyFn0AQnu5G78UmStdKw5Y16YVs/cF8OKdlLexb0EJYMM2bJT4jED0ZyTL9QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412610; c=relaxed/simple;
	bh=01/60c/nOwSWkwifMFLJHJIwuPOuMgn8pc5wDxJDfWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ij4YmkcUy5/hGEbSHbf7eKedh5EZFGMLUw1Myn4FZkVA+iiWUcN8up50lojeIBgbSQSsimo3kJL95/dK4TceDwiA1jVEoGVysherIfwIq1FXzChnyGM9oMvRjNYykIYjLT7dhfFcxRSFNoZCr9yuyMj7Y41MvWA9+93+wBVkyl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fSspbzOW; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fSspbzOW"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AfHDZCgEgf7IXwdPo8DdWyxjIRhwdDjqUGvANuWQuPg=;
	b=fSspbzOWRiNU3iokPGGBIxWizw5yZdmZ/e9/ul6PJEiF/AxZkMXWmHULo1hCKxjE8AVzcMwyf
	x+hIUNdoXW24Ybgoj6B/z9wcK8UNfmCfuFtAbO+oLMs5tGBjFSJIrz8VmRteEsbLViatDYQ7hEA
	wfDiDGHJW10854xGOMILgvM=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gvYsp0s9tzcb1b;
	Tue,  7 Jul 2026 16:14:22 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 676EE2025F;
	Tue,  7 Jul 2026 16:23:23 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Jul 2026 16:23:23 +0800
Received: from hulk-vt.huawei.com (10.67.174.72) by
 kwepemq200017.china.huawei.com (7.202.195.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Jul 2026 16:23:22 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<amir73il@gmail.com>, <brauner@kernel.org>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH v2 -next 1/2] security: Delete dumplicate assignment
Date: Tue, 7 Jul 2026 08:06:14 +0000
Message-ID: <20260707080615.1235830-2-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707080615.1235830-1-caixinchen1@huawei.com>
References: <20260707080615.1235830-1-caixinchen1@huawei.com>
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

Delete a blobs variable with duplicate assignment.

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 security/lsm_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 7c0fd17f1601..d7384866e3a5 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -290,7 +290,6 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 		return;
 
 	/* Register the LSM blob sizes. */
-	blobs = lsm->blobs;
 	lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
 	lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
 	lsm_blob_size_update(&blobs->lbs_backing_file,
-- 
2.34.1

