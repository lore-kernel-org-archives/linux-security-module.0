Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D8649E5D3
	for <linux-security-module@vger.kernel.org>; Tue,  1 Sep 2026 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290276; cv=none; b=nllOnTDfNNxs9niAL2cPgHI1W+pHY3G/1Kyf9ASJwyumngUH8x3OpCZWgLAf7beY7R9jVuPtsuL8XgqAZXwRmwNwSdrC9PUqSfTu0VCkQnyWLHMwJeeE0khYpWP16pC9ODjuTg5VFwnjytOMEaKL+ac+Xk8pLYcJsky3HEXw21c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290276; c=relaxed/simple;
	bh=0jwdXdfk3syk+XHr1u1Yc/KPjSCjcGtTUI06brHURIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MQnnBvAX77yc5TbmJAYhq865ch4HGgIAlvp0Ca6RUg8vvGVnxHiAbUc2Zxvmpg73508RuC/oOMLGn14TG2HjXGcSYHaINCF9EPbyjy0o4ktmTu3f1dfU1NSyHrhsEGg8gw7SSMSir1cdXie3vistw17j0BauXKo96YsRTgjmr4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPoWDFHl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPoWDFHl"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so1353875e9.2
        for <linux-security-module@vger.kernel.org>; Tue, 01 Sep 2026 12:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788290273; x=1788895073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eg0ua7x7JoyJExrPZs1KOT80PnYes7wKoAQi5Fj6K9s=;
        b=kPoWDFHl0ZjIYcHyQbonMk1eAe9CAtG/v5+n6xWeCgRP79zBgxkMJWxIgeWte1XyFd
         ETQWqGWOb0o74JlPAXlADznAy0b4MZZYkktcho5U02igkpg+9nqcZ8gXmatLfK6B6TdB
         dR6ukOaxj+3ClDj80o7RNSPmgt9sly5bsDww8Ne5y32ch+j2TAxnczKBolNxMToii/wn
         2J3QDo6a5rseAIbflEmOxbkCpD7LYXQphExm60B2ITuh8swzTMyK4/D1z1RfXojop+28
         SuyJvAAN+FpCmmjYm0+5yvPu/lQ/r+OjpbsxAEjQfWG1guHQv0uWc2p/VZW32GW5K9RA
         TYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788290273; x=1788895073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eg0ua7x7JoyJExrPZs1KOT80PnYes7wKoAQi5Fj6K9s=;
        b=pIy4aDJjca1Tsp6Ygx8sVqTuyBv8SFvAjQKpbYhopoyDp/Z1MOdmCIQgLHc88Pt3nL
         xwaqn8IkFr3/BttKfunN6m79SVnMnASafax4AYIcr3eoS3cqN1Yo3LFI5WJHeMyNO6Vd
         4jSvzVXyoUffNmrWbKnVmUXcLychrHj0ZcVamDPxlekK+6pZ3LgPpEzNOX/9aMP8RdJw
         UFnE/UPDdiGhNsyehhUaiZEtNxvmKXU4nB8JPktThuRjs5/q71IK6TCkA3BT4CV/za/P
         7xqqk50IOdxDmUpT7IO00wMhoFjpS/BPO+INYc3Gc7nwLOSS/sy/CWHu4+DImfoFzxlA
         0fJQ==
X-Forwarded-Encrypted: i=1; AHgh+RqX8toIuw4eQ7v74xZqKn+exz+iQXIf1iFRq2aG21Uh+2V9k4fbZPmJojB02VAl0rWRhVP/UT3GHprCysP6ONbOBhe1LRg=@vger.kernel.org
X-Gm-Message-State: AFuF++kH+hhTMi1axh4Lj2yvfFPSm9+3EMOPAfVsSqv5lqqQx1XmvH4c
	pJIwzjfKwRB2g2NhWRpxa3k4prr61yxmcBhgk1upn9rrlLdQAqfrLx6g
X-Gm-Gg: AR+sD13PJZn7dypP53OylekgrLQbQ5VfHsj02rS/D4ZH2uKvIcxt8CaMcCMIotQoDvw
	Dh/kfRyGM+7OeTZ0hdaqB84TPbLO1TEQx0/Uj1I48XoF9YPlGsGAYT6FrwQtVWRSrBpDH8sZ7GZ
	a0VWj1SswvmraE1HXjD8uwQ08IUVrUFAFwV2ias6KaE1FG23W5NjaJBr5Pv8+VNIW6xAoEjlILe
	/u90uyEvurp+qpAu7yoaoY4IzuLhYYtcU1K6PdfRHYchzJbmXuBz8/QIUrKVSlmxrTp+p2cU/A0
	nev1xzkd+70DNcazNosEIEw80qePhBGTxlm5P26NReF1IsMTEEFabzfHGBvEuV87RtHt21AdVQd
	Ml+83tYQuLjhp8YZMibEDFWQRef9xPxFzP2hzleVHNrx47FqQJN3ohkOvoFVx1aY749GtLSNQC3
	1OMCYJL22RfQ4b/4E7ZmWQdMSWu782ILsZetnQT+CAzwEF0bky5VZz8fEXhl49GCnsHYWRmqGuf
	YFlxGNsdThrqCaPJZK9rtS60EQH47gVZaWDKt+UUaq4pVjrTEK5jTkOxvO7Jjpr7N88GAfjj6Gh
	tZYhxFr/WJD1wTQresw9ykA4LAe4PvdxsWOstV1exRcVpZiywEAzVgh9Yz9OUcgG2a0=
X-Received: by 2002:a05:600c:1389:b0:499:49f3:77b1 with SMTP id 5b1f17b1804b1-49b91c1713emr527192075e9.3.1788290272273;
        Tue, 01 Sep 2026 12:17:52 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a16a-7801-fd8c-4b37-36b4-e53a.310.pool.telefonica.de. [2a02:3100:a16a:7801:fd8c:4b37:36b4:e53a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce47885b1sm7189615e9.14.2026.09.01.12.17.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Sep 2026 12:17:51 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] keys: finalize persistent keyring timeout after link attempt
Date: Tue,  1 Sep 2026 21:17:43 +0200
Message-Id: <20260901191743.39210-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When no keyring exists for the requested UID, KEYCTL_GET_PERSISTENT
creates and registers one before linking it to the requested destination.
The configured timeout is set only after the destination link succeeds.

A destination restricted with KEYCTL_RESTRICT_KEYRING makes that link fail
with -EPERM. With persistent_keyring_expiry set to 60 seconds, /proc/keys
still reports the registered keyring's expiry as "perm".
The failed call therefore leaves a quota-exempt keyring in the namespace's
hidden register, where it may remain until namespace teardown.

Rename the write-locked helper to key_get_or_create_persistent() and return
the key reference through a result parameter. Return 0 when it creates a
keyring and 1 when the retry finds an existing one. Return a negative error
on failure. Another caller may create the keyring between the initial
read-locked lookup and the retry under the write lock.

Set the timeout after permission checking and linking. Do this on success,
or on failure if the call allocated the keyring. This leaves a new keyring
collectible after failure without starting its timeout while linking is
still in progress.

Fixes: f36f8c75ae2e ("KEYS: Add per-user_namespace registers for persistent per-UID kerberos caches")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Changes in v3:
- Return the persistent key reference through a result parameter (Jarkko).
- Keep lookup-or-create atomic inside the helper and use 0 for creation, 1
  for an existing keyring, and negative values only for errors.

v2: https://lore.kernel.org/r/20260901164323.35785-1-kmehltretter@gmail.com/

Changes in v2:
- Rewrite the commit message around the restricted-destination reproducer
  and trim the explanation (Jarkko).
- Track whether the persistent keyring was newly allocated and finalize its
  timeout after the permission and link checks. This preserves an existing
  keyring's timeout on failure and avoids expiry during linking.

Tested with QEMU 10.2.1 TCG on i386 and x86_64. With
persistent_keyring_expiry set to 60 seconds, KEYCTL_GET_PERSISTENT returned
-EPERM and /proc/keys reported "perm" before the fix and "1m" after it on
both architectures.

Also tested on x86_64 with persistent_keyring_expiry set to 1 second and
gc_delay set to 0. Successful calls reused the same serial, a newly created
keyring from a failed call expired, and a failed call using an existing
keyring left its timeout unchanged. A test-only two-second delay before
timeout finalization did not allow the keyring to be collected before link.

Two concurrent callers returned the same serial. A test-only 100 ms delay
after the read-locked miss forced both callers into the write-locked retry
and confirmed that the second caller took the 1 (existing) return path.

 security/keys/persistent.c | 55 ++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/security/keys/persistent.c b/security/keys/persistent.c
index 97af230aa4b22..e99929b81a1a2 100644
--- a/security/keys/persistent.c
+++ b/security/keys/persistent.c
@@ -33,25 +33,31 @@ static int key_create_persistent_register(struct user_namespace *ns)
 }
 
 /*
- * Create the persistent keyring for the specified user.
+ * Get or create the persistent keyring for the specified user.
  *
  * Called with the namespace's sem locked for writing.
+ *
+ * Return 0 if a keyring was created, 1 if an existing keyring was found, or a
+ * negative error.  On a nonnegative return, persistent_ref holds a reference
+ * to the keyring.
  */
-static key_ref_t key_create_persistent(struct user_namespace *ns, kuid_t uid,
-				       struct keyring_index_key *index_key)
+static int key_get_or_create_persistent(struct user_namespace *ns, kuid_t uid,
+					struct keyring_index_key *index_key,
+					key_ref_t *persistent_ref)
 {
 	struct key *persistent;
-	key_ref_t reg_ref, persistent_ref;
+	key_ref_t reg_ref;
 
 	if (!ns->persistent_keyring_register) {
-		long err = key_create_persistent_register(ns);
+		int err = key_create_persistent_register(ns);
+
 		if (err < 0)
-			return ERR_PTR(err);
+			return err;
 	} else {
 		reg_ref = make_key_ref(ns->persistent_keyring_register, true);
-		persistent_ref = find_key_to_update(reg_ref, index_key);
-		if (persistent_ref)
-			return persistent_ref;
+		*persistent_ref = find_key_to_update(reg_ref, index_key);
+		if (*persistent_ref)
+			return 1;
 	}
 
 	persistent = keyring_alloc(index_key->description,
@@ -61,9 +67,10 @@ static key_ref_t key_create_persistent(struct user_namespace *ns, kuid_t uid,
 				   KEY_ALLOC_NOT_IN_QUOTA, NULL,
 				   ns->persistent_keyring_register);
 	if (IS_ERR(persistent))
-		return ERR_CAST(persistent);
+		return PTR_ERR(persistent);
 
-	return make_key_ref(persistent, true);
+	*persistent_ref = make_key_ref(persistent, true);
+	return 0;
 }
 
 /*
@@ -78,6 +85,7 @@ static long key_get_persistent(struct user_namespace *ns, kuid_t uid,
 	key_ref_t reg_ref, persistent_ref;
 	char buf[32];
 	long ret;
+	bool created = false;
 
 	/* Look in the register if it exists */
 	memset(&index_key, 0, sizeof(index_key));
@@ -100,23 +108,24 @@ static long key_get_persistent(struct user_namespace *ns, kuid_t uid,
 	 * also need to create the register.
 	 */
 	down_write(&ns->keyring_sem);
-	persistent_ref = key_create_persistent(ns, uid, &index_key);
+	ret = key_get_or_create_persistent(ns, uid, &index_key,
+					   &persistent_ref);
 	up_write(&ns->keyring_sem);
-	if (!IS_ERR(persistent_ref))
-		goto found;
-
-	return PTR_ERR(persistent_ref);
+	if (ret < 0)
+		return ret;
+	created = ret == 0;
 
 found:
+	persistent = key_ref_to_ptr(persistent_ref);
 	ret = key_task_permission(persistent_ref, current_cred(), KEY_NEED_LINK);
-	if (ret == 0) {
-		persistent = key_ref_to_ptr(persistent_ref);
+	if (ret == 0)
 		ret = key_link(key_ref_to_ptr(dest_ref), persistent);
-		if (ret == 0) {
-			key_set_timeout(persistent, persistent_keyring_expiry);
-			ret = persistent->serial;
-		}
-	}
+
+	if (ret == 0 || created)
+		key_set_timeout(persistent, persistent_keyring_expiry);
+
+	if (ret == 0)
+		ret = persistent->serial;
 
 	key_ref_put(persistent_ref);
 	return ret;

base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
-- 
2.53.0
