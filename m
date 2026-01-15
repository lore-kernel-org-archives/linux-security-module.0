Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BFF1A2630
	for <linux-security-module@vger.kernel.org>; Thu, 15 Jan 2026 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768437827; cv=none; b=DTTi5M0qSPJ55ixpYf2jEnA25lUpydWPGNMJTiBk1Oic5P5kccAsZV4JHksEjFV0svUTzUNmWQ6PXOdHA6ejRgCkJRDRP0jwz39tKY+eveyfZWu9mE0oSVGPrPwomQF4e8sxSXCCU14l+Dz4IOn1vGrJQdxmFWWBQ+zhG9w8YF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768437827; c=relaxed/simple;
	bh=Uk2NSQPdfgTq0jMeR9dvSjO2NK7HoD4YahlyEpAv2ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=tvHZprBMu6VlUS4IkP/pJXkWOnMA0dxGBnffSnNiuKWU4SODD2N9qf86WZz/U5qhUietyP9zLpDWMAVCUYB2xOPZ5nvhW8NG9WgtgmPCpEB/+QpA2N00C7RrNX6ydbwJ/tSpW61vRQbpe9KtP2Sp7kGub1dE9Ck4fWYpBGELwZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JPhju0Hx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPhju0Hx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768437825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4eXF+yg0VGRJrpW2uvJQuHP3qJwRIyGLrzkDgdoUSU=;
	b=JPhju0HxerXXxuTBaM8n9TuEQMDbYrNPYB7JGLnoSr3xUzfNS+8SUSYEA4hhN16sZfZK+z
	T7O+svZuYUXhMRNTzr73MdLmLV9Z/d7N/84bKRk1Nqgwwt5NdSX4WNHGfzKw246I5Ptl7q
	gUVZhUNe3b9zfhF+Bja+n/p6qU4fPpA=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-ClOf7mFZN8ORGx7cxazObQ-1; Wed, 14 Jan 2026 19:43:44 -0500
X-MC-Unique: ClOf7mFZN8ORGx7cxazObQ-1
X-Mimecast-MFC-AGG-ID: ClOf7mFZN8ORGx7cxazObQ_1768437823
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81f4cb0fdd8so269871b3a.0
        for <linux-security-module@vger.kernel.org>; Wed, 14 Jan 2026 16:43:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768437823; x=1769042623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k4eXF+yg0VGRJrpW2uvJQuHP3qJwRIyGLrzkDgdoUSU=;
        b=jaueL1U/FLIH4jBENbli5uPm7oPNJZmcolAZfzjOIK5uKk+BGEql/YlWWiX/zDZngy
         c5tXV2tlrAYi9R+UeMVHGY2JangJSJWyUs3JZw0oGtH6DWa88bOto2P2jL7bUWzBwJKp
         iva6Itp7xaoNyGKLRqrld1+8zDHlhbnUuyxpFZYjE0sV/4saU/aXuGxy6n1jZs5myzMz
         qWqKlzXCZl1sZA1kO8D1GHTiQEcTxQK2W2uOmLYSMjevUIubE4O4xXtibh9QaDxqsJY4
         iaV209rC2hJrrbfVkZUJ8si+z2EndEn5lcYKgUZ6RXpfIoyIdZzsArHjvRGj0xwZ2ij8
         ++Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVfD9rF8KnXNY6gsDIn9lREkKgn9HArHNq5Ri/ngCQ3QeSQBl5R39EJWvc7eBidvHpiY6EusZtSSwRmt0Zu2orHEXZdGSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaVEUx5tSATBOt9qrmVsHOpLsaqZCS5EZduM/iFWCvWQbXpaCq
	X1latoMouiytLte+VFB6FCre5F3Fnjw3HuaoscGBi6IOnHoW9g62Hz8xPK7LjE+sLlZTMGPRbZq
	4+HJBLZlzbq6NlRUVVXus+G7B1NxnAxjgEP6DjmhFUVn3GBGP/ewD9oX41I7+1CGfXMRH781xpg
	YPZJKv2NWWplU+
X-Gm-Gg: AY/fxX51kvHr0yRuNf5HD+FiOMN8n0TJxeiZrFQyPqAqZICbqAo5A4+FwtCHVIE65M9
	3TMK0qJvdRHuhOC1kA1QarlAEoBri5gYhhSUqaleDpB+7lWeJ8km3XAX4uXRdvcOsBgmt9v0iL2
	6gctrdyBezoL5DdDGIMUgscDrPry1QYC3fUpwp7YjJuNg4w5IzHXA528+AegOJHkJqH4s9CaSZf
	rpdMvIit1Q0u8W40RCWP8fExLKF0Y/FAPaI/NFnJ/Hk35VfaKoMSn8lQ+Msmx1T9z3tE/WiJO37
	O8mK2iALKzr024CEd2bXnR/2aOXtW+Kn4xl2fWmxiuQfjoEMfkrq4gULwvjHAsKOhJpoLyuEzni
	N
X-Received: by 2002:a05:6a00:4196:b0:81f:4abd:f15b with SMTP id d2e1a72fcca58-81f8200640amr3916151b3a.58.1768437822985;
        Wed, 14 Jan 2026 16:43:42 -0800 (PST)
X-Received: by 2002:a05:6a00:4196:b0:81f:4abd:f15b with SMTP id d2e1a72fcca58-81f8200640amr3916117b3a.58.1768437822405;
        Wed, 14 Jan 2026 16:43:42 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8e4b6ca9sm692388b3a.4.2026.01.14.16.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 16:43:42 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] evm: Don't enable fix mode when secure boot is enabled
Date: Thu, 15 Jan 2026 08:43:24 +0800
Message-ID: <20260115004328.194142-3-coxu@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115004328.194142-1-coxu@redhat.com>
References: <20260115004328.194142-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NPLO6bCon4VGOMKMfxgliGNecwA9R7qjrGw8rLUARB4_1768437823
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Similar to IMA fix mode, forbid EVM fix mode when secure boot is
enabled.

Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Suggested-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 security/integrity/evm/evm_main.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 73d500a375cb..00bba266231d 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -72,17 +72,25 @@ static struct xattr_list evm_config_default_xattrnames[] = {
 
 LIST_HEAD(evm_config_xattrnames);
 
+static char *evm_cmdline __initdata;
+core_param(evm, evm_cmdline, charp, 0);
+
 static int evm_fixmode __ro_after_init;
-static int __init evm_set_fixmode(char *str)
+static void __init evm_set_fixmode(void)
 {
-	if (strncmp(str, "fix", 3) == 0)
-		evm_fixmode = 1;
-	else
-		pr_err("invalid \"%s\" mode", str);
+	if (!evm_cmdline)
+		return;
 
-	return 1;
+	if (strncmp(evm_cmdline, "fix", 3) == 0) {
+		if (arch_integrity_get_secureboot()) {
+			pr_info("Secure boot enabled: ignoring evm=fix");
+			return;
+		}
+		evm_fixmode = 1;
+	} else {
+		pr_err("invalid \"%s\" mode", evm_cmdline);
+	}
 }
-__setup("evm=", evm_set_fixmode);
 
 static void __init evm_init_config(void)
 {
@@ -1119,6 +1127,8 @@ static int __init init_evm(void)
 
 	evm_init_config();
 
+	evm_set_fixmode();
+
 	error = integrity_init_keyring(INTEGRITY_KEYRING_EVM);
 	if (error)
 		goto error;
-- 
2.52.0

