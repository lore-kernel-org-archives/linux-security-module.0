Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6602331F99C
	for <linux-security-module@vger.kernel.org>; Sun, 23 Aug 2026 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787504704; cv=none; b=jefMaRHJXYlTGE+ndYQHujew+rgfb353TF04IO6VKYLOHmhgoewar9Pu13YZzWLYZOLxi3mSLfy5vvyDKAX98804Zm2auZyHVRpyxcvRoFz59RySZpfQ8w45DCOXMEaVyKMdFIFYpmhiGPrOg9X61hoBjoy89s+ZpuYI7/WjnL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787504704; c=relaxed/simple;
	bh=gWZEjagFLSEHCLiuRXV3m9OHpXG30kNMA/tQzzHkKfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DRsampf/PY+fm01E/a+28bBxW6cS7tQvgThJAzPdpMr/kTg3EnE9sSY64vEvRy1DhcB2FVvdwRC5tShifSr3gQkeUUpXvqrM21ohhy5CZMbiExF3oHSFT8SWkGsDilGOB5ljxFKDDYSedML8zrpubtD9eNYUpc1ZvltrnLWfEU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYlMljNb; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYlMljNb"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66b0230bcc2so261369d50.3
        for <linux-security-module@vger.kernel.org>; Sun, 23 Aug 2026 10:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787504700; x=1788109500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7fp7SzY66XTj6zmh2H/e3A8N/ODfvtqZLUkZGsmrEbw=;
        b=IYlMljNbEZfglzy3U83D6qQhWDLHPfAZnO5R+b4emBXjS+xLb3prctm7I36iFvPIo1
         595QCypQs4qwPrZJOdi2eSglflZfby8gLBMhjQBFDArjhF5wB9cxsnhET1Qg+iYStBH9
         sqUduKs4wl6vsjP1y5lhphZlryQu5YusJvaUr7hcQeeQwRPt1o1pfsnwaFhnBif8PW17
         +GRunEsh8XL9PFwKP0Ql9wTkhUhz28qblVr78G5SLVksNPfyYSSTGwHWEvcDKKmN+m2C
         EePXAa/7RX3ogc4Sql7v38RDYTkirAjZ6/A/Mx5s5NzzhjPfDw5gIo9wkeqTajB643Es
         lF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787504700; x=1788109500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7fp7SzY66XTj6zmh2H/e3A8N/ODfvtqZLUkZGsmrEbw=;
        b=mPjuLPwWTfKAak7pcw4TPPmgnHZJ+XOOjCFWGnLeR9969xfAS8Ub+ZuVUpXAfqJX0E
         D5XEIYDCgGQ54w2iHAlFyyv5MTc7xSgeW8RaGth9V3u+MWBMUh6xRGP0dh7oRJixtJki
         fTMF23stHQx87hZu/Cr4bDILHkQnvzWYLXveVPGMrzvFRQe0Gk3taRMxXHpQMc/64hxP
         vExXot7mU+D7bX3rbyB87W4Wld4fO7fuAGj/KCvyqRXAgKJRckyu+XOtqKiVqT/E08Y/
         MIYoTG/3lQUp/69R+iz7XQXH5FnRfXyzeeAl/bhGxhtRwNOyJR7L0zIsLg5s11COZ2/I
         LRjw==
X-Forwarded-Encrypted: i=1; AHgh+RrKCDRylUauY4al42SIAM1ixKs3kcArIwve8ItGo1twjEZby6f37+TQXfFy881OCJWFYXzPjcObF4fWfXDraC2+qgX0yj4=@vger.kernel.org
X-Gm-Message-State: AFuF++nod3bl7SjCrB1PSs+38RVNIVniwYYEm31BOR8GAsBOSgO57Ppb
	JW+GUXIT5rywcgw8P34Wj/bGNQjTcM4JBuWY4tFfzYxibpdnKsBrPJCeU19+tBByPWI=
X-Gm-Gg: AR+sD10jhUr4GHVU1oD9w6Lxx4ng2eHppZNLAEqO4qt0KEe8a3fG1iMQE9L5h0b/W7p
	+mFUnniQoHBfFXSG9Nxynd+d1ORmW6dWh2/1UlnjUOv8z/08vNthe220AW45kqz7aOk7ZFuCBkC
	j1cpsAUALbF4/Pi248DQRdPWjIRiqHy3Gvg9j9HV1vQv524HxFBa+UYF+HWFVAGGoDML4qVm53L
	1mpozP3jac8Oq+knVkwa3Oxgz5u4ZgSPjOJP2H2xMqgVISWxWHu6CeLlBmInNLfSVLZWp9sCmAs
	GHQEADbz29p1uO16YIAzvp8L53qp8cOR6WJ6dTgtNA655gvygIuwdGWJ4vpQojiDvu0Ivi2TU0T
	icKAv+lhxyObmUEpHBYnWzchsI9BT4wZ7MBGtH/VrBz2DR5fTR2IUf1qmu7Pruo/qT5JCw0+umo
	b9cjUr8XhzwSdYHxnydcFjFgSTWxQ2a0E9qESh1mrY1DHoUSa9+xHmfhWCU251gWFEovJ6l93CE
	AmF9WgkmmTB2V/2o0BrRaN+bEl2d3xKufl2C7h/zfkcw2Gc0rQF3eM=
X-Received: by 2002:a05:690c:e013:20b0:81f:49e1:1f15 with SMTP id 00721157ae682-849ea01a334mr58148687b3.0.1787504699844;
        Sun, 23 Aug 2026 10:04:59 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84ca68c25aasm22529197b3.22.2026.08.23.10.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:04:58 -0700 (PDT)
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
Date: Mon, 24 Aug 2026 01:04:48 +0800
Message-ID: <20260823170448.3856516-1-nicoyip.dev@gmail.com>
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

Fixes: 454804ab0302 ("keys: make procfiles per-user-namespace")
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

