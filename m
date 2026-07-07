Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3130E0CC;
	Tue,  7 Jul 2026 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412609; cv=none; b=XQxWKa2ImCQB+GZSRm04fxWFUbggTIifBCtTu42Fb4Ym+2jf1E5KoQOzhIuLdgFuGe5f/F93zx1r5FFlXkzSgPqcM/8RSJx8Q/HTcMxC5eAf1wQRnXyKOjkmS4rsFuRcYZ8taRVFWNmmUDZg2jVeTZJ9N0lxXDDn85vChffILeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412609; c=relaxed/simple;
	bh=gWbR1dtgg47N10Jc+clA9F6nwNux4rd4vnt+7fAd35Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HqCwrlUy7dewBYLKvEm1DoBRtf8jdLBc2RQvZwoYdVevGRov9V8hRHkc/UYjWZyHZrVfWZK98n3KjlpoXpHLRoKw6NmYovmojtFSMHEv4MjlFK6ADLKVio7KOikiswSKziuoqcikB0/j9aEzLBT7YzkmY8lv5zMZ33RzDRdDxcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=bsaPXlyJ; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="bsaPXlyJ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZbvPvtwSUj5p1BDrR0vVDMsqKu+ME4smIMYEDIMTgpc=;
	b=bsaPXlyJIIw16BbwJ7mM2eOWgSFt6s7coh1UEciW+Zaxh8cmPO2vxjE5Dw3ndygCf65Oo6TSR
	FSb+JD2B/gDZzY6y1o7VVWnNvA2aPVd/X25ZBWFYa0kNJxEJfFbVSBVTvQTLSnjZgMHiXRqbcCr
	9t2ZzwRxfZOsJ/DVAZivY/c=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gvYsY1tK5z1prpb;
	Tue,  7 Jul 2026 16:14:09 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F05240575;
	Tue,  7 Jul 2026 16:23:24 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Jul 2026 16:23:24 +0800
Received: from hulk-vt.huawei.com (10.67.174.72) by
 kwepemq200017.china.huawei.com (7.202.195.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Jul 2026 16:23:23 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<amir73il@gmail.com>, <brauner@kernel.org>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH v2 -next 2/2] security: Fix call security_backing_file_free second time
Date: Tue, 7 Jul 2026 08:06:15 +0000
Message-ID: <20260707080615.1235830-3-caixinchen1@huawei.com>
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

Fixes: 6af36aeb147a ("lsm: add backing_file LSM hooks")
Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 security/security.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/security.c b/security/security.c
index 71aea8fdf014..bec2f4ebea34 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2486,9 +2486,8 @@ void security_backing_file_free(struct file *backing_file)
 {
 	void *blob = backing_file_security(backing_file);
 
-	call_void_hook(backing_file_free, backing_file);
-
 	if (blob) {
+		call_void_hook(backing_file_free, backing_file);
 		backing_file_set_security(backing_file, NULL);
 		kmem_cache_free(lsm_backing_file_cache, blob);
 	}
-- 
2.34.1

