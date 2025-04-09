Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B900F27C840
	for <linux-security-module@vger.kernel.org>; Wed,  9 Apr 2025 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224830; cv=none; b=HHs+eB3+E1U72VSQIzQ+jQrDhD77hW2K0jsq9n3vHUslKCxfYquAUAgWMUj8DWl3ZxCn4J9Mk/MKQlRCTPRqMWy0ZOOr7+cWNnSDgYM226LqP7+nVPy0KIENsPkUAg+ki2KE/mFrii1sPt74dhfrdMcRhswVCGyi5DXx5RVPrrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224830; c=relaxed/simple;
	bh=aZmsIvJPoI4ngYmXJWeXgF8y2oOlPMmKtKzq1MSs1DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YI+THjffkyYhfymbcxNcoZXJ0Y3vCz0Cnh5zW87Yupe4krnD+hINMQe/mClmzn65wTQk5HXwFefQzvM7AlruH1hQwg9K6w0g94VR7HbUYKfZJiIoyfIP4byRuKyf020Ehtp2xJqKelep+C9Nh7m8Fzd0z5GrAO/UOTjndz7qJ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Tqoe9yd9; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Tqoe9yd9"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-476ae781d21so68996611cf.3
        for <linux-security-module@vger.kernel.org>; Wed, 09 Apr 2025 11:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224827; x=1744829627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0frXzb7FQ4unUv7hadq0SfdHmMnKmLmjlk2MSpCAis4=;
        b=Tqoe9yd9L05LucWrnguG82ECWN47AzV1zDI1m9MAgp13yEvWHvA+ngzw+BVMLjJ55w
         BsCpXVCy6l/aLNetiXEyPn/7JECS2Eh7GssTVY6NBNmCRR0MVqDmhFpuBuhfi326GzJk
         wqLAEGqrucv9BUM5LWvlVXYC3o4/T7PJNzoJh6ss4tzOdkPxYvFFOhV+8Wjm19bEtpLP
         p8qYGeAnAk6xOVvT9XvVMcU2icEsQJKxWp9xKv9x/LqpJhyrtWsjWn9CKQYJByJ8ZtF3
         Im62uF1m/pw773cLUu+nSdwpwtqUh5o+vVuw2RmfYgyspBpLnydcZ5Kulg72aB5a6Qu5
         SHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224827; x=1744829627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0frXzb7FQ4unUv7hadq0SfdHmMnKmLmjlk2MSpCAis4=;
        b=DaVFJA0LhbRUQEmsFcWAqk04yaeGtGexIsSSVRIffr6rUBm5diGsq6EnBjuc99hMMG
         7Sk4SQWg7xJUDJFQ7yKtn3Oz5wWkr2z8D/BLf4RNLGT8FRe3wRR9X0rcszs/axn9b/pk
         rvBcNfgTpTpaZ4oLXrOvLAtaqGRsz/XsPTuhfns1OOVZmkuh8UcMtbyiL59GUabPPeYG
         Fqsv5bSG04LgO3Liw7nbYHK8Jwfn5CV5+oQtCwmINPJuIuhKlH1gw7aK6bFyOXG5tslc
         rNar0MFeOW7u/pFBOlcb04drOG3GHwMZsZFAJRR4N6o8pxo5MiL1d0/2RpbVm5k+G64S
         bD4w==
X-Gm-Message-State: AOJu0Yx/bhkCFRfh3J6T78FHLfOsxq/bM69F5235EcRidrhwVSt2qMeS
	3M1JHoOSPjrAoVfOPh3KJy4zCMDfNFRqfiuODtomC7d1ZwRrtNMZD9cE1mTnXSwnvULmNSJPKOo
	=
X-Gm-Gg: ASbGncutm0UY5DSP9Cl7HdXK9mdC7ZD+4VDdJdRp60KeAdn9BEyIbCUtvnFJhT3ttNj
	gbHJ6rH8VTDjhC2V9FMTC6k4rD89XMxqJazuz6jerC1fOtdoG3yW/kRG0lz/G0xGma80gYdOtGx
	0arlVmPIYwI7Ocmm74M6IlhGK4CwH/MkjWbdEG87XpiTudyLQomDyVnSPEtPbUfltmopP9mC5E2
	WOQ/P33xbga5ffajdxZDXdk0cLShG1sWtD0tUI35LXO1TPwAV7PorADCl5Z9Fdk3GVjoz/DLtjc
	qzVibI0WRTlSXuk4e00osfq5OC4ZYoCXgcJGukv2/LbiQ9Cx6eYDX5vzzQHGQITzYChW4idSnZe
	FuCrQqG6JOQ==
X-Google-Smtp-Source: AGHT+IGM3GNaeeJGL2gDIPHXC+k23Jbk/TbMdo4kNoHgoR36g+QYaYkUm4L98mVKKwoC7nghpRZPpQ==
X-Received: by 2002:a05:622a:11d4:b0:476:903c:822e with SMTP id d75a77b69052e-479600c2978mr57671031cf.27.1744224827573;
        Wed, 09 Apr 2025 11:53:47 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47964ef7283sm10257671cf.68.2025.04.09.11.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:47 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 19/29] ipe: move initcalls to the LSM framework
Date: Wed,  9 Apr 2025 14:50:04 -0400
Message-ID: <20250409185019.238841-50-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1483; i=paul@paul-moore.com; h=from:subject; bh=aZmsIvJPoI4ngYmXJWeXgF8y2oOlPMmKtKzq1MSs1DE=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sHcccWtngsU8Cc84kYdEf9bgvv0CHwM4v1BC 0cgx2uWnuqJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bB3AAKCRDqIPLalzeJ cxYcD/9+8juKSTsg1WDIkPvMtLDYg1N/UF0f6RqwFmfnoPtH4gJN2rVLNdLp343bq+uZIWhjT5Y sod1rK5biX0sWHs9qmHHFp5+3uGXYDIAyFcALVc5exOCacHkFgdISykduCLLvHb45jKXpTobdSz Uv5s2xMUAKWhcWKlvoBku3Bq1A2bB0w14eca3ndSDzzsk5wKNi9Onja5WDAiAvWdyjPEQRj9Kj+ C37ZlTJc3WlH7faMncbhAjwiuAJwUQDsiOPG2GQ63Sf1GzBo8LDCQ9eMqRJhaoOzsz1CVgJeW4I 56JIs+m4HqvHNGBD9mtVU7rvG9VHwsbdB+uMEtYFSRfZFc37ZkHYB06K7M7takz0uLSPDZKHgfV gke6QlDwoJgPy36OVDcz8W39PZX67hJrmXUx0G1wB/ynhYXt8ygKmLHWZdDxDoZCCmGbNZEzaty AVfucVA+eVkMJ9RrcYHZxv3WRh3vq7bwMhxDi6VORaxNSDFREOEhzEmHG63ahksayaz5apkf3Ri QF/rsrUrUXI7HD7v+ZhndrwPo3gbr+GzcdriefXf4ScabZzjHPEDEVsY1E5fQz6hSE1Nd/mlF/7 HKETphgdAm9rpD0w3MB8Uv3OEqtkfnak/DiYjzBC3VIiypzWRcnOarBE+lUXwKsA8x5QmTazKHd HpLQWAC4uJcZ1Rg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/ipe/fs.c  | 4 +---
 security/ipe/ipe.c | 1 +
 security/ipe/ipe.h | 2 ++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/ipe/fs.c b/security/ipe/fs.c
index 5b6d19fb844a..e4437c70ed3d 100644
--- a/security/ipe/fs.c
+++ b/security/ipe/fs.c
@@ -187,7 +187,7 @@ static const struct file_operations enforce_fops = {
  * Return: %0 on success. If an error occurs, the function will return
  * the -errno.
  */
-static int __init ipe_init_securityfs(void)
+int __init ipe_init_securityfs(void)
 {
 	int rc = 0;
 	struct ipe_policy *ap;
@@ -243,5 +243,3 @@ static int __init ipe_init_securityfs(void)
 	securityfs_remove(root);
 	return rc;
 }
-
-fs_initcall(ipe_init_securityfs);
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 2426441181dc..71644748ed56 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -95,4 +95,5 @@ DEFINE_LSM(ipe) = {
 	.id = &ipe_lsmid,
 	.init = ipe_init,
 	.blobs = &ipe_blobs,
+	.initcall_fs = ipe_init_securityfs,
 };
diff --git a/security/ipe/ipe.h b/security/ipe/ipe.h
index fb37513812dd..25cfdb8f0c20 100644
--- a/security/ipe/ipe.h
+++ b/security/ipe/ipe.h
@@ -23,4 +23,6 @@ struct ipe_bdev *ipe_bdev(struct block_device *b);
 struct ipe_inode *ipe_inode(const struct inode *inode);
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
 
+int ipe_init_securityfs(void);
+
 #endif /* _IPE_H */
-- 
2.49.0

