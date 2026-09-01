Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE0531B10B
	for <linux-security-module@vger.kernel.org>; Tue,  1 Sep 2026 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281019; cv=none; b=IFmNfpxDs7Ps5sfQ+QQTzOICrvjfKZBRmsEW8J22NY6tQ+m19ET/xfiNNFoQBw74iUEVfB/ZDxsm8DFhmHr/Z9n7X7wRKz0l1Cg7Rdwycit2s5nKKS4FlMgrJImVvYJXmOOEmXXSpKZxyNfaHyraW2bz78fhxMPoz5mcdMaJzPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281019; c=relaxed/simple;
	bh=NM1OhZ9rfYb9F3MzDtG1tc94qtUJK44wkdFmtomAr2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fjT8pw4YM4Z2vfxlq+jWd8M3ZAO0F5tVGI3hukGtPbvi1uKP5JgGM3Ss3uJ5QD/3vp5SC7ECqG3P7QTjEH+iAGNrLgJ2/54FJ/6tFy65L1fQc5aVVm9JkPeTTEUS8jOJVhkWIFtJCRRVFLwcHgP5CbmDJgrfoDScwhfNFSI3xLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgskcyZZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgskcyZZ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so59625025e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 01 Sep 2026 09:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788281016; x=1788885816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yUjhJUdR6YGxtlP3WPGJhQ87yiDLscKuDto9mJ9pZts=;
        b=YgskcyZZCdunLm7pbAHhsVRJSUL8Q7DvB1l5PdI962LlFFu7nB/C00jAqRAWYrt5NK
         KGMah9tVKiCOByrNHFIy2VJO9pPYn18+A3Zio1OH2oNLnSV3t8yoKTPDoCOYhRs5ExJi
         yTcFTndHD0f1KxvrpR+PgFcHHtjNVz0/RARxz4HLTrV57kSPD0G9xmqEKowlAezy7OL9
         vKAG4nOpnKrKSWVaVsWzyF3h2dxTcx3uFzsYnCa/tRGe9sTe1+K3l17Qa+5F+0Yt2Gy/
         M/DY7peSMuNRp7cr7XcR0Iu/Z8Mo9ESTXUD1nkhICInG3KHfvkrz+PNr6pjsHOGLe/UQ
         QiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788281016; x=1788885816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yUjhJUdR6YGxtlP3WPGJhQ87yiDLscKuDto9mJ9pZts=;
        b=r/uLNSEYEXDparLPLfMn0SBdgXiFkn4Bidr8vElcJK6xOO953d1koUiJ2KrjhRmwwi
         iiHi/ATU1PxbilfE4giKgu8KX/sJ+KNn4J4KZibUfrb94YUaK3+9P5LL5tL7X1Un1rGE
         S8TGZsIBBkr62M0VHTQ9UYGXOudtEvT+pE0IPWxpg96SzqYO52iGZIY6RXtqAx/V6qWW
         ND/tXw8Xfe4m+ELp54OSt1exBs4I1LkYkXPP8LrdIHecowHLvdYq+eMUAK4zrK9zpHsm
         WvknC28PxNz+lheABFqvGxAir8hOw6xoKF6RaWevfrM3/9R337BHheqjdarqKOzkFw3X
         XEBg==
X-Forwarded-Encrypted: i=1; AHgh+RqKrr0Lg6AG6EgNygpr1ePv7i2UuVhOyqM6iEcMLkqElZd4jv9KeQ8KE4R5Yftgi3OZfjx5EKUH3gx1f0HsOIc4Pu/39Is=@vger.kernel.org
X-Gm-Message-State: AFuF++mkU+5lHeq0aAG0KOBriCYqiyESN/AGhNxFA4LrfGnYRsNjUeqw
	7YTlyboi9bzO9sNZpnQZ3gbiPG1Nn0f5FzKRizpAR1VjHav4DJpW5aUvjpOoZpcs
X-Gm-Gg: AR+sD130v/Ng4p/3PHT5YhGVsfG9AHMT0Oh04+P+CcN1dfIPjj+5NuHXIiqzmhEbImd
	Rb6TZLYW1ONvcb0JdQwLNDSw/DFLlfLRXLII2sXLfEh8BNKmfXZaukfc09jVe8wloBlsbU1CKQS
	Rjyhz+8QC8AlFkX9Pfcl3dIzKbefDK46PEGzDuylsRdjvftObywBK+UvIabbOJ7HuNbZ1OHRp2C
	GYL1UKMx7rADEZOt+Tsub3mAt/pglDcMfiDnVXhHxZOTJSDIyI0ieoeKHibSdqH2snZCZ1T84V4
	bhQCiCBkuCeQTV35BC0yBw+sQHcmCK3eXeZO7tifP9h6+5fEqi6h3mlAS/Axg8/8wOGn3d4eaTv
	WFJJe7pE7aH1NA46N2t60/m+BaL1/Jofv6UFwWmbiSs/pSMRClN7ZVMu9USTWQtA3QrOSWNB39E
	+S0WdIcH1452S62Gt7eo/sSF9jYy5oH92crIhl6gzWNoQxmoTX1Mzl/gSbYd2oSwlKrvKsdBBXU
	70JXNNWuDzc6hcU5nVj8BtKBJl0PTKPyUvOpWobl825Dr8Boyc58B6ojrrGZ6JF2+81u+VuRRR8
	b419RuTvEkDbD+v41BYaiHmFaBjcta5T76Wuw7GnMNgtdoBMONiWte/DfDr+E+z82xoM/RPVI4e
	Ax93VVA==
X-Received: by 2002:a05:600d:8498:20b0:499:dbae:86be with SMTP id 5b1f17b1804b1-49b91c4de9bmr443281585e9.14.1788281015501;
        Tue, 01 Sep 2026 09:43:35 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a16a-7801-fd8c-4b37-36b4-e53a.310.pool.telefonica.de. [2a02:3100:a16a:7801:fd8c:4b37:36b4:e53a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce309e418sm22960605e9.13.2026.09.01.09.43.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Sep 2026 09:43:35 -0700 (PDT)
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
Subject: [PATCH v2] keys: finalize persistent keyring timeout after link attempt
Date: Tue,  1 Sep 2026 18:43:23 +0200
Message-Id: <20260901164323.35785-1-kmehltretter@gmail.com>
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

Have key_create_persistent() report whether it allocated a new keyring.
Another caller may create one between the initial read-locked lookup and
the retry under the write lock. Set the timeout after permission checking
and linking. Do this on success, or on failure if the call allocated the
keyring.

This leaves a new keyring collectible after failure without starting its
timeout while linking is still in progress.

Fixes: f36f8c75ae2e ("KEYS: Add per-user_namespace registers for persistent per-UID kerberos caches")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
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

 security/keys/persistent.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/security/keys/persistent.c b/security/keys/persistent.c
index 97af230aa4b22..f356df8f3c973 100644
--- a/security/keys/persistent.c
+++ b/security/keys/persistent.c
@@ -38,7 +38,8 @@ static int key_create_persistent_register(struct user_namespace *ns)
  * Called with the namespace's sem locked for writing.
  */
 static key_ref_t key_create_persistent(struct user_namespace *ns, kuid_t uid,
-				       struct keyring_index_key *index_key)
+				       struct keyring_index_key *index_key,
+				       bool *created)
 {
 	struct key *persistent;
 	key_ref_t reg_ref, persistent_ref;
@@ -63,6 +64,8 @@ static key_ref_t key_create_persistent(struct user_namespace *ns, kuid_t uid,
 	if (IS_ERR(persistent))
 		return ERR_CAST(persistent);
 
+	*created = true;
+
 	return make_key_ref(persistent, true);
 }
 
@@ -78,6 +81,7 @@ static long key_get_persistent(struct user_namespace *ns, kuid_t uid,
 	key_ref_t reg_ref, persistent_ref;
 	char buf[32];
 	long ret;
+	bool created = false;
 
 	/* Look in the register if it exists */
 	memset(&index_key, 0, sizeof(index_key));
@@ -100,7 +104,7 @@ static long key_get_persistent(struct user_namespace *ns, kuid_t uid,
 	 * also need to create the register.
 	 */
 	down_write(&ns->keyring_sem);
-	persistent_ref = key_create_persistent(ns, uid, &index_key);
+	persistent_ref = key_create_persistent(ns, uid, &index_key, &created);
 	up_write(&ns->keyring_sem);
 	if (!IS_ERR(persistent_ref))
 		goto found;
@@ -108,15 +112,16 @@ static long key_get_persistent(struct user_namespace *ns, kuid_t uid,
 	return PTR_ERR(persistent_ref);
 
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
