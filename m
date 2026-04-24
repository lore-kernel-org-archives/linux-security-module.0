Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6BF3BAD8F
	for <linux-security-module@vger.kernel.org>; Fri, 24 Apr 2026 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777030795; cv=none; b=VCfzgVTGyl7J9Up9wQazeL/9PeZFMSilIq2SFbM0uPnCxcozO/5mM2uV1qMo8/eWyxQB+WKf9NgrahG4tgTnHR8DCqDPToQwkW2t2CDj7oEYehOD30xDKvkBzrxg5/RiF9FAvOoAbkn7fYlBevPS4yFl3GPKdYVNneLfbyCyMHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777030795; c=relaxed/simple;
	bh=Mn8baejszrg8TBBwgRqdVIVk2uHyhbJN3nmGuxlJh1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RtiTPQ5jCjXCCq5h9x18dRMmLnFs9XHDKIQsdVRHGHBsbyuAjrCbTmxkH9giH/bHEBpwAPpzN1+HSNnHtU0PXyIOJx2b14ffhiPBzDGC/LI/ZeT4D/7spLptBo3pi11kHKRpVz0+ni+JfSpM/L3O6lIDDyLLZ6XJTVGHQQeAp4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dig6Aj/2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dig6Aj/2"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aaed195901so33982555ad.0
        for <linux-security-module@vger.kernel.org>; Fri, 24 Apr 2026 04:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777030794; x=1777635594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ycQfsCwJU6aj5y3c9itCmneMe/paG5gWp/wWLRcNhI=;
        b=dig6Aj/2VdAZ8VmJDRgXYMIVoFNuliTvOX9hXkRdpsI9uEiRJC2dQC4DRUPX+17JbJ
         IYH+vyVtekzdjpCxTkTAt2F2rod4ZvIvKHo0QPjr7gceJY/x0CUeZTifWbXbMEvvpO43
         mP+3mu9Rh/7JoptvosYcpL+YAsHROPob8xIDlaRfWC9XPV+oEdlR0GqEvvlBv9e1wxra
         zHThyI/MmsGdFowxu5wWEF9iH5A6RuiF9yxN9x90pP2fMl8UiUBW/C5/oqRoqlaP0Z8a
         IvcQYFGxtiUsKdjZ6Vjaj6uCIh6A3/mxMKY+WSWbiNF7xmm4Ijawe0egwEIF43mfNesh
         4tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777030794; x=1777635594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ycQfsCwJU6aj5y3c9itCmneMe/paG5gWp/wWLRcNhI=;
        b=nwvH9u3ufbBXkU9tU3laTy07QxUrCNnLi8ZuS/TBkQ9J3y9XM5Ou7dElrwZOCfPobC
         EpmwEQXXooQWvH/BbKka84scPsxoW2V+BRrq8GW0s56vqurGicxIZEDkXP+oe/RYhShG
         iu0STwEeOZpD3aFgj7HEDbKXObz7O8Kck8C+bpfuhq+p+FqKocScI9/k769ROMKYgISL
         xzhsaVQuBQ5xd6MMwUEnXT04UBuX6XxnSV/jwVjDIYm3MDrXjoxzXqX+amfrevkPxVK1
         W++GCzIIVjmf1HrfroI4sM73LZ5jrTwh86g8Irzkvv8jpFPzbp62q57N1hVjurWrhe1E
         5U/w==
X-Forwarded-Encrypted: i=1; AFNElJ/Bm18KpXeKc5YBnz6SokRxJPIyOu/Z4sD88GcFlfzvcK/alO+xi3FVGBK8ozgggWZ1acfXzW5kLaj/B3DHk554CQa6V1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDeCkBAxeR0QTR5xOvYHGsGWgPwslgkJAYvzlSo4SP5nieOWtj
	DdpG4Jwj8nF94F1Lw36aqCQS0SPCLtD64o0EW+KasB+TND6wyO98rzrp
X-Gm-Gg: AeBDievgZ4sdzxKkSbp2Xwu9mFpijm0eiapGkbtJl78OJ+UOIMp4AsNLxx8Rwzxu+YN
	YG79wJ1GD6drrFGzgBQy48DpoGbX7L/9UXGmaxzV4/fbJ5hKVb6rgqZ61V4STavGWzWXsrvBmhh
	up2bF5CvxzLBri/2Y4rcmpXv6s5JbuHPOtzmP5bj4mj76OhkKZkiGLv/ULzBGUfrPVXD0W5XqZj
	Q17qlXKg3QFD41i/5b8E39zx8brprpGK/Sgu+vxcfUZH00qOw0a6bRJVewLe0F03A9jI4iK4Q9c
	wxeA5SrBTFa5bjTuFJiRMpa4KhjeqL5o59p6ivPMLUNBqvVVb+7AldcxFpkhQENTSr09DPCWsrj
	p8wGv2gnq5JhrCDGa5CrdkX9tKMQM7ZfXHzqKKDVMpuopQ83UhdhDieiES5aKjZ3z0heQo2iQet
	jXQZmrmIUpdykMCiWDRGu0lgFk4KZ3jewTjkeBgifWligAFzA+jF5/Gic=
X-Received: by 2002:a17:903:1a88:b0:2b4:5b9e:4edd with SMTP id d9443c01a7336-2b5f9e9a500mr337105715ad.9.1777030793817;
        Fri, 24 Apr 2026 04:39:53 -0700 (PDT)
Received: from kam-mbp.juniper.net ([136.226.244.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa3073asm213824545ad.27.2026.04.24.04.39.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Apr 2026 04:39:53 -0700 (PDT)
From: Kamlesh Kumar <kamlesh0hrs@gmail.com>
X-Google-Original-From: Kamlesh Kumar <kam@juniper.net>
To: zohar@linux.ibm.com,
	stefanb@linux.ibm.com
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kamlesh Kumar <kam@juniper.net>
Subject: [PATCH] ima: Fix sigv3 signature handling for EVM_IMA_XATTR_DIGSIG
Date: Fri, 24 Apr 2026 17:09:46 +0530
Message-Id: <20260424113946.16561-1-kam@juniper.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ima_get_hash_algo() only recognizes version 2 signatures when the xattr
type is EVM_IMA_XATTR_DIGSIG. Since sigv3 signatures also use
EVM_IMA_XATTR_DIGSIG as the xattr type, version 3 must be accepted as
well to correctly determine the hash algorithm.

Additionally, ima_validate_rule() does not include IMA_SIGV3_REQUIRED in
the allowed flags bitmask for MODULE_CHECK, KEXEC_KERNEL_CHECK, and
KEXEC_INITRAMFS_CHECK hook functions. As a result, policy rules with
"appraise_type=sigv3" are rejected for these functions.

Add version 3 to the accepted versions in ima_get_hash_algo() for
EVM_IMA_XATTR_DIGSIG, and add IMA_SIGV3_REQUIRED to the allowed flags
for MODULE_CHECK, KEXEC_KERNEL_CHECK, and KEXEC_INITRAMFS_CHECK in
ima_validate_rule().

Signed-off-by: Kamlesh Kumar <kam@juniper.net>
---
 security/integrity/ima/ima_appraise.c | 5 +++--
 security/integrity/ima/ima_policy.c   | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index de963b9f3634..2dd231567710 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -195,8 +195,9 @@ enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
 		return sig->hash_algo;
 	case EVM_IMA_XATTR_DIGSIG:
 		sig = (typeof(sig))xattr_value;
-		if (sig->version != 2 || xattr_len <= sizeof(*sig)
-		    || sig->hash_algo >= HASH_ALGO__LAST)
+		if ((sig->version != 2 && sig->version != 3) ||
+		    xattr_len <= sizeof(*sig) ||
+		    sig->hash_algo >= HASH_ALGO__LAST)
 			return ima_hash_algo;
 		return sig->hash_algo;
 	case IMA_XATTR_DIGEST_NG:
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index f7f940a76922..b1c010e8eb13 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1313,7 +1313,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 				     IMA_GID | IMA_EGID |
 				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_MODSIG_ALLOWED |
-				     IMA_CHECK_BLACKLIST | IMA_VALIDATE_ALGOS))
+				     IMA_CHECK_BLACKLIST | IMA_VALIDATE_ALGOS |
+				     IMA_SIGV3_REQUIRED))
 			return false;
 
 		break;

base-commit: 82bbd447199ff1441031d2eaf9afe041550cf525
-- 
2.34.1

