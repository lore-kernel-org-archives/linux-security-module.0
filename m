Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D83C1BC2A
	for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 20:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727296960; cv=none; b=u8vy8yev8DqOOBLl1huCd+XZIkwXJr7oh8P7kKTgvm+X8M0IIakvpEvoMeyX+9gU7UMUI8ZBOwm6l5eAjfHaDJGFhCyUIw2R2CoTImeiZivuxHzdrqU4b+GFklKPdOGhojiJZAvwH6NpubaRDdCF135nk316qqdvg6kG+DfNg3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727296960; c=relaxed/simple;
	bh=TP3xycn/jtxRx4y0XaZ+Q/R60ToumjjVVl5vwHMdOac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F5c0nS38zOoxEN1w9HBQNw4jiAj9m8cgCbScrujrmU8VnB9ROa3kP+3NCi3Q17aqfk01UWTk+qfu5Sq10YpU8953zIX9hSXXSXBNYXb9zHltbmUAn6IstR6NBAcSVitb9/BRHabQ6cg7fr2BHVTnj98+dvfhwCnb+Vew4TPnShM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=II4PJFUK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="II4PJFUK"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a83562f9be9so27964266b.0
        for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 13:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727296957; x=1727901757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ISZAdzoG0y/GX0yVQekQg7QOpnYZdyWYnClzV1p1R8Y=;
        b=II4PJFUK+WGTFHB91Wt5uCMN4CRKCzXu2R9gQU9K5niaWonyLwcS4Sdlzj3v58H1S9
         rQtv3YKu6YemLPj4FfCkHZ79F0KnZnmWM/Vvw6jQE2QXn87r9wxQTofHOqT43z6MYxXz
         eW5VgA1WyyAIIIM+VmDIVqagTVJb/kAcbcJZkn4wEb34cKhj8He3QbLC4Ywhb9skC3XZ
         52dT1qssvZkfokGisk+R2iZUn4y/+wj+L/jjPHWbjt6RgfJhTbCjJM2cLxjzbTt9MUa7
         9NqECA/XnLax/CaxvMqFdCjxPqKV4cKjXSo12AWI/SVMwCipdscA71SyM4MyLqIOdk+O
         WNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727296957; x=1727901757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISZAdzoG0y/GX0yVQekQg7QOpnYZdyWYnClzV1p1R8Y=;
        b=Tefv9MUk4uMOYgaDQR3succEwD2fHlcLCypbdl/qgGKYZorhigksKUUCtRixZNVQ3K
         2R7Ye4CCDPtmBiK5RPTZglxgtkRhRgtvCrhufqjzMURKZ43SvcKHmLWb9GhWUPKK2RfM
         3T4rrZOo7uSsEFan7TOOSldn6oYByJAyYZaCzWBGFgD7AaiRPGWPb5BKBfUDWCY74glg
         n9Q3zp/DVpyaInWyHXadLVMrI6n+mYzim5xRy+kKuaPKp7X5HBiGs/Nqm4/1Fq3XzNfG
         NB3rbztZ1wLDihvaOXF3TOINsM60B4W/JT4Qcd2tIQBp+nnFiZG4PIKHTUyi7fbX2hOy
         EO6Q==
X-Gm-Message-State: AOJu0YwE9d7tVcExpMrWDA7d3fsv1Bj0dDSWmEboCnpppXVXK7v0BbrF
	bAVPSbJkiFE/FgsodhaFxsczGs1G0I4+T8Zgb2pDMMpA12o5yklupO2ahgAPgUw=
X-Google-Smtp-Source: AGHT+IGUP7E+EJMVuJWso+bNhDFaNZgpK5Y9n235+aG4fhxDL2PIxcJHPDT2ELjwGtRlN8siwhoIxQ==
X-Received: by 2002:a17:907:7e91:b0:a8d:fa3:bb24 with SMTP id a640c23a62f3a-a93a0383db3mr347405866b.23.1727296956773;
        Wed, 25 Sep 2024 13:42:36 -0700 (PDT)
Received: from localhost ([82.144.39.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f54171sm257080566b.82.2024.09.25.13.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 13:42:36 -0700 (PDT)
From: luca.boccassi@gmail.com
To: linux-security-module@vger.kernel.org
Cc: wufan@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH v2 1/2] ipe: return -ESTALE instead of -EINVAL on update when new policy has a lower version
Date: Wed, 25 Sep 2024 22:42:26 +0200
Message-Id: <20240925204227.528624-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luca Boccassi <bluca@debian.org>

When loading policies in userspace we want a recognizable error when an
update attempts to use an old policy, as that is an error that needs
to be treated differently from an invalid policy. Use -ESTALE as it is
clear enough for an update mechanism.

Signed-off-by: Luca Boccassi <bluca@debian.org>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
---
 security/ipe/policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/ipe/policy.c b/security/ipe/policy.c
index bf5aa97911e1..3a0069c6d5af 100644
--- a/security/ipe/policy.c
+++ b/security/ipe/policy.c
@@ -107,7 +107,7 @@ int ipe_update_policy(struct inode *root, const char *text, size_t textlen,
 	}
 
 	if (ver_to_u64(old) > ver_to_u64(new)) {
-		rc = -EINVAL;
+		rc = -ESTALE;
 		goto err;
 	}
 
-- 
2.39.5

