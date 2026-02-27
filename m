Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB27E43DA38;
	Fri, 27 Feb 2026 23:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772235593; cv=none; b=L9/9k6Np+s6MWA6LMlNn1bcx69vzHweyjz6gImXk6lZJWFhGPixa/3FeSIcAUNUnRFfrwAgmdKXraGPwV7+IIKJqw8Mm45oU76i8cbj4U7j+wbFv9K9KLkWPHIJvVC31H2aTiYyofkNdjc1wEDSPhqpYvxB/u94H72mpxB6QSGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772235593; c=relaxed/simple;
	bh=D+VW+R8K0POrbRrS2dDXlHwIgvGIZ20tTK8oobQrcU8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEEMf3H799sY+zkyKMM/euDIWRVQw7FKmD3fYwZC2gDXMMiUsaQrW4JxmXrRtC9bF9BdsVp7RmM/MD273e9EGxp5xGU/FmB+Vt7bZvHLrtjb4VF4tEy/HoVDuG3h+mm/2ejv3aarcFgq7NNRA2kRXFxM7kG4V5NHhd1dXv/H8tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gzghteCX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gzghteCX"
Received: from narnia.corp.microsoft.com (unknown [40.86.183.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id D68AE20B6F05;
	Fri, 27 Feb 2026 15:39:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D68AE20B6F05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772235586;
	bh=RWTkY/Qz36aGS7+IlbNK7vvrm7c3OmK6+02GyFNw8gk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gzghteCXxMr2ovaOFA76QgqeGTaOnZ+Ss/fLEghoEd70NUqAkYsKBTXhc5AxOoRVz
	 vs0oOYKBucm7sJ8ytZICGDcHLclOy/MOBc8j4SV2f/URau/dlUEeQT+9rIWMgO1ImE
	 d0wMMfjA5epeBcbJLI0GnkG27sAZB7+X8du0UGAg=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James.Bottomley@HansenPartnership.com,
	dhowells@redhat.com,
	Fan Wu <wufan@kernel.org>,
	Ryan Foster <foster.ryan.r@gmail.com>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 02/10] crypto: pkcs7: add flag for validated trust on a signed info block
Date: Fri, 27 Feb 2026 15:38:31 -0800
Message-ID: <20260227233930.2418522-3-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227233930.2418522-1-bboscaccy@linux.microsoft.com>
References: <20260227233930.2418522-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Bottomley <James.Bottomley@HansenPartnership.com>

Allow consumers of struct pkcs7_message to tell if any of the sinfo
fields has passed a trust validation.  Note that this does not happen
in parsing, pkcs7_validate_trust() must be explicitly called or called
via validate_pkcs7_trust().

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 crypto/asymmetric_keys/pkcs7_parser.h | 1 +
 crypto/asymmetric_keys/pkcs7_trust.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/crypto/asymmetric_keys/pkcs7_parser.h b/crypto/asymmetric_keys/pkcs7_parser.h
index 6ef9f335bb17..203062a33def 100644
--- a/crypto/asymmetric_keys/pkcs7_parser.h
+++ b/crypto/asymmetric_keys/pkcs7_parser.h
@@ -20,6 +20,7 @@ struct pkcs7_signed_info {
 	unsigned	index;
 	bool		unsupported_crypto;	/* T if not usable due to missing crypto */
 	bool		blacklisted;
+	bool		verified; /* T if this signer has validated trust */
 
 	/* Message digest - the digest of the Content Data (or NULL) */
 	const void	*msgdigest;
diff --git a/crypto/asymmetric_keys/pkcs7_trust.c b/crypto/asymmetric_keys/pkcs7_trust.c
index 9a87c34ed173..78ebfb6373b6 100644
--- a/crypto/asymmetric_keys/pkcs7_trust.c
+++ b/crypto/asymmetric_keys/pkcs7_trust.c
@@ -127,6 +127,7 @@ static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
 		for (p = sinfo->signer; p != x509; p = p->signer)
 			p->verified = true;
 	}
+	sinfo->verified = true;
 	kleave(" = 0");
 	return 0;
 }
-- 
2.52.0

