Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793853508;
	b=QOJrc6xmzjt2FVgpvweK9G38+OX5nHX29YSaqULc9VstqoWxXmHzsUHKTlfmJCS1/r/C
	 MMaadhdk18JeS6lUo7sGEQoRCcw9hw3pjyPNh7UkBtSec3zAiS30Va8Te6KqrkWl3kOWn
	 vfajQlNhsLP7PfQozOl1tJp8SrGUCJ6ksl3sClGhOTmW6dpr5AF/PUWa7kwAsQUs61zNK
	 5LlhaQUj9L3MeHFCdr671/s3V9tlSS/V2q8R9eoDo7Ifrhur+CT0sG6SrSC2L+3NsLiT+
	 pEolexhnPSBcQNt2A5fu+K1Qy15uBompHFHrVYz4KsXozh6tk1dS615BR6mtvjBNdAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793853508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=48V+VsvijFUjy1EizLIiYaKYQ847uo8vE4JKf+yBXAY=;
	b=quqtRLgMX/OsiNS6QtqNLQvbVzwcZFNr4bnP7pr6avdxREetufspcK2X0HjWF+rOim8j
	 Z1JfJm981b/G1Hl/7vgviO6HL89dQDf2Lnd+02n+bwzgC9zfUQijeZP74oWJgxoSnWfDC
	 IpJTyyxzaeVSj9OtCLxpkRobORkZ6UJEr09oAWc6O+3kT0BihhecUmge2Uu5wt4DF6Ooe
	 hzHQ/MiTpiELS7OZ4hMIoEF5vi7oU0q5Pdqd0Y1OtOtvafPwNG2vtEYqZRwNBI+Y2+vpr
	 bHqM8m6ezt7f9kNK7E6O8M3FmTjHrY3iM7h6f4lQtkUt+JEI6wfidwfwIhn1tadC0qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xzTtXARL;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B21606A32E
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 04:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16B21606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xzTtXARL
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso681967a12.2
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 20:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793853507; x=1794458307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=48V+VsvijFUjy1EizLIiYaKYQ847uo8vE4JKf+yBXAY=;
        b=xzTtXARLYN2RESb9u7JaWRcCOM9339Cll6gqB99I1UayC7NyCgiTKuUW6GDmIAHgIZ
         b6+fS+ZVhOYVrbQ3NeDTwCyKGGRvQhCILna9fWmgbYCFSwoTPEwlm6Wiqx36ieXo45yX
         N9Ng7JDJ4qTizFRVnDg8+iSMuL+HfGBifN3F5RTplq/Y8XuXNl7vNHkQamYdiDVqUvfA
         Ds4cos1dhugMquQGnqYY96Czi3UXL+FFaS67DA5bkNppMCgQmlacH+VrAk64Qqk8S3Dv
         d6OwVYGaRiouE19l+vWv2kPfHUe7ykXVpe9OelXFuLwTQqHq9/rVCZ4lqYAKhzRsTauc
         lQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793853507; x=1794458307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=48V+VsvijFUjy1EizLIiYaKYQ847uo8vE4JKf+yBXAY=;
        b=2w2heWEHem4yf10wwfC2gYe4niXnzxeRtDXqDYX6eqPf5CWZEk/pO6a6MhPYbrQzHy
         d58t3znbPT2IGayyhOU9QNn5doHvKY26DdbOXciii3hG/3WQvRzK5e4SujLy4P3gD6yU
         ZHPlNbZCLtOSTgKuyx4Y2ZruPRuYCGay15vyilIj3zIlbqwbVp3qDQNmtMwprA8Kaigg
         nBTpln/t0lFxAxKKAibks9IEasLvaegG7RH6NoyfoxqLDr+ab7enMP0y1BImPnXH+4SX
         yzrV8GUh8XClU0VWvpBpAwt67MTPeKAwLtuS9PQRbwePn8Shj46Q7uAXcMe0roHg/DO6
         anyg==
X-Forwarded-Encrypted: i=1; AKwUvBwlOzM844MuJnXWBBjPYOLrDaLuiN2PYxkhOtgED52m//SGa1x0KDf4Mdi4la7k/fhEfzeb6vyKBHpxHFnztjCDDDcJcag=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QmxJQ4BInr/XCF8nyRwDvdIGS+W+kMFLr+jqGRFRRfWim2Uhx
	bNn7iX5kjGwuwTSc6mcR264+CcisnOyah+nqdw8fHvSSGxkVbqBLxaSS
X-Gm-Gg: AYBFou14P1M0WTWAF96wzAurFRa7XM1+ZEbJPqD3Uowbd/+QctQEQf7AZOVPTzr8Kqd
	2xQA+AUD77dPOJCuOJMceTBL9lzP/QmyGQNjMgfGnE70pyPfgTRLWhmxwXK86OI2AVBDNsD3Fdb
	sfkFN0GLVdZYHMaxqLi6pah3I1q878TBqGfnnMFlXPxarlVyhsdJVC2SrYm8eHSC6xOato26pP/
	7rmSj2dr1Lr0X5JtcsYrlQyRMbOJZ3brsO7vWSeUEgdv7AlHd7XSQ1hGumwGuNap5e70he79UkE
	arvEqzou9ynegSiLt1uCoYU6gLr5rk2L2byivZM/n1U/dje8ZXq+1iVKePDXRT2+JZz9ERoDcBF
	QpfTQFfILQ2xqPisg1igXDMHEYziWN5I0O9l0h6q3/EQJwQFbH5QElBFvUyWWoADhXLhpLSZp/M
	sKy5LOfcSlEtIf2QuuYF0lVOnp7S+DgB5y1q21VmIINECaJbEyqmeUtP8mRaUZzWaLJvF6DHc1g
	2aD05UhBoPat8ME0mA0Mwk4RUMQk13cjBQuv/PezRKGfjmZwl12w777E2Ec5Gi5DDHLu4phF5Pd
	VSxH9vggMzk6i4iKFYmioom2Rn4dXZtS4/weoRZ6zBClzTo=
X-Received: by 2002:a17:90b:4c08:b0:3a8:de1:db07 with SMTP id 98e67ed59e1d1-3ae8957d253mr16261437a91.5.1793853507248;
        Wed, 04 Nov 2026 20:38:27 -0800 (PST)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b3280378sm1635751a91.12.2026.11.04.20.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:38:26 -0800 (PST)
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
Subject: [PATCH v3] KEYS: Protect pkey method checks against type removal
Date: Thu,  5 Nov 2026 12:38:21 +0800
Message-ID: <9d47e202bd11857b3555e6b95694b3c3a4f2460b.1793852399.git.0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <auv35Ljgz1OA1zUZ@kernel.org>
References: <auv35Ljgz1OA1zUZ@kernel.org>
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

Hold key->sem for reading around the method check and the matching call,
so that the type cannot be retired in between.  Each keyctl handler takes
and releases the lock itself; the semaphore is not passed out through the
parameter block.  User buffers are copied outside the critical section.

This is the same type-removal problem recently fixed for the read
(925c84e3cc21) and update (aef3a8a4f988) methods.

Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
Cc: stable@vger.kernel.org
Signed-off-by: Yuansheng Yang <0xbeac@gmail.com>
---
Changes in v3:
- Keep the switch, allocations and existing error handling in place.
- Use one unlock point per method check/call pair.
- Set -EOPNOTSUPP inside the failed checks; add blank lines before labels.
- Use my real name in the author and sign-off fields.

v2: https://lore.kernel.org/all/20261104021414.50696-1-0xbeac@gmail.com/

 security/keys/keyctl_pkey.c | 47 ++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 15b6bf6399..40475817dd 100644
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
+		goto out_unlock;
+	}
+
 	ret = params->key->type->asym_query(params, &info);
+
+out_unlock:
+	up_read(&params->key->sem);
 	if (ret < 0)
 		return ret;
 
@@ -185,7 +191,16 @@ long keyctl_pkey_query(key_serial_t id,
 	if (ret < 0)
 		goto error;
 
+	down_read(&params.key->sem);
+	if (!params.key->type->asym_query) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
 	ret = params.key->type->asym_query(&params, &res);
+
+out_unlock:
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
+		goto out_unlock;
+	}
+
 	ret = params.key->type->asym_eds_op(&params, in, out);
+
+out_unlock:
+	up_read(&params.key->sem);
 	if (ret < 0)
 		goto error_out;
 
@@ -307,10 +327,6 @@ long keyctl_pkey_verify(const struct keyctl_pkey_params __user *_params,
 	if (ret < 0)
 		goto error_params;
 
-	ret = -EOPNOTSUPP;
-	if (!params.key->type->asym_verify_signature)
-		goto error_params;
-
 	in = memdup_user(_in, params.in_len);
 	if (IS_ERR(in)) {
 		ret = PTR_ERR(in);
@@ -324,8 +340,17 @@ long keyctl_pkey_verify(const struct keyctl_pkey_params __user *_params,
 	}
 
 	params.op = kernel_pkey_verify;
+	down_read(&params.key->sem);
+	if (!params.key->type->asym_verify_signature) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
 	ret = params.key->type->asym_verify_signature(&params, in, in2);
 
+out_unlock:
+	up_read(&params.key->sem);
+
 	kfree(in2);
 error_in:
 	kfree(in);
-- 
2.43.0

