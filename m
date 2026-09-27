Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2EF41379F
	for <linux-security-module@vger.kernel.org>; Sun, 27 Sep 2026 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790526364; cv=none; b=mcfS0ml0hWSWT0+546nCPZranp0dvxAVURkgFK1VMBxP+v95kMrGKC39WQMNqW8lXYns4L+XGjGLPoQypDL4Jv5UJaXSXuhofa2Ves1AN2IOJpylAoQCwILR9mlz8KU22R+E8JS9yTrG1qgLyhE6+0ooqbqWQLC3NfBgcJnnMvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790526364; c=relaxed/simple;
	bh=w7hXOZR3kGcBhr0hjg4B5lwGJGB/KZcZNRTsshLVPPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaR5FT4+1Xm6jz7GmS8H6EgoHmlLyRw0U7sqMc5cNU6twGQKWia69WvgrsKDxjzIG0hRdpUKUAurgJOSuaFdhJN75fYEETfJ8ma1wJPiLrP3MA2rznzTwGximqmC0elcYm8/wOSZZm/0o+BtU+n2JShbdjLf/nn5W2F2gxp4Wb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7exR3oT; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7exR3oT"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-141a5cf1371so129946c88.2
        for <linux-security-module@vger.kernel.org>; Sun, 27 Sep 2026 09:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790526362; x=1791131162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N3ycCXPKuJpAbU8om5dCwVVH3DJubz8qaLeZTTofQWI=;
        b=B7exR3oTA2rtdJVTHBE7Acu8x7bnuCAqkFk08S12qAvZWwp8QVYfUl+ztUKhoVtLTj
         vnG13LeURACVwp1m6PzG1DvWdspEel0XinKQvk14tbR3xo5UpBMKYoou4vOp9CVxigmV
         cQmcZLeQ3q4BtrsIKRAT/fxyRg0sn6pCyNwiZF+WmYwR4jAVD5ujH/yIl4lx9OTt8/ch
         cFNntNL9wadNBByttKaoBGBoS0R2LSTiBnFSudl3RWvxQ7+fWiig4fjVlTe49zFRp7oR
         cSshj1LjLmT0ZEGXHWN3OM7yVJMRRQl84xc0C7m20z/bsbangzmgk5+6YjEVW8beKldq
         stmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790526362; x=1791131162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N3ycCXPKuJpAbU8om5dCwVVH3DJubz8qaLeZTTofQWI=;
        b=QFZ7Dj9ihUOoQ5I8NNSSO8SKj7msAWUV3JWrTmVpSVxTgAjqTp7hZAImCes1r2Xs0o
         pspGYOtaxNyc3Jr8dasbJRHhUBbvTMbjonzKtQnkaYe2Q+o+n2ex7/04FBbIaAe4Mjuq
         Py80DcaxYLn0mRzmUorj3W+DuyPY+6VZk0p7BpJPeXyksgxEpddbfuLeCjf2YpD5VC5t
         DCEE8jreoF6I03bTtLu2J+4nEr/s12wUb8rCod6MWquqSXcd9bxKX5fx2Pgp4e2IcUm1
         Hc8KGslf+mWNPpOtxa01dPwhYoOxu9NCRyPPTHnLOsyC5N1LWq0VmXN8InnwP+qM736/
         xT3A==
X-Forwarded-Encrypted: i=1; AKwUvByFX1EaCC36xz9nxSJFUon2kMFdM+L7o3sNvaflJwsnlO/GckNBlavbsklXapJh1tCqS9PcLSXqftw9Jcr8RqK8NKYarQ4=@vger.kernel.org
X-Gm-Message-State: AFuF++nIFSn0+D5RJ3elf3UZEvrGIQtaHGsACNiJLJZr51Ru2nhnc16z
	cVb+WNH4cTp3x9EK9rpDxDwKqZ8xCc7EO2XQldXukiba7unijlvHXl+I
X-Gm-Gg: AYBFou2ccjCaC+t/uK3k9UaMBYmPEFzSc2hDnlZknNumoDpNynMeGUV/W986A6Zdvji
	QuLApQE6MFnPF7QxJNVJj+uy98CIV9Q/CI7xb5yBfy6qxTQmnoOe9cFeFfgBZiLUuF66db2ygDH
	bow1EO8CzEnu2M2boXf6EpRkK/kelXHuVNejLq0+j9fY+HwHmcfkJpQN8zm1y3auv4ppHc4n2ik
	9UIqQpfbz5hukrhIyiIA93p4sBo8S3rdBRbhQE+Cw9JZdEOx2zFMPtqMfGPday85bJ4rvqXA0/G
	l+DCGq//Et+P1rG1oFu3E4ofQaCDrQ3/0BBIdaXyHMu+P26RLVIstfqS3VNBZyqQcKOpLpoMEt7
	8cbInWL8yFIZtRtmkn6cFhcWj6U6AmYKo+OfIKuCL/KiwHf8/YVT7spxLROLT+v7rXo2pSk0fM+
	TTiO9PcCwxmqtLHPe+D40OEPIopuok+2LdKSaaYr9pe4RyNAe5ka68W9rm1NT0Paj9F6rHwEde/
	zLK+UdF/9p8a68xCwkQK2VZcrGhs2+PG7uAbAbhfcmKAJgBOyYKNBwr9UyAg9zu+Qd+jQ==
X-Received: by 2002:a05:701b:418f:20b0:144:fd17:3b21 with SMTP id a92af1059eb24-146cb50233emr12002309c88.0.1790526361709;
        Sun, 27 Sep 2026 09:26:01 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145a7318afcsm18498575c88.0.2026.09.27.09.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 09:26:01 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] keys: Serialize ownership transfers with key accounting
Date: Mon, 28 Sep 2026 00:25:28 +0800
Message-ID: <20260927162528.943886-3-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927162528.943886-1-nicoyip.dev@gmail.com>
References: <20260927162528.943886-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Protecting individual accesses to key->user does not make ownership
transfers atomic with accounting updates. keyctl_chown_key() holds
key->sem, but instantiation is serialized by key_construction_mutex and
need not hold that semaphore. KEY_LOOKUP_PARTIAL also permits chown of
an uninstantiated key.

The instantiated-key count can therefore be charged to the wrong owner:

  instantiate                       keyctl_chown_key()
  lock key_user_lock
  increment old->nikeys
  unlock key_user_lock
                                    observe KEY_IS_UNINSTANTIATED
                                    skip the nikeys transfer
                                    replace key->user
  mark key instantiated

The key becomes instantiated under the new owner while the increment
remains with the old owner. Negative instantiation has the same race.

Quota reservation can likewise run between charging the new owner and
replacing key->user. It then adjusts the old owner's quota and changes
key->quotalen while chown is transferring that quota burden.

Extend the key_user_lock critical section in keyctl_chown_key() across
the quota and key-count transfers, state check, and owner replacement.
Also extend the instantiation critical sections across the state update,
so chown observes the count increment and instantiated state together.
The existing per-user quota locks continue to serialize quota changes
against other keys owned by the same user.

Keep allocations, notifications and reference release outside
key_user_lock, and release it on the quota-overrun path.

Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's owner")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v3:
- Split from v2 as patch 2/2; see the cover letter for the full split.
- Rebase onto current mainline and retain explicit reader-side locking.

v2: https://lore.kernel.org/r/20260904080940.575882-1-nicoyip.dev@gmail.com/

 security/keys/key.c    | 4 ++--
 security/keys/keyctl.c | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index d0d583194b05..54c675b3b58d 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -454,8 +454,8 @@ static int __key_instantiate_and_link(struct key *key,
 			/* mark the key as being instantiated */
 			spin_lock(&key_user_lock);
 			atomic_inc(&key->user->nikeys);
-			spin_unlock(&key_user_lock);
 			mark_key_instantiated(key, 0);
+			spin_unlock(&key_user_lock);
 			notify_key(key, NOTIFY_KEY_INSTANTIATED, 0);
 
 			if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags))
@@ -613,8 +613,8 @@ int key_reject_and_link(struct key *key,
 		/* mark the key as being negatively instantiated */
 		spin_lock(&key_user_lock);
 		atomic_inc(&key->user->nikeys);
-		spin_unlock(&key_user_lock);
 		mark_key_instantiated(key, -error);
+		spin_unlock(&key_user_lock);
 		notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
 		key_set_expiry(key, ktime_get_real_seconds() + timeout);
 
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index c17924609317..83a9575b084e 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1004,6 +1004,8 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 		if (!newowner)
 			goto error_put;
 
+		spin_lock(&key_user_lock);
+
 		/* transfer the quota burden to the new user */
 		if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
 			unsigned maxkeys = uid_eq(uid, GLOBAL_ROOT_UID) ?
@@ -1036,11 +1038,10 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 			atomic_inc(&newowner->nikeys);
 		}
 
-		spin_lock(&key_user_lock);
 		zapowner = key->user;
 		key->user = newowner;
-		spin_unlock(&key_user_lock);
 		key->uid = uid;
+		spin_unlock(&key_user_lock);
 	}
 
 	/* change the GID */
@@ -1060,6 +1061,7 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 
 quota_overrun:
 	spin_unlock_irqrestore(&newowner->lock, flags);
+	spin_unlock(&key_user_lock);
 	zapowner = newowner;
 	ret = -EDQUOT;
 	goto error_put;
-- 
2.43.0

