Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C7826289
	for <linux-security-module@vger.kernel.org>; Fri, 13 Sep 2024 23:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726271329; cv=none; b=ZesZ3MA5ypERzvw3duD/ziri16933p/w6YF3ngnjw3tlmyZcer81rtQ/MIAU+EY6swL73tIwhbUPrSc+otDQfdjWqAy5VZCAeNeRsYlI/IT4PNNdY8B0hNVWnu5OTY+GrcENQYPBYMMzOD1Jn+JNd2RRm5ckxWdHaiM2p355DUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726271329; c=relaxed/simple;
	bh=49Bel+kpqO3i3ZolBRVyhjnkdeYzspASkynTKwDo4k0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WEtstaAI1LFEqnW1phZQQ0HNoo/X9nuEN/431XVdxQYn6sfCBJdi78tP37T9lxf4MvyZAOeBHEn1vcP9W5r+bErgYt9BmdxeNFkRHwDNbdpjisqtOaUP945gdtm23ExIiO3P7JK8RxMI5xyAbWYtPi+x/Q01mQ5hktc7kogUuOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApnkrulE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApnkrulE"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d4979b843so358503966b.3
        for <linux-security-module@vger.kernel.org>; Fri, 13 Sep 2024 16:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726271326; x=1726876126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S0ve5d0fo0bSXY7CWtOFJbRuz/KqSCMjlXl2XbNUxI4=;
        b=ApnkrulEfYGgg7Ge1VE38ZGYr9tkiYocyLrygWd0HFSri7L25IvWQDuosGTA+wz8Yr
         b2v4ILgxrEEK04FLrc+gKB2UDMC/h43/K8iZSBQ9t51ZzveUJHeme2+SvXOfceDFW3bC
         Tb3gsz7B95Oew7YLt+ikaanv5DAFJ7ldaPZoC6ppB0Cv36Y97kdkOc0r4KXnNxAztIYA
         X23nepBUepa9K0STC52cvHX8j9pKejJ509Qe3jcaJ5q/+PpZJ0o4lp4kh2QlrrmC3vw2
         hewedJzrvO85gxEhb5HRUp6WyV5NET73ZsculN2E3OKxbO1WTNYDdCx1hCQpL9szd+B2
         poEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726271326; x=1726876126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0ve5d0fo0bSXY7CWtOFJbRuz/KqSCMjlXl2XbNUxI4=;
        b=NSHfXxgekLwAu8tHpxSkNJsvGEDmJt2VSYmdB+9o00f/9P760iXOv+RDlk1voXTJrq
         a1OC/SGyAJr6uYqgfJ35AYSLuJConYx6AnEWf1AWjAIhgM35N3t+9O98/SJXYii8zBv2
         fTgA1Loqoy81DS0dMr0yFbIiV5crmOoHXfQYeO4m4TIA8lew5cqx51Iki+JvOdrU+1s3
         0/8VilEVFdJyVlOR93+8dBjBy9w3Knea/cpr7Gqfjk2x13ILvzzfqAg60b19Nh3Z3ZmS
         vSNbhlGv91DxDxNvU3lGoQMtAq5FVqNwd3PeCcaTm+KDCOigj6ewY01FLFW1jmZbDTrs
         1ksw==
X-Gm-Message-State: AOJu0Yx47EP74zIR6aXxw4L6J2f3bb4P9OSF77beFZJxRtRNmkSUT+VM
	QtLMGsSQtI6b8Vqn2aVv8gX4XcH1DAc3qkUodgNJmjHVtIEHTOCVC4VmbV5iOQs=
X-Google-Smtp-Source: AGHT+IEnumtz2qh9btYA66ZTmQzjruJU2kNJiWWcLiYd3ihdj2B+TRnnLNTdh1YNLV4dC/kYYl2JPA==
X-Received: by 2002:a17:907:f702:b0:a86:a1cd:5a8c with SMTP id a640c23a62f3a-a902947e862mr718259666b.22.1726271325774;
        Fri, 13 Sep 2024 16:48:45 -0700 (PDT)
Received: from localhost ([2001:871:213:da56:8414:8296:c4db:f217])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bc88cf7sm94832a12.90.2024.09.13.16.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 16:48:44 -0700 (PDT)
From: luca.boccassi@gmail.com
To: linux-security-module@vger.kernel.org
Cc: wufan@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH] ipe: allow secondary and platform keyrings to install/update policies
Date: Sat, 14 Sep 2024 01:48:40 +0200
Message-Id: <20240913234840.1318655-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luca Boccassi <bluca@debian.org>

The current policy management makes it impossible to use IPE
in a general purpose distribution. In such cases the users are not
building the kernel, the distribution is, and access to the private
key included in the trusted keyring is, for obvious reason, not
available.
This means that users have no way to enable IPE, since there will
be no built-in generic policy, and no access to the key to sign
updates validated by the trusted keyring.

Just as we do for dm-verity, kernel modules and more, allow the
secondary and platform keyrings to also validate policies. This
allows users enrolling their own keys in UEFI db or MOK to also
sign policies, and enroll them. This makes it sensible to enable
IPE in general purpose distributions, as it becomes usable by
any user wishing to do so. Keys in these keyrings can already
load kernels and kernel modules, so there is no security
downgrade.

Signed-off-by: Luca Boccassi <bluca@debian.org>
---
 security/ipe/policy.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/security/ipe/policy.c b/security/ipe/policy.c
index d8e7db857a2e..cac304dc86c2 100644
--- a/security/ipe/policy.c
+++ b/security/ipe/policy.c
@@ -169,9 +169,15 @@ struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
 			goto err;
 		}
 
-		rc = verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len, NULL,
+		rc = verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len,
+					    VERIFY_USE_SECONDARY_KEYRING,
 					    VERIFYING_UNSPECIFIED_SIGNATURE,
 					    set_pkcs7_data, new);
+		if (rc == -ENOKEY)
+			rc = verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len,
+						    VERIFY_USE_PLATFORM_KEYRING,
+						    VERIFYING_UNSPECIFIED_SIGNATURE,
+						    set_pkcs7_data, new);
 		if (rc)
 			goto err;
 	} else {
-- 
2.39.2

