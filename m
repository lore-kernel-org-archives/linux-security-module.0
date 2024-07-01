Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9EE15D5D8
	for <linux-security-module@vger.kernel.org>; Mon,  1 Jul 2024 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841104; cv=none; b=K0Pg4IOqPwo5zhsvxTCRaN8kUYRM5xiRUOxZIN2fK3ao2BWedCmPg0Cw5MqzoJDzQiMahLK5ALg20cxC2lXFPfLwmHpjx+xo+rxX/h/644+kVA7L7C+maDuKs+Xj4nHRNIBWUyLYY6Xm7ojHzob9Y52AGnTqqtCVFP/fNqS04dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841104; c=relaxed/simple;
	bh=IN2Pz7feRSB89N45CnxvbpbzXQIdjfaQZf+/3twSXjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dn4+uPEZGp5ZTxasx9GRR18oJz9GdepNFC7Xb8s0Mlqcd4N67DPVoSM0+Lzy3EHGw4nwk4ZOZ75LXPaU7yZczzYd+1wjlFZHe4jj3qTWMztKjZQh4K5l9eBBkFgJeDyn7qAVSoarLPZRc/3uHGs0hr+5sdREt8zfTndCxmv8kGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=02MZcKf0; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="02MZcKf0"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebe6495aedso31415601fa.0
        for <linux-security-module@vger.kernel.org>; Mon, 01 Jul 2024 06:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1719841099; x=1720445899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k5sD7PnRdPX0lFwpY8jX67XXDkztmCAH2fY727c2mDM=;
        b=02MZcKf0LQ3T+MiaBjc8YXR816vctgKAJ33jaB//yAU1DhUC7tyiDI3wqx4DWj4IEr
         IVtZHZT+Rq2o7jcRFQUGNszDxmp8y7wlMTbDjU/9p1VUHuAu3LmxHwmH3Y8TuiJhRuxP
         Do9fXpdRsdSQldYyr9hDPK46CPnxVtrlKBOn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719841099; x=1720445899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5sD7PnRdPX0lFwpY8jX67XXDkztmCAH2fY727c2mDM=;
        b=t8doDY0Xsp7NmH0ADnsB0rNTYZWO8/vJYjY8nPTqs3+yZjQmTgLTq+QgYj0UJy0v0e
         UNrWi03Ezx7mGDjZjpNYENHdFLPQDPOJo3+TO0t0re7rwyDbKcXX3yDZXocAKU2Llql2
         A74xxTJsF2ts1wuneHacY2+XE+p/mO53hocD2R/QlqnhkU5bM9XG2kfoWUkFG7uuDaQa
         CLDCNZlvtxZCGnL8BIikJUm4JTdyQLXJybG1q3N1rsfVGoYvni99xTWfhEdo+0pXsGsQ
         x/mJHxBOQi+dIeAXDKdQfS3eQsJtL1HXvxYJIlIlvHYF5z8916OjPrVUlQPWYXuT7A3g
         8Eiw==
X-Gm-Message-State: AOJu0YzLGUU4zc6L2/cko8p93sMcq1BHzJi6A7froeu1EhtkgVX9vdFd
	icIQOhlJl73/L/kNoL331+IZI0a8oXr6E6g1PxlMqztN/yy1mal/9J92G5UDjDA=
X-Google-Smtp-Source: AGHT+IHmRxD0Ok8fKaC0DosRpV2IDl7uw7clyTO+K42aYv3Bil+q7gUIwRukGNNBTLKKJQSiA1uKog==
X-Received: by 2002:a05:651c:4d2:b0:2ee:5301:945d with SMTP id 38308e7fff4ca-2ee5e37e0e8mr43871931fa.11.1719841098600;
        Mon, 01 Jul 2024 06:38:18 -0700 (PDT)
Received: from P-NTS-Evian.home (2a01cb05949d5800e3ef2d7a4131071f.ipv6.abo.wanadoo.fr. [2a01:cb05:949d:5800:e3ef:2d7a:4131:71f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af5ba67sm153562855e9.19.2024.07.01.06.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 06:38:18 -0700 (PDT)
From: Romain Naour <romain.naour@smile.fr>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	serge@hallyn.com,
	jmorris@namei.org,
	paul@paul-moore.com,
	eric.snowberg@oracle.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com,
	zohar@linux.ibm.com,
	Romain Naour <romain.naour@skf.com>
Subject: [RFC] integrity: wait for completion of i2c initialization using late_initcall_sync()
Date: Mon,  1 Jul 2024 15:38:14 +0200
Message-ID: <20240701133814.641662-1-romain.naour@smile.fr>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Romain Naour <romain.naour@skf.com>

It has been reported that on some plateforms the ima and evm
initialization were performed too early during initcall initialization
process and misses TPM chip detection [1] [2].

Indeed, ima may uses a TPM chip but requires to wait for bus
interface (spi or i2c) and TPM driver initialization.

[    0.166261] ima: No TPM chip found, activating TPM-bypass!
...
[    0.166322] evm: Initialising EVM extended attributes:
...
[    0.182571] ti-sci 44083000.system-controller: ABI: 3.1 (firmware rev 0x0009 '9.2.4--v09.02.04 (Kool Koala)')
[    0.281540] omap_i2c 42120000.i2c: bus 0 rev0.12 at 400 kHz
[    0.282314] omap_i2c 2000000.i2c: bus 4 rev0.12 at 400 kHz
[    0.282972] omap_i2c 2010000.i2c: bus 5 rev0.12 at 400 kHz
[    0.335177] tpm_tis_i2c 2-002e: 2.0 TPM (device-id 0x1C, rev-id 22)
[    0.471596] omap_i2c 2020000.i2c: bus 2 rev0.12 at 100 kHz
[    0.472310] omap_i2c 2030000.i2c: bus 6 rev0.12 at 400 kHz
[    0.472951] omap_i2c 2040000.i2c: bus 3 rev0.12 at 100 kHz
[    0.473596] omap_i2c 2050000.i2c: bus 7 rev0.12 at 400 kHz
[    0.474274] omap_i2c 2060000.i2c: bus 1 rev0.12 at 100 kHz

The ima stack was expecting to start after the TPM device (hence the
comment) using late_initcall() but fail to do so on such plateforms:

  late_initcall(init_ima);	/* Start IMA after the TPM is available */

Using late_initcall_sync() variant allows to really wait for i2c
initialization completion.

[    0.285986] omap_i2c 42120000.i2c: bus 0 rev0.12 at 400 kHz
[    0.286706] omap_i2c 2000000.i2c: bus 4 rev0.12 at 400 kHz
[    0.287382] omap_i2c 2010000.i2c: bus 5 rev0.12 at 400 kHz
[    0.331503] tpm_tis_i2c 2-002e: 2.0 TPM (device-id 0x1C, rev-id 22)
[    0.677185] omap_i2c 2020000.i2c: bus 2 rev0.12 at 100 kHz
[    0.677904] omap_i2c 2030000.i2c: bus 6 rev0.12 at 400 kHz
[    0.678557] omap_i2c 2040000.i2c: bus 3 rev0.12 at 100 kHz
[    0.679167] omap_i2c 2050000.i2c: bus 7 rev0.12 at 400 kHz
[    0.679792] omap_i2c 2060000.i2c: bus 1 rev0.12 at 100 kHz
...
[    3.062788] ima: Allocated hash algorithm: sha256
...
[    3.318975] ima: No architecture policies found
[    3.323536] evm: Initialising EVM extended attributes:
[    3.328662] evm: security.selinux (disabled)
[    3.332919] evm: security.SMACK64 (disabled)
[    3.337177] evm: security.SMACK64EXEC (disabled)
[    3.341781] evm: security.SMACK64TRANSMUTE (disabled)
[    3.346819] evm: security.SMACK64MMAP (disabled)
[    3.351422] evm: security.apparmor (disabled)
[    3.355764] evm: security.ima
[    3.358721] evm: security.capability
[    3.362285] evm: HMAC attrs: 0x1

[1] https://lore.kernel.org/linux-integrity/9b98d912-ba78-402c-a5c8-154bef8794f7@smile.fr/
[2] https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1375425/tda4vm-ima-vs-tpm-builtin-driver-boot-order

Signed-off-by: Romain Naour <romain.naour@skf.com>
---
 security/integrity/evm/evm_main.c | 2 +-
 security/integrity/ima/ima_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 62fe66dd53ce..316f8d140825 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -1180,4 +1180,4 @@ DEFINE_LSM(evm) = {
 	.blobs = &evm_blob_sizes,
 };
 
-late_initcall(init_evm);
+late_initcall_sync(init_evm);	/* Start EVM after IMA */
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f04f43af651c..0aa7cd9aabfa 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1220,4 +1220,4 @@ DEFINE_LSM(ima) = {
 	.blobs = &ima_blob_sizes,
 };
 
-late_initcall(init_ima);	/* Start IMA after the TPM is available */
+late_initcall_sync(init_ima);	/* Start IMA after the TPM is available */
-- 
2.45.0

