Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793438804;
	b=Qxc+O3DXhFy65+FFqT13HCox/2XYdQEsJBwjFPemyvaeYXuv8UCdu6ahYHXF/Hieh3vs
	 CzsDRrjZDv2QI1cUOkOtzWyi2dcTzEXKu8BaRdYqd4cv/mQRnf0Uh+QF1gu2Hcmcib9yX
	 bHmcCOd65Ty+v958p2pHAqgrOdj0VL+2Lwcka78kvfbCd17gxWlt6vlvYZap0APDjGWKA
	 9SuoqAHwYKcksJyMSsnNLMtiw5XPoryYYjf+Nfzy9P+ef0xn9CQ0tEckuPHkY4O9ga6h7
	 1Lrj51fI3oZXXGLTCt94f2e7+8KTG1eHziHCCtB+Mao6aRFoiS+3bKoBSgKLS5Dhzyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793438804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lvUARKSFlBFo1wd0FtQ9SAcYovSttrZG7U4+Cm7iAqg=;
	b=lZal5x/Pyl9uXajUoMuzD7sfe463c7T6tK02r2K6MQZZo4VACX6RvsjX/kinnSy/Kxgq
	 CcDGSBmAklhRbzFQxpKJnI7xOnjyFEC7XfB6gHp45lInLgVW/JLF47s0A3akr+t6JykdM
	 n6GdYlEMVWcYjojwMBrTQ21y3VIYXR8bjS0fF3AfIoeRG5t0cSOCoYMyOwbWm07bTn0do
	 fVRwg2oZMki+LWrVxNeZWZJuKFzeYassntNBBefZ77vhX162zbOa1wYbjI7AFkCX8459K
	 C8Rg1bJU9izJBkgl2tCAo5NDbWoxBNlGCv7DGNxkZU5AG/gna71TsJrum0OwTV5ED1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c7UqJmIB;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04702606A31F
	for <linux-security-module@vger.kernel.org>; Sat, 31 Oct 2026 09:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04702606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c7UqJmIB
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso533286a12.2
        for <linux-security-module@vger.kernel.org>; Sat, 31 Oct 2026 02:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793438803; x=1794043603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lvUARKSFlBFo1wd0FtQ9SAcYovSttrZG7U4+Cm7iAqg=;
        b=c7UqJmIB3XfO5cXQf7NNZEei/zDfkbCL7tJu8wVEmOmKHpB3zzv2a3oVUG3wOOqbMo
         mlWMk5eu3YBFr3n5o3iD7EUzZ8WPZnIMUIv7MfYgQCw1vMSZ3+7OiAQm5xcxL7rBEfns
         1fPR0hpQ4aMt4gcx3QQi7tZaCQRbgVKg6r5cZtrSDfZpsDaKhWUvaFMlWCUedG/nHmlO
         o2h/P9yaqByNTXYRLW1a906oXI1DDR1m2EY6hzubeTwkH79Mc1WKih1L1BBIhwhrj7hb
         pgOSJfDYT8snbBJyidxMDni17AIczscQd3OOc8/E3aj4IiUlDXcC1fAjfLO5O5a21ZVJ
         qfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793438803; x=1794043603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lvUARKSFlBFo1wd0FtQ9SAcYovSttrZG7U4+Cm7iAqg=;
        b=OwE7Ru8EPnC6MnfFURT1R8FJhses6i1RUYOpeoue0obeD3P5WFQzSVin2JKPV1CgLZ
         PyysVD2iJaaL0FZOMHNJzUVQrxB4J2Qe75G+0TQ9JyXUEQqowIIzwcniTt2nAzazX/SN
         ikuIMqdIOHn4Tyy/lENAcmatb0EwKp3M1zFyaBTlAnmZl+mX8rKt0ksfs0ZqwLY9XSrA
         Ctllt11OCIPbd87+2UAWUMGGRkTFZm1QYF5JANJ1B0olTuQ9/aH/O9/7lMwZWQbVK8pi
         5dYS1jr7OhULr9IZ1zNma+cQpvPq4R4frFWtLTtm9F2Qz7P1GE0jhpxab7XULsJ6j9Wv
         E5Lg==
X-Forwarded-Encrypted: i=1; AKwUvBz7LZmsN1FsVHXupczUpFqfdvgHAJ+JP5yYzGSf+/sEN3hYrLdZ36QRLiNsUqEMl/WqXufvOGzSuOTdaeK1jhwSQPqmHR4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJx3feg4oKghAKzZKASSiJ9gWfyZKGmUkK2pjIOR5deZUHabDPL
	RwIXBTkOIMfbPxZdzN8vzjJMSIKpEkit250M+3HtwE2yoaK6kIlPej4s
X-Gm-Gg: AYBFou0g5kIz2PBk0aNuN8rju1q0Hbw6T89g2ucMFb3a8feSvcvs5ypxADlcbq/DwDp
	K5KexqrEqEci8nptCIkVI3kEiWMHtniRKwrgqCjhAn8f15JICmErhq5+hHt/rYgh+RFIvzrH4Zs
	7ulFgreXxsqdJA9N2XmE1B6fqmFKhMUN6qQj/eIe4y3WlOxaSlpkiyefIXtIkXI4nLjT6T1tHSw
	3vv1kTRMrg45kyqH83xEBSfYcIgWCTCqyFd7EFIn3lUytzUvyAbCApYtEGpoZXxitVhaFqXJpfD
	Nx2INcHPzM8zoIG+e75WpnGZVpSiM09sDcQ6xkFAwUjKDCd+NwJX2UYlKlCcUCue+IjM816/cgb
	WTATIIsXoM6ehFE14tHOdHnpaH8PaUHMqLbYv7dtmLtdti7AeTx78dvzUBi8S2ody+Zdy7FT0lT
	WHoefKI8/LeYLbK1tsQ0ZfLcOXGOK208sh/HV7UnM14LyPLwi5RQCTB5HYXjuQ3menjMDOm7ag3
	wItikPW7z7l7fBOBdzVLBO7Uwar/L780G6G5zJ5YMxhroIMi5icxNz44K9tDljWN3PaOMbZuB5u
	aGldFIT9FQKGEqVadjcPq5F7
X-Received: by 2002:a17:90b:2ccf:b0:3a4:6e84:e7d8 with SMTP id 98e67ed59e1d1-3ae897a8b33mr4034663a91.54.1793438803364;
        Sat, 31 Oct 2026 02:26:43 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87f5dcc3sm3622395a91.3.2026.10.31.02.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 02:26:43 -0700 (PDT)
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
Subject: [PATCH v3] keys: Protect the update method check against type removal
Date: Sat, 31 Oct 2026 17:26:36 +0800
Message-Id: <pm-keys-update-type-removal-20261029-v8-a0dbc48c588bf2b6a278@gmail.com>
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
Changes in v3:
- Rename the error label to out_free_preparse and add an empty line before
  the out label.

Changes in v2:
- Refine the commit message.
- Remove the code comment in key_update().
- Drop the Assisted-by tag.

Link to v1: https://lore.kernel.org/r/pm-keys-update-type-removal-20261029-v6-3d92b2f9693854230a02@gmail.com
Link to v2: https://lore.kernel.org/r/pm-keys-update-type-removal-20261029-v7-e79d113bcff91e140d04@gmail.com

 security/keys/key.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index e88548f1a704..3f1f0fc13710 100644
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
@@ -1113,11 +1116,9 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
 	if (key->type->preparse) {
 		ret = key->type->preparse(&prep);
 		if (ret < 0)
-			goto error;
+			goto out_free_preparse;
 	}
 
-	down_write(&key->sem);
-
 	ret = key->type->update(key, &prep);
 	if (ret == 0) {
 		/* Updating a negative key positively instantiates it */
@@ -1125,11 +1126,12 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
 		notify_key(key, NOTIFY_KEY_UPDATED, 0);
 	}
 
-	up_write(&key->sem);
-
-error:
+out_free_preparse:
 	if (key->type->preparse)
 		key->type->free_preparse(&prep);
+
+out:
+	up_write(&key->sem);
 	return ret;
 }
 EXPORT_SYMBOL(key_update);

base-commit: 9a2a4c51dccc3168c3dc949fcbaa360a478fa228
-- 
2.43.0

