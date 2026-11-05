Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907398;
	b=JfjT88sibiznnMc3xsv7BBV8fcD3kZsfuBe5Td+tjim5izHexDeeQRpquPxxR4UwFllC
	 jrjO3vesZux1f3JfqUYRJHoyR0E2SIgcShHcbz9uyj/l7tCic0Om2KB7LX0PX5R2IwC23
	 4yAO4fI/OEw6Vgw84BFXW4l2wruz//LZvKopUUrYR+DR1SP/VBevvRRZkVORrRNhXRqMQ
	 oI7Y88K62Y0SRbkIZvysgb50Zl57yGyThL4I+OEqeHKbFWd1yXL3IZvsugYy3Dv4OQj0y
	 kGUP9Rm/FaTCGDEijhE50PRGKogYMtwlXlEykOIS2YXn7aBVKe3lwHNwqT55DaAaCGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Varby6vTTgGosmDxdkbVVCPGhFaIy/1zgNtje3gNyzM=;
	b=NSCP4BrImAXN3Xqxe4fsNBxb0AswwcLJ9Odil35xmaDNuJwu0d9wM12B9BWOFi67pUi7
	 8TbN88dqJheFZRBES5c23YYp6RjYV5UDdN2LG4bGPcc0STjhGyTZkgrLjtKVaEit+A6rL
	 eO914j+wtwIiXY25GFWXnFppfPardNz5L9/2VOYPMHOpekafNwMWFX7zFXfZf0BdIw0qU
	 qJNx+Y4RIZYshfUCVTaKisme67Lwa/yt8W0ngev3equPnHQiPRBQmNsUDZoyotZvkAN4s
	 yBGhcowIpkAeJd2MxDYSFdnhU+kQCEo5UjkWPfrtcwEssc2xsBBzugUTwYlSCdrZvfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="MrvVq/pA";
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3575B606A6E0
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 19:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3575B606A6E0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MrvVq/pA
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso1536712a91.3
        for <linux-security-module@vger.kernel.org>; Thu, 05 Nov 2026 11:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793907397; x=1794512197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Varby6vTTgGosmDxdkbVVCPGhFaIy/1zgNtje3gNyzM=;
        b=MrvVq/pAxeEpkWXJvxeD7gcR/Qrh87bKPPTXZNEO0tG57lXCu9eFrtFxefXkdMbQ+t
         +FiL/k3Ptej86tBsPDeoLoizkVTIBwROn8QWbNusVRS8R/bCWm9dd6AGcGB7ub/WtPGR
         UWy3DCVzTTXRt+1WOzTVq60M6NKtxfs+3JKFNAt/gZKsEsjG8TdLG+xv5InLaxogx2T5
         OmYwab8IEf/IYxJ3jC3/1u/celUFJj8e96sXYWLdq5SO7gk63YV8hC7JdeKci8xMXjEq
         4nI7GwwwC1aOwO/Mk+UIING/PbLJezKjiIG/tMhS17HnfXM8TKGnyuXPcUMKDSksixfU
         SLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907397; x=1794512197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Varby6vTTgGosmDxdkbVVCPGhFaIy/1zgNtje3gNyzM=;
        b=zUWZW1XQZxeYLafvIE2b5t3sOFoMfEf4nRRI9mlE4ppm+P1qwOLdJ4CkizovY2Qesl
         RJ3I3rMqD0PoaufQP6D3TaYWV9RnRPapbEEVkNZfJgxfnBPeO0LD3iuLgp21wcxJ7C6l
         IHDwF3ODvatEDRqzUaMfLYAbwN9C6IS1U/Z/77olHvMg92bGpR8rpHqj8ZEiPn2X+DoW
         Qk67UMcBGst9Qaq2+HTLLImZbTNdTW6pPrTJfNFXkcXp0oJM3CPYjVJyaKvaAYeHYYVK
         Kg5pYnrRUpFHwj2N5CInwZD+pc7KosJW0iR7yfZnelb5OZN2fTVjlivnACfo4rTcBV5A
         zgqA==
X-Forwarded-Encrypted: i=1; AKwUvBwNmra/TCRKAH2hvHMTeQ8gwTB2U+flgqDM1ddoCn5HtmcoSn9537Q2WFwaFDIg7uZe+3S9/x/Sdvi+uBukmN0gXQkd8/4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8P2XhjNdUb+JYECPKWMQC6XAF/HZGW5OYj7wNTreh5BdK1tJ+u
	IWTHx0C4dGHn7lG0ySHWNPAeMChGHbVS3fv4+/bCnmEFrmD9RcEDmWgU
X-Gm-Gg: AYBFou1nvouoE//MxMd7ooPdFvtY3hbgGIowAZ1E6bUDAGW0SPPJB+sSlOC9QJblCMQ
	pisoJwfta0Gxe3YRH8lmj9EPkbbVnbhTChCRCX3vpFKrhvmW8XhZhm7OoZT3rmr5/NRsr7PSg1B
	aPlXECb26g2c45wHdzgZHx4fgKEq8140cP8bxlFUXu+XCS68wEFA+8+LocpeEuZaXx3RGxhYjxN
	JXU7nFS4f9pkPDVVTEhX3EQKQpjGXq0EuPUHYC50aokG6oHK2X7Qw5BeSRSJ9b7sfvwD63SOnMI
	GbP4bRCpqm73R4CdkVV87phRGZnEx1lgWFtJznvGjcSo1Nt2Hc3LUFub6CRtxd+4bNTJ965kp+Y
	mTQVSyZxEFyqs+UxXvG9euwxOYyrSkN3igQ91CxgalR7m/Xc6QVQ4KEyXCwLzNbIL6mpKmNaSFu
	eEeRWKhF+KCnjL1DfyuQlWTv6MGMPRZ3BIEPwMczc1molAsJDpBAD8XtEtyFvul7hdelJ1cfY7j
	5w/2gpy3Y4JBztP8Gxle0/Hoi+A3rl3Sedxlx9O7Wxqj8+VERHM2ErGEahMTFSbsqjZU1dyCx0O
	nUSi5HgD8jfTLxZ7VsWCjJI2P+cbmIWQOBkhVdqn0USKPibA
X-Received: by 2002:a17:90b:448f:b0:3ab:9c73:147 with SMTP id 98e67ed59e1d1-3b0db69ee38mr32308a91.14.1793907397392;
        Thu, 05 Nov 2026 11:36:37 -0800 (PST)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.124.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7c42932sm499331a91.6.2026.11.05.11.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:36:37 -0800 (PST)
From: Yuansheng Yang <0xbeac@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] KEYS: Protect pkey method checks against type removal
Date: Fri,  6 Nov 2026 03:36:31 +0800
Message-ID: <20261105193632.34363-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <auy1ANMSKTXZb8GE@kernel.org>
References: <auy1ANMSKTXZb8GE@kernel.org>
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

In-tree, turris-signing-key provides such methods.

Remove the key->type->asym_query check from keyctl_pkey_params_get(): it
runs without key->sem, so key_gc_keytype() can retype the key right after
it.  Instead, make keyctl_pkey_params_get_2(), keyctl_pkey_query(),
keyctl_pkey_e_d_s() and keyctl_pkey_verify() each take key->sem for
reading, check the key->type->asym_* method they are about to call, call
it and release key->sem.  As key_gc_keytype() takes key->sem for writing
before it retypes the key, key->type cannot change between the check and
the call.  Drop the asym_eds_op and asym_verify_signature checks that
keyctl_pkey_e_d_s() and keyctl_pkey_verify() did before memdup_user() for
the same reason; -EOPNOTSUPP is now returned from under key->sem.
memdup_user(), kmalloc() and copy_to_user() stay outside key->sem, as in
__keyctl_read_key().

This problem was recently fixed for keyctl_read_key() by 925c84e3cc21
("keys: Protect the read method check against type removal") and for
key_update() by aef3a8a4f988 ("KEYS: Protect the update method check
against type removal").

Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
Cc: stable@vger.kernel.org
Signed-off-by: Yuansheng Yang <0xbeac@gmail.com>
---
Changes in v4:
- Rewrite the commit message: describe what changes in
  keyctl_pkey_params_get(), keyctl_pkey_params_get_2() and the three
  keyctl handlers and why, and cite the read/update fixes by subject.
- Rename the out_unlock labels to out_up_key_sem.
- Use out_up_key_sem / out_free_in / out_free_params in
  keyctl_pkey_verify(); leave the other functions' existing labels alone.
- No functional change relative to v3.

v3: https://lore.kernel.org/all/9d47e202bd11857b3555e6b95694b3c3a4f2460b.1793852399.git.0xbeac@gmail.com/
v2: https://lore.kernel.org/all/20261104021414.50696-1-0xbeac@gmail.com/

 security/keys/keyctl_pkey.c | 58 +++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 15b6bf6399..3e3253330c 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -100,9 +100,6 @@ static int keyctl_pkey_params_get(key_serial_t id,
 		return PTR_ERR(key_ref);
 	params->key = key_ref_to_ptr(key_ref);
 
-	if (!params->key->type->asym_query)
-		return -EOPNOTSUPP;
-
 	return 0;
 }
 
@@ -129,7 +126,16 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 	if (ret < 0)
 		return ret;
 
+	down_read(&params->key->sem);
+	if (!params->key->type->asym_query) {
+		ret = -EOPNOTSUPP;
+		goto out_up_key_sem;
+	}
+
 	ret = params->key->type->asym_query(params, &info);
+
+out_up_key_sem:
+	up_read(&params->key->sem);
 	if (ret < 0)
 		return ret;
 
@@ -185,7 +191,16 @@ long keyctl_pkey_query(key_serial_t id,
 	if (ret < 0)
 		goto error;
 
+	down_read(&params.key->sem);
+	if (!params.key->type->asym_query) {
+		ret = -EOPNOTSUPP;
+		goto out_up_key_sem;
+	}
+
 	ret = params.key->type->asym_query(&params, &res);
+
+out_up_key_sem:
+	up_read(&params.key->sem);
 	if (ret < 0)
 		goto error;
 
@@ -230,10 +245,6 @@ long keyctl_pkey_e_d_s(int op,
 	if (ret < 0)
 		goto error_params;
 
-	ret = -EOPNOTSUPP;
-	if (!params.key->type->asym_eds_op)
-		goto error_params;
-
 	switch (op) {
 	case KEYCTL_PKEY_ENCRYPT:
 		params.op = kernel_pkey_encrypt;
@@ -260,7 +271,16 @@ long keyctl_pkey_e_d_s(int op,
 	if (!out)
 		goto error_in;
 
+	down_read(&params.key->sem);
+	if (!params.key->type->asym_eds_op) {
+		ret = -EOPNOTSUPP;
+		goto out_up_key_sem;
+	}
+
 	ret = params.key->type->asym_eds_op(&params, in, out);
+
+out_up_key_sem:
+	up_read(&params.key->sem);
 	if (ret < 0)
 		goto error_out;
 
@@ -305,31 +325,37 @@ long keyctl_pkey_verify(const struct keyctl_pkey_params __user *_params,
 	ret = keyctl_pkey_params_get_2(_params, _info, KEYCTL_PKEY_VERIFY,
 				       &params);
 	if (ret < 0)
-		goto error_params;
-
-	ret = -EOPNOTSUPP;
-	if (!params.key->type->asym_verify_signature)
-		goto error_params;
+		goto out_free_params;
 
 	in = memdup_user(_in, params.in_len);
 	if (IS_ERR(in)) {
 		ret = PTR_ERR(in);
-		goto error_params;
+		goto out_free_params;
 	}
 
 	in2 = memdup_user(_in2, params.in2_len);
 	if (IS_ERR(in2)) {
 		ret = PTR_ERR(in2);
-		goto error_in;
+		goto out_free_in;
 	}
 
 	params.op = kernel_pkey_verify;
+	down_read(&params.key->sem);
+	if (!params.key->type->asym_verify_signature) {
+		ret = -EOPNOTSUPP;
+		goto out_up_key_sem;
+	}
+
 	ret = params.key->type->asym_verify_signature(&params, in, in2);
 
+out_up_key_sem:
+	up_read(&params.key->sem);
 	kfree(in2);
-error_in:
+
+out_free_in:
 	kfree(in);
-error_params:
+
+out_free_params:
 	keyctl_pkey_params_free(&params);
 	return ret;
 }
-- 
2.43.0

