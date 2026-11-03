Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692294;
	b=GAbJ4d30KnuVTuQ0LhIStk1clrDlrjNcKagSlW/2R3AmRAiCeTliyms55A6ex4oL5PmA
	 iiRDzlbBmoYyRjp9ovC0Bx4XTViiH3pZhrxLSJ5Xj5iKvYks1r2l7dZ125TnN7uYV6INa
	 v4htIkMRCJfyvXZXifxLyqXVVPx3WkcUrGnCjpCUqzVaapLoAULGg9Ucq1EnYpGW1So2I
	 TKSb9Q0SnwHYbWvf6wcYYvaWrh9PJudPVDd/99gC4V3JeSe+dHWFp+pUHAdeUbUGEYzIp
	 EmTqosHi9MDYJSrWQAdqCy2sa45eRgMbq+n8kO3v/Auo9RfVEh8LC91H3/KGmjxpo7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692294;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=ras/1dSsqRmwSxXXz60jAE+dvwJWDKmYwH+3pCSl30g=;
	b=DFTz/+QE5298LJbQrXYEe5DtvifRBpGUicZHdA3QUc0oeDVVDAwSxY8dkNrDm7ryo9dz
	 FKsHXxaZUv2y/+1wEtc7TgLFegaD8n+VqDeA4UKua2Y0dLbbELgDAUKiZ4FBnk9t9OIWB
	 newGeifbG0rUlAm/PJ/Epl+A0Lq51BS3RUwkUtWroxAI5C35Ey3r4KtiVwXuMcDo06pdE
	 fihJy5JtBd4BgyssKUX0tvf5VsCuXqzdOmCFLW4tSp4ECdCz9xnJXnbcOjL4y1GovOuDk
	 kTt+kh1mfZ+8b5oAO5BaNmCFCKC7MuGJv6uz9pqXF8d2AuRi+KpaDvPhWnBjQJEEz7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=knsps0Rf;
	arc=none smtp.remote-ip=113.46.200.221
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D101606A32C;
	Tue,  3 Nov 2026 07:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D101606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=knsps0Rf
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ras/1dSsqRmwSxXXz60jAE+dvwJWDKmYwH+3pCSl30g=;
	b=knsps0Rfbt3UUizAJZAaW+eIq8XkjMGX0+XJs3woIA/54U3Jc/d/SMyXe8Tt2fTiJbCLGSvTd
	HqW3eOMJs7QGgYjK6XZoOSexcK1SE5XN6GqsEe22/i9RcnJsUyDjRE1zL+iQW3vt0VwyXgKp/UY
	1KpP8iopJ1rvAR1SJV5HMmQ=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4jJgkF69JPzRhQn;
	Tue,  3 Nov 2026 15:51:17 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 756FA203AB;
	Tue,  3 Nov 2026 15:51:23 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 3 Nov 2026 15:51:22 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <caixinchen1@huawei.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH -next 6/9] lockdown: drop an unused include and simplify secfs init
Date: Tue, 3 Nov 2026 16:24:18 +0800
Message-ID: <20261103082421.3033195-7-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20261103082421.3033195-1-caixinchen1@huawei.com>
References: <20261103082421.3033195-1-caixinchen1@huawei.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemk100010.china.huawei.com (7.152.184.41)

linux/export.h is not needed since the file has no EXPORT_SYMBOL() usage.
Also return the result of securityfs_create_file() directly instead of
storing it in a temporary dentry.

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 security/lockdown/lockdown.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index b6f99b9179b9..08a30cd471e0 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/security.h>
-#include <linux/export.h>
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
@@ -158,11 +157,8 @@ static const struct file_operations lockdown_ops = {
 
 static int __init lockdown_secfs_init(void)
 {
-	struct dentry *dentry;
-
-	dentry = securityfs_create_file("lockdown", 0644, NULL, NULL,
-					&lockdown_ops);
-	return PTR_ERR_OR_ZERO(dentry);
+	return PTR_ERR_OR_ZERO(securityfs_create_file("lockdown", 0644, NULL,
+						      NULL, &lockdown_ops));
 }
 
 #ifdef CONFIG_SECURITY_LOCKDOWN_LSM_EARLY
-- 
2.18.0.huawei.25

