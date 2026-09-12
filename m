Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331E34BEE5E
	for <linux-security-module@vger.kernel.org>; Sat, 12 Sep 2026 00:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789171467; cv=none; b=sIjIxNkGA1/hxh1uZSKEHNKbmSoEw4v7eYTSq29fuE6ZfLZ2MjkW+WjLhd6yMbasRkG4THA/6bXpk1oI5AhTjH6qsRmtD1ICZvyPxUAT8clFk/eWJXiyrmnwkMxPd/AYKWgGfpdYHhwg9hun5UL+OJeVdyR/OcQ7wkV9YHFK7ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789171467; c=relaxed/simple;
	bh=n82F2pPmPahB5H5p9ewC4ejFVmfTVZNABSsI4Qn1j80=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jws9p44uK+tByB9RPExqeNXDzPqsDeMmay1imQ8vijBcOHpdv352WxzrqKSTmS/ExEtOwNufvoDMsPRbv+M6d+qNlGDTxeR0iX+jh4h1AqX9gRMt7QoKJoM5iUCjO5dnGfA3p8igWUjCViF/KzS5WS5LotTX9ATfdlmwERwHXVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/jYKkrJ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/jYKkrJ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd6185db7so1948375e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 17:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789171464; x=1789776264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RWmViMmNo6OPinFA/8hMYl/DXoZAHUCdFKUGuJNPOrE=;
        b=g/jYKkrJRpJnUCt/JoeTgVYP5tJQMjms7y2KoUTnx9WSXP736OjNDY2C3NLqKJa9j/
         5kLCqEPrLvUzFBcda0HtxiWllcZO9MFVkv6ueLLE6xTYwhDtnlB5z4M5kcf+IVHesTUY
         n1dVmWgq+jv98jMatXg6cG1h3iHiZOLYfDL+hyq/kKsmul3mfsYeMkG1uzXASJpFXYQi
         anYiT4h87DLgyNfy2a7UtRUPGl5gmlfpWFdUr8hbp4laq4pMNCtUsCy0rlvxQ58gOWMR
         UCUSwNdoc5Si+3RU9LlCS9VJ/kvDmXy9dKO4aF5AUrd9XAgODbRX9+qW5phnpQwG1yKR
         M0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789171464; x=1789776264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RWmViMmNo6OPinFA/8hMYl/DXoZAHUCdFKUGuJNPOrE=;
        b=qVpKE7VQ75da+o07TVFVgEvsCurInL/PL8pFSWRpPBgA9QybLnBuBP1G5ZbfjT/nxY
         9TNgvgFhZ6LcxodYdcibWvM6zJ6UmkHd+ntHaOBaPTa940BHC6dy6HKotYIYgc49E4Bx
         DhWfMW0WZb7tVnEOvqIz03XmsbsBc6qPOUFQsIWoe7vayYAcO7dPrCm+B6oyg9sE78YV
         BrAURBTyAR55+2yrBTD5gkAWBDjGu1sQycMZJ8HhYPxRYaixGyyVwOVkiXYhBHK1w5V4
         aMPr0AEUmkWHdP12490czFASgCYkwjAelGGQf3W9+gv7N70Rn70qj3s8PH+oHO0v3IIl
         IrSQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0n4bGor4GyUk08Kz9Q23vAlw+KACA3ntRQAA2tnXAB/Teg6+BASmKNWTZL5G5dtpRHjYhitpvdb7ajJTt2oBkroAtOBg=@vger.kernel.org
X-Gm-Message-State: AFuF++lmDxES5NN34hDyQAn/5MfbIMzALSHf0DNFbe4fRMmCJSpDF9ar
	OTAykqdFjb3dgEKPnIEQHD3ySbMReQd+D2KOG8b7zYiaAUURrhc+mB7w
X-Gm-Gg: AYBFou3NZAMi4FrJ9aOoQi0BOepye2i6lhMNGwiMwsHao2iOaBpFYQyQo2HffLAXtQg
	Sh1VVbsKtPg1vms74NZzI0mkd6RztunNnV0DO+6wuGMdjq3VK2nbQp+RYxcToJSm4XDT1Fzcmac
	u0tHFx80kDShcZtQa5MIubekI1ICLx28N5WYqPiS2eLMa3Pj0apgFsuGhnfEdeRWTDVCS9s+Cgd
	oiCZrr7c6sfWEVAfdODS3YFL2TlXhcglcAJeQ4bGkbZEn2hNQRb6xrn74My99JiZzRFt4vKxOLB
	9XvhdzXU94CfLb6mhwcKbAQ0cEljaLO3L0XeIWfyqQYpV0be98NbNms0/ytgr7L0OBRc1BSx0Ig
	zPFQqWUcPbNnQH0qf6E4qdddqUk4Yt23vYGugOZ8FO6XPyuDAiARRVxbTBRsdz0bvGxgx+OQONv
	KTi547B0YnKvEFz/otxps1w3BOmA8d08rN3IU7DJjdsBe3X0LZ2ZSuD5IWOAEqFeliEpjiQsfXQ
	I5NqfrfKJ0UoOTpPYeZf5OLzNynnsSqQyBLwRk6leJ6dDXsT24MVg/HGSYBIEMLr8FKrxQ9E7WK
	x2z+OUPYSEt7JaH8RwIxAzrX/HV5hnsXzbwR
X-Received: by 2002:a05:600c:4683:b0:49d:1916:2133 with SMTP id 5b1f17b1804b1-49e6106d393mr77113675e9.8.1789171464161;
        Fri, 11 Sep 2026 17:04:24 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-033-154.95.114.pool.telefonica.de. [95.114.33.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60a8a89esm108675645e9.1.2026.09.11.17.04.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 17:04:23 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: Fix the return value in split_token_from_name() kernel-doc
Date: Sat, 12 Sep 2026 02:03:02 +0200
Message-Id: <20260912000302.34565-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

split_token_from_name() returns ERR_PTR(-EINVAL) for malformed input,
but its kernel-doc describes NULL as the failure result. NULL is instead
a successful result when the name following the token is empty.

Document all three results: the name, NULL for an empty name, and an
error pointer for malformed input.

Fixes: 63e2b423771a ("AppArmor: userspace interfaces")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 security/apparmor/procattr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/procattr.c b/security/apparmor/procattr.c
index c07b6e8fd9c93c73ea82361af83337774e6d1bdf..cfc45db43aa0c7418604fbba0e4c30a90f0f6cbd 100644
--- a/security/apparmor/procattr.c
+++ b/security/apparmor/procattr.c
@@ -74,7 +74,8 @@ int aa_getprocattr(struct aa_label *label, char **string, bool newline)
  * @args: string to parse  (NOT NULL)
  * @token: stores returned parsed token value  (NOT NULL)
  *
- * Returns: start position of name after token else NULL on failure
+ * Returns: the name following the token, %NULL if the name is empty, or
+ * ERR_PTR(-EINVAL) if the input is malformed.
  */
 static char *split_token_from_name(const char *op, char *args, u64 *token)
 {
-- 
2.39.5 (Apple Git-154)

