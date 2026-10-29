Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275096;
	b=xYVRzTqJeHkPwbOyUfxaSiMEZQAN4x+xeIUIgTD/elAFU08h/aTxnmg4qMtIwyxWidPg
	 hxz2ez9ZXn7u4BgyVKm5jJL0lQe1NYrH9dxsJNhW2v0Bqt4PQcdNTjUPNkg8rqUKAgE/X
	 XR3H8yMnxblY1WvhlWEcP8DKZxIDTRs8EawBEVIS/yyL5ROfX8/1YjPpgePV/taucjhx/
	 FS3mC8nn0P+B78tMGPOP4j07PhFZzWgM3vqv+fPhhfuByZRmknFVX0G3RKst94T64wnhP
	 I7D194keG1K2CyPYANjXh+vkyHDlui3oA7+Xk1eS39pgB8m+aJ5wdgzuM/JMqsNfwvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VEJxuw7v5WS1JXklJNxWI3IzTNd4l+O1vemEGC9NlII=;
	b=4NlpcDEceQy9wZqml1643+Aa7v7/9KZO6K2CSGZm8YjbTTV3+PbUBtXcG+ze9lIsQ7nF
	 RNuwdBAP6GBE69rF160broXg6IpcvnBbVLjyBsRtM/pT0e+WlGWzcq0aTtInBOHbepOSf
	 sk3Kz0a/9G7WRKpP6Rcs0/tqqeacobD8VdJJSw+NewfpImM6Ll13K0sVO62b9wdgAN+YD
	 /0qQP7KaU5fgUcvDlXO5La/uPZ7Du9E3qR+8fYNf6nCj+Bigr7/ss1tPKn2/P2hASEPIM
	 TL85RlKYIVZPh+aLC+LHQIqU9d7jEIdb4ou8kCWlDGFG7hhXQBgHOI8RqFqbNgqmhtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZxOySYw6;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E220606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 11:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E220606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZxOySYw6
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso1004935a91.1
        for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 04:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793275095; x=1793879895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VEJxuw7v5WS1JXklJNxWI3IzTNd4l+O1vemEGC9NlII=;
        b=ZxOySYw6NYmINxrUznhCRkoVM326b1kMuU0Pzv421sKfplb9XFqTFdPUjFvnQHH07z
         dU1dUS6CghARvfNo0xujIQxq0UtnRQXho6lVU2aBzH1dV6rzrbMl9qn+62l9uSeWGR/Q
         /n3DmY+eG/tVIP6NWe7zrqjdPr7Pd76YXeNf5eXZbEqjOJ2PUDQfZEl+Ikp76A9KNXfP
         QsrWwasvhfhgUFBKNVv9G9xmiIoEyYpocrWbBPlkb8K//1xwGGxZzz9aLI8m4SKuQcNK
         uF3tVlKFnZbXjuKX6XWmBEdXdDVFdsdYtBZHRWKe4Eb+43avQTJXnvK01TvDRJgQjdgA
         ES/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793275095; x=1793879895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VEJxuw7v5WS1JXklJNxWI3IzTNd4l+O1vemEGC9NlII=;
        b=H8UWAzX9E33ZWSUoI9w3YJXFdrjFkDmMq3lIYNxz90hT5OMMZMnSwwXIXgXAWab1UC
         3jmoHsBbzVtzJztTlIIWTY4GjS2GRMHl4p13NfoF1aaZy5x1F3I23/+mB9UGmryZL+T2
         T8r04nP3Y924gUSl86oFUhZB8cTRjp4dGvrgJUOOUxog5+5DMy372bGLuDhOKM9MbDfB
         qMusTq0lYo4txRbdmDD34B8TuvSzJblilUx01A7c/DXM9G9fa9g5ksN9xB8WxnqXh20l
         Y2rh1ZThuniQ5og3qnLqKohsgdBqBNTSdTaXmDWBF26c0wpc/wqqJn/S2IWDWq17Brrd
         mQbA==
X-Forwarded-Encrypted: i=1; AKwUvBwJ5dok7hPfhFplEVywXvVpl8QMiJYFwaf0luCjtIgJTlPNT1Jaix990Zq2pAg2hczk2BKAjSA+xn97K+QItode2LSUobQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJs7F/jDBP4hYpB0NW6+8SaBJLi8p0EUKVC1/A2SD+wPvau9zJt
	aEWQT87lK7Tf4qIenfhAo3qgufeXulZULu8/iJALUw6/DuBb7AuYfNzh
X-Gm-Gg: AYBFou0t7qwD2ZhoiKVhCUjdtQ91rQfWIiK/RVp20ZEvGVDzcvQTWjaUs8leQnoYm7v
	hjHpoBvWRUbzcEczh0YgY/huriBaVKSj7ID+1EcJ9NJCu5Uj0tBemQa/ISRbECrlv0ICOPIA2zZ
	a38tarfP96JieVtK5ZnfGvrKBrUYixBI6lJDZ8aehWuXIAerlPZLwctlZIa1R5cHMGKt8VMicrw
	44I8PFnecBVppedULqQ6iLRPcrw+7XTVNxJh1RwBRXLJqRDZQjE+QS082Gh8c1xPm0kuS/qJCvl
	eIWm9cMW4TNsBOtKetZ54MqpqsuRuwrxiOBYbYYDxgd37HlSCRdxzNWD6I7nPkdbCDkIjEs6cnX
	bgLyKc8YySEoLS4YJA4DXkSuFOjn9h1kYXUa4FSc7/nHDBCiFep2MBgJX9S6yio4rhwl9aUSsvi
	H+4+oT5xCYhRrzjhU7ZUWYLD3Y8cJ0iLgWTZVjuvBo4aahmv83wjHyPHrLzaddZpr0Iwtda5PwA
	VMU4sxfzDqCI+rJm0uTwqeDQXEiv64RTxnsHm8SpLSfExVMCKMFNmf2W3oAL0PSt4lNqNm7q7EZ
	cxAJXrAozpYHiQwOjc3k2vmi
X-Received: by 2002:a17:90b:2710:b0:3ab:ab5a:ef06 with SMTP id 98e67ed59e1d1-3ae57f637cemr3901099a91.12.1793275094915;
        Thu, 29 Oct 2026 04:58:14 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8401casm4137834a91.11.2026.10.29.04.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 04:58:14 -0700 (PDT)
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
Subject: [PATCH] keys: Protect the update method check against type removal
Date: Thu, 29 Oct 2026 19:58:06 +0800
Message-Id: <pm-keys-update-type-removal-20261029-v6-3d92b2f9693854230a02@gmail.com>
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

The encrypted and trusted types can be built as modules and have an
update method. For them there is a second window: the GC can move the
key to key_type_dead after the method check and before key_update()
takes key->sem. key_update() then calls the NULL update method of
key_type_dead.

Take key->sem before the first access to key->type and hold it until
the preparsed payload has been freed. Once a key exists, only the GC
changes key->type, and it does so with key->sem held for writing.
unregister_key_type() does not return before the GC has done that for
every key of the type that is still in use, so the type stays valid
for the whole update. If the GC has already moved the key to
key_type_dead when key_update() gets key->sem, there is no update
method and key_update() returns -EOPNOTSUPP.

Assisted-by: LLM
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 security/keys/key.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index e88548f1a704..bac2333089fc 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -1101,9 +1101,13 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
 	if (ret < 0)
 		return ret;
 
+	/* the GC cannot change the key's type while we hold the semaphore */
+	down_write(&key->sem);
+
 	/* attempt to update it if supported */
+	ret = -EOPNOTSUPP;
 	if (!key->type->update)
-		return -EOPNOTSUPP;
+		goto out;
 
 	memset(&prep, 0, sizeof(prep));
 	prep.data = payload;
@@ -1116,8 +1120,6 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
 			goto error;
 	}
 
-	down_write(&key->sem);
-
 	ret = key->type->update(key, &prep);
 	if (ret == 0) {
 		/* Updating a negative key positively instantiates it */
@@ -1125,11 +1127,11 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
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

