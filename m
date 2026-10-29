Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290038;
	b=smE/KgSevsstzX6oFr6YcuVvdBaaWfEEanbz7L7WlUhs/7pDX286SE0G4uFMC4obu+Qa
	 YOpd7CyBy+Hbl3EPYatqAMN6Qlc3ko3hhecM3VjYOxXrr5gKuMU7x8Oy71ZOHeNjrPNPe
	 xL2AQ9xrkXejftBYpkrwIKkrrHjdXkqKpra1Vp7vDR4DgvWKYaxSbKa/vlmwvUtlgHwLJ
	 DPmvBpcHaVbZClqODi0ogAoe1Mg7FXFsZDo0EC1tu3WPAwLczr8H/r+5Hu5hZ2AV9Mhed
	 uS4yNw+MgUrZzPneEv5RBJzOccCWV6criHtMkErwm6Z3DS6Qz/72QT1H2dJE/Nt+TCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6phBB/LhTBBlHeyPPTy42KiMPUWx2B/+SfXHzMCVM8g=;
	b=GYCAEShmUpl+jFmmYF7a9adZxaH7TByS3GjqWqM2MnysCTFU1PAtZpXHjc0lcvTCjpKg
	 +GgRheKRonABfrX1GiECUtNxVBzYw7/jIh+bFIQxQv1e4d0k9pTShINuk8782SWEWgIeN
	 ho54wU+IkyAfs/1hSpKQlXSaJG57LrfxX6aWNujKNQBOusjYy2jvgwAFJgDD7U2QhR+PQ
	 +SCGxpzk06vtQVqmNpODFGyhhalHsog5IIHYTKMZaLS8q66mY5uc2FYu9N0Jp2pY5ey4Z
	 1hU4jP1auzuve7LfOo6xADhBxeapHZdWqvGL/SgUy6AB7IqA63NCQ8IrPmr4hnQ93xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qz0J8qL1;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CF2606A31F
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 16:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50CF2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qz0J8qL1
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ccca948203aso1062757a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 09:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793290038; x=1793894838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6phBB/LhTBBlHeyPPTy42KiMPUWx2B/+SfXHzMCVM8g=;
        b=Qz0J8qL1HNBLnCibb7ZytadKUpGO+CWFl2dTuBChRwrAbhnR8/axv/QGQFyFk14YiS
         xq0ed0Ksbn6jt1KiUQQKJyUI3+hx2ukiEwkjFvjifU2d9HITWiBIrHrkG5ATB0Ci8gDJ
         q1MKz/qygmbP34AxWKSyLMngopUWjiJN7aNkWserV+t2XfZaJW1hCJ4GD3OyKJQTEPVG
         fN4LBtAVfmbi18qM4/kE4ODRCZzU86jsu3SFt1wTl9Oe/cpJWGEW7k9ouPxxrNltheJj
         hYzGhiUhPqkS11aM2CLLLUXZg+J7u1kmPYTk7fqnUzTrbmjmWKtGgRfHx7qAbYLwI2Hi
         cPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793290038; x=1793894838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6phBB/LhTBBlHeyPPTy42KiMPUWx2B/+SfXHzMCVM8g=;
        b=cClFjvDoJzWB1uFK9ezHliMaVf09wMeV1wu7PiwXf6mqIM+ps0B5Gm0D0os5Ouvfhc
         Vxz0MJxtXpdglq3AMYOBO2IAWELEvhyo9AHnruDQwfhueDVeqq2Lux2mszgkCYPDZQar
         0Y1LDadWv1q+c8o0K9ZlE7pfkbKtvUjXWtKfTfdTn1TepTmjhZbKq1hUa154nAt1CL+2
         W4K4tiBNBQQmIP1FrbcvEPgr7MjCWzaKoDAhOvAoVw0QgW5o1No3JNRY5DO/0yR1AMKk
         OOdPM6/ziUjvP0zehIn5w501X6p1BMwBmToB0EMAcLUN4Tn+Tp8ppiJ0jXIiwUHv35GY
         vncQ==
X-Forwarded-Encrypted: i=1; AKwUvBzmWK6ygLc3IO7j9MFY065+2Fi8niXr5Dm05iA1MzRsMeUyoXyuifQkSN2DFEISlz+uXThnLZHy9X63+HcOqSapdgYlXyI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQTDjHpOFPwo7ZtmFGLIT6vBDEIoOVUKW9W+PZRoYqwp2putTv
	EqNI3Ih7ZSwsvqyFUadw3AWkoVqP3zdOtGqNcNMuQDEzuUxcj2SNTdGA
X-Gm-Gg: AYBFou2p2zmHSIPjgggVhrcTR0n+YuttOrl48QzgdSbpkqW85r5b/K9cGYEHxxHZuOX
	t2N490TFVcSLVxZCWbfkxZpXQuJTwfqG+XxIsRHGaPJEfWSkoT5afFPJM4vWkolmOchtCjj2wSK
	xoFRbnxpEQLQ2yhG78IS3o8/hWhobBvIPZpWIWCrWmta9+o71GvKlc8ma9cHRl14LwCgGlogoFI
	7lHzLSxdjdpdP6+9J+nlZQjn9mR2rEfLxQt7sGccxiRbKYN43+IY1dLhr1PiTfUp9nLueDZXptC
	Z/3VSWr1t45cdXWvkpixEaMl1Sv9RlP+uo5HSgWXwNJpb4c9VHdnNfajAk4bBRv/W8vZzwTEhaU
	Lsl8NNGbILTvLXcbbngu9afc8Z42wPi2Tbj8nvP3df/laEUye/oTGJZGPHgGyYBrUHfatmZhAbt
	2BLYnVdh8hAbeW+pUU9tRZLDfSgzf5cJ73HmCbcjqopTx096eEyVN0k7mrHqpkJ5slUw0O92hQT
	beDuzvoUwReyxgIrtKVcKXTZ/gia7i6SQLdPoqo2ovwU+sqwp9Nx6URGHRFUv8+VvF51Mvt202E
	CllNYO6H9GgqlOVekj88cmOG
X-Received: by 2002:a17:90b:57e3:b0:3ab:413:49bc with SMTP id 98e67ed59e1d1-3ae58123796mr4489353a91.37.1793290035781;
        Thu, 29 Oct 2026 09:07:15 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845432e4sm279427a91.3.2026.10.29.09.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:07:15 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2] keys: Protect the update method check against type removal
Date: Fri, 30 Oct 2026 00:07:08 +0800
Message-Id: <pm-keys-update-type-removal-20261029-v7-e79d113bcff91e140d04@gmail.com>
X-Mailer: git-send-email 2.34.1
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

key_update() reads key->type->update, ->def_datalen and ->preparse
before it takes key->sem. A reference on the key does not pin the
module that provides its type, so KEYCTL_UPDATE can race with the
unloading of that module, for example dns_resolver:

  KEYCTL_UPDATE task                  Module unload and key GC
  ------------------                  ------------------------
  keyctl_update_key()
    key_update()
      key_permission()
      load key->type
                                      exit_dns_resolver()
                                        unregister_key_type()
                                          GC: down_write(&key->sem)
                                          GC: retype to key_type_dead
                                          GC: up_write(&key->sem)
                                        unregister_key_type() returns
                                      free_module()
      read saved type's update member

The final access reads freed module memory. With the updating task
held after the key->type load, it faults:

  BUG: unable to handle page fault for address: fffffbfff804107f
  #PF: supervisor read access in kernel mode
  RIP: 0010:key_update+0x12d/0x550
  Call Trace:
   keyctl_update_key+0x6b/0x110
   __do_sys_keyctl+0x21d/0x4f0

This is the same problem that commit 925c84e3cc21 ("keys: Protect the
read method check against type removal") fixed for KEYCTL_READ.

For dns_resolver, which has no update method, key_update() returns at
the check, so doing the check with key->sem held would be enough. A
key type that is built as a module and has an update method, like
encrypted or trusted, gets past the check. If its module is unloaded
after the check and before key_update() takes key->sem, the GC has
already moved the key to key_type_dead, and key_update() calls the
update method of key_type_dead, which is NULL. So key->sem has to stay
held from the check until the update is done.

Take key->sem before the first access to key->type and hold it until
the preparsed payload has been freed. Once a key exists, only the GC
changes key->type, and it does so with key->sem held for writing.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Changes in v2:
- Refine the commit message.
- Remove the code comment in key_update().
- Drop the Assisted-by tag.

Link to v1: https://lore.kernel.org/r/pm-keys-update-type-removal-20261029-v6-3d92b2f9693854230a02@gmail.com

 security/keys/key.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index e88548f1a704..994a34a80c29 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -1101,9 +1101,12 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
 	if (ret < 0)
 		return ret;
 
+	down_write(&key->sem);
+
 	/* attempt to update it if supported */
+	ret = -EOPNOTSUPP;
 	if (!key->type->update)
-		return -EOPNOTSUPP;
+		goto out;
 
 	memset(&prep, 0, sizeof(prep));
 	prep.data = payload;
@@ -1116,8 +1119,6 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
 			goto error;
 	}
 
-	down_write(&key->sem);
-
 	ret = key->type->update(key, &prep);
 	if (ret == 0) {
 		/* Updating a negative key positively instantiates it */
@@ -1125,11 +1126,11 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
 		notify_key(key, NOTIFY_KEY_UPDATED, 0);
 	}
 
-	up_write(&key->sem);
-
 error:
 	if (key->type->preparse)
 		key->type->free_preparse(&prep);
+out:
+	up_write(&key->sem);
 	return ret;
 }
 EXPORT_SYMBOL(key_update);

base-commit: 9a2a4c51dccc3168c3dc949fcbaa360a478fa228
-- 
2.43.0

