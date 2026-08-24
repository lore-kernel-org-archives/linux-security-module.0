Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A07450413
	for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2026 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588546; cv=none; b=Wn5rPDanvC46x3RvAg6F59qbslOZRAL1+t/dHNwu7Yz/6ve/RodmLb3vPsrQ9YPYW/UkgO21bBivEUeciWGqMqMoRxr/zzHbS18aGoIDtvZ9Rp+uCNY81xdQkBKCgjjhLUB0FfV9viGukAEAm7hKI63igIR0EzTQ9F/qQUwUAlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588546; c=relaxed/simple;
	bh=h6x4klQMuaENRYpnPstAUeKDBWZfZPIGWzm5A6TXAek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WC2oxvQQNbi9aWvQGEbYwDyaZcqtTGHyiw90eChyuV9iKfy0fuidU9q4hGpYnTHKx4vCJSoz9/WSTQfnc6AhGbX1rccWzKFUjFYLpXFbsGzLzIkWTHcSZqGvspNgm/EBzLbGrd1aVqlNW09mYqHIxMXqilgJylnRHGW/qnBZ4s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qp+RqEjF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qp+RqEjF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so272735e9.1
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2026 09:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787588543; x=1788193343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pOdYzX56ODDkS8MxIa5w7s/cy/kIlqifW5C7xMdwnpg=;
        b=qp+RqEjFoWyPVgWnsBIq7fMjt7vpvDJyNqwvDnShP1AlibtmQVqsjKUw9qbo7z6J/g
         8B/G2EMu268SGdgQRE4CGXHx6MWRcmTRqRG6BwgrAU40FMnJKXgAx7wKVlX3twqrF0DN
         di6rXnefX0gUphCPeAc5IRuaKqgF+/CAC+PnmIsAYksWcXCUTbHXhH2UgEWZR/wtKZ/t
         HM8iunnyG5YQZKxnVFecDCqV3t9DHsI+iJ7E2hJfENl6ynkTRd3GiOGhqw5U55IulF/2
         5YgWFQwHK1tviZDnGpxAktzk8fD4Nim2rtCVCVMAlRMktucyD4Vb0I723m6ofWAOUx6x
         uoqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787588543; x=1788193343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pOdYzX56ODDkS8MxIa5w7s/cy/kIlqifW5C7xMdwnpg=;
        b=mz0eBMa4rcVq8H8AVt4N0wFlBi4HVBM+aoeJN8qr0P+uN+m9VjqMfq1DMviv5spjoB
         cJtx1LrqdKDIGdanzWKsHz6OHVTTFGfWY7Vbt1v7QPShqTkQurmN6bp5AeZFDkeTEIsc
         j5cnbvtdUgZdHTr2nXLvaSXBvbfLL1eII+mePbC3JM5ahaSL6XIvf+5zIomusI81sBjm
         KeZVgBQPWaWdF1STxVX2E3K89wM0pP0TrIC1EtVTsdnjV+J/wNndzTjg6knGrZ9+yE4k
         /lOQxvQaIwWXjFB4rauBlsl0YmUe66EPdoz8rb7TEqa7cld2uTAiTH5f01nFeSxNX6xE
         I+rg==
X-Forwarded-Encrypted: i=1; AHgh+Rq9EN2OQszbEIW9jriteAutvoQxXq4bDGwJWn1IhQHH4WvCZcBnsDF2nn1Sv/oUCOYl2bDvlSfuM9se+wf3a4ee+OGTCkg=@vger.kernel.org
X-Gm-Message-State: AFuF++k9qJ6VEDgV9BYbl686pL+i+lQ/ViHuscaLKDbkIfCerPxeyBEs
	txsCVzpsygpnJFvELG0J60K0wbGpvO7o3nNkp5OJUoxpTyvOr0reQnj4
X-Gm-Gg: AR+sD13aI77P8eqVl7NFa0cwWy9JAAzNQzsBvoqD0/QMe3KsyktYUNmWgWy4Yqq8iZB
	RGFFcnPFD+CC0iBubyAr0vXopRMGr6l6DnPuhrlI7h5ZC5bJ+3EYw3vNvo2DRCSyJ1d71b9aMub
	w92jNNQVvl7esOIuMs9dv9PJ0YcQ6SfJw7ZiFhb9GJwZzfYRfUkiwyEj7QSb84U7m4Q55878NQV
	pkociXgvKkfsS9pvXeLsus1nCGfEO/GAsrpRmqgJoHth0mDFsfx9yJbIlYmc6Pf6IVHFBOC4szd
	vZRaB6Cm9cJM9x5kKf6nORD6oTF30JSUaMGGzzPZN4Gb9OppWdufOb+pdn6itx7a7rmxeOkpjvj
	/2XbHQ60dTeSpMfg2lIm251NZn3z9oDQw273V1cn+qY4JEBLn/+bIqwaHywml9Oan4q8cqtbWMc
	B/6q9X7JpQw2EEnktnyU78sd+XyzRu7pz4tfDGEks+XNhpTIgadVf+7OLDyUlR6hly40jXFEqum
	mk6YOfWxE4kz6cPvpJ2u25eCHZQxkwlSPCe6DNRSEIIOd87386j
X-Received: by 2002:a05:600c:3d92:b0:499:8d9b:832c with SMTP id 5b1f17b1804b1-499d6323202mr7372435e9.4.1787588543063;
        Mon, 24 Aug 2026 09:22:23 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499d6335051sm1342115e9.1.2026.08.24.09.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 09:22:22 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: eric.snowberg@oracle.com,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] ima: allow users to specify the pcr index with IMA_MEASURE_PCR_IDX
Date: Mon, 24 Aug 2026 17:22:15 +0100
Message-ID: <20260824162215.1572367-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IMA_MEASURE_PCR_IDX option is currently not visible in the kconfig
frontend, so it always uses its default, 10. This means that the
'range 8 14' is dead code, and users are unable to specify the pcr index
value.

In a previous discussion, Mimi explained that users should be able to use
this config option to specify the pcr index. [1]

Let's add a prompt for users to specify the pcr index, when EXPERT is
enabled.

This dead range was found by kconfirm, a static analysis tool for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
Link: https://lore.kernel.org/all/1feff118-4afa-4b9c-86f1-271a7a88208f@gmail.com/T/#mc4efa2491b4937eb7c9e532c29ffba516a70e662 [1]
---
 security/integrity/ima/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index b3a9f86809b0..2d5bb19ea6ac 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -46,6 +46,7 @@ config IMA_KEXEC
 
 config IMA_MEASURE_PCR_IDX
 	int
+	prompt "PCR Index for Aggregate" if EXPERT
 	range 8 14
 	default 10
 	help
-- 
2.55.0

