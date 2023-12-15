Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C8250E6
	for <linux-security-module@vger.kernel.org>; Fri, 15 Dec 2023 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="pi6WclaX"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3333074512bso928427f8f.1
        for <linux-security-module@vger.kernel.org>; Fri, 15 Dec 2023 03:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1702638432; x=1703243232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glgMvtXI6KkmHIaNgJkuNjVnZkyLK3+FNQI0ug3e7hI=;
        b=pi6WclaXebaRIiVqzsP8HuqnES18cTXikmJfA+8KRMFSXCOVsKPbMsWzq44YEqrRZJ
         pqMPawBszjLxmNwx/MXGsbk60srt6opJqe6H5r0v1dzoWRJni+MCAnfKz6X5QjclaqGY
         GEUIvUxu3OiHR3O8spWkEcJCYv3sHWS5FGqyzsk5A2Ausn7oK+OucW6es+83oI1T3fis
         LclhWIxrDdYxzrOz4VTfqZx+srUeRCA4rpUnPBoILOjhTlY4rNG2dA9l/fDRF7xUBcdA
         L+v2NXtkAXtpXRCpcR+PX6ZPfkqv/+8JCiqEhFYUfQmSnalbNK027/t5tkgfR51ZGAlC
         2E0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638432; x=1703243232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glgMvtXI6KkmHIaNgJkuNjVnZkyLK3+FNQI0ug3e7hI=;
        b=qEh13QJRXPyYPBCjf1g3FtY4pHNxgUEk61cIdKHgvB+WfK5xDkY2RCreeAey9rQv7s
         EsEz/SxBvxi1CryRYEtM8fpG9jCyVH4GEZnHKN6c1hGRNdyoJr5vrmCmlOELC35ng3fq
         s6Sc7QlbAsLIGSBZWO3Jk36Ze7CS5xEZ+npWRLQtUucRS1lkzVpflVqw1dIw4TyLVKpm
         EmZUxb/M7AKzHYqcLgUZrvKwUy97+M6btjiRrPMCxF7iW3DSxooiyBdC+ZonZkKL9iRm
         OBngqcJ7CJ355ZS4amLOPVrum/Wp61SjYh9UE1UuD8SoEMnQQ25FzQYD8qy3HsgVExMg
         2z1A==
X-Gm-Message-State: AOJu0YxVI0fCrnI+UG+zIqaFCXYnuj01MOd2tabYtSSy43jLWEeNZo+k
	5D8AzWV9tge+Fn39IcHjhlJxsg==
X-Google-Smtp-Source: AGHT+IFvQkMHaxRZA5Zs8mkotuWDtp+T3hyCKoTiMu/ivavbVlHMH2icSqyklYImwQNURYB9+KWiSw==
X-Received: by 2002:a05:600c:4311:b0:40c:2788:2903 with SMTP id p17-20020a05600c431100b0040c27882903mr5823244wme.125.1702638432281;
        Fri, 15 Dec 2023 03:07:12 -0800 (PST)
Received: from localhost (clnet-p106-198.ikbnet.co.at. [83.175.106.198])
        by smtp.gmail.com with UTF8SMTPSA id p8-20020a05600c358800b0040b40468c98sm30050771wmq.10.2023.12.15.03.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 03:07:12 -0800 (PST)
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
Subject: [PATCH v5 2/6] KEYS: trusted: improve scalability of trust source config
Date: Fri, 15 Dec 2023 12:06:29 +0100
Message-ID: <20231215110639.45522-3-david@sigma-star.at>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215110639.45522-1-david@sigma-star.at>
References: <20231215110639.45522-1-david@sigma-star.at>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checking if at least one valid trust source is selected does not scale
and becomes hard to read. This improves this in preparation for the DCP
trust source.

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

