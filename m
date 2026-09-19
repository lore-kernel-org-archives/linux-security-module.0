Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4129A376BD1
	for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856267; cv=none; b=Nq7vTCQ8Am9oHTyvFeoLN9wM8xtZJLyZ6/F07Iwi2cMKZlIBxsUJOP9ywJEgEk94myaS2RqWw9LNIEKXw6YqtdY6+7jICJEMy/sDBtU2hM43Krwsowv/kLsmYvqyICBQEjOfP9HEnAgcBhQGaf62te02QHvAgCTeSsk+IoxGCsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856267; c=relaxed/simple;
	bh=luG39Slsuu9toOe2oysPgljEJ4oyaSeqnju93SdcYmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=REYDaSUQyLJtb8+M9YDnKI+2NQaK1X2zZfUkV5t9mvkcMW3fhDbRsxrX/LKeZ4r9dt/sWMOW5Hjb4DZ+0AblwxeT8fWRc3FyrPSzkT0Enke8KSt6JmUVBZbTykxL6XQ6pkVLwaX1SMNBYVIC4X+pCIfgGFdK1qMdhhqheAJMIJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAsGnIET; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAsGnIET"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fdc579daso21130435ad.1
        for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 15:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856264; x=1790461064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7+KkRzAFhVcVxvzlKQ3lllIEZuNf/Ys+gCGhed5VDjE=;
        b=EAsGnIETjvd8dHTwVql8HYC2+QtLK4Z9qmj1nHamRP6oHLK27YmIOqfurFyDLDUSBv
         MbCzXTn0yRk4USqKeFdn3Eb36T2gEIg5Few2Tobtbso/v8qZme4YOAjC/H0M4+XWLAfd
         7JSTuFx559fKJTRijoIaaBcUJlL8l9wxEmRg1EnJC7/V9Q1u3kW5yVbY9uXhDMl2Z8U6
         1GmBPsjq5Qc9XVLuyMwPhfMFULHq3t/8gZ/9ibZv6JBXN624wqHLlXO3IoaJrpXo1N5T
         QasNDBNgwdu429GICgCApwuNm3EgIfRHPNhW3LMWKPKD6ab227zfWbrfpNRGoLNNmq7c
         jw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856264; x=1790461064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7+KkRzAFhVcVxvzlKQ3lllIEZuNf/Ys+gCGhed5VDjE=;
        b=oIZa2YQFwzLSWA0I+IYwya5GjAL6YXt03EgJ8hNx7wsLk11qwH4fhs7ZXgxGYrpsXM
         f4Yj+HAG3HV80Q+Bw+j/euZLgn0Y/kfHO10h6X4pMFFtk68851L2MFG/1rqC7z3FdicY
         hVXkb8GQMO6enQz1OGvz5TOoJTvVXx82lv0OaetXfXyr2xw4bAt7QuI1ghpjBiYaxQmU
         7nRA4uEzpxRyMUTy8hU+S+cQr7pndZyA2oFqpXjevkgHiTVKAJI7nSn1DxhB9myvK/PR
         aqrefgCBxbYEUJdBfewgwO914YwAKxOoS6YQbY83/o4xE95CC1cvlmRxwz9GIpHKgcxy
         DPSQ==
X-Forwarded-Encrypted: i=1; AKwUvBwIO+oaXru22JCYjeq/8ZKAZU2bdUPz/PuYwH39O0w6c8Wxx4Vqryt3rUkUhhLcp81GLlBUSAFghfj13k5xI79Ar2H8Ml0=@vger.kernel.org
X-Gm-Message-State: AFuF++l21WpDXOb/xkDcKSoqEWhbtRsxHJSk3lG2OAwBCUTshrbVj9aH
	9EogIrn7DlddXLkDFpba/41MGTSdBLmKPm6e/TI/flG3iz+sntNk5SyW
X-Gm-Gg: AYBFou07Tgx0PX/gBaTX7cM6PXH/QIfnbwUKrF641PfUzsbYic0NFiNyo5wYQktCnjG
	LuxkRCSDPjLmZrVV+rUNbHHA7KEfQznOfytg96sVrYW0wQ4urJBAF7TZcpotE3ZA7pzmdHsA1vq
	jkBsd+puqWcMWad02s0pJ1F/+oVpV1XnOzZ55ruWUK0DxzHrJoRcS2zgn7uwdLBJ8MOQJ778Fgn
	I1v/uH0bM2/RLZSYNVHJ+EqZi/ACD49lbAu2OaSlMVRuu+tDXo111ie1iust7BKI0HXDcZlfa3y
	xCdG7+Q+aqnv4gDz+twleckwOPyJVC8d2BedbtRW8lNEsXQC+WEIuouw+t3sEKtdn93+lcRe493
	PGUsT5mRqfiuJTMv4EKs2hdSsAl1UQf356w5YNjfHDXsO/QMTtpf1vWKpdUt1uatDL1C+81XFY2
	RSJ9YlqO32FgLHGzJ47PpYTptM2g8XYrggBksxIqKOlNnyCJDVMg4ve8ZSx3/qKFXnj1YeYh3Hf
	VBGBoYb6W41zYFj5fOdFQbwixL5XFOwOx9TFNvIR5S48Fcv695MQMTzNIZoOqb57hpwrM7hDV1t
	eVzGfRnVcT7ZBmeCBTuF
X-Received: by 2002:a17:902:d4c6:b0:2dd:c100:3130 with SMTP id d9443c01a7336-2ddc100319amr48902415ad.44.1789856264177;
        Sat, 19 Sep 2026 15:17:44 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc178701csm12904705ad.13.2026.09.19.15.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:17:43 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KEYS: asymmetric: fix out_len bounds check and in2_len union clobber in keyctl_pkey
Date: Sat, 19 Sep 2026 22:17:42 +0000
Message-ID: <20260919221742.3709658-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two bugs in asymmetric keyctl parameter validation:

1. In keyctl_pkey_params_get_2() (security/keys/keyctl_pkey.c),
   params->in2_len and params->out_len share an anonymous union.
   Assigning params->in2_len for KEYCTL_PKEY_VERIFY after setting
   params->out_len clobbers out_len, and info.max_data_size is checked
   against in_len instead of out_len for encrypt/decrypt/sign
   operations.
2. In software_key_determine_akcipher()
   (crypto/asymmetric_keys/public_key.c), ensure buffer length checks
   properly validate both input and output sizes against the key's
   maximum size.

Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index 09a0b83d5d77..4d8e5592fce8 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -358,7 +358,7 @@ static int software_key_eds_op(struct kernel_pkey_params *params,
 		BUG();
 	}
 
-	if (!issig && ret == 0)
+	if (params->op == kernel_pkey_encrypt && ret == 0)
 		ret = crypto_akcipher_maxsize(tfm);
 
 error_free_tfm:
diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 15b6bf6399b5..6d334531dd5b 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -136,21 +136,21 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 	switch (op) {
 	case KEYCTL_PKEY_ENCRYPT:
 		if (uparams.in_len  > info.max_dec_size ||
-		    uparams.out_len > info.max_enc_size)
+		    uparams.out_len < info.max_enc_size)
 			return -EINVAL;
 
 		params->out_len = info.max_enc_size;
 		break;
 	case KEYCTL_PKEY_DECRYPT:
 		if (uparams.in_len  > info.max_enc_size ||
-		    uparams.out_len > info.max_dec_size)
+		    uparams.out_len < info.max_dec_size)
 			return -EINVAL;
 
 		params->out_len = info.max_dec_size;
 		break;
 	case KEYCTL_PKEY_SIGN:
 		if (uparams.in_len  > info.max_data_size ||
-		    uparams.out_len > info.max_sig_size)
+		    uparams.out_len < info.max_sig_size)
 			return -EINVAL;
 
 		params->out_len = info.max_sig_size;
@@ -160,7 +160,7 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 		    uparams.in2_len > info.max_sig_size)
 			return -EINVAL;
 
-		params->out_len = info.max_sig_size;
+		params->in2_len = uparams.in2_len;
 		break;
 	default:
 		return -EOPNOTSUPP;
