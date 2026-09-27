Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF54411F9F
	for <linux-security-module@vger.kernel.org>; Sun, 27 Sep 2026 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790526360; cv=none; b=O6kWfqfmRvJasz/u+q0M9T+TG5fZgTDnRLlsf0wxDdxcsuI5Pd7/VM1/wNIi5RHdoBnHIbwPzum7Vxo0qxPQzhOKFxrKq4F3pQ4HtSImgxiG8DdKntfsu5KtWY+AjUUlDu7AFMAQa4CVsnanSci0j/0KXcsdMHgfiWWeTFKcrxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790526360; c=relaxed/simple;
	bh=5BsCgw/Ym2EH/pD7XqkBxlQbnhUeRH3QF8aygI8y1DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blT0b/S5P6rb+Nkfq8JZpn9BxwKPbMDBxSnYQs7tRyl1bhWRzapc+BOImC9Tzo8B2MJMBvfQo1cYONavt593SRH3Mp9F7llo0dZ3vt/CThCyyirpTEwa5NXuO106ppje02CATA7aCPCJb4Z2oxvE01nCDJHEBDfcuiUBSBjJR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dY0FfIxn; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY0FfIxn"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-141a5cf1370so58884c88.3
        for <linux-security-module@vger.kernel.org>; Sun, 27 Sep 2026 09:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790526358; x=1791131158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zBVj5LHFjCIsTTSs4aP3yw909X6su0JitJhhyc4PxWE=;
        b=dY0FfIxnqkhSLnN25LJsheIPhci77WFCpAQ5fci8UWiRzxuvrqzq2tpzYK3Gr/MfPB
         aTrmXDJo4Yz1J1ZAeIKZ//2idkd6c3PiDoio1o49VIM6OYSyVCeubRvRXCG9eC1zn6Wr
         IKvT1TOGrL/Yzn4lufhYBDevQJgrsGXu9QLrsI1ntfiI4+TGp5O8MCUmyS3NY+KmNepF
         cm9QEXhsL1ZrnZCuIsg7wGUsHp37/hFUpZkzrM+GXVIkQsFoObUzq5/SINBiMTsF/Wql
         jgOPy1KaNH8NBENOGoZe0PhL5A2jrwTDg+mLEDAMOibZzXgFdPZqYMzz7ZhgmcFzARHY
         2PrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790526358; x=1791131158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zBVj5LHFjCIsTTSs4aP3yw909X6su0JitJhhyc4PxWE=;
        b=l0C434rJn5iVfSI+EdeOCeSqX/YJHudKmF4BIJtTFu97o+zmn0g4bydUAWZ5HPcC6x
         nXvapinVHoIXwJJMBUiSoeCZtxMawNp065PGB6jYmtP8Dnx/C3Nx//lLb5hhoaA/sarb
         6m4++QIqmZ7mKkN+nLJo5hzhq3G0t2/Ih84dTE8KrbEeEu2zJR1BjzZUWYXiKHVuYjTv
         6FxuQYSCTPlS2+jYybopSNEEACxeBTr/WndxcotfHWbuPJzSr1pDbp/jN6rBfe00PBAp
         e71v3keA4t/Ivt09vCk7WL9ZrDviTiz2kU2FezrnCm55nqepPCe8S+s5USEOa//5lgrr
         74DQ==
X-Forwarded-Encrypted: i=1; AKwUvBxingxEPmPAIQRtCqj2vwCKsqO+vAYVVLKqpJ85S9CUjU2uXG7YmngCgeUII/t+EvQBpNMnRJKhODn8WPNKw4YRsjVRcCA=@vger.kernel.org
X-Gm-Message-State: AFuF++mA+ErpnlNMcKZ5vkPy3VwxyWbZIkFhudHbKfCEGQqI3E1FgKIR
	XqkrsWUtJ++NSwobXlhDsForyE4zuTTK/QQ4PU5rYOCfb4YS62PLzI63
X-Gm-Gg: AYBFou1Aw6KIS4PJazPEn7+Blpimh+7Q83Py/652ZB7PFO1u97g/9cl1A5aCy9crut7
	E7LT5iwdadKnNL//4VDb1kSavZ3oXjQCUZBZWBo7rjuv12FYsF+EZXj5KDeH/OY28Xz8riJcd76
	F3rWwzOr8FQ0VIdH/Zqj8XhDFSFBGcdsxOs3QRMnsL+CXc9hfv5sD/y0a3grlJJks+jVBjl5yBM
	kftKzilMsgTnFoAq4fjU+vDTriTgnPpnrJz3Li4v6O3/FYOU2xPjSxt2P5GcXu7E5/5QDVl8s42
	yGWPRd/eiv27BOyUhtMAIINSyoRRgNQ599hQEV1zmLhfJGfDlLgFIkThIEgz+2j7XaohEv6aKz1
	f2i0pqIiPgfYTGP3gqyP+O3kUtXJFs8BP3HUeSs4BFEGp3ZnGh8J8DXPLPNmWfVl1uDMYI0GWd1
	PwcfMzA4F/rzDMMimgTVrR9WKaUQsO2cHfujVYYRG3Jqs/b51TB79/YIQuAPF//Fi90zqyho2EJ
	NM/lK/aYnpWtMSAdc6u2/QwwMqhKEE9WU1B05oSKUKmqX9LhDndZo3f5iovIlnradMm6kAS9psC
	ZXwA
X-Received: by 2002:a05:7022:29c:20b0:12d:c389:ae54 with SMTP id a92af1059eb24-146cfdd1a65mr10850532c88.2.1790526357635;
        Sun, 27 Sep 2026 09:25:57 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145a7318afcsm18498575c88.0.2026.09.27.09.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 09:25:57 -0700 (PDT)
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
Subject: [PATCH v3 1/2] keys: Protect key_user lifetime during ownership changes
Date: Mon, 28 Sep 2026 00:25:27 +0800
Message-ID: <20260927162528.943886-2-nicoyip.dev@gmail.com>
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

keyctl_chown_key() replaces key->user under key->sem and drops the
reference to the previous owner after releasing the semaphore. Readers
which do not hold that semaphore can still be using the previous owner
when key_user_put() frees it.

For example, namespace filtering in /proc/keys can race with chown:

  /proc/keys reader                 keyctl_chown_key()
  user = key->user
                                    key->user = newowner
                                    key_user_put(old)
                                      kfree(old)
  read user->uid

An earlier instrumented run reported:

  BUG: KASAN: slab-use-after-free in proc_keys_start+0x353/0x440
  Read of size 4 at addr ffff8881128abbc0 by task poc/88
  Call Trace:
   proc_keys_start+0x353/0x440
   seq_read_iter+0x25d/0x1190
   proc_reg_read_iter+0x19e/0x260
  Allocated by task 86:
   key_user_lookup+0x1b4/0x540
   keyctl_chown_key+0x3cc/0xbf0
  Freed by task 87:
   kfree+0x149/0x330
   keyctl_chown_key+0x7b0/0xbf0

Serialize pointer replacement and the affected readers with key_user_lock,
which already protects final key_user removal. Take the lock explicitly
while /proc/keys and find_keyring_by_name() copy the owner's UID. Retain
the quota-owner UID rather than substituting key->uid, since they may
differ for thread keyrings.

Also hold the lock across owner accesses in key_payload_reserve() and
across the instantiated-key count increments. Instantiation need not hold
the target key's semaphore, so these paths need the same lifetime
protection. Leave key-state publication and the chown accounting transfer
outside the new critical sections for the separate accounting fix.

Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's owner")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v3:
- Split from v2 as patch 1/2; see the cover letter for the full split.
- Rebase onto current mainline and retain explicit reader-side locking.

v2: https://lore.kernel.org/r/20260904080940.575882-1-nicoyip.dev@gmail.com/

 security/keys/key.c     | 13 +++++++++++--
 security/keys/keyctl.c  |  2 ++
 security/keys/keyring.c |  7 ++++++-
 security/keys/proc.c    | 15 +++++++++++++--
 4 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index b34a64d81d47..d0d583194b05 100644
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
@@ -447,7 +452,9 @@ static int __key_instantiate_and_link(struct key *key,
 
 		if (ret == 0) {
 			/* mark the key as being instantiated */
+			spin_lock(&key_user_lock);
 			atomic_inc(&key->user->nikeys);
+			spin_unlock(&key_user_lock);
 			mark_key_instantiated(key, 0);
 			notify_key(key, NOTIFY_KEY_INSTANTIATED, 0);
 
@@ -604,7 +611,9 @@ int key_reject_and_link(struct key *key,
 	/* can't instantiate twice */
 	if (key->state == KEY_IS_UNINSTANTIATED) {
 		/* mark the key as being negatively instantiated */
+		spin_lock(&key_user_lock);
 		atomic_inc(&key->user->nikeys);
+		spin_unlock(&key_user_lock);
 		mark_key_instantiated(key, -error);
 		notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
 		key_set_expiry(key, ktime_get_real_seconds() + timeout);
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

