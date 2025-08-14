Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C74166F1A;
	Thu, 14 Aug 2025 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190463; cv=none; b=J1mxVTeYpHHmzPfXGI1lE3oOCxYJFxG5Fg8+vpj5jBS31XfrvN/PjDxZ2N7GB+f3GBGo1AcT9tJWzkTqiLlla1d4X0qmycdkSCIUdO0dvQsJlnisQNLukMWE0ATW5peIv8nCTPFYkA0oFO6dXt0gDU/JZI8Af7xNotj75IwkNhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190463; c=relaxed/simple;
	bh=YfHkh+eSRqs9I6udgnVleOU/rOxXdnn1bs0TZZvIbmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tRwTnKYz0Z+YadCARFIBC86fihacooaMUCxfLQ4xyqy0jkCS1ytHLXAnrv1YaMh6q6QG7Kw7iG9N7f89PIGxYmQIQ+uVdJzGd5OqXELjzGKrK6UDheAsu6IfLDVbTFAA/v0EpgKqUkMhiOuWllVs2qQswIelTAwriaGXeDAncuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfH/zQy0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfH/zQy0"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24457f47000so10011075ad.0;
        Thu, 14 Aug 2025 09:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755190461; x=1755795261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bzAUOwpAWoQpgwAW5jB4MGjXOdEDxLQtc2FXn4/gdjw=;
        b=gfH/zQy0i6G9/4roGh5krWToK/2GnUf9pQwDfIQrCD3c82XHBc1e/ySv7DszgXeHpf
         /f0njJqVIeumvqcSAE68wQcxJUCc8JFZa1XbA/ufYsmmTGAQzpleaP4mjxGs0VgZNyY8
         66PCy3dTUT8biHWduHb/PqJnFlEYraoZGAuqbF4vPjdkPYR8IiC86Ephh5VrolFAFhgK
         bUNnOmCEVTpSHqERHAJ3JDXL9W1634EcI9nORMUaXBekLs9p2st9HLHWLMlpjDnoyGGP
         a5mIiffh5lQvv8XwJJGLLoQIvqIFFgoMxUGsiq337oH8yb61G6W+54qpvbAqzPN5DuYa
         JHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755190461; x=1755795261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzAUOwpAWoQpgwAW5jB4MGjXOdEDxLQtc2FXn4/gdjw=;
        b=bOAQQpwG3ady6njLW/+KzIbYZeOlWeQztGjHANq9aJ1v8r6Blt1JP9EGm34caodRZZ
         GsvZYqXuopVddOkQdhu1SGKIrnJ44AMvpLzUIDNPpE4gkprDfsp/lXLkrKBqnSi0o8IG
         a9hy5vECRyAfX3/3aKZEXpDN2NUWpaDOLbi+dlQoLf24luDVmNvccBytVrQ7PwuUTf1K
         Eg5m2GGGWhW3p/StqMDwBQafrx3BgwjtZtfjyiTu58nfpV6WKCnQnr3BssDuYIqc31mY
         gBz5s/PbMm6M6gfOLiswTa0CiF8jhd4idAXAYxzFol6KhZg2XUb66xpft+0LdWPOdJa5
         0inQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/0Jb036T0Op4GTVq8eYhzks9OyPlKOlcHSLjp9fyG8FYa0MG4PrIbM2jgpbbD2A54UE8gDXCNBSbkr6eJ/aCa7aVpBBl8@vger.kernel.org, AJvYcCWbtbud9UZ7EDWJszJH4Z7WgY2dA4sxbupuRxKeNuQic771daIdKOHeXV5PA8bwEKhsUSwzmggIEkVRr3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIcHVhFjlM2A9DGUIOYGtFuOYvq7Tb+nlOqF/MYgPNUfXSIx1l
	k6XOQgFrTkY+8yha9xjGndv7Owx7KcICBDHo3E4Oy36Y6K2QMU10SRmq
X-Gm-Gg: ASbGncuSc97eHVYCTG99OWai2VjrEYgKEAQwEb11IaYSdvm6aPRPX3NYiRBJjy/y4M4
	hOinYk8dc7anqWMpItAm0tR4v0pVR8BSR5KyylRqiEmuexBy9CVxePo+/dnECp9xT0uQSdGSsPa
	KuNO3F8da71dTodRD5Qr7MBvInw9wp78TYx4an5GeZGL4v4c1wOU5ua/8PGpgsq04SI9AsVPPb4
	5iole71nmQGWaLZuEfoMb9qva0xI2/z+x9H5h14iT9O07YCBPIu4jAvby/09h81bhYFZ7RrQuFS
	wGxTupXkJRYhDdWwOwsMM95c7vzqmHN/gnndqY27XiqA0WPl1+08SQd4Ee8nTWwSCyaSl4ZF/FK
	NXzLlh7/UVQxhEH2otvCBalcjOJcTKZJ+TBFsfRHAKb5Rr4eEqlPE7Ek7B9+5U2cMMat9O8zsig
	I=
X-Google-Smtp-Source: AGHT+IEqMpZO5u/tm/cwn+0YsGs4tZglauzhONrWB/FV5p8lGP3iOxI6+izHLFRBqWNEDG3eBmVaBw==
X-Received: by 2002:a17:902:c952:b0:234:ba37:879e with SMTP id d9443c01a7336-244586bf29amr53951435ad.38.1755190461424;
        Thu, 14 Aug 2025 09:54:21 -0700 (PDT)
Received: from chandra-mohan-sundar.aristanetworks.com ([2401:4900:1cb8:7b85:37eb:c20:7321:181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24244f5c1c0sm310205985ad.45.2025.08.14.09.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:54:21 -0700 (PDT)
From: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
To: john.johansen@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org
Cc: Chandra Mohan Sundar <chandramohan.explore@gmail.com>,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2] apparmor: Remove unused value
Date: Thu, 14 Aug 2025 22:24:01 +0530
Message-ID: <20250814165403.616195-1-chandramohan.explore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value "new" is being assigned to NULL but that statement does not
have effect since "new" is being overwritten in the subsequent
fallback case.

Remove the unused value. This issue was reported by coverity static
analyzer.

Fixes: a9eb185be84e9 ("apparmor: fix x_table_lookup when stacking is not the first entry")
Signed-off-by: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
---
Changes since v1:
    Fixed the commit message and Fixes tag message formatting.

 security/apparmor/domain.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 267da82afb14..9c0c7fa8de46 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -592,7 +592,6 @@ static struct aa_label *x_to_label(struct aa_profile *profile,
 		if (!new || **lookupname != '&')
 			break;
 		stack = new;
-		new = NULL;
 		fallthrough;	/* to X_NAME */
 	case AA_X_NAME:
 		if (xindex & AA_X_CHILD)
-- 
2.43.0

