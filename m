Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46738E5C4
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326273; cv=none; b=SDLoh7/rxYHLlRrtf3uGN5+m9JXIWpK6WS8KVuxTLx1HQXy9g1h1ipC9caPiewvWr+lA36UssMexV6X+llo3b1PXMWl7LBGcjCV0RmW6EC6qjTzFsquY433FeuQ4nIMiaqa8ZaDlChSphlCWlbr0B3hjdyfz8cVTc8k3TyInBkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326273; c=relaxed/simple;
	bh=kv2uDg2+0iHsl5szpBFyX4vgGSWyCvmnZYkeqTTse+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uUEDATt5ryLkQ/DdX2WUgdxYSRS8d1iWQKXhY3fzRbS3jzIpQsztzmJv47GDUiGBk0hiAzptMsgSitSYYqEyqEKc0EmSWMs5zYRDQWtUZMJA4J8s7SEwAnoCE0PMl3Y6QqGukDRz1xATcyXZFJ0iSW/2E61QPr/zcVbcb6jkdwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=I2mWoHuW; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="I2mWoHuW"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-81c5aac8478so688750a34.0
        for <linux-security-module@vger.kernel.org>; Tue, 06 Oct 2026 15:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791326270; x=1791931070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AKKY9Fkibh1XMid4ztLQiWwJPl9GxPacahqvWme53CY=;
        b=I2mWoHuWHozgSspO7WZskL+0zGGDpfux1j0DPS2m24NYLqb13bi2oCkGwPBzXDGOT0
         0ULjENc9SHMJqeZV8P7GMe2Lkiz2MtNuGeXWYgh/XoV6iRcauPh+/rZ64xS5BE5lC+KR
         tkyrk4nemL7V3kAW3higIpdCbGB2mCq+H5JOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791326270; x=1791931070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AKKY9Fkibh1XMid4ztLQiWwJPl9GxPacahqvWme53CY=;
        b=sSUvHgqwNXER1Hta5D4YYNcaqiVWkV8rhMW+Fyo91Zu4a9qo4SdAQCV8J+kD3l6/e/
         NCfC9CAIBHeOCtPwE8qNZX42m5qsDJo0QXa4QWrG1MbV72uWA7cVgbE3YDTRW5pvzz8d
         Mu3eFQeZj9wme4aWUEidNusmAyeOgflpitKOS9P2kkwHi8PAySCqW5LZECruLNjeU6dV
         uV1Fcx6PmFOrkGNc/X7rbosiAwkBpw6cMHuv5ED+bUJx+5l7sRvL2sOtmpA+2Np15uaP
         FiqiGGsuhI6h7/lDJU8YRbgBHL73QrybtYRMVwAOO04I451v8F0vCN4Lt5g9ZBz83UoZ
         EzSA==
X-Forwarded-Encrypted: i=1; AKwUvBz7ROk5J23huLWAHDH3PHnWm1nOdsS/hnbvGE3UL/ocvt9bheiCr6GngLVTI1lpKzs3PPiJ53vr/StR/lGHv//qtWirvQc=@vger.kernel.org
X-Gm-Message-State: AFuF++mtAVz9X8tagRmj4UPn0CdejjGKpUk1SCwaoXQQxqDnJidBhg7A
	h+H6fH7NV51BC/ic4nyCtS/CLeX4N3clCq23wAXKAyGls2s/kzXt8Yj68F3T9fR4Pto=
X-Gm-Gg: AYBFou37gZw7frIhFw4ZgYeGFTIFC9HcAUyEuroDH05mFFzsNDDQt1BHJzbppDl4S+a
	WKlvu3Basnf8waNMZV0bosheVI4o1kvsYIoOoGP9eX8Aawdgtzkht5P37I63VNDAqPpWVUtGSYu
	cXTlE4cmoDiXiVjgWiGvB0cfNz7QR2LndF2+OvydJJ1v2bddqTo2Jw3RA7rBqeEXLBfMOk/gMWt
	CaIrZes0N913JLqiJwijzc7Pxk8r8vqmNyHccWWyY9pmWRF2ul8pTekgecFiFNtwEb1c6ydW28e
	PBuSYB6sloattovVZPhIrL+xQ5x+37lbRmg64+2R2cOmeXeBsZdF75HN2e27FvZdvd/RFwDz4yK
	RJ6rGxA8tykHH5c0S4IM9nwUekmyFBDJANcL2u208jJQk+xUCPHebVJH6rMJO7PWwDKxbSTg1NL
	aWO2RlM1kQUJpMx7Ty4FpSiLah9CSUKAIfJqUy3ccOGxbu87DByR/e9XOAppuB9Ove/bhg9JNY5
	XH35QTbY9AYuyNUyUTRLSg/MF6exTyrRCZCHzD9rXCqMVs3E14Uct+H0g3m1iVFPxqmjlO2C34=
X-Received: by 2002:a05:6808:6609:b0:4c2:5ac:7f9e with SMTP id 5614622812f47-4fc478aa20fmr673868b6e.43.1791326270458;
        Tue, 06 Oct 2026 15:37:50 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4fc49032c44sm656436b6e.10.2026.10.06.15.37.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 15:37:50 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: keyrings@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	dhowells@redhat.com,
	jarkko@kernel.org,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH] keys: make keyring indexes independent of kernel addresses
Date: Tue,  6 Oct 2026 15:37:46 -0700
Message-ID: <20261006223746.48940-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KEYCTL_READ returns the serial numbers in a keyring in associative-array
traversal order.  The first word of the index is a public, deterministic
hash of the type pointer, domain pointer and description.  An unprivileged
user can therefore insert keys with known descriptions, predict their
order for each possible KASLR slide, and recover the kernel image address.
On an x86-64 build with 16 MiB alignment, 45 user keys suffice to
distinguish the candidate slides.

Remove the addresses from the whole index, not just its first hash word.
Assign each key type and domain a nonzero 64-bit ID and hash those IDs and
the description with a once-initialized SipHash key.  Use the full IDs in
the later index chunks as well.  Truncating or hashing the IDs there would
lose the guarantee that distinct type/domain/description tuples have a
differing index bit.

Allocate IDs lazily since private key types need not be registered.  Cache
them in the index key so tree walks and copies of an existing index do not
need to dereference a type descriptor that may have been unregistered.
Keep the 32-bit chunk layout and diff_objects() bit offsets consistent,
and retain the separate root slot for keyrings used by recursive search.
The key comparison, permissions and userspace data format are unchanged;
only the address-dependent in-memory ordering is replaced.

Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 include/linux/key-type.h |   1 +
 include/linux/key.h      |   5 ++
 security/keys/keyring.c  | 145 +++++++++++++++++++++------------------
 3 files changed, 83 insertions(+), 68 deletions(-)

diff --git a/include/linux/key-type.h b/include/linux/key-type.h
index bb97bd3e5af4..c4f329b6ae3f 100644
--- a/include/linux/key-type.h
+++ b/include/linux/key-type.h
@@ -161,6 +161,7 @@ struct key_type {
 				     const void *in, const void *in2);
 
 	/* internal fields */
+	atomic64_t		index_id;	/* Opaque keyring index ID */
 	struct list_head	link;		/* link in types list */
 	struct lock_class_key	lock_class;	/* key->sem lock class */
 } __randomize_layout;
diff --git a/include/linux/key.h b/include/linux/key.h
index 81b8f05c6898..e40b5267658f 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -107,6 +107,7 @@ struct keyring_name;
 
 struct key_tag {
 	struct rcu_head		rcu;
+	atomic64_t		index_id;	/* Opaque keyring index ID */
 	refcount_t		usage;
 	bool			removed;	/* T when subject removed */
 };
@@ -129,6 +130,8 @@ struct keyring_index_key {
 	struct key_type		*type;
 	struct key_tag		*domain_tag;	/* Domain of operation */
 	const char		*description;
+	u64			type_id;	/* Cached index IDs */
+	u64			domain_id;
 };
 
 union key_payload {
@@ -251,6 +254,8 @@ struct key {
 			struct key_type	*type;		/* type of key */
 			struct key_tag	*domain_tag;	/* Domain of operation */
 			char		*description;
+			u64		type_id;
+			u64		domain_id;
 		};
 	};
 
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 15bf4af8f282..c03e394b885d 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -14,6 +14,9 @@
 #include <linux/err.h>
 #include <linux/user_namespace.h>
 #include <linux/nsproxy.h>
+#include <linux/once.h>
+#include <linux/random.h>
+#include <linux/siphash.h>
 #include <keys/keyring-type.h>
 #include <keys/user-type.h>
 #include <linux/assoc_array_priv.h>
@@ -147,49 +150,46 @@ static int keyring_instantiate(struct key *keyring,
 }
 
 /*
- * Multiply 64-bits by 32-bits to 96-bits and fold back to 64-bit.  Ideally we'd
- * fold the carry back too, but that requires inline asm.
+ * Give key types and domains address-independent identities.  Zero means that
+ * an ID has not yet been allocated.  As with inode sequence numbers used by
+ * futexes, this relies on the 64-bit counter not wrapping in a machine's
+ * lifetime.
  */
-static u64 mult_64x32_and_fold(u64 x, u32 y)
+static u64 key_index_id(atomic64_t *id)
 {
-	u64 hi = (u64)(u32)(x >> 32) * y;
-	u64 lo = (u64)(u32)(x) * y;
-	return lo + ((u64)(u32)hi << 32) + (u32)(hi >> 32);
+	static atomic64_t next_id;
+	u64 old, new;
+
+	old = atomic64_read(id);
+	if (likely(old))
+		return old;
+
+	do {
+		new = atomic64_inc_return(&next_id);
+	} while (WARN_ON_ONCE(!new));
+
+	old = 0;
+	if (!atomic64_try_cmpxchg_relaxed(id, &old, new))
+		return old;
+	return new;
 }
 
 /*
- * Hash a key type and description.
+ * Hash a key type, domain and description.  KEYCTL_READ exposes the tree's
+ * traversal order, so no part of the index may contain kernel addresses.
  */
 static void hash_key_type_and_desc(struct keyring_index_key *index_key)
 {
+	static siphash_key_t hash_key __read_mostly;
 	const unsigned level_shift = ASSOC_ARRAY_LEVEL_STEP;
 	const unsigned long fan_mask = ASSOC_ARRAY_FAN_MASK;
-	const char *description = index_key->description;
-	unsigned long hash, type;
-	u32 piece;
+	unsigned long hash;
 	u64 acc;
-	int n, desc_len = index_key->desc_len;
-
-	type = (unsigned long)index_key->type;
-	acc = mult_64x32_and_fold(type, desc_len + 13);
-	acc = mult_64x32_and_fold(acc, 9207);
-	piece = (unsigned long)index_key->domain_tag;
-	acc = mult_64x32_and_fold(acc, piece);
-	acc = mult_64x32_and_fold(acc, 9207);
-
-	for (;;) {
-		n = desc_len;
-		if (n <= 0)
-			break;
-		if (n > 4)
-			n = 4;
-		piece = 0;
-		memcpy(&piece, description, n);
-		description += n;
-		desc_len -= n;
-		acc = mult_64x32_and_fold(acc, piece);
-		acc = mult_64x32_and_fold(acc, 9207);
-	}
+
+	get_random_once(&hash_key, sizeof(hash_key));
+	acc = siphash(index_key->description, index_key->desc_len, &hash_key);
+	acc = siphash_3u64(index_key->type_id, index_key->domain_id, acc,
+			   &hash_key);
 
 	/* Fold the hash down to 32 bits if need be. */
 	hash = acc;
@@ -209,7 +209,7 @@ static void hash_key_type_and_desc(struct keyring_index_key *index_key)
 
 /*
  * Finalise an index key to include a part of the description actually in the
- * index key, to set the domain tag and to calculate the hash.
+ * index key, to set the domain tag and index IDs, and to calculate the hash.
  */
 void key_set_index_key(struct keyring_index_key *index_key)
 {
@@ -225,6 +225,14 @@ void key_set_index_key(struct keyring_index_key *index_key)
 			index_key->domain_tag = &default_domain_tag;
 	}
 
+	/* Preserve the IDs when copying an existing key's index.  In
+	 * particular, its type may already have been unregistered.
+	 */
+	if (!index_key->type_id)
+		index_key->type_id = key_index_id(&index_key->type->index_id);
+	if (!index_key->domain_id)
+		index_key->domain_id = key_index_id(&index_key->domain_tag->index_id);
+
 	hash_key_type_and_desc(index_key);
 }
 
@@ -263,11 +271,14 @@ void key_remove_domain(struct key_tag *domain_tag)
 /*
  * Build the next index key chunk.
  *
+ * The hash and inline description are followed by the 64-bit type and domain
+ * IDs, low word first, and then by the rest of the description.
  * We return it one word-sized chunk at a time.
  */
 static unsigned long keyring_get_key_chunk(const void *data, int level)
 {
 	const struct keyring_index_key *index_key = data;
+	const unsigned int id_chunks = sizeof(u64) / sizeof(unsigned long);
 	unsigned long chunk = 0;
 	const u8 *d;
 	int desc_len = index_key->desc_len, n = sizeof(chunk);
@@ -279,27 +290,30 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
 		return index_key->hash;
 	case 1:
 		return index_key->x;
-	case 2:
-		return (unsigned long)index_key->type;
-	case 3:
-		return (unsigned long)index_key->domain_tag;
-	default:
-		level -= 4;
-		offset = sizeof(index_key->desc) + level * sizeof(long);
-		if (desc_len <= offset)
-			return 0;
-
-		d = index_key->description + offset;
-		desc_len -= offset;
-		if (desc_len > n)
-			desc_len = n;
-		d += desc_len;
-		do {
-			chunk <<= 8;
-			chunk |= *--d;
-		} while (--desc_len > 0);
-		return chunk;
 	}
+
+	level -= 2;
+	if (level < id_chunks)
+		return index_key->type_id >> (level * ASSOC_ARRAY_KEY_CHUNK_SIZE);
+	level -= id_chunks;
+	if (level < id_chunks)
+		return index_key->domain_id >> (level * ASSOC_ARRAY_KEY_CHUNK_SIZE);
+	level -= id_chunks;
+
+	offset = sizeof(index_key->desc) + level * sizeof(long);
+	if (desc_len <= offset)
+		return 0;
+
+	d = index_key->description + offset;
+	desc_len -= offset;
+	if (desc_len > n)
+		desc_len = n;
+	d += desc_len;
+	do {
+		chunk <<= 8;
+		chunk |= *--d;
+	} while (--desc_len > 0);
+	return chunk;
 }
 
 static unsigned long keyring_get_object_key_chunk(const void *object, int level)
@@ -330,6 +344,7 @@ static int keyring_diff_objects(const void *object, const void *data)
 	const struct keyring_index_key *a = &key_a->index_key;
 	const struct keyring_index_key *b = data;
 	unsigned long seg_a, seg_b;
+	u64 diff;
 	int level, i;
 
 	level = 0;
@@ -339,28 +354,22 @@ static int keyring_diff_objects(const void *object, const void *data)
 		goto differ;
 	level += ASSOC_ARRAY_KEY_CHUNK_SIZE / 8;
 
-	/* The number of bits contributed by the hash is controlled by a
-	 * constant in the assoc_array headers.  Everything else thereafter we
-	 * can deal with as being machine word-size dependent.
-	 */
+	/* The inline description contributes one machine-word-sized chunk. */
 	seg_a = a->x;
 	seg_b = b->x;
 	if ((seg_a ^ seg_b) != 0)
 		goto differ;
 	level += sizeof(unsigned long);
 
-	/* The next bit may not work on big endian */
-	seg_a = (unsigned long)a->type;
-	seg_b = (unsigned long)b->type;
-	if ((seg_a ^ seg_b) != 0)
-		goto differ;
-	level += sizeof(unsigned long);
+	diff = a->type_id ^ b->type_id;
+	if (diff)
+		return level * 8 + __ffs64(diff);
+	level += sizeof(u64);
 
-	seg_a = (unsigned long)a->domain_tag;
-	seg_b = (unsigned long)b->domain_tag;
-	if ((seg_a ^ seg_b) != 0)
-		goto differ;
-	level += sizeof(unsigned long);
+	diff = a->domain_id ^ b->domain_id;
+	if (diff)
+		return level * 8 + __ffs64(diff);
+	level += sizeof(u64);
 
 	i = sizeof(a->desc);
 	if (a->desc_len <= i)
-- 
2.53.0

