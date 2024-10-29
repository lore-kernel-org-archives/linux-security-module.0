Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350DE1DF989
	for <linux-security-module@vger.kernel.org>; Tue, 29 Oct 2024 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730201665; cv=none; b=c44ixCrmDIwCV0sDJMVb6ld+8K1rgSBNKYuU17ogU9ZLcNXLmTeCms6LSm2033V4qZHuFqmYxiVSLaV/78phPH10FS3PpIpFp066/077mKA41RAMi01udc1x+FQmIDiae2Qt0nVWGIEWHhooohJct1KrQBAjRuJVL7hjqO/8YfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730201665; c=relaxed/simple;
	bh=cPKEJ4jerXa/h6ueOtoFqHZZD6u7n4AElLCBfDVkuAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXL8ltkXScO8SVRzTWxQXNj4SWq6K04k4s/JUr2JAbyYriyO4fiayYSmebJiIqSzKxSCT+NgwZrbXlRIWS0tG17ZOdbqK5+MAyFaB2CdXvQWDuF7sGIoAsBZX7EbM9rIB7pb9928VX19oelpAsSjnzL1XUsvSxrlHz5NH5uP1QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=ap/W9MXz; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="ap/W9MXz"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d4ba20075so3660190f8f.0
        for <linux-security-module@vger.kernel.org>; Tue, 29 Oct 2024 04:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1730201660; x=1730806460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUO11C/JRTs4GKxfufQ6dUqgB6gKo2LmLUMdUeU8K1k=;
        b=ap/W9MXzkQRzXylxlEwl9vrjtn4+mVxv5Dln5/HFOmSJtI2c1uJDvPw+iTmPDB6+NM
         ogtZzXTUR0mOpR4sKySkHlXlwfGp2SVUCRPOWNM934bn42MyKO/j0AW86OTPImOeKcq7
         ehYDhB6SbvxWHr9PZ28OxYEKvyioWUz4eLZ/5aury1TZa0G8wEIFXfyBVnFG3G3b49Fc
         yvQor9LnoJhhJm1sQuR5nd2A4XENxUIpsZmMuH9+JWbDWzpK+sdTL7FO501zS3pi1YGL
         IyEyu9Xgun/pPgBSnura1G3Q6dHNJA6h6E0XPPz8roSsapXM/Ya/tjj9PPS0qtJsY3y3
         hjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730201660; x=1730806460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUO11C/JRTs4GKxfufQ6dUqgB6gKo2LmLUMdUeU8K1k=;
        b=rkpSboaWv1UNZNyGXWZ8PW2Cog0rpVLmc1hrJNECxJKCPXYmKEZaR0a1vf08iLiWDX
         sUnJN6yu9i9Y8TExr3d2oWTpnYc38UTGG1xQZywabciRx9uFlsJkMSk2KVWXh1dPAHqS
         G5oDkvFfnYTyMick8NRy4ZuuBZXTzQqoCVp+gP+ue5hDtz5lahWKRjti5ceTx7YGJmwR
         g+tA9mJ5Ib7hrCF91B6lX71CyiDLzMndWJTl6ihRcRRBjdv+lBXrtleXKRbpZEX13MNK
         tnQO1gKVkWbu7i+KvAFDOvQOmszly9BPqJBHBkjn5DGmFQwsoEYqQTKNufy5qolAMZ92
         ksrw==
X-Forwarded-Encrypted: i=1; AJvYcCXqx/pjO0naAheYWjswzluY1Kdv2PpHk0BqzPmUURuKTgF/i+fq+8MG7O+W7asclzILDtK4nPFyjmEIZWySzKhUpmQmwBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcdGF7Ty0BnEs0+VzZP6HCPzC7bpijM93ArHLXamLd7brg8F83
	adHdcRrpYxaOK5DPm62t+yZl59Ucn8tfYx7KvSZOuApDol7Isx+z6OlXol4WtB8=
X-Google-Smtp-Source: AGHT+IFJoyZ6NxzI4ys9GDFWfJixnTkKlsJEMZbZjWGrqOc2/MIuNQIrRuJSwDRXg2rPjjIDI76/9g==
X-Received: by 2002:adf:fdc9:0:b0:37d:43e5:a013 with SMTP id ffacd0b85a97d-380610f49e4mr7243573f8f.8.1730201660311;
        Tue, 29 Oct 2024 04:34:20 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38058b47952sm12152755f8f.48.2024.10.29.04.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 04:34:20 -0700 (PDT)
From: David Gstir <david@sigma-star.at>
To: parthiban@linumiz.com,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Gstir <david@sigma-star.at>,
	stable@vger.kernel.org
Subject: [PATCH] KEYS: trusted: dcp: fix NULL dereference in AEAD crypto operation
Date: Tue, 29 Oct 2024 12:34:01 +0100
Message-ID: <20241029113401.90539-1-david@sigma-star.at>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <254d3bb1-6dbc-48b4-9c08-77df04baee2f@linumiz.com>
References: <254d3bb1-6dbc-48b4-9c08-77df04baee2f@linumiz.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sealing or unsealing a key blob we currently do not wait for
the AEAD cipher operation to finish and simply return after submitting
the request. If there is some load on the system we can exit before
the cipher operation is done and the buffer we read from/write to
is already removed from the stack. This will e.g. result in NULL
pointer dereference errors in the DCP driver during blob creation.

Fix this by waiting for the AEAD cipher operation to finish before
resuming the seal and unseal calls.

Cc: stable@vger.kernel.org # v6.10+
Fixes: 0e28bf61a5f9 ("KEYS: trusted: dcp: fix leak of blob encryption key")
Reported-by: Parthiban N <parthiban@linumiz.com>
Closes: https://lore.kernel.org/keyrings/254d3bb1-6dbc-48b4-9c08-77df04baee2f@linumiz.com/
Signed-off-by: David Gstir <david@sigma-star.at>
---
 security/keys/trusted-keys/trusted_dcp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/trusted-keys/trusted_dcp.c
index 4edc5bbbcda3..e908c53a803c 100644
--- a/security/keys/trusted-keys/trusted_dcp.c
+++ b/security/keys/trusted-keys/trusted_dcp.c
@@ -133,6 +133,7 @@ static int do_aead_crypto(u8 *in, u8 *out, size_t len, u8 *key, u8 *nonce,
 	struct scatterlist src_sg, dst_sg;
 	struct crypto_aead *aead;
 	int ret;
+	DECLARE_CRYPTO_WAIT(wait);
 
 	aead = crypto_alloc_aead("gcm(aes)", 0, CRYPTO_ALG_ASYNC);
 	if (IS_ERR(aead)) {
@@ -163,8 +164,8 @@ static int do_aead_crypto(u8 *in, u8 *out, size_t len, u8 *key, u8 *nonce,
 	}
 
 	aead_request_set_crypt(aead_req, &src_sg, &dst_sg, len, nonce);
-	aead_request_set_callback(aead_req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL,
-				  NULL);
+	aead_request_set_callback(aead_req, CRYPTO_TFM_REQ_MAY_SLEEP,
+				  crypto_req_done, &wait);
 	aead_request_set_ad(aead_req, 0);
 
 	if (crypto_aead_setkey(aead, key, AES_KEYSIZE_128)) {
@@ -174,9 +175,9 @@ static int do_aead_crypto(u8 *in, u8 *out, size_t len, u8 *key, u8 *nonce,
 	}
 
 	if (do_encrypt)
-		ret = crypto_aead_encrypt(aead_req);
+		ret = crypto_wait_req(crypto_aead_encrypt(aead_req), &wait);
 	else
-		ret = crypto_aead_decrypt(aead_req);
+		ret = crypto_wait_req(crypto_aead_decrypt(aead_req), &wait);
 
 free_req:
 	aead_request_free(aead_req);
-- 
2.47.0

