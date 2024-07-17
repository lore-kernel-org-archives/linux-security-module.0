Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A42D17F4E8
	for <linux-security-module@vger.kernel.org>; Wed, 17 Jul 2024 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721215770; cv=none; b=UA7ofKBkPz3k1Vv6wJUijMkeYKHcL/Nb7I5pwZek197w7ZcLbUmKf7f8PL5loNZWEVj9N9K8F3W9aqnWe3BGxxcWRkgI12rnwzsuoPnPIiv7pqn+z5yOhngoeLJ9eUaX305uD7aXZ6Vu7VHP6yAW4I3vNWyqQ5B3xi4CtQnqge4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721215770; c=relaxed/simple;
	bh=mlueMApefrBx3oCbCetbJgT4sruWDXzUi6v+8CnwLuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFHL5m5UfPihdHPFZBaDQJVNnC2dz1s9x3l4UQWBoL0Nz42TaefUpKpNvBAz7N/JoQw5M6Y30urE0Pq5K8eio4VG9XhJpTqQp7EFuViDywm2icPhuXIj34vUQU/iEFjMIpjWp9Ig2X6wXLDLAMkGvUf7mZDAFREPO8XZAGc8ZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=Zt8Ckj4K; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="Zt8Ckj4K"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3683f56b9bdso156331f8f.1
        for <linux-security-module@vger.kernel.org>; Wed, 17 Jul 2024 04:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1721215767; x=1721820567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juT3uodcmwnlXPVSCunbVs4x8IyH/tPtIrSj5xeHKyQ=;
        b=Zt8Ckj4Kc6ZIBApxp846A8PfVpIH3JXYgwzLXfvCxVHhd5WJtQPm2HQsV09bEK/ynv
         WByzUZ0UvAsb0NJ5ibmNJfZ3r9MyBgyMTPKL6LZpPSWohz0FG9eYtDSLJf+F7UfVCBFt
         DLNR0CpDj4J+LNv/cGDILPezDwRSviyo1iTMselmwscW03A0bU7Swk95v5Z0/yWgNrDI
         mRMznVeswuZRgWrbWu2c5NZFCS3TvWk7CbucqN6DSVEEn3+ecp5O7WVc52rglZecA+bN
         B9ghVMS3ddmYQQHl7bQLrJdKOMmkQ7vaUnWcdJPlBhmZZ1MP02yvupN3dV7DSCT594i4
         Ga+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721215767; x=1721820567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juT3uodcmwnlXPVSCunbVs4x8IyH/tPtIrSj5xeHKyQ=;
        b=ueRrMslXhi7EVwt5ddtJEmPSci3vgTVec8kTW7m4nU4JoJyjbfaq1JuMmefLqnCXu4
         fvLIkhbU8hGCCjx1Bmsnck4mYm67g1uXbyySTn64uQTgOoYRIoW+dZ19qrlKf1XP9tZ0
         MvjJYIll0xe0Wf1Aw5SX0XLFDP3I22I6FBG0Y7U+pkoMThc8yifmyP+SZgP6xcZUbbVh
         luuB8MrYu17RcWLDgsSXjb4gxoNKJ/Wp+LkgSu5sgj7cXgox9M6MefhLQoB25Vmy5331
         GPXmAoU5VaVdDDaNSaqALVMSx+H5QmgrvsGRcX2rYhNHoAFUrq1NwrNnz7Ld+aWlsjQ5
         0t8A==
X-Forwarded-Encrypted: i=1; AJvYcCVvZ9VuhAODCCo8ExZoF51yXaZPTQqzqSWoSdl9Di4FAi5JG4FWIfpfkgr75YR8z2IRRncJ4GJEPNz7YoI1QZopqR9HcYAl7HMfQkWVJVbw7lGje4yV
X-Gm-Message-State: AOJu0YzoM5zbh5/DhM94cqHv8UPIFIW6qu4SEqQDUVFVVzngZ0lE5Dt3
	8YVOOGL9oFs0Aj+JvVfvl0vvIiQK5YBk8p/Uixj+fEpyzs10pWBNUObeZjp/TqQ=
X-Google-Smtp-Source: AGHT+IGYE7f7sIy7b+/v6HZr1Z65eDUdS6PMQc5R2C0QdpR/FSBhFb+VKCZNHWlw7oT3n32HFT6z9Q==
X-Received: by 2002:adf:e508:0:b0:366:f041:935d with SMTP id ffacd0b85a97d-3683179ebc7mr829016f8f.60.1721215767047;
        Wed, 17 Jul 2024 04:29:27 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-368119970e7sm10640354f8f.21.2024.07.17.04.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 04:29:26 -0700 (PDT)
From: David Gstir <david@sigma-star.at>
To: sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Richard Weinberger <richard@nod.at>,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Gstir <david@sigma-star.at>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] KEYS: trusted: dcp: fix leak of blob encryption key
Date: Wed, 17 Jul 2024 13:28:45 +0200
Message-ID: <20240717112845.92088-2-david@sigma-star.at>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717112845.92088-1-david@sigma-star.at>
References: <20240717112845.92088-1-david@sigma-star.at>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trusted keys unseal the key blob on load, but keep the sealed payload in
the blob field so that every subsequent read (export) will simply
convert this field to hex and send it to userspace.

With DCP-based trusted keys, we decrypt the blob encryption key (BEK)
in the Kernel due hardware limitations and then decrypt the blob payload.
BEK decryption is done in-place which means that the trusted key blob
field is modified and it consequently holds the BEK in plain text.
Every subsequent read of that key thus send the plain text BEK instead
of the encrypted BEK to userspace.

This issue only occurs when importing a trusted DCP-based key and
then exporting it again. This should rarely happen as the common use cases
are to either create a new trusted key and export it, or import a key
blob and then just use it without exporting it again.

Fix this by performing BEK decryption and encryption in a dedicated
buffer. Further always wipe the plain text BEK buffer to prevent leaking
the key via uninitialized memory.

Cc: stable@vger.kernel.org # v6.10+
Fixes: 2e8a0f40a39c ("KEYS: trusted: Introduce NXP DCP-backed trusted keys")
Signed-off-by: David Gstir <david@sigma-star.at>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_dcp.c | 33 +++++++++++++++---------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/trusted-keys/trusted_dcp.c
index b0947f072a98..4edc5bbbcda3 100644
--- a/security/keys/trusted-keys/trusted_dcp.c
+++ b/security/keys/trusted-keys/trusted_dcp.c
@@ -186,20 +186,21 @@ static int do_aead_crypto(u8 *in, u8 *out, size_t len, u8 *key, u8 *nonce,
 	return ret;
 }
 
-static int decrypt_blob_key(u8 *key)
+static int decrypt_blob_key(u8 *encrypted_key, u8 *plain_key)
 {
-	return do_dcp_crypto(key, key, false);
+	return do_dcp_crypto(encrypted_key, plain_key, false);
 }
 
-static int encrypt_blob_key(u8 *key)
+static int encrypt_blob_key(u8 *plain_key, u8 *encrypted_key)
 {
-	return do_dcp_crypto(key, key, true);
+	return do_dcp_crypto(plain_key, encrypted_key, true);
 }
 
 static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)
 {
 	struct dcp_blob_fmt *b = (struct dcp_blob_fmt *)p->blob;
 	int blen, ret;
+	u8 plain_blob_key[AES_KEYSIZE_128];
 
 	blen = calc_blob_len(p->key_len);
 	if (blen > MAX_BLOB_SIZE)
@@ -207,30 +208,36 @@ static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)
 
 	b->fmt_version = DCP_BLOB_VERSION;
 	get_random_bytes(b->nonce, AES_KEYSIZE_128);
-	get_random_bytes(b->blob_key, AES_KEYSIZE_128);
+	get_random_bytes(plain_blob_key, AES_KEYSIZE_128);
 
-	ret = do_aead_crypto(p->key, b->payload, p->key_len, b->blob_key,
+	ret = do_aead_crypto(p->key, b->payload, p->key_len, plain_blob_key,
 			     b->nonce, true);
 	if (ret) {
 		pr_err("Unable to encrypt blob payload: %i\n", ret);
-		return ret;
+		goto out;
 	}
 
-	ret = encrypt_blob_key(b->blob_key);
+	ret = encrypt_blob_key(plain_blob_key, b->blob_key);
 	if (ret) {
 		pr_err("Unable to encrypt blob key: %i\n", ret);
-		return ret;
+		goto out;
 	}
 
 	put_unaligned_le32(p->key_len, &b->payload_len);
 	p->blob_len = blen;
-	return 0;
+	ret = 0;
+
+out:
+	memzero_explicit(plain_blob_key, sizeof(plain_blob_key));
+
+	return ret;
 }
 
 static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
 {
 	struct dcp_blob_fmt *b = (struct dcp_blob_fmt *)p->blob;
 	int blen, ret;
+	u8 plain_blob_key[AES_KEYSIZE_128];
 
 	if (b->fmt_version != DCP_BLOB_VERSION) {
 		pr_err("DCP blob has bad version: %i, expected %i\n",
@@ -248,14 +255,14 @@ static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
 		goto out;
 	}
 
-	ret = decrypt_blob_key(b->blob_key);
+	ret = decrypt_blob_key(b->blob_key, plain_blob_key);
 	if (ret) {
 		pr_err("Unable to decrypt blob key: %i\n", ret);
 		goto out;
 	}
 
 	ret = do_aead_crypto(b->payload, p->key, p->key_len + DCP_BLOB_AUTHLEN,
-			     b->blob_key, b->nonce, false);
+			     plain_blob_key, b->nonce, false);
 	if (ret) {
 		pr_err("Unwrap of DCP payload failed: %i\n", ret);
 		goto out;
@@ -263,6 +270,8 @@ static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
 
 	ret = 0;
 out:
+	memzero_explicit(plain_blob_key, sizeof(plain_blob_key));
+
 	return ret;
 }
 
-- 
2.35.3

