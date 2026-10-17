Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453213BF66B
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792224992; cv=none; b=CjuCy89qJzm6eShyq3wlGT3HP1k8MxkdI1/+MtLfKBD3PuXlNCJ9wNmGgDb+VRdtnlecZ76fKfnZuQywzESDZ7kz0NQKLFDuYWjUCg3P/2eIM2AI/IebaFHzUQzqvyol01j5NOCjwqxG3Fd9Qcsm6c+MzvlFFvW1IppFL8h8HZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792224992; c=relaxed/simple;
	bh=KOss2RXNEsYXOLGcex6zn2KON6+z01gxh5ch8cLaMJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VHTHshxtPcu5lZc5WsMo2KgWZDhFxbPD+3pmuJMrZ36IC0GKF1rLvhWByipFyz9P2BYEEgFzBCRxPYsD6Ss3kg3f22KftKzAHzAn69awnfqUBjAgBfSs81tNl6uhDsUwIQm16g9pit5oboyvWC5yty89W9XyzpOIv3K5nJX4aUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rxvn0DrB; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxvn0DrB"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ab868eb9cfso403836a91.0
        for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 01:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792224991; x=1792829791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Rvkgh3Vtn4gb/N875529l68oF+mXegyVxx4uqGo40A=;
        b=rxvn0DrBGA4lUspUCoMRnhQoLszSi69RyZVnC97bvR5v++ZzYwPFMWx8o3uQ0O6ZqU
         J0Y36YYqGq43zUk+1GugNgHhflWfd3vAKJITCTkpYPjxoJZ1HAUGhx4YUQkgA8g+9yz0
         joTqo9B8chmNRu3cY/PXnkOskC2xxitsrRg54Kh7tJXm38sbC2juv2T1mmR0rhhyajZf
         KWclV2A4WiVZvPfS9wnB/3I5gJCJVToNiyT6YtIYhz024vsu7gq79fE5khitzfcaKEqd
         rzRdaD+a65oBybA3b+jBSXYxFpG5iRVp1ZN6JUR22o0XPLwQe60Jwcog6quxl3bBBSrQ
         h6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792224991; x=1792829791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Rvkgh3Vtn4gb/N875529l68oF+mXegyVxx4uqGo40A=;
        b=s+9rSACD8JPg6WgIFtF5ZBIUP3x1YAtKzpJ58wuRzUuc8AFPJsBGgoJ7afWqxKQBps
         /BtaBin/3tQ3tIYfHIBf0xA0+0UmitDZQf34RWS3c4zOo6fLEW0cUzp96nm1ADkLhAfH
         hdkOCo7D0yeAOXUwtXn1n7a8mLsdv1t32HQoeoI3cBiEWszR4VAMO1mEeaaG8W5pDSBD
         +I3adj62N0RzUEbCoP+H2YA/48k2hgO9aml7r6MhELbeBb5BpGyZHC7Q+rEW/OOguJwo
         i2rPgadTR971JghQztt3s1WH8IeOgCPZg0seBKKHfgaUHpzJew2YgpjpEEb05f0usepg
         FWsw==
X-Forwarded-Encrypted: i=1; AKwUvBzOM4W5rfD1Ys1z1k426wFAVIf5uhoFctOfJEz6YpXUbRVjDP6dLhbuuG37H/Ied6kQQhzwKm3auhvrOr0W0dbENPQ1Yr8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIzJoGsMpluJkH/KLm1o50bdnzUDBcgQoQH9/Kmld3FKwXDyCpV
	teepT7cIiqIEzWHTbJgeOjF40tD6wGOXGAq4HygxhBeGnzNQe1b8dPSX
X-Gm-Gg: AYBFou35v5kcuz0O/+kP6l0ZXBx7MljpWafvuojiUQup2o9uUpVl0BDCqxhRyDZ0seB
	qhQHOXP6S8oTRGH0AUr/08ZFbPxR/dHDrHVc0XhBe0f22w06H8uWVMs+dmi+UCj/460lj1jyPXL
	qZll1eR+ppqKjoq2hv+VlGQG1y0LTshvDp5BQlp/tsS4InxnsV8fdSrqfG5J4GNX5XF6DpO/XTg
	KExDJQ7lWYkeKHOiaj6DEZxGsZ2dPD+/CXfhqPmeF2yo46yxhXOuESzVQBuCzsFBNfqrD5aiazI
	2TiWIUvVeSweNf6u4qNI5ZcanPuCEgUzpKMKjZX8+lxWWDIUnHfOgWKqR1LUu+lALzoAR4S2qVR
	gT+tlxH91LT/w5P0KZdnB0SLo/6LMcEmMhBpZJZ+vK45rEu3ByKhfdvv+5eHvIrya4YlvrnEDtr
	Frxls9h8XNvkHr7Xjfsqp2Hce3VOivi2hGsluyqwBf+OT5tuTM1F1IoXAjdJXn/M6tTw==
X-Received: by 2002:a17:90a:e7ca:b0:3ac:7872:d1b7 with SMTP id 98e67ed59e1d1-3acef14859dmr1938332a91.32.1792224990592;
        Sat, 17 Oct 2026 01:16:30 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc980a548sm3607125a91.0.2026.10.17.01.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 01:16:30 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ebiggers@kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] keys: Avoid owner account dereferences in /proc/keys
Date: Sat, 17 Oct 2026 16:16:22 +0800
Message-Id: <pm-keys-proc-owner-uid-followup-20261017-v2-8f8f34a41eb1bbb94ef0@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The namespace filters in find_ge_key() and key_serial_next() read
key->user->uid while traversing the serial tree under key_serial_lock.
That lock keeps the key allocated, but it does not protect the separate
key_user from ownership changes.

A /proc/keys read reaches find_ge_key() through proc_keys_start(), and
key_serial_next() through proc_keys_next(). The lock stays held until
proc_keys_stop().

A successful privileged KEYCTL_CHOWN on the same key replaces key->user
under key->sem and drops the old owner's reference after releasing the
semaphore. If that was the old dynamic key_user's last reference, a
/proc/keys reader can access freed memory:

    /proc/keys reader                   KEYCTL_CHOWN
    proc_keys_start()                    keyctl_chown_key()
      spin_lock(key_serial_lock)          down_write(key->sem)
      find_ge_key()
        old = minkey->user
                                          zapowner = key->user
                                          key->user = newowner
                                          key->uid = uid
                                          up_write(key->sem)
                                          key_put(key)
                                          key_user_put(zapowner)
                                            kfree(zapowner)
        read old->uid -> use-after-free
    proc_keys_stop()
      spin_unlock(key_serial_lock)

Use the inline key->uid in both filters, following the approach already
used by find_keyring_by_name(). The serial-tree lock keeps the containing
key alive, so filtering no longer depends on the quota owner's lifetime.
This also uses the same owner UID as proc_keys_show() and the permission
check.

For thread keyrings, key_fsuid_changed() can update key->uid without
changing the quota owner. The filters now follow that current owner UID,
including when its namespace mapping differs from the quota owner's.

Fixes: 454804ab0302 ("keys: make procfiles per-user-namespace")
Suggested-by: Eric Biggers <ebiggers@kernel.org>
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

---
 security/keys/proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/proc.c b/security/keys/proc.c
index 4f4e2c1824f1..aea06a74d0fe 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -68,7 +68,7 @@ static struct rb_node *key_serial_next(struct seq_file *p, struct rb_node *n)
 	n = rb_next(n);
 	while (n) {
 		struct key *key = rb_entry(n, struct key, serial_node);
-		if (kuid_has_mapping(user_ns, key->user->uid))
+		if (kuid_has_mapping(user_ns, key->uid))
 			break;
 		n = rb_next(n);
 	}
@@ -100,7 +100,7 @@ static struct key *find_ge_key(struct seq_file *p, key_serial_t id)
 		return NULL;
 
 	for (;;) {
-		if (kuid_has_mapping(user_ns, minkey->user->uid))
+		if (kuid_has_mapping(user_ns, minkey->uid))
 			return minkey;
 		n = rb_next(&minkey->serial_node);
 		if (!n)

base-commit: a626e44fd64c456d373ae8c28b939197b9446a02
