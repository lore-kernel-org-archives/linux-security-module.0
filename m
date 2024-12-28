Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3013629A5;
	Sat, 28 Dec 2024 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735371939; cv=none; b=H/h+6vmumIkA3fiIzQda4NLM9oSWRN+mwD14/agbhZMfuy/mmUnlB/+A10RtB2Ik1woyRHn+m7NxFE5cxW3Law0Uda/vjmlvcgVKCdZvs3G68dV7njjJOpNj8Z/FWg9bxxwzcb2wR4wx+HErvma8Y2His7YvBctqYojfEyAnsU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735371939; c=relaxed/simple;
	bh=eBFdAlrHxzjQK47KjlNcuTaAis9UI5hOJhthkHWWGnk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fnjiYVy24Fz0aF6TCH1B58sHrxCwbclnH7BLLDaME2jpFvLEmT5WRT0/p0NmApx5W4xynxhTXf7NfRgDrXheqG0SsPvNxXnUq96Rn1783CYy7GDOxGE6izKMytgw6RpGgUJKla74hi3lSFqJgvz+bEPufBqYz/44ybc14AhNLrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpQ6tFLX; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpQ6tFLX"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f44353649aso7955320a91.0;
        Fri, 27 Dec 2024 23:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735371937; x=1735976737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e4zDi9btoIV05QgCGOmrJi32c8FvkmSREr+jRO+o1w8=;
        b=gpQ6tFLXAY1f3rA8nW26A3c2P3Y48e8ogoaU90rzQIM71JFCZlmvi6rFNtWZLaVE11
         XtBsSv1ndvrZ39IZipKQKKCyrFrtZvCuKSCOCUrPQ6/eQ9tsxguapSoCtXK8D5EhxKTn
         iLjhdZwwt4GlPTkiFNkileEN4QvSnbfGFqL4s6tCST1B5MV4TUzqSIymu/zJ8sPRhNwp
         6JbLL4sETu6+RlZYpjklLin8Gx8Pmp/LzgbiyLiZahCkAfJqxiebHW/qmiaKAY24Sgl+
         WtwWCnCYoYZSXkIzwYn7674MWO/qpJEwaquBytC+VinhRfDWjneyvAqYHGBgl5VtawDI
         usaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735371937; x=1735976737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4zDi9btoIV05QgCGOmrJi32c8FvkmSREr+jRO+o1w8=;
        b=GKtzIkLsKbxWiH/JALuRQEdQL6w+SiZkXlktYI0a4uvrNC7yLm8K+qffIQh6/mfrRs
         3q3P+iN03K/NiT/MPbWKNzqZNUVjbvSSTReMnlQILk4G9iYBC7AYu8kH5hRQCP0WlFQO
         X8Dxo1FcKGXQeObJYPqYs5N0VFeiQXTlM5GKzxSo9j88+K9V2jF2wFvUiWnHnc6jcEXR
         YyuSeRd/f/X3QNGg7ZB6EtikSzQrkhPdJbKPTaWbsQo5mR+SvL1GNe94wljZiPsY88hH
         Feh5n0mlcfAzRAEtxzocoIiem2mpCpo5p2AvZGlZ9mq8/0r3jSWNuXhBT6bh7Ww82qTU
         gdwg==
X-Forwarded-Encrypted: i=1; AJvYcCVa9cMMF6YYYqAiwNY7+s9A8LEzGa7y1+OXx2t/xxO4yYaibG5o6IemlCYqIf0Lu4pTTcjhhm3vG9CFZbkozju833OEratp@vger.kernel.org, AJvYcCXZfQbVNJY7U4ddSD+cUkHCpAYbILmpoEalk1V+kcwmbw53d998Un/dFVKZkUnTPhhMUOBK+S2YDFN10Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpQ/sxrvadz2Kut0e2CZwHwW/AbQPmpheG0xn/XDthtaRsHLrj
	epY3n+M8S6L+W/BcXOmcgjUzlBs2hvz8e3pW6Djz6kLwDuYMGstN
X-Gm-Gg: ASbGnctc0Ej1m+pJNfXx6oRZ8gtoyInSmCHC6M1JfLyRx9VQMnGw704MeUw/jaSkbyT
	gVQbbv8Kn04FHU65MDxvm4CKA2UCQTrDEObLXQiX4jvKIAqWQdWSPPBGk2ThFGWM5CUNokLmmvF
	aXna3k+Uy0fljKy5XM27onnsTd5l9DOUApJzJBG2J5MuwdJzToWWGnDjhFNoYx+uG4i6PXc2/jr
	TjjozrxIE5XfXcerdrqeQ/QCdVN6bG2MylG+/DV/O/O29kGfgxl
X-Google-Smtp-Source: AGHT+IHToe2HwOFp/AZ+7phDrvE2Rvx/RhDePfLRBX3ni7fZokMlBa3pyp3fc71FXbBx6Sc8e4CYhQ==
X-Received: by 2002:a17:90b:2d4c:b0:2ee:b4d4:78 with SMTP id 98e67ed59e1d1-2f452ec6f9emr44411907a91.24.1735371937395;
        Fri, 27 Dec 2024 23:45:37 -0800 (PST)
Received: from localhost.localdomain ([45.115.0.249])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-219dca04c33sm145586415ad.247.2024.12.27.23.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 23:45:36 -0800 (PST)
From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
X-Google-Original-From: Tanya Agarwal <tanyaagarwal25699@gmail.com
To: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: kees@kernel.org,
	yuehaibing@huawei.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	tanyaagarwal25699@gmail.com
Subject: [PATCH] lockdown: Initialize array before use
Date: Sat, 28 Dec 2024 13:15:25 +0530
Message-Id: <20241228074525.3674-1-tanyaagarwal25699@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tanya Agarwal <tanyaagarwal25699@gmail.com>

Intialize array before use in lockdown.c.

CID 1486102: (#1 of 1): Uninitialized scalar variable (UNINIT)
uninit_use_in_call: Using uninitialized value *temp when calling
strlen.

Coverity Link:
https://scan7.scan.coverity.com/#/project-view/52849/11354?selectedIssue=1486102

Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
---
 security/lockdown/lockdown.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index f2bdbd55aa2b..df2c8435a7a9 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -96,7 +96,7 @@ static int __init lockdown_lsm_init(void)
 static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
 			     loff_t *ppos)
 {
-	char temp[80];
+	char temp[80] = {0};
 	int i, offset = 0;
 
 	for (i = 0; i < ARRAY_SIZE(lockdown_levels); i++) {
-- 
2.39.5

