Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D077B3E5A2D
	for <linux-security-module@vger.kernel.org>; Sat, 13 Jun 2026 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781355875; cv=none; b=Ebji/LOcXkbrvb7cnq5f3zTEhz25gJAnvupFUjZt0Y8SXEw2zfKMR6kPT2JkS81P42GDTosNJ0au2SlGtXORmVfkw57P+Ts5ckode7eMpEdRJ+qaSbWk7+jvgQvEDsvJiZnsXMMPxNAnqWZn0xRyufhpfl4kgHWVFz6QGeSCweQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781355875; c=relaxed/simple;
	bh=3vvntg+S2X+Ax/eMsRRgfXIb9auW/tXA/R5dpCGI/5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuOf45X84ImgBSQd0b8AfGbqbfDvw8z3Ct5aQAX4dPqU190AlaObCIDdXIv6Sl4xdDQooHAlN+Mv5qX+SFJIH/6s81oNcloR4y3jhkxcRVOCCV3/l8baE15xdz730jrIvmsBcHAAupeGgPhT1tKoVjtuapbmIOxgQExCyUiQOaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtSeXVka; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtSeXVka"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4921e4dd62dso7153525e9.0
        for <linux-security-module@vger.kernel.org>; Sat, 13 Jun 2026 06:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781355872; x=1781960672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNuTD3YpkBdUsN3SNTli4o0UK637uh750gxlUeSrfmY=;
        b=EtSeXVkaWCF9Qw3BXu3nd38sotcl/2lSC2GWMZjEUdfJaAoMI9/JZIsftYuRdB+6Z9
         waqpnD5fcdQpgeuQHG2XM28IeIoYtBi9Uss5YhGMs1CqMJI2eJg2VrjJw0VltPG3Y5zb
         EYXWN+WKjXR6s7NqhhDtDOWtC7Jd+WfufqzcuksH8xffZzVv3DqI2gAjrI6qjcs92sl4
         l4uWNEjNjgMVYFZTy7ICKgVOXR29AYr2j2STolTsn2Hgq/YQ32gYGIL4hZAA4HOTd76u
         J0hkhoLfAxC5cDd/bT7ipSoFtPAqQbw9FFXdpHFJ4UbxHpl3XxOYbsG9DQMzYgCaUPgX
         zVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781355872; x=1781960672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bNuTD3YpkBdUsN3SNTli4o0UK637uh750gxlUeSrfmY=;
        b=oPkO3sM6ti0d2a+5i3rlBW8J84xiqGIbsTHjAGoQmsv4NIUBY+HKledTR0CCqV/oTU
         ftFj/qKKi/EH9cciYB1d4pRM1hzIPrb02UexxhVE0/hRCwXUY5DcDCOCsDhOtyLptrCn
         MX2vFK+bbQv4t/abco78HxAEn2eJSwqQvBwcyrlbJqFLOO0fo2tToq4LP8S/b/owOSk4
         MXU1GuOEGMy9GBuHE76JQclYCoZSFBqdCUMSZYQhUaIGiehrzB9wfsE+l6DRsCu9EVDR
         btYpyOdNaNb4oMndi936kUQSSxUPj/htfjf45X5rMB0JflFqP6Y3AHv6I6fe3X3pnvgW
         tlqg==
X-Forwarded-Encrypted: i=1; AFNElJ/Ay+y3dirJSpUU/TWvw0igTmKF7q+ig9SzHi47nuHYblZL1dO2aMn3nLFSPh+42smcGSP/Ap83ViaeId0qdtMjV2NveQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYN24tvNzO3LPbwJx0E76+FVKoJepAjUhkDuawTufNeygR6brJ
	YlqsqDS6QIUBhkpLAB9g0bsKY7k1pq4xsEmUAy0d6qWf8i5Bjrdhfws=
X-Gm-Gg: Acq92OGd02N0S9A2L7TK2LDTEMb65250CcW1eiAG2AqP8fZcLwlqjWH8XVPz6JQ2zXQ
	Qhrz61upWw84J5pYgnyNCGhlOtCKdViOymycP5V+W0UueOqUVX7frKCQQs7WWQ4tlQaIw8mJKTX
	EVGg6B+lZIx9pmLcuUj+TPqXcA5gNVxwxCI4PyjWAD0b5tK9AN8wTANvEFoW7oo37CB+ZeNFNLA
	Q0rQlZGQWdM6rlK1CMp6mmc3nyPHxuKUTMyqcmn43zeuAuPg0mvEDeH4MjHE2E4+UFYI4WGGTR4
	7w1Iuk32UevTs+PpdDJI07bN9xywu1Qjk5IoC1DiR4gsf7RgOd34gbS2+O0wAHaul4MJGQBsXdr
	hLHPGPlmwKYsMGbN+Gyfso2s10qNJ/5FfjNWc34Y/aRa9xfNTLrcFleskmm4vceM+7WtrtgsHLG
	aTDAF8zGQiWMvapPNyVZXUmhjeVffyDKrb0WMfCaRXDtrDMha4x0+WeLFONMg60yx/r3iv7U1qg
	5WKNxeD263nGKCh/MkfgTD8IEtFTbI1M/ZweZOC
X-Received: by 2002:a05:600c:8b5b:b0:490:7df7:9190 with SMTP id 5b1f17b1804b1-490ec49f2bemr76562845e9.8.1781355871908;
        Sat, 13 Jun 2026 06:04:31 -0700 (PDT)
Received: from hp-ubuntu.. ([41.140.217.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203c0801sm66259515e9.10.2026.06.13.06.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 06:04:31 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: jarkko@kernel.org,
	dhowells@redhat.com
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	kees@kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH 2/2] keys: keyctl_pkey: replace BUG with return -EOPNOTSUPP
Date: Sat, 13 Jun 2026 14:04:08 +0100
Message-ID: <20260613130408.13709-3-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260613130408.13709-1-med08elkadiri@gmail.com>
References: <20260613130408.13709-1-med08elkadiri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace two BUG() calls in keyctl_pkey_params_get_2() and
keyctl_pkey_e_d_s() default cases with -EOPNOTSUPP, matching
the error style already used in these functions.

Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
 security/keys/keyctl_pkey.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 97bc27bbf079..6b2821ffeb6c 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -155,7 +155,7 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 			return -EINVAL;
 		break;
 	default:
-		BUG();
+		return -EOPNOTSUPP;
 	}
 
 	params->in_len  = uparams.in_len;
@@ -238,7 +238,8 @@ long keyctl_pkey_e_d_s(int op,
 		params.op = kernel_pkey_sign;
 		break;
 	default:
-		BUG();
+		ret = -EOPNOTSUPP;
+		goto error_params;
 	}
 
 	in = memdup_user(_in, params.in_len);
-- 
2.43.0

