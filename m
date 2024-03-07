Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1264C12F39B
	for <linux-security-module@vger.kernel.org>; Thu,  7 Mar 2024 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709825949; cv=none; b=izjvJ73taDLSPcPX+7PxJhE8gyMPD+I8tvY66W6XSGr1d42DuWbAAhW/XLEeO7xP+lgVfmIQeYgWJ3jNapLgi/wUDhMSIQ8KEFd0ahZvnuhqsKF1nQKmSQIrIur33o/OAIOempiQRJLmfnDVx+ZJcEVP2CGl2pKVjYMF/rSTkVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709825949; c=relaxed/simple;
	bh=A0O6/w7bbUy1TrcLSjuH9e83BoPYKup6oiJvr7VavE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWgz3tBi95xBekzNqCxHRLL0X6QD5U5DBTSN0bH8a4BqydUcdazx0CDIObeO0RGqOS0NF1cFSXwv//KbdSNH8xEb8Ju4kvyg6TP7iwahI+sN0ZrcNF/y6XT6lfYCOV5LE7POUjDHEQMBKJZUYtQuG4OmQe25OIBro2HevCKJU/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=JAvWO9KN; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="JAvWO9KN"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d3b93e992aso12876011fa.1
        for <linux-security-module@vger.kernel.org>; Thu, 07 Mar 2024 07:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1709825944; x=1710430744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5byLpxSkDHpWtFqk+o0iXmSYvszrS7+YdXxWavlXQY=;
        b=JAvWO9KNPCWPeNiKas3mCKiB18zgWaGnFoppsCH7DfyWJx7CHooFSfJDD90LGuKjew
         wrS4oJIJtLpO+rFHNsBjHa2wlo22w4+4+UTYWgm1Q34YiGe7fnh6BmLu3mWEQkRSKbeC
         EQUGztP2DxfJjxVPDMgPxDQyhF/ivSacxEgIlygjozM1SIe5AyK4ubpdcfslNlNmh/Lf
         VUuM45cRJL0o1Twq05Ai/NDpZFPTy/ls16uRBcNzeuCpl9Qi+Y/8FeMM4ivJ40NXZaLs
         udq4jjOVQQlro9TwSR7BYmZIVlNvsNeadmj8R6Trk0kI8HhdppjqkTC+nIgYJ8WXmcUL
         cMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709825944; x=1710430744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5byLpxSkDHpWtFqk+o0iXmSYvszrS7+YdXxWavlXQY=;
        b=kuAnBwIAieLMQmox3/WUSQrcqoKmPewZAFm1m58imV0/v6IqXZRPmY9tXfZfxyEluj
         /13935u37j0/G770cHkhQchVt9dXm2ahu7esOCreW7K1RVJhVS3Ttzclk54VG1PiF5A9
         KuNNZrK135K2xzyUp+Xd6lb4v0LmBfKaXQEPi2e36ZDhWW6k8gKvOPqftrU5KZJ1Lv6j
         JfDbLKk6OBQ7rT8jTJjkkIFGQm6hHLPV9FdBnSeyQ1euNae2/2sWf0n4763053TPDCUN
         wo9Lno/mgw3s6pcN4c6ew3Kcw6UkughvLt7CXDwC4jwvV8PQkqyJDN3jShL68Mt01qjY
         NXgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDr+NEq44B5085b9cWJE0AJOv9M5i32+ajvVHi4ozYHv69Hi8cuf5+pygGABGfzr2NekvmY/vjEh34QWPy2BV1ZP/L9biXvXuG56a+lrRDDB/tJ85F
X-Gm-Message-State: AOJu0YxziSur0vgta8SE7HsNysQyJDmM+1Z9tK4yuK6Hnwy+6h+Hq5d3
	YQTiap7yuyujEHp5tMXFDQmgZaJUjf1whK3z6auFWFwEMZZ1JFtJ7riY9Y/Dwf4=
X-Google-Smtp-Source: AGHT+IH+LPdv4uI8ZtpLAROMjGCY94DX6j2AvsclNLplVSroc4bHXuz/v1iWuKlTq88uAf/Bob4Hwg==
X-Received: by 2002:a2e:a99f:0:b0:2d3:2a95:6f0b with SMTP id x31-20020a2ea99f000000b002d32a956f0bmr1921680ljq.12.1709825944291;
        Thu, 07 Mar 2024 07:39:04 -0800 (PST)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id n24-20020a05640204d800b00566f92f1facsm6501964edw.36.2024.03.07.07.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 07:39:04 -0800 (PST)
From: David Gstir <david@sigma-star.at>
To: Mimi Zohar <zohar@linux.ibm.com>,
	James Bottomley <jejb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: David Gstir <david@sigma-star.at>,
	Shawn Guo <shawnguo@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	David Howells <dhowells@redhat.com>,
	Li Yang <leoyang.li@nxp.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Tejun Heo <tj@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v6 2/6] KEYS: trusted: improve scalability of trust source config
Date: Thu,  7 Mar 2024 16:38:29 +0100
Message-ID: <20240307153842.80033-3-david@sigma-star.at>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307153842.80033-1-david@sigma-star.at>
References: <20240307153842.80033-1-david@sigma-star.at>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling trusted keys requires at least one trust source implementation
(currently TPM, TEE or CAAM) to be enabled. Currently, this is
done by checking each trust source's config option individually.
This does not scale when more trust sources like the one for DCP
are added.

Add config HAVE_TRUSTED_KEYS which is set to true by each trust source
once its enabled and adapt the check for having at least one active trust
source to use this option. Whenever a new trust source is added, it now
needs to select HAVE_TRUSTED_KEYS.

Signed-off-by: David Gstir <david@sigma-star.at>
---
 security/keys/trusted-keys/Kconfig | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-keys/Kconfig
index dbfdd8536468..553dc117f385 100644
--- a/security/keys/trusted-keys/Kconfig
+++ b/security/keys/trusted-keys/Kconfig
@@ -1,3 +1,6 @@
+config HAVE_TRUSTED_KEYS
+	bool
+
 config TRUSTED_KEYS_TPM
 	bool "TPM-based trusted keys"
 	depends on TCG_TPM >= TRUSTED_KEYS
@@ -9,6 +12,7 @@ config TRUSTED_KEYS_TPM
 	select ASN1_ENCODER
 	select OID_REGISTRY
 	select ASN1
+	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of the Trusted Platform Module (TPM) as trusted key
 	  backend. Trusted keys are random number symmetric keys,
@@ -20,6 +24,7 @@ config TRUSTED_KEYS_TEE
 	bool "TEE-based trusted keys"
 	depends on TEE >= TRUSTED_KEYS
 	default y
+	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of the Trusted Execution Environment (TEE) as trusted
 	  key backend.
@@ -29,10 +34,11 @@ config TRUSTED_KEYS_CAAM
 	depends on CRYPTO_DEV_FSL_CAAM_JR >= TRUSTED_KEYS
 	select CRYPTO_DEV_FSL_CAAM_BLOB_GEN
 	default y
+	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of NXP's Cryptographic Accelerator and Assurance Module
 	  (CAAM) as trusted key backend.
 
-if !TRUSTED_KEYS_TPM && !TRUSTED_KEYS_TEE && !TRUSTED_KEYS_CAAM
-comment "No trust source selected!"
+if !HAVE_TRUSTED_KEYS
+	comment "No trust source selected!"
 endif
-- 
2.35.3

