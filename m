Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7156535F602
	for <linux-security-module@vger.kernel.org>; Sun, 23 Aug 2026 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787498950; cv=none; b=dfQVd0oFcaDnjJtSbplAkhAAVyehWntuaer9Jnaq1GrfyPj5fgQ1tgqE4LvZLElgToQk5EwcqUb0cc02QTBSk+CCDlrYpxl9jF560flia41l2q6dUNBkwmpvVcw2NlZ7g5kZPeUbWAMvGPYH9mMJlK2X75fP2SR8dmbtzbW2KjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787498950; c=relaxed/simple;
	bh=noH06bWbd9au3QwTfyCzv6YG/11P0qQ2GQOGnBRkOM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZSywo+oHo8XZoAxhDpWPZQ+M2GWqDwJtKsEA7c8umfe0xuP6Mqo0ZcnGNtAfll2IeZsky9oUXAoYaVna5pl8OnZUCWlqFGH64gD9JdNhc8z/T9OY8z5bHgdXv7itMWhZLbN7vJLl25+FSA+axSxFiHKT+rVQrFWAZKQ2/KAakI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOpu+1pt; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOpu+1pt"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66c70effc23so287808d50.1
        for <linux-security-module@vger.kernel.org>; Sun, 23 Aug 2026 08:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787498947; x=1788103747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OFwQKaYUKYWnpFig82RL6B4iFCO0UHPAGhK0xZ0RmTw=;
        b=FOpu+1ptZtZAkMi0rwj1xwe3oHGFeiP3SZtzIB0mjYlNpDi/c13lHNaiZ36jkPYGmU
         RYMxwtCcssI7OWU1qYGT7qmdhxUkVT6DVKGWMWEOiVUwLYbwx/Onjpj05AC7yoMHVFqW
         2k7V2CadXy+YNBiP/urVQGjYZU+VZwDE13fKHZAswfCraYBLP1h8mwCkdL00c/Eyc2Zr
         2sg87EmLQ0NdqrBH4gHG04zCPmk88BzDJ0PI3pFYoR/UZQHV5ymCQasoxqaLDtG0Q4/H
         mt4NMfpufjyZX2nOq6kfM3jIwRsLpdDP2DvGa55oZASldr/D61bWA6lzhKVQD33F79Z3
         Nw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787498947; x=1788103747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OFwQKaYUKYWnpFig82RL6B4iFCO0UHPAGhK0xZ0RmTw=;
        b=q8bLACsNORRvXLRhQnBitV7Sk7Je8jjejazKQjAPBMZSH+ZbRo7IqQ9Oz72fOo0cQ+
         onq8H4H5L/zPT8maVLZWTPiwFoODWeOB2DRxS8RD74Kbzck/XWX0Sy0i3l0A59CdfQBe
         AZZIXgcZd4vNn6F0yj4cUF/pxJjC2bp8suLoZEngMyFZmsZYdkVi/t9C8qrlPNnxWlJ+
         9e2nJlAZMqT3yrp1z3gW96Rh7ElNTDqGUIePM/u5O35EaTiAKVR5vjAoDAhxJmoaCEtX
         HrRFvbILe8koVqRTxVmw0CgEKMhWJvAgelbZ6Lr48hYAl+yTo9uwPUIS3QFFSHicGySt
         qERA==
X-Forwarded-Encrypted: i=1; AHgh+RpmL8mRVPiZ0F/lbauXYLfjrICVu+HT/lJBpO6sk3uBjzjy0MipXDa+cjv09qXTe/p+TR1Veifr/l2xPCplk6yF6mZq/WY=@vger.kernel.org
X-Gm-Message-State: AFuF++nRRFAe2gHppYqaUiFYHcE9/3ChrdODXaDkxebp7tWeEMaOmuqG
	qoXvyTYgv1PTynhcHdMScBgyQXcrubpkVJ4SN3OAuNPl9imr4SUYQ7I9
X-Gm-Gg: AR+sD12lCCL7pA/v8E1G8XhqaqbBIjCKt1QP/cC3YYWHuX4Tz1V87G7ZrCG8CFVM3DJ
	PwKUxGQD0PIuGaAtM7PcTyJ8wqrz5nELB/zIbU0pEePL7eYSuET/OYRs6eRF67Pem/VefX0sAi/
	nPcXjQgYn3khizQyBL3JQIXOQ8FLvMOKrp3kT2uJM+uz6RHUGGfTiS8GZNLyl4BU5qibvBxz9xy
	twAj8dp6fmHsbne3E1841dudajoXWJL9xsYYIXHx1Bo8NkUJQ1nRCWBzm+C7E+PoLdsTfMzRDTp
	waAOHqP2kY0YBApT46hFRLgzNk6gJ18rJvkwD6FmRi/62R6MydAKF+EWKtvEM65kigknq0ONocQ
	hOM8ixR+IvkNNnIxOvDpXuGobKxYrVNE9295HBlg2gV4mgFA8q+7ROnU/XCGJrycYD0+msBIS4N
	MxBFkzLsQplHDSX1H27L7TS62iQkRoSzNmSLdCPhXS0uxwZt27nBkL15FTdGboQLHsV96SYlvax
	vi8NItBHRITUI6rhuc0jQj1Oi0nMTzfwjN1y/ilxvg/S1zccdzrxOZNPGXA/9nTJA==
X-Received: by 2002:a05:690c:b96:b0:81f:45f0:21b7 with SMTP id 00721157ae682-849ea4f7f47mr87069237b3.0.1787498947218;
        Sun, 23 Aug 2026 08:29:07 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cab84ef2esm21895757b3.34.2026.08.23.08.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 08:29:06 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Serge Hallyn <sergeh@kernel.org>
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH] keys: Fix key_user use-after-free during ownership changes
Date: Sun, 23 Aug 2026 23:28:58 +0800
Message-ID: <20260823152858.3839939-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

keyctl_chown_key() replaces key->user while holding key->sem and drops
the old key_user reference after releasing the semaphore. The /proc/keys
iterators and find_keyring_by_name() instead dereference key->user while
holding unrelated locks.

This allows the following interleaving:

  CPU 0 (/proc/keys)            CPU 1 (KEYCTL_CHOWN)
  load old key->user
                                replace key->user
                                key_user_put(old)
                                  kfree(old)
  read old->uid

Serialize the namespace-mapping reads and the pointer replacement with
key_user_lock. This lock already protects final key_user removal, so the
old object cannot be freed while its uid is being read. Keep reading the
quota-owner UID rather than key->uid because those values can legitimately
differ for thread keyrings.

Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 security/keys/internal.h | 10 ++++++++++
 security/keys/keyctl.c   |  2 ++
 security/keys/keyring.c  |  2 +-
 security/keys/proc.c     |  4 ++--
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/security/keys/internal.h b/security/keys/internal.h
index b7b622bc36a1..741d547ba5c4 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -70,6 +70,16 @@ extern struct key_user	root_key_user;
 extern struct key_user *key_user_lookup(kuid_t uid);
 extern void key_user_put(struct key_user *user);
 
+static inline kuid_t key_user_uid(const struct key *key)
+{
+	kuid_t uid;
+
+	spin_lock(&key_user_lock);
+	uid = key->user->uid;
+	spin_unlock(&key_user_lock);
+	return uid;
+}
+
 /*
  * Key quota limits.
  * - root has its own separate limits to everyone else
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index d14ace88e529..c17924609317 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1036,8 +1036,10 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 			atomic_inc(&newowner->nikeys);
 		}
 
+		spin_lock(&key_user_lock);
 		zapowner = key->user;
 		key->user = newowner;
+		spin_unlock(&key_user_lock);
 		key->uid = uid;
 	}
 
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 15bf4af8f282..49f4be934525 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1158,7 +1158,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
 	 * grants Search permission and that hasn't been revoked
 	 */
 	list_for_each_entry(keyring, &ns->keyring_name_list, name_link) {
-		if (!kuid_has_mapping(ns, keyring->user->uid))
+		if (!kuid_has_mapping(ns, key_user_uid(keyring)))
 			continue;
 
 		if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
diff --git a/security/keys/proc.c b/security/keys/proc.c
index 4f4e2c1824f1..8d6d26652aab 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -68,7 +68,7 @@ static struct rb_node *key_serial_next(struct seq_file *p, struct rb_node *n)
 	n = rb_next(n);
 	while (n) {
 		struct key *key = rb_entry(n, struct key, serial_node);
-		if (kuid_has_mapping(user_ns, key->user->uid))
+		if (kuid_has_mapping(user_ns, key_user_uid(key)))
 			break;
 		n = rb_next(n);
 	}
@@ -100,7 +100,7 @@ static struct key *find_ge_key(struct seq_file *p, key_serial_t id)
 		return NULL;
 
 	for (;;) {
-		if (kuid_has_mapping(user_ns, minkey->user->uid))
+		if (kuid_has_mapping(user_ns, key_user_uid(minkey)))
 			return minkey;
 		n = rb_next(&minkey->serial_node);
 		if (!n)
-- 
2.43.0

