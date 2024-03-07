Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA2130AE3
	for <linux-security-module@vger.kernel.org>; Thu,  7 Mar 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709825955; cv=none; b=g+lzrs1zRO3XczBB4L/Hjp7+hVqGGL4x5U4Nbtx5LABxPYMST6GN53m0b1PGkdi+balgTM6J7Hk4ZGhb079+0+wJ5H/996lUKlcTXJXkr5VbgaIWjQwZBjdrXjnAF0jRLAtj0I36gJHRP/a1soRCqeFYT0xNM8sBiwJ/CsLKhUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709825955; c=relaxed/simple;
	bh=IoJ5PhDwmkZFYUe1jIRt3XY+XYejXNxDc1GhQecxiN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vj/jjz39BwzBENY36BC0HRUpyb4hNF8XbuKOJMxHbwP2JfMzR0+24oShPxhS8IBFbBwgR468uDDgaYVjuH1hqDz6ejw0cjlPzMLT8bzmZjs3hqq+6BWcz5S/1XF95liIRfOCecjVaFp0pWln0oU4lEiPRQcxpNhwKmCubGWNwgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=VAEefIaw; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="VAEefIaw"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso1287762a12.2
        for <linux-security-module@vger.kernel.org>; Thu, 07 Mar 2024 07:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1709825951; x=1710430751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q95Pv5eUd7/PCCDIkGY46bAHfemcttBtSKECUmP8rbg=;
        b=VAEefIawjg3T0EMzO060miLSluQ2j4JanLZgMzl00mJvqwgSMPPKXwZ9BJepZgjYkQ
         QnE4IS13xqUFvGK/2SHXykv0Q2biLLRBi42Remc8PMD3TpTDfEqELcub0UTe3QMJ8bfz
         YexEZi0lkba5r3Cs+Pqm9bKpVZJoXHAxhuZRGHQTpHvayfDeftj1wvQKNU2Sceroy1NT
         1KQEERpIUAQnwIsVZTSegM4nk9MruwD1nsyByloMl/GBV0to/nq/js1vzS9g0pU7QbJ6
         4YVNTeaWfcXV9e8J7rHqVVrjXliJKq/rIXFJU2EOOfXSsGHEj1AV81nfKfFknFeDaqkG
         9r+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709825951; x=1710430751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q95Pv5eUd7/PCCDIkGY46bAHfemcttBtSKECUmP8rbg=;
        b=ipsOR2iA3ht/n3bhgeQjnOpNmxxq5uL1x7M2muAOq8xFjgAFSywAFI31SoU/VoRXN/
         xwDBLArc8zPBWUlSgNi2hPDvHKxqO5z+vFvRVGx87lDUHn4sQhc5oPmny1EY4BCuY5f4
         wZue+j+QnxCCOSWrNlIGIklmvQ5/+YS3VHkaTWYUXp67VINgNpotcAcOcTfj8x3NKf72
         P9kWasH5yYDZ/de102RRPPkCk4sl3RXJ2oX583wU4X0Rgh3lWWs0zScl+yKRCNq5o7hf
         zP7GfLHjRWMzQI0ztp4KQe/ODSzDwKwbbU6UydUyMkBLZJ0xPdU3yTlxSUEgKlB6lDKd
         dY4g==
X-Forwarded-Encrypted: i=1; AJvYcCUU2Rmh8cJtbcgwCj2jPZjAdj5BaOkip1g0TH4XIrdgCH8UxmUHWvWejgOoDkhUxhh64CFsXy1GnodNKCBmVzDs7AVnV6ezoQ+JqveoUO3kFVvWILdp
X-Gm-Message-State: AOJu0YzBO/R/DKVNpMSHAAbYNxc/w0FENTUY+1swSnGNZ9AJXpkjn8dE
	6HwW5lSMgVuh1y1PeNoE2j8QrSsjB917RrvjqGVpt0ZzNetmIYcny39JvXZHJEs=
X-Google-Smtp-Source: AGHT+IFQim0IlvlrKFx/Yx6UJFZNUGR3Suw118WkReabIIWNHe5La99iFLjJ/8OXFgt0a3qNMqW7EQ==
X-Received: by 2002:a50:d514:0:b0:564:5c90:f521 with SMTP id u20-20020a50d514000000b005645c90f521mr115786edi.14.1709825951647;
        Thu, 07 Mar 2024 07:39:11 -0800 (PST)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id a26-20020a50c31a000000b00567f9d21b7csm1617918edb.94.2024.03.07.07.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 07:39:11 -0800 (PST)
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
	linux-security-module@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v6 5/6] docs: document DCP-backed trusted keys kernel params
Date: Thu,  7 Mar 2024 16:38:32 +0100
Message-ID: <20240307153842.80033-6-david@sigma-star.at>
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

Document the kernel parameters trusted.dcp_use_otp_key
and trusted.dcp_skip_zk_test for DCP-backed trusted keys.

Co-developed-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Richard Weinberger <richard@nod.at>
Co-developed-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Signed-off-by: David Gstir <david@sigma-star.at>
---
 Documentation/admin-guide/kernel-parameters.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 24c02c704049..b6944e57768a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6698,6 +6698,7 @@
 			- "tpm"
 			- "tee"
 			- "caam"
+			- "dcp"
 			If not specified then it defaults to iterating through
 			the trust source list starting with TPM and assigns the
 			first trust source as a backend which is initialized
@@ -6713,6 +6714,18 @@
 			If not specified, "default" is used. In this case,
 			the RNG's choice is left to each individual trust source.
 
+	trusted.dcp_use_otp_key
+			This is intended to be used in combination with
+			trusted.source=dcp and will select the DCP OTP key
+			instead of the DCP UNIQUE key blob encryption.
+
+	trusted.dcp_skip_zk_test
+			This is intended to be used in combination with
+			trusted.source=dcp and will disable the check if all
+			the blob key is zero'ed. This is helpful for situations where
+			having this key zero'ed is acceptable. E.g. in testing
+			scenarios.
+
 	tsc=		Disable clocksource stability checks for TSC.
 			Format: <string>
 			[x86] reliable: mark tsc clocksource as reliable, this
-- 
2.35.3

