Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CB93294FE
	for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 22:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060867; cv=none; b=he5LLocEkIUitaCyutj6sXBrI9L3DTyLGAfEr7J8QEn4osY02n3z0/cJ3gOA7Skqg36oeYhyWPGk1t7iz362mk0ernFJZaRSaGV7SKuylEeGRfQUyuqtecYoLLjAz6KOVEd4/ju/aXpNGWM7l2G1ygs+RHwCLycnkXIWoPtP/G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060867; c=relaxed/simple;
	bh=MdOdl403AAmx6EaK5G/kf3D0ZcnIWf8hQtg8Cp8fPQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdQ55pG6MBqqIgG4XvIFj4tMLrDDipBN2Ul/0qFR+X5d0IIb4Cq1p5JaS0g3iET3+lyspAfHPqPVXll/ZSFc3tuamGdhmPjKgCf0FAxz7VUaGwtld3RAPFbfKQCEa74fNiqVteg6IxiXgbqUi8+FqxW8Sb2E/TmajNqOqlD5ARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OMKstbqz; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OMKstbqz"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-770db3810a7so32571716d6.0
        for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 15:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060864; x=1758665664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x00LphZFGZPzPYCxzWmyeqt92KKRcJk2FySWOF+nsmM=;
        b=OMKstbqzFzc8RH3Q0+vuaCpJ5p0LkGHf12yuHF6dMr5+iqo5h+kHP7xljN2YqRmwv6
         kYErnwDc2aeQ8ZNsme0ySYpb6GvHFOOPBGKTpKygbVbkmhcp18j1MEEz2vXuUYXH1ZKz
         Gdg5CU8gsuA5POq9roJxBbQP9HY5Dt+FKXCr5cZUpS2zd9mZPerWVfj8Fg7bd6AArWYk
         j9e0x8CiNk2ZPLGiuVoWpvCZzELbWVpOJw5QnQajm560js+CfXO+Q7j1trmHUWlbFSGC
         okJX7tDfCvR3ZTiI880PiryUjfgtxs0BlXqIv8n4zUTrL85zDZueVRTZBXvO0kO2HQMw
         iNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060864; x=1758665664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x00LphZFGZPzPYCxzWmyeqt92KKRcJk2FySWOF+nsmM=;
        b=Ky9Fh8urkXwL6VaJfKP+TFt6kAnIif3ggONVEttPB+0XL+Iz0qz0lkGI8B6QfK/Ptz
         YnpMaTBuR1Xvq8r4a0SkT26XNIC2ALfDM9wBLdjHdYzdOaeVQVEF99b37Ux8jabyxHvV
         8RqU7XKz6Fm+g0EHxl6YTrgxhL6siKFjmDh1r2K4fR76tLWUpd7dRh5I3F8GX5zWHzOR
         ZjBPkNZZ8l4Aad6HsdxUqI+DOIDhjMMPwCN4dWHB5HkuHl6XETdHnz+RV6PF7coYhxtx
         yKCKenP+fkwwFbnf+8XB1b2Ul/5iXATwoswvFSa4dX68wU3KOaHuYGiB2Te9Yxy8kHs6
         U1dw==
X-Gm-Message-State: AOJu0Ywfjsvq3okYsOsA8/jCk6odkyhBtWIe80TV4EPA2I1GQhCj0n2u
	riHsDUgFo6bhMY2jURiE2pGd7MP1CCX3pylo2Y+7bx8bJCDz/d0VxfkbdcQa3DfonA3Lrgz1asX
	1V20=
X-Gm-Gg: ASbGncu9vWG3VBEIUlohex8NR7lBJNhIxmLIUdeF/zuqWWkYb4wJ9cqqR7/yrxEQ2dx
	w4kBHsk2oTV/95XywCEb8Egd/lASQtdE1XUM3pJUwcAKJI+HIC2G4YehErukSLI+TzUiQ9DTAPp
	BRsrVRSw8Cg4/7fVAi9kJc+bPU3Tym1RYzIrWAeofRkURejOU7wWwVe8fLvfqWilKlPLcx0dbNd
	fl1IAbmbwsgfBOP8TfknBvlqPkLNPbIvKLjN9i5EhVdiROLkQgZZyyLBJCogzJM8Vtq/5jJViQU
	3Irp1mcV0Hy/33zRAAN6ZjqOzkxBB3K311Z4v9Sds6NPbmFeS90C2KMwFg3NXiUva1DehIyVm+W
	H6S5Iq5kf/99o1yFiSeQl1G0rVDHvGRIqloiLfFDv6jkjes6D/8aCBMU+Uwv/HXAUWXkj
X-Google-Smtp-Source: AGHT+IFJ8lVgzisrCe2bzObZyVN9BQbbCZHhb/QDlgdNZzPxBKSHumGJUW/uUobyG+JtQQIALoHLxw==
X-Received: by 2002:a05:6214:2b0b:b0:783:f54f:4187 with SMTP id 6a1803df08f44-783f54f4237mr114207056d6.28.1758060864279;
        Tue, 16 Sep 2025 15:14:24 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-78040544175sm47988186d6.62.2025.09.16.15.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:22 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH v4 25/34] ipe: move initcalls to the LSM framework
Date: Tue, 16 Sep 2025 18:03:52 -0400
Message-ID: <20250916220355.252592-61-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1659; i=paul@paul-moore.com; h=from:subject; bh=MdOdl403AAmx6EaK5G/kf3D0ZcnIWf8hQtg8Cp8fPQI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd8b2iWUDC6m4rypPel7juaV1r1LKgrmw4zK+ Fo/ghII3K2JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfGwAKCRDqIPLalzeJ c7WLD/0TINdindUyMl3edV3z4QGER/marIc7uWKXM3ULz+eF5oHI+rbx2NbIpPjfnk99nRpttxP 2J5WDjV9g+OggM0umSQlqbgmUwKkZ1lrHINxE+IrlNbGK7wQefNeL4OjQT7Rq6o9sA3E6zdAjr5 fCip3LpC6Q7Xc356y8fVtEdkFEkKVjRwX5n8KV35+A0juueXC2lBcqU3Yrt0Yl0CkDjFDQEKWbG UQqxYqSaD0ZHS4U+rPfh2XkqLKEET8ApRb3NSCVaZJFJhUQNtnVsEwgBTFlFhIT5XbE/j+WKsvF EbRFFzkT6fn2AXJFBbbT7Qgfe2BsFZfynw6YdJvLBO58G+ip/LJUeWPWvopguddWFXc3LKGdBTa nPTHx/FRcPDm2GyjXYJ1ARdgDEHZ4VUj48Plc3Q5H9o/QEc+jc+QuR5q09yI4edlPdFHqA+L8Y+ ok31mSkq85XjxB9BFOngxu1Df/iTBpVJd7xP2Uz55ViEM1Wna8B8b3p6sAyr+GZz2CtxFpJLT1w 5r8uBqwFsqljT/D1YMMF96mwtxzMBFt3O/k0xTe7+I6/tn5nqvk9tGe49J+yH7tuIvfwS2ilIDI aM1O0fFku9DhKDZzay9j44YTXka/L0UTuURHN142AWaSqntrMhsAenBhEUIa5H2+T2JVE2U0AZd GaANnn/t9QwuMsg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Tested-by: Fan Wu <wufan@kernel.org>
Acked-by: Fan Wu <wufan@kernel.org>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/ipe/fs.c  | 4 +---
 security/ipe/ipe.c | 1 +
 security/ipe/ipe.h | 2 ++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/ipe/fs.c b/security/ipe/fs.c
index 0bb9468b8026..076c111c85c8 100644
--- a/security/ipe/fs.c
+++ b/security/ipe/fs.c
@@ -193,7 +193,7 @@ static const struct file_operations enforce_fops = {
  * Return: %0 on success. If an error occurs, the function will return
  * the -errno.
  */
-static int __init ipe_init_securityfs(void)
+int __init ipe_init_securityfs(void)
 {
 	int rc = 0;
 	struct ipe_policy *ap;
@@ -244,5 +244,3 @@ static int __init ipe_init_securityfs(void)
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
2.51.0

