Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C00728469A;
	Wed, 13 Aug 2025 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100927; cv=none; b=Y99BKU9DyzbVy/N5IhZRBVLgFooEEIppaGLeIYU87aKUy0K7wpKpsPAbe/7mfZ/eTH0uRrNeIdonp7sE2RY5k3UuqyxftKIVQtS30m3H3vOdFSurRpVGasT3VwT1IlNlOo4h9u5fnliOIxXUhoDQ6SO23eQl+kyrwx4fTLiBNZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100927; c=relaxed/simple;
	bh=UDmbkCATMj3zYzhEYu3RaoajQKcynIBgbBYwP3uZH3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZIhD4LYOK/sMywd0lazsz/Y/Lpi5oEKWpAsNZx87IvuHQKfZ0+1G+niNfVkTIY9QahyvSlBh1WfDzKIklX9CjeXSEFFd2eC4oNB+2GolA9G+ixj+b42Z/D+z9wyaGdYkodRA25nYA5YdlMDiVq4NT92u7pzmKXXIoFm3teQ+ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeDNfJep; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeDNfJep"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2406fe901c4so43253975ad.1;
        Wed, 13 Aug 2025 09:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755100925; x=1755705725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=15PDS4kBFxnfhGyuPIxLhWrdICQOQTl1rvLJxElN8H8=;
        b=GeDNfJepympUCYCYVbW7S+2qnGu7ESKNWjVQuKZxJ4GTV70nOvvcnyMQDCiwGljTgw
         W8AvRIbI44UiIa4+t44aFWi4WQQp7VmdnDu0Degd+m1XoyVa/yse8QK+MB4bMUailzwi
         KLeOtzWfSUAGI09zaKSHM9OcXH9VXumQo8OjCHl7hxuSLZbS+y/eYwknig87acOMYegR
         HPzcryR699bbiP1xQV09Tfg/9f2H3aGQQNcHqzG20y5h/mZOj/R/Wgy5riOMR00pLrTQ
         nJQXJDXPRD5yDh9JhV+cUTMVtqbRX1yr1yeqne+lK8XEyG0F0byYluZNHCrx/SwRW0K7
         Va4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100925; x=1755705725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15PDS4kBFxnfhGyuPIxLhWrdICQOQTl1rvLJxElN8H8=;
        b=BAEiOEKQuwpGWQEnrVeq7SVhiZKlSnUAkfpdn0/rVjHZaGelXGxKBjRmJ3qGesGuqH
         vWDwAayKzTaosyTCG4ICiyt0I9A8fXSgdkNH+CdByrkMXMWSBVOMGK7LCY8N7reerY7p
         q2DgiMS3rnFPklZx+towDlduTJaXRJ9USNBVVbAbw8SZaPvBTNousNfyyINioPkOsJFR
         h8dMXl3Wyxl31ny662i53lAi2aTMFC82cGsEHZnVCHfCw1UTAIo8swY8Rwekw91Rkqnu
         BlWP5LP2oyrUY8uy1egoBXF3hH6uBIpIC4cBLqDxtLzsLTnFuErJrDHJ2RovxQ3VM34N
         zGAA==
X-Forwarded-Encrypted: i=1; AJvYcCVAiOPBLzhG6m7iCosil09kl1Rg5g56MJGLaE+a2JIXfZ/PzF8ujs1JD6HHk9dVm+e3XenJ0fJe3Vkrgp4=@vger.kernel.org, AJvYcCWfkcPO/GXKh00ptlvbi80bVXu6imrhjfAWLj21PpL7towdXtDtbpbxkCB/lE2SKU0JM0WV4yUe/hlfoJVqaIafJQfLwN8j@vger.kernel.org
X-Gm-Message-State: AOJu0YyPs+BeuHQkFf2dLoyGprgfm54e+dzulfP+xzVdOwDhtSrGrEQd
	uU/tjnsbKCtC0Df72xxJX4bNpzdLQ9eKtJYgwfir4uWRISmb4lV7EHGdFtWJ+w==
X-Gm-Gg: ASbGncuPuA6DKiPnbn9bBjfkY9ViLrXTrOrkgEMsXFUsCZDTSAgnKuivLt/aFljlkx2
	EIAtXFlm4ihXMh7jGJsYsVyE37pEHliWoGU6ysLXKgODocIHK3SqPPxM1gubBCvF0Hu18oS/FW/
	0l3UU9z0nKRfSruipaVxq24IhsJwl153W9ixOFqaTPF1co0Hzwsv/3m8FkECUIFlAzYQ/VcXzEF
	TEp036tYzRy9H3ogqqGePmexdLf7ycM1gbFew1M2Va3QhMBrcvq7yPUeU1quslGkRnLPDaDQKLy
	M5B1L22EGEYunfKmxH85khTXxS8tejGbGzTJiAX0hWK7Tko9inE2Sy0dll23ZaMQ40+sb0VyAsc
	85f1Ty1ehYEi4VPSPuYsscnCFGyp0yaaEnM5af0mzEItlgZP6dpL1BnMTO6W4G4NCSemPFOrbgh
	VuIQ==
X-Google-Smtp-Source: AGHT+IFneh6DcSCXvD6FkQgAozlcfSCn7Et/p7McK6cLRii7ICb97K3VSPkcw+k/fd98jJHchkAFog==
X-Received: by 2002:a17:903:1aec:b0:240:2e93:8a9a with SMTP id d9443c01a7336-2430d1e570amr56436565ad.42.1755100924906;
        Wed, 13 Aug 2025 09:02:04 -0700 (PDT)
Received: from chandra-mohan-sundar.aristanetworks.com ([2401:4900:1cb8:7b85:9b4a:84f0:66de:85c7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2429b4ca995sm197380615ad.177.2025.08.13.09.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:02:04 -0700 (PDT)
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
Subject: [PATCH] apparmor: Remove unused value
Date: Wed, 13 Aug 2025 21:31:43 +0530
Message-ID: <20250813160148.132192-1-chandramohan.explore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value "new" is being assigned to NULL but that statement does not
 have effect since "new" is being overwritten in the subsequent fallback case.

Remove the unused value. This issue was reported by coverity static
analyzer.

Fixes: a9eb185be84e9 (apparmor: fix x_table_lookup)
Signed-off-by: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
---
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

