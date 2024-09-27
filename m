Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8552189B82
	for <linux-security-module@vger.kernel.org>; Fri, 27 Sep 2024 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727425450; cv=none; b=lg7Bgo+kWwemobGYcZgFFPbII+Lnou+EZJknp4AfQR6Vk9+t9VUiqAR2n5F+Dl9HHlziGGtPsIxzXydk1jJ5PWVUaQzCEU9iMwDLwUSfJ/G2X25lmZ8jSnaBTAa1dWkTvAGHu3d0aETPmAmcCPATHYMirVMq5DRwxUF7oSu4IWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727425450; c=relaxed/simple;
	bh=CMaRWK9qntzXRMyqHLBknH/QlMtghCmbh3QODrzSCMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AENSdgDdB3Wg60rFcSihAmO76rW96ZydeqBD77/xCN7bk9yRF7Hz8HcMiphzpKzbc4mzpmN6tP8/ofEeBeLjyTujpVYUyg4vKjL0Dq/IYfHevEErE4snBZXYZT4FbB8aYNxJs52Yjs9rQn+TNdxKtI1lQ/8olgw4OKS3BVtSd4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByiZS/YO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByiZS/YO"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso267166366b.1
        for <linux-security-module@vger.kernel.org>; Fri, 27 Sep 2024 01:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727425447; x=1728030247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEjFzo37f6EpyDzDuRpVaQAIohDLYGPYMxdwR6yvEmk=;
        b=ByiZS/YOK+WHL4qCKudxoVmv3arNZFgLSfRIJNrElBT/ush5p7MMf1GzFVDsjqESmb
         5Y8lMMBroQyIC3nOGJTbHnYbm4o6ApqivlT+nPxy06MlaPDG37E/2XmU9MpG5HnC1l1o
         oP5/DlEDkwomEPKK6oZlfDTV5lPNNKWuemtoFFAcJXiKOwEE4vuDNTsmy958G8zNIdIX
         5t7B2/UaOnVRXwvKCFF/XPvNKQBap73TRQiR4OcYA+xF7osTMbm+koBJnjZNYUG8Iuu5
         degVkRRz2pFImvi7j6uwy9vf/KZKbXVnkAmly4mWnTT4hcNaVtmUnS2xT/VSeLbfYtEw
         d7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727425447; x=1728030247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEjFzo37f6EpyDzDuRpVaQAIohDLYGPYMxdwR6yvEmk=;
        b=ih3lpdkz9gaRxLNVK7a6T8rYX5tRofkQwGwxenE1YwbOFwnoWkBkl4xvuqdK6Iym8O
         KuCGrU8I4JuU5JEnjGx0UMrVuCoME24ueIz9munYDPRZxzv3kU5v9PeR4gwzsTgCpNvP
         VBr2ewn33vlOBgh4uJtbRNVXOibJ3nRu94H4v7nspn4uUSpD4F4qL/LuzGXpO8yUiteA
         IzhqBxXte5G9RUv0k5sRgYwQqqpG/SOzMv1nD6tB/JyneqwWdttxCl9XIvxHhsS+RrxA
         JIG1eS0s2CiUvK7/wXdvNJ2VyziDiEnuHLGNK7TN8bdHe2C6+MkQxXio0MtpihmBp3Ug
         OEOg==
X-Gm-Message-State: AOJu0YzYdmxt2rTRW0LS09eIAWJqNxi2dt34MENSRL81fBNtq5f2z1A0
	r71e3otS8sloA8fp7avnUqV9c8Z4pkM30dUjIBl65Dzg0qFMGRqrKheQ5bg/
X-Google-Smtp-Source: AGHT+IFu25UHZTj7JHnNIHVUgB9+k1qGRpdjYDdgrDlBxiXG+OCZAnY64dlVUghGW3QI5RHn/5zrIg==
X-Received: by 2002:a17:907:318b:b0:a8a:7549:2a30 with SMTP id a640c23a62f3a-a93c4c4238bmr196587066b.63.1727425446309;
        Fri, 27 Sep 2024 01:24:06 -0700 (PDT)
Received: from localhost ([82.144.39.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297be2esm100727366b.174.2024.09.27.01.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 01:24:05 -0700 (PDT)
From: luca.boccassi@gmail.com
To: linux-security-module@vger.kernel.org
Cc: wufan@linux.microsoft.com,
	paul@paul-moore.com,
	serge@hallyn.com
Subject: [PATCH] ipe: fallback to platform keyring also if key in trusted keyring is rejected
Date: Fri, 27 Sep 2024 10:23:44 +0200
Message-Id: <20240927082343.553258-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luca Boccassi <bluca@debian.org>

If enabled, we fallback to the platform keyring if the trusted keyring doesn't have
the key used to sign the roothash. But if pkcs7_verify() rejects the key for other
reasons, such as usage restrictions, we do not fallback. Do so, following the same
change in dm-verity.

Signed-off-by: Luca Boccassi <bluca@debian.org>
Suggested-by: Serge Hallyn <serge@hallyn.com>
---
The equivalent change in dm-verity was accepted, so apply it to IPE as well:
https://lore.kernel.org/all/63220688-ac55-e1fc-300d-c93a948801e3@redhat.com/

 security/ipe/policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/ipe/policy.c b/security/ipe/policy.c
index 45f7d6a0ed23..b628f696e32b 100644
--- a/security/ipe/policy.c
+++ b/security/ipe/policy.c
@@ -178,7 +178,7 @@ struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
 					    VERIFYING_UNSPECIFIED_SIGNATURE,
 					    set_pkcs7_data, new);
 #ifdef CONFIG_IPE_POLICY_SIG_PLATFORM_KEYRING
-		if (rc == -ENOKEY)
+		if (rc == -ENOKEY || rc == -EKEYREJECTED)
 			rc = verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len,
 						    VERIFY_USE_PLATFORM_KEYRING,
 						    VERIFYING_UNSPECIFIED_SIGNATURE,
-- 
2.39.5

