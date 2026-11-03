Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676588;
	b=D9eb26uxLdRmWPqLmUu6jcma3/s9eqjbZkQphtPQdsTo+/aI3zQoFLNvPyCFFEJTeD6S
	 3c3vcrRudJLT69RiivStsse8icRA11+1hNlNmeudU7Yi6biIEa+cNvXVh/YzN8tkwuUkU
	 m4T7HpDdKmbv1mH9u8n6n+z76wRVFv0eTVWJVPtLRzASRZqg/Z+wI7n1A85cEB7Z3zwih
	 6ok+zT35oy04LnWTQg6chOSc6IWBscIbheRkCfMDqDfN6xiTueiG+2cXFvRXF/vNp2sFn
	 X6lRtPB0d8blCO5/KnTjbfDt4h6P/1KoY/pKyUOrRZLp8mZ7EEu0mmttkX1BdVgLZdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676588;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oxs2B3KfhNYJIVkfqODARwic0zLW8yubsDNepUkaIgI=;
	b=QRVPjLK2VtPSZxZKcC664pV9HmW/lZHDyfpkYZ4FDgIVcChJR3pICo3rWMzYEKnurAHj
	 oXKrKFVHXtnnQ5lkTiYSoYRxr6zboot8uq1BIGKvtXtokoFb53HpmwZJnhzBj/jwCTIoN
	 BM2J/8uH1g3KALc9QxyHHiQY2WxuPsI1lTYDU3qFO7GmIhZN/ZpHoF8Phy7NmMoUZXnKS
	 32DQVL494m7ak+wuD8K9zXcnBcZgjjZffmtWka+/Nov03jd6bHZnSxTi1dFT9lehJyjVl
	 ydeACYzMrzcO+9yZjLSJfJgCEGTqlmIxJ83kQuMgEl67UvHnD4FHNOpueOuXcuY08KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMWhhZqm;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE13A606A324
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 03:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE13A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMWhhZqm
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e812e2b31bso21911635ad.3
        for <linux-security-module@vger.kernel.org>; Mon, 02 Nov 2026 19:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793676587; x=1794281387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oxs2B3KfhNYJIVkfqODARwic0zLW8yubsDNepUkaIgI=;
        b=AMWhhZqmR9TIixkMWH2d0/BwYbLF9qPxWAXEhyiHO0dl08UPkkEwn0TtRUjxhKaVlk
         MyQmbcDYkioBdJ6E80jsPgMZJN5E8Xl1u4bP6ieiuCXyoQgRoftMj7BrLkQTGb0EU00j
         m62A/BdB/rS2zyz3voYU5ZBko+EjPFc8q4igOgLoS5gnnNSrAnEBajB4Y4u0zRIeShXX
         IbOPx7YD1GF+6QCl7LT7mAS55Dp+ZqvFa/aPxCxjBUi9Jms/ET7Xvozb1hNLXDqUDXFk
         U8zzcNfmayibIlOmv7uafT3IPx4cUp8mhMtQvWsXjH8EPNzCOvVlTjvvobfTKXAVZoab
         edwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793676587; x=1794281387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oxs2B3KfhNYJIVkfqODARwic0zLW8yubsDNepUkaIgI=;
        b=S2dcn+HD3Li2Jc0cFqgl8lbjxFWgzZjyx+UKTgp8a/ccrMhVZJ2eqESuYN7o59Ea9O
         w+uOqi5cRJJsJFHJ/ynguLW9bkThE3qY4xdRq1QeqP/NuWadBbJTgv2QudlpF6VAPaZa
         kjhmLTyVE0cSOl3B+whIMtdcjXlom8DBGivjeBluWDCbOIOcqUEyeCHH/UzD3q1VlFoy
         AXA4wW5GZFFy9vZpiseL8fqr2eYAZT1uZvBfSuO2ap3OB6TOykge+/mG1xqXZEgRfIAR
         UBmbCQVzKUOGqkjfcVHSADP+0T+LwUigFbh0NSc3z2OlgNPvAoWEVTtRVDXlwcsLc4Z3
         QB+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzelixi5jqfvOxOdBFeU92n7duJhLX0KACjoc2GVK4Xi4bj37gpGruN8qNaQHjglELUXxfaKaWvu9ZvrPgRIhsE6HuF1qA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qclkohtkit3/cFmUQBElgNXrLWVHCR8kNlznmCUALXpamX8Ad
	mWP5VUCvaYIGJ8xEjjBfkhsHKASptoGgm3Y5KFDjsLIZjcm/+z4UtAswzfaBINBtpt8=
X-Gm-Gg: AYBFou1fqtqQRv2/2cWLuTz/ZmBWF4Ps62t4EWg0rApXquf8lhdA+2GfbVJA/gAb/v6
	hYqKw3l9BjC+OfDBNrRvhfI8M9E3uyP7Rwz0RF8naEhhRcx8BHtSErHYc/Oxr0CCGTvf94+NP3Q
	O1VTGufIP632TvIi44zLsjhgSco7UEIg2M0Oo207EXkViZAESsgvagpl3Yyi2diz8KNspZgWVqC
	qRQ1zbnqjU5uDXDL5ql3epMX4jF6LvfybSi8eHAHZkiOLTyYx+Jb3tHhn50QCnoUzD1U7Wo44K3
	fr04jrLcufyb/0qLFNFK6TzC5nJnPWQqg12fCP/b0ZufDNSGlBZLLPMtYkfKGsu0K98DN9Ex7Xi
	yp99y4lGuh+9IK1NxPBN49VF/89az6OIZpnS8SRXgsM9bgG+TuVF4E2XTOFzwNCej90Z5vErTqz
	L1dIhtF3jrZkKV4OA0BIsW1BLlhgpy7gcShJa8eGjLP8ETxAFdrhEheN+uTuirXJDK6IyE01qHU
	tNDlF34C8rj1H4Rbu19MdUaoCtWbzXSPpC92LSx5EOS8FOyjlE3WJLEGz/JRWOIladbkgjIIJT4
	XzKW2lvfOlrfuZwg9liwNRSnDXp+HnSnkPJyZYLeyGFIE8M2wc9A2fwTqBR6TYfDXwKx
X-Received: by 2002:a17:902:e5d2:b0:2e7:e73e:7091 with SMTP id d9443c01a7336-2eb364bcec2mr126948885ad.31.1793676587056;
        Mon, 02 Nov 2026 19:29:47 -0800 (PST)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3928104asm33984555ad.53.2026.11.02.19.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 19:29:46 -0800 (PST)
From: BeaCox <0xbeac@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KEYS: Protect pkey method checks against type removal
Date: Tue,  3 Nov 2026 11:29:40 +0800
Message-ID: <20261103032940.51826-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

keyctl_pkey_params_get() looks up the key, and keyctl_pkey_query(),
keyctl_pkey_e_d_s() and keyctl_pkey_verify() then dereference
key->type->asym_* outside key->sem.  A reference keeps the key alive, but
does not pin the module providing its type.

unregister_key_type() calls key_gc_keytype(), which retypes every
remaining key of the type to key_type_dead under key->sem for writing.
The pkey paths read key->type again after their checks, so a concurrent
module unload can turn the checked callback into the NULL key_type_dead
member and call through a NULL function pointer, e.g.:

  KEYCTL_PKEY_SIGN task              Module unload and key GC
  ------------------------           ------------------------
  keyctl_pkey_e_d_s()
    if (!key->type->asym_eds_op)     unregister_key_type()
                                       GC: down_write(&key->sem)
                                       GC: retype to key_type_dead
                                       GC: up_write(&key->sem)
                                     free_module()
    in = memdup_user(...)
    key->type->asym_eds_op(...)      -> NULL call

In-tree, turris-signing-key provides such methods; out-of-tree asymmetric
key types are affected as well.

Hold key->sem for reading from the lookup until the parameter block is
freed, so the type cannot be retired between the method check and the
matching call.

This is the same type-removal problem recently fixed for the read
(925c84e3cc21) and update (aef3a8a4f988) methods.

Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
Cc: stable@vger.kernel.org
Signed-off-by: BeaCox <0xbeac@gmail.com>
---
 security/keys/keyctl_pkey.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 15b6bf6..b7e3648 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -17,7 +17,10 @@
 static void keyctl_pkey_params_free(struct kernel_pkey_params *params)
 {
 	kfree(params->info);
-	key_put(params->key);
+	if (params->key) {
+		up_read(&params->key->sem);
+		key_put(params->key);
+	}
 }
 
 enum {
@@ -100,6 +103,7 @@ static int keyctl_pkey_params_get(key_serial_t id,
 		return PTR_ERR(key_ref);
 	params->key = key_ref_to_ptr(key_ref);
 
+	down_read(&params->key->sem);
 	if (!params->key->type->asym_query)
 		return -EOPNOTSUPP;
 
