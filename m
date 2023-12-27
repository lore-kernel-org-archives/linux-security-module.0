Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3676522C
	for <linux-security-module@vger.kernel.org>; Wed, 27 Dec 2023 04:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbncCEl8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703652123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OFJIO0ZcDJiyym1avHSfZOIU1zn9ynuH2Tm3h86pSaQ=;
	b=bbncCEl8w8ZPBIA3vs2AegNx8KWWuqURT/QtPIrUMtd6RHCjWdG6cASfn+uFoNQYWfrI/E
	d2IapRPKuETxr9SEMeZ2VqJ9gHMOJuYPZtJGS/64LCp7SzDtPue2vgJuPKGyJsUwM76Yk7
	wAoDEa6B0jYiA0wXhsJeKkcmbuhZgTc=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-iNbUvzvqO3m-ZoC8hh6Z4w-1; Tue, 26 Dec 2023 23:42:01 -0500
X-MC-Unique: iNbUvzvqO3m-ZoC8hh6Z4w-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6d9b4573b21so416974b3a.2
        for <linux-security-module@vger.kernel.org>; Tue, 26 Dec 2023 20:42:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703652120; x=1704256920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFJIO0ZcDJiyym1avHSfZOIU1zn9ynuH2Tm3h86pSaQ=;
        b=Mye4dvr67GOrGTdWzlkOzaEEGzM6wy9Rn8cLTlFC7mtVEDIOnD4UWofylSGWiTMKmL
         R3zK4hsK5g8vqawoJgN+mkx4L8YxwfXtcAjWE5YawsPI+oNB7DkK/H8/VCVC2/o59j9y
         DzAgwG+syqP0yEpcRLj6ZFAzcvLpinuMnJYNzszjgxN5/DgDjTYErgNZStd6JXVUK6jk
         vYYezY0jJoqFCoprnQ9CqQ1YP6Q9kYPqWNHFGm2uupMEeTfxKqLRk2viU3OLwF0p1FiL
         gvDIotBEsnU8na5CqlB9K1fJrGIQYjlLZQXsN/H2p2WAZ9B2VvlssDFY4HAG2q4Hl2CR
         cXxg==
X-Gm-Message-State: AOJu0YwK2jpu4xGDRmdggsbwfYCVdH5+AOHXArR/DjeGt7MgikeAFxZu
	J4RdURIdIFw19AwbF2m4GLTBfK45KIi/vWTqXAD+IJEtJYxL9wYNq01ZgCPTii8FvFsNgSzpWwN
	RtxbNHPe/7OZNb/hcXMPeQAI7LzKiJ5v9ItdnXBIfiRmZ
X-Received: by 2002:a62:ed06:0:b0:6d9:663a:aba1 with SMTP id u6-20020a62ed06000000b006d9663aaba1mr2684492pfh.43.1703652119950;
        Tue, 26 Dec 2023 20:41:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFUn/n35P5dU+QxbjFP+WACwyOuzLleZSPM/s0XIzuDegsw8h3wgv062OsIuQ8szsc1mlo5g==
X-Received: by 2002:a62:ed06:0:b0:6d9:663a:aba1 with SMTP id u6-20020a62ed06000000b006d9663aaba1mr2684488pfh.43.1703652119543;
        Tue, 26 Dec 2023 20:41:59 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a8-20020a656548000000b005cdf90c21ecsm6929316pgw.67.2023.12.26.20.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 20:41:59 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: itrymybest80@protonmail.com,
	Mimi Zohar <zohar@linux.ibm.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] integrity: don't throw an error immediately when failed to add a cert to the .machine keyring
Date: Wed, 27 Dec 2023 12:41:56 +0800
Message-ID: <20231227044156.166009-1-coxu@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Currently when the kernel fails to add a cert to the .machine keyring,
it will throw an error immediately in the function integrity_add_key.

Since the kernel will try adding to the .platform keyring next or throw
an error (in the caller of integrity_add_key i.e. add_to_machine_keyring),
so there is no need to throw an error immediately in integrity_add_key.

Reported-by: itrymybest80@protonmail.com
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2239331
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 security/integrity/digsig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index df387de29bfa..45c3e5dda355 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -179,7 +179,8 @@ static int __init integrity_add_key(const unsigned int id, const void *data,
 				   KEY_ALLOC_NOT_IN_QUOTA);
 	if (IS_ERR(key)) {
 		rc = PTR_ERR(key);
-		pr_err("Problem loading X.509 certificate %d\n", rc);
+		if (id != INTEGRITY_KEYRING_MACHINE)
+			pr_err("Problem loading X.509 certificate %d\n", rc);
 	} else {
 		pr_notice("Loaded X.509 cert '%s'\n",
 			  key_ref_to_ptr(key)->description);
-- 
2.43.0

