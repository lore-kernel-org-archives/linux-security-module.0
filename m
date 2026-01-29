Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F264436C0AC
	for <linux-security-module@vger.kernel.org>; Thu, 29 Jan 2026 22:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769727100; cv=none; b=u8p2Tq+45y8hg/ZLmNhndGBEdhjkTLBnalkLwO4FV5+wC1ftOkHk2pJzLZEABQxt+kQiW2oF9V/fm4GqW6CIxQnFApKprAImbmL240yO73y5c2Wr1EJJooNyczTA1ggWlfs4fqT1HgGIBJCP99fgOi+RgiJqYLDTQo6YE6MtNzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769727100; c=relaxed/simple;
	bh=jNcQkI5lVA7LwC9/vCuDXRmjKKHFGdLPOmtZAer45UI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T8uZlkgQUH9wWNBs3LV8CW/NtJpgfBiFbmX8qhPb/U0g30FilkPLE+86GubJ3M9M4TBwgTI42/+9HC74wbf4ZiEVuXZkMqGOxo5l9AyRBqMX+zWIMYQvbUgjXt8Pkkuay0EKnM90H2rQO819dG2F1KNlXz7BOQ870p+JMCsGcH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QCmiEThG; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QCmiEThG"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89461ccc46eso24594996d6.2
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jan 2026 14:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769727097; x=1770331897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uEP+gJiAzlwp00B1A4dOGcokvvRCbpgoelaDUUk+rQc=;
        b=QCmiEThGUzwlPbsRUqJC4V4XZ+m0ZpymRa+57dfXcH+Rpz4gJdzXDPMTrPcuUi6eA8
         M/FiBFkiTwMnDu6xJvMe0A1trefUcJW5wAX9ShxMiaNbAvo7d7IO384yEVg7aDRp9p00
         5lHL8WoLHCr464kDS/lGukm65VjFpK60SQhh7x9UpHFqt91ZOgFadbq2BLqqqEOMwPiE
         hFMIwxsO1IxgOfG0LJVvF74zuOPKuBOoVew9tK5BTGq/gZq+JZ66c5FBQbcZVHJ84BS7
         EU6KtLmzevn/54ewPuhRaQMS8UKeYV79brqRIcjpl6i/hsQq3+sEfEPiewAHYkf/d3C6
         UkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769727097; x=1770331897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEP+gJiAzlwp00B1A4dOGcokvvRCbpgoelaDUUk+rQc=;
        b=fzVjpgpRqax8a4Q1ni3B3zmPO/CI2h54VUp8a8R58ADc3D8XovqI4uZsPVW1fqrxdb
         O4wV1OsrveSrtuEEuDCSzL3HCoydibr1T3alSH6IGnwjmF6s6MvZTW4l5LwIGXxnaeXw
         vjumoTGfbolzzfrHX9TjaNKzexccer7yj4XbBbutC2xbxooB9J7y1IaAsAcDe44TRarF
         H2zgyt9XchclNJz3u3mf8LHWQleq3tPMlLBvghemBDLIki7OH4K4julTSY4QCNiKo936
         B1mVHQt7e/PioQxeWqjffa1k6SwzNWshymd9t6cu33IPmYu9PHZ9/GNeaxsBjytHuXI/
         pJVA==
X-Gm-Message-State: AOJu0YzOYTLjZ70Lz/lT4DhcPzrGvhE92rZ5J48EDw33NFZ+C3u57rKS
	X8JotipsVvlPB3nIujdJtoImSWrSZFFc2JE1qc9n0JpLKsc+EazS8+H9dqrriSWNgCfcGLybusU
	eTyC9tg==
X-Gm-Gg: AZuq6aLXdff4M+lraaDm6lyEETEttLC2FgyzBzNrAeEiWMMQ2e7YSDjvhmSzwsRXhe9
	oNTLBFsKnHWUuRDXXbtCUSQv8uvyju/O4OWO+3q6+sDjJjYPFofOKGRc2Kr+HIC9r/wEobUSgHP
	OFGvmoby9DKF8JIbAqqQYEhoajiw4ETc/6kICn2X/vGzw7nX3c113mZbnS3SXJJnDBPz9Se/fUP
	ZEA6OX72c8rA8UzmZGwUdggTOgnAX6m1UGZ7fMAA68caYjXbUOIUKL513cqngDoDTRzc5ou4YUz
	KINh7gLgDgQt1dnSndKvMLl3i8U+Nfw6njR3UewOLRdd4uIL2h0YI781E/z+HaKSKfxyhtDvNpz
	ZdgyTv7pWbq4xYpLOUHDYckuNj7o6GFaJIPH3/eMgjDG9vqapGE5Wqn1T+m18EAIFyB/fZH8J2L
	oGnoCGBpAEBzKPhIAMKPURTsnn2yWHELQgkYMJ9C8UUlDMyi1V/6RA/p0a
X-Received: by 2002:a05:6214:29e2:b0:894:6c8e:ed10 with SMTP id 6a1803df08f44-894ea0618b5mr17277646d6.47.1769727097273;
        Thu, 29 Jan 2026 14:51:37 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d47f92sm493658085a.42.2026.01.29.14.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 14:51:36 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org
Cc: linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com
Subject: [PATCH] lsm: preserve /proc/sys/vm/mmap_min_addr when !CONFIG_SECURITY
Date: Thu, 29 Jan 2026 17:51:33 -0500
Message-ID: <20260129225132.420484-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2528; i=paul@paul-moore.com; h=from:subject; bh=jNcQkI5lVA7LwC9/vCuDXRmjKKHFGdLPOmtZAer45UI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBpe+R0dStdMaTc8Lfm5qFDGpBQfKxtHEEtyER/O XUTmwfdj8GJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaXvkdAAKCRDqIPLalzeJ c9afD/9DxXkYDZT/uoxwuPoLhwd+ey5hAd8FJbSnOKPAf+CyWIKU7uUdeGuwRzpaCN9DhzmF2Oh pcac3xMhz0nLUewgQ2H0WNuQX2yYAiPqumoj3Ap9DfLNCT+CDGoyUYjJ7PmXHyc67DDlo35SRek /R5yDaed34LudFzTfc1XRX8Xkbb8tcKngy3snRd3RQTpLpikgZ8pqchNtSPJIt2ELQZKAK/pcgT UBkF0SCOjL38785FGqiFWPzcDtzoYOIoWJhDHGALcxJ5/C/WEy/mLRB2szX9+QeHatepYjnMIrd mKjt45TisSfPIXizI1F24dKnGHbrLPmm72bXT68ZC1sbHnK3RQvi7NDrW8VDhSxEXVFgd8sOTxX HzDiAZxaY7I2tb4IH4/8vha8r4pfklG7OtcNmbj4EdjwdUBcFjqCCbGbzfCY+xn+4I85l14404T M5kEJLyKzg+snlv5ew0PnfMtyXWM4Y/SJQw6PRohgNBq/GeFnllmevAJdE/lNtVQ16eqA/magEu Xvf6r9jSxp83obf/q/oiEBi6cIyhXEzRD/Kwhz9ad9Q8IDcKI+4Si6CmmuE4eZP59scaDzseW4k 0bu6Ai9AnBl8z6PmxPht9bwVBu++iQTKaqbDzIMBvP/L2f9m4ccSoQpYl3Hq4zt2OJuh34D6Z4G KOR7Gpa1ClfwcBA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

While reworking the LSM initialization code the
/proc/sys/vm/mmap_min_addr handler was inadvertently caught up in the
change and the procfs entry wasn't setup when CONFIG_SECURITY was not
selected at kernel build time.  This patch restores the previous behavior
and ensures that the procfs entry is setup regardless of the
CONFIG_SECURITY state.

Future work will improve upon this, likely by moving the procfs handler
into the mm subsystem, but this patch should resolve the immediate
regression.

Fixes: 4ab5efcc2829 ("lsm: consolidate all of the LSM framework initcalls")
Reported-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm.h      | 9 ---------
 security/lsm_init.c | 7 +------
 security/min_addr.c | 5 ++---
 3 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/security/lsm.h b/security/lsm.h
index 81aadbc61685..db77cc83e158 100644
--- a/security/lsm.h
+++ b/security/lsm.h
@@ -37,15 +37,6 @@ int lsm_task_alloc(struct task_struct *task);
 
 /* LSM framework initializers */
 
-#ifdef CONFIG_MMU
-int min_addr_init(void);
-#else
-static inline int min_addr_init(void)
-{
-	return 0;
-}
-#endif /* CONFIG_MMU */
-
 #ifdef CONFIG_SECURITYFS
 int securityfs_init(void);
 #else
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 05bd52e6b1f2..573e2a7250c4 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -489,12 +489,7 @@ int __init security_init(void)
  */
 static int __init security_initcall_pure(void)
 {
-	int rc_adr, rc_lsm;
-
-	rc_adr = min_addr_init();
-	rc_lsm = lsm_initcall(pure);
-
-	return (rc_adr ? rc_adr : rc_lsm);
+	return lsm_initcall(pure);
 }
 pure_initcall(security_initcall_pure);
 
diff --git a/security/min_addr.c b/security/min_addr.c
index 0fde5ec9abc8..56e4f9d25929 100644
--- a/security/min_addr.c
+++ b/security/min_addr.c
@@ -5,8 +5,6 @@
 #include <linux/sysctl.h>
 #include <linux/minmax.h>
 
-#include "lsm.h"
-
 /* amount of vm to protect from userspace access by both DAC and the LSM*/
 unsigned long mmap_min_addr;
 /* amount of vm to protect from userspace using CAP_SYS_RAWIO (DAC) */
@@ -54,10 +52,11 @@ static const struct ctl_table min_addr_sysctl_table[] = {
 	},
 };
 
-int __init min_addr_init(void)
+static int __init mmap_min_addr_init(void)
 {
 	register_sysctl_init("vm", min_addr_sysctl_table);
 	update_mmap_min_addr();
 
 	return 0;
 }
+pure_initcall(mmap_min_addr_init);
-- 
2.52.0

