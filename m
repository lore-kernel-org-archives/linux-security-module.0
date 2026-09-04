Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADA2388890
	for <linux-security-module@vger.kernel.org>; Fri,  4 Sep 2026 08:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788509391; cv=none; b=Rmk/hr6h8Sn7SwIPL71FFq0Vfs5gBrZubolcwMTwBzwZRnYPhCOUbqm+6/mJUf7pf7dCVBT0vUwKZQtMifhCLGHNp5Mj4a28E1JP0pADTgSwTXgSERs62gHf0Kt61SEJvRxXmjv/3DZ8MVT8Jq2yTPk49ddl1wxhuNIYYHkeGyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788509391; c=relaxed/simple;
	bh=HACMX+LXnMqI9f9mdRxV9S15xsrMIb40XFMmR6zi/z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kkXng8nQR+6aZVebX9/NSNG42RQyQE3UQ0WjuWnFFQYeKAEjcaEqEUaAL+gUPo8K1FW3bHg0t+8oZSqaeQLVn5ROUh/mUOB6QBadZsJcQNH+92Bm+4SyYWtKqJl2SN0k2LUb6bnn8bA4kXRqqf5W+5BMPMkHrZGoW7cxNvnjDEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1Qq+79r; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1Qq+79r"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-396afefb35bso78992a91.2
        for <linux-security-module@vger.kernel.org>; Fri, 04 Sep 2026 01:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788509389; x=1789114189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QuKGhcV8twnDAPnDv4bBYkqWbBQMc0+zi9pzIkYky7U=;
        b=g1Qq+79rWDjoWVtuFrEookroVSUP+5bEd9GcNeiP/lvBwQEhLO0Y7VS9YnaG4LwxJX
         bXrTPg0ENbv/RuXXTp4DCY5vO0XRPCykcLoGr9//RofcYSZv9lZBHeI9zAuzl78ZVoMw
         kwyNmFl0TctgKCrP5p2QSeTsyBMlfBoh2/dnrMrdUC/MNEwcfX+3rxDWnaYEby3ETIpH
         B8S2KjanNSDgmjxBBH+G9h6bziSTk66u48fgw86wbms2VHoUyWKNaEX2SZtJoeyxOiSV
         5LJXWzeiZ7YqYnGBWdun0q7dHsnGzjg065Qdpc7peGv6JyoOLxQUba30EYejQ9/h+m3b
         V9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788509389; x=1789114189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QuKGhcV8twnDAPnDv4bBYkqWbBQMc0+zi9pzIkYky7U=;
        b=myO2z0TJYr3QDpqE4P1g1ooHrxk6XXl1aFX808zOAoxyGNGQH7gBiXCHPqj2gg0T+D
         nwj5OEtbyKcfSaC2cw/XZ2xJ7UDL/vI6KfbxYcrXh11TTlXuVpG7d7324Z+42YrPHKz7
         kPKqyXAr+r5NXCJ+ftzDUEUKzB5LEv6EEeeNdnREJpddzsM8QqIkjIwQdWkOn/pf2okz
         9N+XVtpH8B5YEm4BWg/3RxJR036BrvTfAKg8d8ese5iGpV4JvQAqK1kTiLnzS1uzp1gT
         H7Cs5xIDe8n1h63DB+5WbM2MuqXA6XHYA+tjAHzsclpGsXx9RVsqM0jcssz0Tou5RB76
         cVvw==
X-Forwarded-Encrypted: i=1; AKwUvBwe4hL9u7TLoE2+7CJhnbWGxLgnhUHWssfew3+ozWKuUcIO+CCdBUuufLgLcD0W4MIqlkn9N0M2/jQe3nKQx5ugSHghBtk=@vger.kernel.org
X-Gm-Message-State: AFuF++nc6Uck97SzKIXLbdjHL5SMjze3Te/UpUvmSrgNUbQoVICt23Vl
	1JYAm3LEO8xRJ7k1F1DsehYixWrKAcO0Ywzazcf6TQ7h3xIhomneciRx
X-Gm-Gg: AYBFou0JH0ElyU9j/ohKVcEhCfHbU1sTk5Zg6tc5KwRqmCevSsof7ne9jxO/f/3iJol
	zOn5tEPYqb2S/a54NJ1Yy/p1njA3O+ck69gYf5F17ObYOnn+S7Sw0muIPGOjw732iPVvQkLtZdB
	CaVFo2lGrxmiqsWLHvMvuhbOiP7AeEoGE6S5UP16+zhW88k8I+SAIirYw2oHbYvxSuOhtjBJsjH
	mT0Br+u80m8c+noIp6sxDQVpDIzItaf/hFXh/xNmNIrVTP58LVKgVPj+wSm+eiV1VkV06LM7/yG
	DDOwGaGJQOhp/OjLYQ6gAjEXtXOjN537FIjET5nbjVGF2LgeuBxJLx3cRsA2NfLp5ky1S5HEP5e
	tzhzcPe8Y5eGN4psCT09hS8RwtCcnfg2fZv/DIjSLkLLgXGPgRGsc+vThzFX3iQTqz15doDEW7S
	J5QCwpcKyiDo7RWvF4hoVRKJHg/1UeODoSNezVKR+x+kud9dyrdgq3Pfo7UKZr4OigBPpVUXtZM
	PWm/lDedQ1ktDGcD7kCz2xeFJ0Lp7IqVgOJpgBIcw8cOqRBdvNX9WLwRg==
X-Received: by 2002:a17:90b:5404:b0:396:d28e:b52 with SMTP id 98e67ed59e1d1-39b26229b5dmr4311093a91.3.1788509388892;
        Fri, 04 Sep 2026 01:09:48 -0700 (PDT)
Received: from localhost.localdomain (45.78.64.189.16clouds.com. [45.78.64.189])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432423f99fsm4578817c88.1.2026.09.04.01.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:09:47 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH v2] keys: Fix key_user use-after-free during ownership changes
Date: Fri,  4 Sep 2026 16:09:40 +0800
Message-ID: <20260904080940.575882-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

keyctl_chown_key() replaces key->user and then drops the key's
reference to the previous key_user. Several paths access key->user
without any common synchronization with this replacement, including
the /proc/keys iterators, find_keyring_by_name(), quota accounting, and
key instantiation.

This allows an ownership change to free the previous key_user while a
reader is still accessing it:

  CPU 0 (/proc/keys)            CPU 1 (KEYCTL_CHOWN)
  user = key->user
                                old = key->user
                                key->user = newowner
                                key_user_put(old)
                                  kfree(old)
  uid = user->uid

The same missing synchronization also can corrupt instantiated-key
accounting. KEY_LOOKUP_PARTIAL allows keyctl_chown_key() to change the
owner of a key while it is still being instantiated:

  CPU 0 (instantiate)           CPU 1 (KEYCTL_CHOWN)
  atomic_inc(old->nikeys)
                                observe KEY_IS_UNINSTANTIATED
                                skip the nikeys transfer
                                key->user = newowner
  mark key instantiated

The increment remains charged to the previous owner. Quota reservation
can similarly select one owner for its quota limit and another owner
for the usage update, or access an owner that has already been freed.

The existing locks do not provide common exclusion for these
operations. keyctl_chown_key() holds key->sem, key construction uses
key_construction_mutex, and the affected readers hold their respective
tree or list locks.

Use key_user_lock to serialize access to key ownership. Hold it across
the accounting transfer and key->user replacement in keyctl_chown_key().
Use the same lock while readers copy the owner's UID, while quota usage
is updated, and while the instantiated-key count and key state are
committed.

key_user_lock already serializes final key_user removal, so an old
owner cannot be freed while one of these readers is accessing it.

Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's owner")
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v2:
- Audit every user->uid occurrence and all direct key->user accesses.
- Take key_user_lock explicitly at each namespace-filtering reader instead
  of hiding the lock acquisition in an accessor.
- Serialize quota reservation and construction accounting with ownership
  changes while preserving the existing direct key->user accesses.
- Use the commit that introduced ownership changes as the Fixes target.

Link: https://lore.kernel.org/keyrings/20260823170448.3856516-1-nicoyip.dev@gmail.com/ [v1]
---
 security/keys/key.c     | 13 +++++++++++--
 security/keys/keyctl.c  |  4 ++++
 security/keys/keyring.c |  7 ++++++-
 security/keys/proc.c    | 15 +++++++++++++--
 4 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index b34a64d81d47..54c675b3b58d 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -21,6 +21,7 @@ struct rb_root		key_serial_tree; /* tree of keys indexed by serial */
 DEFINE_SPINLOCK(key_serial_lock);
 
 struct rb_root	key_user_tree; /* tree of quota records indexed by UID */
+/* Protects key_user_tree and key ownership changes. */
 DEFINE_SPINLOCK(key_user_lock);
 
 unsigned int key_quota_root_maxkeys = 1000000;	/* root's key count quota */
@@ -380,9 +381,12 @@ int key_payload_reserve(struct key *key, size_t datalen)
 
 	/* contemplate the quota adjustment */
 	if (delta != 0 && test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
-		unsigned maxbytes = uid_eq(key->user->uid, GLOBAL_ROOT_UID) ?
-			key_quota_root_maxbytes : key_quota_maxbytes;
 		unsigned long flags;
+		unsigned int maxbytes;
+
+		spin_lock(&key_user_lock);
+		maxbytes = uid_eq(key->user->uid, GLOBAL_ROOT_UID) ?
+			key_quota_root_maxbytes : key_quota_maxbytes;
 
 		spin_lock_irqsave(&key->user->lock, flags);
 
@@ -396,6 +400,7 @@ int key_payload_reserve(struct key *key, size_t datalen)
 			key->quotalen += delta;
 		}
 		spin_unlock_irqrestore(&key->user->lock, flags);
+		spin_unlock(&key_user_lock);
 	}
 
 	/* change the recorded data length if that didn't generate an error */
@@ -447,8 +452,10 @@ static int __key_instantiate_and_link(struct key *key,
 
 		if (ret == 0) {
 			/* mark the key as being instantiated */
+			spin_lock(&key_user_lock);
 			atomic_inc(&key->user->nikeys);
 			mark_key_instantiated(key, 0);
+			spin_unlock(&key_user_lock);
 			notify_key(key, NOTIFY_KEY_INSTANTIATED, 0);
 
 			if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags))
@@ -604,8 +611,10 @@ int key_reject_and_link(struct key *key,
 	/* can't instantiate twice */
 	if (key->state == KEY_IS_UNINSTANTIATED) {
 		/* mark the key as being negatively instantiated */
+		spin_lock(&key_user_lock);
 		atomic_inc(&key->user->nikeys);
 		mark_key_instantiated(key, -error);
+		spin_unlock(&key_user_lock);
 		notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
 		key_set_expiry(key, ktime_get_real_seconds() + timeout);
 
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index d14ace88e529..83a9575b084e 100644
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
@@ -1039,6 +1041,7 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 		zapowner = key->user;
 		key->user = newowner;
 		key->uid = uid;
+		spin_unlock(&key_user_lock);
 	}
 
 	/* change the GID */
@@ -1058,6 +1061,7 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 
 quota_overrun:
 	spin_unlock_irqrestore(&newowner->lock, flags);
+	spin_unlock(&key_user_lock);
 	zapowner = newowner;
 	ret = -EDQUOT;
 	goto error_put;
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 15bf4af8f282..5943e8b48c0f 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1148,6 +1148,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
 {
 	struct user_namespace *ns = current_user_ns();
 	struct key *keyring;
+	kuid_t uid;
 
 	if (!name)
 		return ERR_PTR(-EINVAL);
@@ -1158,7 +1159,11 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
 	 * grants Search permission and that hasn't been revoked
 	 */
 	list_for_each_entry(keyring, &ns->keyring_name_list, name_link) {
-		if (!kuid_has_mapping(ns, keyring->user->uid))
+		spin_lock(&key_user_lock);
+		uid = keyring->user->uid;
+		spin_unlock(&key_user_lock);
+
+		if (!kuid_has_mapping(ns, uid))
 			continue;
 
 		if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
diff --git a/security/keys/proc.c b/security/keys/proc.c
index 4f4e2c1824f1..e507c500c068 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -68,7 +68,13 @@ static struct rb_node *key_serial_next(struct seq_file *p, struct rb_node *n)
 	n = rb_next(n);
 	while (n) {
 		struct key *key = rb_entry(n, struct key, serial_node);
-		if (kuid_has_mapping(user_ns, key->user->uid))
+		kuid_t uid;
+
+		spin_lock(&key_user_lock);
+		uid = key->user->uid;
+		spin_unlock(&key_user_lock);
+
+		if (kuid_has_mapping(user_ns, uid))
 			break;
 		n = rb_next(n);
 	}
@@ -80,6 +86,7 @@ static struct key *find_ge_key(struct seq_file *p, key_serial_t id)
 	struct user_namespace *user_ns = seq_user_ns(p);
 	struct rb_node *n = key_serial_tree.rb_node;
 	struct key *minkey = NULL;
+	kuid_t uid;
 
 	while (n) {
 		struct key *key = rb_entry(n, struct key, serial_node);
@@ -100,7 +107,11 @@ static struct key *find_ge_key(struct seq_file *p, key_serial_t id)
 		return NULL;
 
 	for (;;) {
-		if (kuid_has_mapping(user_ns, minkey->user->uid))
+		spin_lock(&key_user_lock);
+		uid = minkey->user->uid;
+		spin_unlock(&key_user_lock);
+
+		if (kuid_has_mapping(user_ns, uid))
 			return minkey;
 		n = rb_next(&minkey->serial_node);
 		if (!n)
-- 
2.43.0
