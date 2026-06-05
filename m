Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939FC3D0C17;
	Fri,  5 Jun 2026 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670631; cv=none; b=KBn8LXdFG3M7ZV4uHpBSOA8+qN4sgCJadCyU8loK7axQY8yIVPFT8DteZ3eKAZ4zPcfQRNc++Cm1KYfEDfBXPdaW0dhWLztZTh1jM5vIh7poHZIMZzjwne19zblYimIaSfo4TFS4UZfbxrYOGcq9hnzwtgJiR5nzlCB3LiYbR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670631; c=relaxed/simple;
	bh=89AoJatEzNGhZ8P3NpK73/gHwNaQ1811DMSbBBQix/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LZZelEPgzTH0SQJyAS6RYb6mLEWrDr41j7oNLBPUTk92ZguDfmXi3NpBGPmdcj80rDGQdVce+AYRO3LsVvH/y6cVDPWM+IhQsPsp0EkyUG4uFlAQO7nbT7HXQhsYT8k1qbt63vT+iVx38p8SuvtpGcOHUjtyWjhoazgbH3rU0Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ah1pfGCl; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ah1pfGCl"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D8F4237B;
	Fri,  5 Jun 2026 07:43:43 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 31F1D3F7D8;
	Fri,  5 Jun 2026 07:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780670628; bh=89AoJatEzNGhZ8P3NpK73/gHwNaQ1811DMSbBBQix/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ah1pfGClri3U5Sw30ICpHlpa7EpLjXxcd5QRwRahQ5ulAQQl2k+xRuKLPy6HVOGKI
	 /Tuh03zHLNiLetXUgcQCIPJbchjFYkNdGGnur/OTKoj4Bhn30nCcsqftjJcnpEoE/G
	 Np2tFFWkGuMDDmWrfsJtyOk3e58VJKXz7zZ5qxzo=
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Cc: paul@paul-moore.com,
	zohar@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	noodles@earth.li,
	jarkko@kernel.org,
	sudeep.holla@kernel.org,
	jmorris@namei.org,
	serge@hallyn.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	jgg@ziepe.ca,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v6 4/4] tpm: tpm_crb_ffa: revert defered_probed when tpm_crb_ffa is built-in
Date: Fri,  5 Jun 2026 15:43:25 +0100
Message-Id: <20260605144325.434436-5-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605144325.434436-1-yeoreum.yun@arm.com>
References: <20260605144325.434436-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 746d9e9f62a6 ("tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's built-in")
probe tpm_crb_ffa forcefully when it's built-in to integrate with IMA.

However, IMA now provides the IMA_INIT_LATE_SYNC build option, which
initialises IMA at the late_initcall_sync level, so this change is no
longer required.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_crb_ffa.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 99f1c1e5644b..025c4d4b17ca 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -177,23 +177,13 @@ static int tpm_crb_ffa_to_linux_errno(int errno)
  */
 int tpm_crb_ffa_init(void)
 {
-	int ret = 0;
-
-	if (!IS_MODULE(CONFIG_TCG_ARM_CRB_FFA)) {
-		ret = ffa_register(&tpm_crb_ffa_driver);
-		if (ret) {
-			tpm_crb_ffa = ERR_PTR(-ENODEV);
-			return ret;
-		}
-	}
-
 	if (!tpm_crb_ffa)
-		ret = -ENOENT;
+		return -ENOENT;
 
 	if (IS_ERR_VALUE(tpm_crb_ffa))
-		ret = -ENODEV;
+		return -ENODEV;
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
 
@@ -405,9 +395,7 @@ static struct ffa_driver tpm_crb_ffa_driver = {
 	.id_table = tpm_crb_ffa_device_id,
 };
 
-#ifdef MODULE
 module_ffa_driver(tpm_crb_ffa_driver);
-#endif
 
 MODULE_AUTHOR("Arm");
 MODULE_DESCRIPTION("TPM CRB FFA driver");
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

