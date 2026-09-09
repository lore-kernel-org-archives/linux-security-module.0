Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FD7545288
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953656; cv=none; b=UvqzNV6XKHrjMZFYcGYRc50f9veL7cXY+98gP/1SimRI62c5hm+prH5RIV8qFYZ4tIOo50mm3+SrNTasgq0SLNz5A9TaS2lg+9o1vxp3WAg+xuj7MoDW6t1r1AkIVOMeoNsugeSCoXpjgXLhNKnVv4+//A4m2tc6EZLoGRyLPZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953656; c=relaxed/simple;
	bh=OXFIMHllfCbUDegbtzI2QAs1imgWJlMGgb0lax5+wlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SAS9GWD8VSJYO4eLTGG07rWU/L+iXtSfi4o1Du1nRbSlfYaxpFOo2jhZdCX/QnZP7/os4ONIXh+nUuZTnyjq2liGHzn0dMV2J/4L6RDdxRkN8Usatx600CYDjSrEwhIv7s9soPDA1F7sWFbmIdiqWgrz59XKvliR32WSMbiBMSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=i2WYyEEE; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="i2WYyEEE"
Received: from sec-questing-amd64 (lfbn-idf3-1-218-1.w90-22.abo.wanadoo.fr [90.22.217.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BAA1A40A1A;
	Wed,  9 Sep 2026 11:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788953645;
	bh=DqRUgMKbQ+vFIldbCaUFMnjpRmH95lD69bHloYCItzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=i2WYyEEETPppNT5HfwXY9XwGqbheUU/3vEZCqRAA6Fevx1x8DTCc6mMoEwBhhOVv4
	 ytbPGTmyk7py1sP5I0/U8FXm6atkBpePekM34Ebjppnbh586eEgapL7lRAQ2rdwGZR
	 5Aj4jnYNtI9nOOWNLXlz0ExztU1yggmhBSh/uVzsQruN75TEIe74+ipG2N+kSsa8ol
	 SbwAj3KCbSmoAYBFpuP46yeonItRcdjabI6kXancGe4KCUli8B7l5oX5RHX4T5QQhp
	 Tvbh6U4e6bhAW7782VDc62kFW4nIsGK6j9+v3jwYCagzfZLWF/QdLfFqNrtIgC/M4h
	 5QWtNKggZ1a2Pzr+sqkj6zN9Q4CItIoDbyKLea1mhN5Qlpg+vZ4dlpwL3iwwRPvKWQ
	 IA9CD53k0v+YRPgprJNcjELJ4VmcQQKEI6X5gXsXYsHG/1Fd5qhtwIR4kha6kw4hfc
	 ofjNBn229iEXudaVRI+XjDB+bQL568DgoeXA3+IRdAHVuyglXh4fAHoRoSgmln88mQ
	 rN50AsOlustBKJRN4q/+uwyHPsO5rzQe56nK2R9kQhstj6kQhe4w+rEmafOB7AOUCB
	 TKzbQjyvK9VKTemYbLofvnRQHaJ9mOA0sShWOOYk+Q/GKp3Z2xwLihkTLMwiK/2dIG
	 lxSo3GPXQMAtwUiIi0Ke3IjI=
From: =?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: [PATCH] apparmor: dedup perms entries when mapping older policy
Date: Wed,  9 Sep 2026 13:26:40 +0200
Message-ID: <20260909112729.96483-1-maxime.belair@canonical.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Older policy carries the permissions of a state in the dfa accept
tables. The compat mapping expands them into a struct aa_perms table
holding one entry per state, (two for file dfas) It then rewrites each
accept entry to the index of its state's entry.

However, as struct aa_perms are currently 52 bytes, these states cost
much more than the 8-byte accept tables they were built from, making the
loading policy several times the size of its dfa.

Most states have the same few permission sets, so compute each set once
and share it. A small hash table keyed on the accept words finds an
existing entry, and the accept table gets the index of that entry,
which is the same layout newer policy already uses. File dfas keep owner
and non-owner entries together, for aa_lookup_condperms()

Policy built by parsers <4.1 always takes this path. With Ubuntu 24.04's
4.0.1 parser on the profiles of its apparmor.git tree, the perms tables
go from 10.3 MB to 119 KB, the in-kernel policy from 14.4 MB to 4.2 MB,
and loading it all from 33 ms to 28 ms.

Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
---
 security/apparmor/policy_compat.c | 437 ++++++++++++++++++++----------
 1 file changed, 287 insertions(+), 150 deletions(-)

diff --git a/security/apparmor/policy_compat.c b/security/apparmor/policy_compat.c
index 94e4b781d33c..39db116577ed 100644
--- a/security/apparmor/policy_compat.c
+++ b/security/apparmor/policy_compat.c
@@ -15,6 +15,9 @@
 
 #include <linux/ctype.h>
 #include <linux/errno.h>
+#include <linux/hash.h>
+#include <linux/overflow.h>
+#include <linux/string.h>
 
 #include "include/lib.h"
 #include "include/policy_unpack.h"
@@ -49,25 +52,21 @@ static u32 dfa_map_xindex(u16 mask)
 
 /*
  * map old dfa inline permissions to new format
+ * takes the raw accept words as the tables are rewritten in place
  */
-#define dfa_user_allow(dfa, state) (((ACCEPT_TABLE(dfa)[state]) & 0x7f) | \
-				    ((ACCEPT_TABLE(dfa)[state]) & 0x80000000))
-#define dfa_user_xbits(dfa, state) (((ACCEPT_TABLE(dfa)[state]) >> 7) & 0x7f)
-#define dfa_user_audit(dfa, state) ((ACCEPT_TABLE2(dfa)[state]) & 0x7f)
-#define dfa_user_quiet(dfa, state) (((ACCEPT_TABLE2(dfa)[state]) >> 7) & 0x7f)
-#define dfa_user_xindex(dfa, state) \
-	(dfa_map_xindex(ACCEPT_TABLE(dfa)[state] & 0x3fff))
-
-#define dfa_other_allow(dfa, state) ((((ACCEPT_TABLE(dfa)[state]) >> 14) & \
-				      0x7f) |				\
-				     ((ACCEPT_TABLE(dfa)[state]) & 0x80000000))
-#define dfa_other_xbits(dfa, state) \
-	((((ACCEPT_TABLE(dfa)[state]) >> 7) >> 14) & 0x7f)
-#define dfa_other_audit(dfa, state) (((ACCEPT_TABLE2(dfa)[state]) >> 14) & 0x7f)
-#define dfa_other_quiet(dfa, state) \
-	((((ACCEPT_TABLE2(dfa)[state]) >> 7) >> 14) & 0x7f)
-#define dfa_other_xindex(dfa, state) \
-	dfa_map_xindex((ACCEPT_TABLE(dfa)[state] >> 14) & 0x3fff)
+#define dfa_user_allow(accept1) (((accept1) & 0x7f) | \
+				 ((accept1) & 0x80000000))
+#define dfa_user_xbits(accept1) (((accept1) >> 7) & 0x7f)
+#define dfa_user_audit(accept2) ((accept2) & 0x7f)
+#define dfa_user_quiet(accept2) (((accept2) >> 7) & 0x7f)
+#define dfa_user_xindex(accept1) (dfa_map_xindex((accept1) & 0x3fff))
+
+#define dfa_other_allow(accept1) ((((accept1) >> 14) & 0x7f) | \
+				  ((accept1) & 0x80000000))
+#define dfa_other_xbits(accept1) ((((accept1) >> 7) >> 14) & 0x7f)
+#define dfa_other_audit(accept2) (((accept2) >> 14) & 0x7f)
+#define dfa_other_quiet(accept2) ((((accept2) >> 7) >> 14) & 0x7f)
+#define dfa_other_xindex(accept1) dfa_map_xindex(((accept1) >> 14) & 0x3fff)
 
 /**
  * map_old_perms - map old file perms layout to the new layout
@@ -97,99 +96,50 @@ static u32 map_old_perms(u32 old)
 	return new;
 }
 
-static void compute_fperms_allow(struct aa_perms *perms, const struct aa_dfa *dfa,
-				 aa_state_t state)
+static void compute_fperms_allow(struct aa_perms *perms, u32 accept1)
 {
 	perms->allow |= AA_MAY_GETATTR;
 
 	/* change_profile wasn't determined by ownership in old mapping */
-	if (ACCEPT_TABLE(dfa)[state] & 0x80000000)
+	if (accept1 & 0x80000000)
 		perms->allow |= AA_MAY_CHANGE_PROFILE;
-	if (ACCEPT_TABLE(dfa)[state] & 0x40000000)
+	if (accept1 & 0x40000000)
 		perms->allow |= AA_MAY_ONEXEC;
 }
 
-static struct aa_perms compute_fperms_user(const struct aa_dfa *dfa,
-					   aa_state_t state)
+static struct aa_perms compute_fperms_user(u32 accept1, u32 accept2)
 {
 	struct aa_perms perms = { };
 
-	perms.allow = map_old_perms(dfa_user_allow(dfa, state));
-	perms.audit = map_old_perms(dfa_user_audit(dfa, state));
-	perms.quiet = map_old_perms(dfa_user_quiet(dfa, state));
-	perms.xindex = dfa_user_xindex(dfa, state);
+	perms.allow = map_old_perms(dfa_user_allow(accept1));
+	perms.audit = map_old_perms(dfa_user_audit(accept2));
+	perms.quiet = map_old_perms(dfa_user_quiet(accept2));
+	perms.xindex = dfa_user_xindex(accept1);
 
-	compute_fperms_allow(&perms, dfa, state);
+	compute_fperms_allow(&perms, accept1);
 
 	return perms;
 }
 
-static struct aa_perms compute_fperms_other(const struct aa_dfa *dfa,
-					    aa_state_t state)
+static struct aa_perms compute_fperms_other(u32 accept1, u32 accept2)
 {
 	struct aa_perms perms = { };
 
-	perms.allow = map_old_perms(dfa_other_allow(dfa, state));
-	perms.audit = map_old_perms(dfa_other_audit(dfa, state));
-	perms.quiet = map_old_perms(dfa_other_quiet(dfa, state));
-	perms.xindex = dfa_other_xindex(dfa, state);
+	perms.allow = map_old_perms(dfa_other_allow(accept1));
+	perms.audit = map_old_perms(dfa_other_audit(accept2));
+	perms.quiet = map_old_perms(dfa_other_quiet(accept2));
+	perms.xindex = dfa_other_xindex(accept1);
 
-	compute_fperms_allow(&perms, dfa, state);
+	compute_fperms_allow(&perms, accept1);
 
 	return perms;
 }
 
-/**
- * compute_fperms - convert dfa compressed perms to internal perms and store
- *		    them so they can be retrieved later.
- * @dfa: a dfa using fperms to remap to internal permissions
- * @size: Returns the permission table size
- *
- * Returns: remapped perm table
- */
-static struct aa_perms *compute_fperms(const struct aa_dfa *dfa,
-				       u32 *size)
-{
-	aa_state_t state;
-	unsigned int state_count;
-	struct aa_perms *table;
-
-	AA_BUG(!dfa);
-
-	state_count = dfa->tables[YYTD_ID_BASE]->td_lolen;
-	/* DFAs are restricted from having a state_count of less than 2 */
-	table = kvzalloc_objs(struct aa_perms, state_count * 2);
-	if (!table)
-		return NULL;
-	*size = state_count * 2;
-
-	for (state = 0; state < state_count; state++) {
-		table[state * 2] = compute_fperms_user(dfa, state);
-		table[state * 2 + 1] = compute_fperms_other(dfa, state);
-	}
-
-	return table;
-}
-
-static struct aa_perms *compute_xmatch_perms(const struct aa_dfa *xmatch,
-				      u32 *size)
+static struct aa_perms compute_xmatch_entry(u32 accept1)
 {
-	struct aa_perms *perms;
-	int state;
-	int state_count;
-
-	AA_BUG(!xmatch);
-
-	state_count = xmatch->tables[YYTD_ID_BASE]->td_lolen;
-	/* DFAs are restricted from having a state_count of less than 2 */
-	perms = kvzalloc_objs(struct aa_perms, state_count);
-	if (!perms)
-		return NULL;
-	*size = state_count;
+	struct aa_perms perms = { };
 
-	/* zero init so skip the trap state (state == 0) */
-	for (state = 1; state < state_count; state++)
-		perms[state].allow = dfa_user_allow(xmatch, state);
+	perms.allow = dfa_user_allow(accept1);
 
 	return perms;
 }
@@ -207,15 +157,14 @@ static u32 map_xbits(u32 x)
 		((x & 0x7e) << 9);
 }
 
-static struct aa_perms compute_perms_entry(const struct aa_dfa *dfa,
-					   aa_state_t state,
+static struct aa_perms compute_perms_entry(u32 accept1, u32 accept2,
 					   u32 version)
 {
 	struct aa_perms perms = { };
 
-	perms.allow = dfa_user_allow(dfa, state);
-	perms.audit = dfa_user_audit(dfa, state);
-	perms.quiet = dfa_user_quiet(dfa, state);
+	perms.allow = dfa_user_allow(accept1);
+	perms.audit = dfa_user_audit(accept2);
+	perms.quiet = dfa_user_quiet(accept2);
 
 	/*
 	 * This mapping is convulated due to history.
@@ -228,106 +177,294 @@ static struct aa_perms compute_perms_entry(const struct aa_dfa *dfa,
 	 *     Unfortunately there is no way to force auditing on the
 	 *     perms represented by the xbits
 	 */
-	perms.allow |= map_other(dfa_other_allow(dfa, state));
+	perms.allow |= map_other(dfa_other_allow(accept1));
 	if (VERSION_LE(version, v8))
 		perms.allow |= AA_MAY_LOCK;
 	else
-		perms.allow |= map_xbits(dfa_user_xbits(dfa, state));
+		perms.allow |= map_xbits(dfa_user_xbits(accept1));
 
 	/*
 	 * for v5-v9 perm mapping in the policydb, the other set is used
 	 * to extend the general perm set
 	 */
-	perms.audit |= map_other(dfa_other_audit(dfa, state));
-	perms.quiet |= map_other(dfa_other_quiet(dfa, state));
+	perms.audit |= map_other(dfa_other_audit(accept2));
+	perms.quiet |= map_other(dfa_other_quiet(accept2));
 	if (VERSION_GT(version, v8))
-		perms.quiet |= map_xbits(dfa_other_xbits(dfa, state));
+		perms.quiet |= map_xbits(dfa_other_xbits(accept1));
 
 	return perms;
 }
 
-static struct aa_perms *compute_perms(const struct aa_dfa *dfa, u32 version,
-				      u32 *size)
+/*
+ * intern perm entries as they are computed so states sharing a permission
+ * set share a single perms table entry, instead of one entry per state
+ */
+#define INTERN_INVALID		U32_MAX
+#define INTERN_HASH_BITS_MIN	6
+#define INTERN_HASH_BITS_MAX	26	/* keeps the table under INT_MAX bytes */
+#define INTERN_PERMS_MIN	8
+
+/* open addressed, slot is stored + 1 so 0 marks a free bucket */
+struct perms_intern_ent {
+	u64 key;		/* accept words the entry was computed from */
+	u32 slot;
+	bool pair;		/* entry is followed by an 'other' entry */
+};
+
+struct perms_intern {
+	struct aa_perms *perms;
+	u32 nperms;
+	u32 pcap;
+	struct perms_intern_ent *tab;
+	u32 nent;
+	unsigned int hash_bits;
+};
+
+static bool init_intern(struct perms_intern *it)
 {
-	unsigned int state;
-	unsigned int state_count;
-	struct aa_perms *table;
+	memset(it, 0, sizeof(*it));
+	it->hash_bits = INTERN_HASH_BITS_MIN;
+	it->pcap = INTERN_PERMS_MIN;
+	it->tab = kvzalloc_objs(struct perms_intern_ent, 1UL << it->hash_bits);
+	it->perms = kvzalloc_objs(struct aa_perms, it->pcap);
 
-	AA_BUG(!dfa);
+	return it->tab && it->perms;
+}
 
-	state_count = dfa->tables[YYTD_ID_BASE]->td_lolen;
-	/* DFAs are restricted from having a state_count of less than 2 */
-	table = kvzalloc_objs(struct aa_perms, state_count);
-	if (!table)
-		return NULL;
-	*size = state_count;
+static void free_intern(struct perms_intern *it)
+{
+	kvfree(it->tab);
+	kvfree(it->perms);
+}
 
-	/* zero init so skip the trap state (state == 0) */
-	for (state = 1; state < state_count; state++) {
-		table[state] = compute_perms_entry(dfa, state, version);
-		AA_DEBUG(DEBUG_UNPACK,
-			 "[%d]: (0x%x/0x%x/0x%x//0x%x/0x%x//0x%x), converted from accept1: 0x%x, accept2: 0x%x",
-			 state, table[state].allow, table[state].deny,
-			 table[state].prompt, table[state].audit,
-			 table[state].quiet, table[state].xindex,
-			 ACCEPT_TABLE(dfa)[state], ACCEPT_TABLE2(dfa)[state]);
-	}
-	return table;
+/* returns the bucket holding @key, or the free bucket for it */
+static u32 probe_intern(const struct perms_intern *it, u64 key)
+{
+	u32 mask = (1UL << it->hash_bits) - 1;
+	u32 i = hash_64(key, it->hash_bits);
+
+	while (it->tab[i].slot && it->tab[i].key != key)
+		i = (i + 1) & mask;
+
+	return i;
 }
 
-/**
- * remap_dfa_accept - remap old dfa accept table to be an index
- * @dfa: dfa to do the remapping on
- * @factor: scaling factor for the index conversion.
- *
- * Used in conjunction with compute_Xperms, it converts old style perms
- * that are encoded in the dfa accept tables to the new style where
- * there is a permission table and the accept table is an index into
- * the permission table.
- */
-static void remap_dfa_accept(struct aa_dfa *dfa, unsigned int factor)
+static bool grow_intern(struct perms_intern *it)
 {
-	unsigned int state;
-	unsigned int state_count = dfa->tables[YYTD_ID_BASE]->td_lolen;
+	struct perms_intern_ent *old = it->tab, *tab;
+	u32 n = 1UL << it->hash_bits;
+	u32 i;
+
+	if (it->hash_bits >= INTERN_HASH_BITS_MAX)
+		return false;
+	tab = kvzalloc_objs(struct perms_intern_ent, n * 2);
+	if (!tab)
+		return false;
+	it->tab = tab;
+	it->hash_bits++;
+	for (i = 0; i < n; i++) {
+		if (old[i].slot)
+			it->tab[probe_intern(it, old[i].key)] = old[i];
+	}
+	kvfree(old);
 
-	AA_BUG(!dfa);
+	return true;
+}
 
-	for (state = 0; state < state_count; state++) {
-		ACCEPT_TABLE(dfa)[state] = state * factor;
-		ACCEPT_TABLE2(dfa)[state] = factor > 1 ? ACCEPT_FLAG_OWNER : 0;
+/* reserve @n adjacent entries, aa_lookup_condperms() expects other at +1 */
+static u32 alloc_perms(struct perms_intern *it, u32 n)
+{
+	u32 slot = it->nperms;
+
+	if (it->nperms + n > it->pcap) {
+		struct aa_perms *perms;
+
+		if (it->pcap > U32_MAX / 2)
+			return INTERN_INVALID;
+		perms = kvrealloc(it->perms,
+				  size_mul(it->pcap * 2, sizeof(*perms)),
+				  GFP_KERNEL);
+		if (!perms)
+			return INTERN_INVALID;
+		it->perms = perms;
+		it->pcap *= 2;
 	}
+	it->nperms += n;
+
+	return slot;
+}
+
+/* record that @key maps to @slot */
+static bool bind_intern(struct perms_intern *it, u64 key, u32 slot, bool pair)
+{
+	u32 i;
+
+	/* keep below 3/4 load so probing terminates */
+	if ((it->nent + 1) * 4 > (1UL << it->hash_bits) * 3 &&
+	    !grow_intern(it))
+		return false;
+	i = probe_intern(it, key);
+	it->tab[i].key = key;
+	it->tab[i].slot = slot + 1;
+	it->tab[i].pair = pair;
+	it->nent++;
+
+	return true;
+}
+
+static void publish_perms(struct perms_intern *it, struct aa_policydb *policy)
+{
+	policy->perms = it->perms;
+	policy->size = it->nperms;
+	it->perms = NULL;
 }
 
 /* TODO: merge different dfa mappings into single map_policy fn */
 int aa_compat_map_xmatch(struct aa_policydb *policy)
 {
-	policy->perms = compute_xmatch_perms(policy->dfa, &policy->size);
-	if (!policy->perms)
-		return -ENOMEM;
+	struct aa_dfa *dfa = policy->dfa;
+	struct perms_intern it;
+	unsigned int state, state_count;
+	int error = -ENOMEM;
 
-	remap_dfa_accept(policy->dfa, 1);
+	AA_BUG(!dfa);
 
-	return 0;
+	state_count = dfa->tables[YYTD_ID_BASE]->td_lolen;
+	if (!init_intern(&it))
+		goto out;
+
+	/* trap state keeps the zero perms it had, slot 0 is zero from alloc */
+	it.nperms = 1;
+	ACCEPT_TABLE(dfa)[0] = 0;
+	ACCEPT_TABLE2(dfa)[0] = 0;
+
+	for (state = 1; state < state_count; state++) {
+		u32 accept1 = ACCEPT_TABLE(dfa)[state];
+		u64 key = (u64)accept1 << 32;
+		u32 i = probe_intern(&it, key);
+		u32 slot;
+
+		if (it.tab[i].slot) {
+			slot = it.tab[i].slot - 1;
+		} else {
+			struct aa_perms perms = compute_xmatch_entry(accept1);
+
+			slot = alloc_perms(&it, 1);
+			if (slot == INTERN_INVALID)
+				goto out;
+			it.perms[slot] = perms;
+			if (!bind_intern(&it, key, slot, false))
+				goto out;
+		}
+		ACCEPT_TABLE(dfa)[state] = slot;
+		ACCEPT_TABLE2(dfa)[state] = 0;
+	}
+	publish_perms(&it, policy);
+	error = 0;
+out:
+	free_intern(&it);
+	return error;
 }
 
 int aa_compat_map_policy(struct aa_policydb *policy, u32 version)
 {
-	policy->perms = compute_perms(policy->dfa, version, &policy->size);
-	if (!policy->perms)
-		return -ENOMEM;
+	struct aa_dfa *dfa = policy->dfa;
+	struct perms_intern it;
+	unsigned int state, state_count;
+	int error = -ENOMEM;
+
+	AA_BUG(!dfa);
+
+	state_count = dfa->tables[YYTD_ID_BASE]->td_lolen;
+	if (!init_intern(&it))
+		goto out;
 
-	remap_dfa_accept(policy->dfa, 1);
+	/* trap state keeps the zero perms it had, slot 0 is zero from alloc */
+	it.nperms = 1;
+	ACCEPT_TABLE(dfa)[0] = 0;
+	ACCEPT_TABLE2(dfa)[0] = 0;
 
-	return 0;
+	for (state = 1; state < state_count; state++) {
+		u32 accept1 = ACCEPT_TABLE(dfa)[state];
+		u32 accept2 = ACCEPT_TABLE2(dfa)[state];
+		u64 key = ((u64)accept1 << 32) | accept2;
+		u32 i = probe_intern(&it, key);
+		u32 slot;
+
+		if (it.tab[i].slot) {
+			slot = it.tab[i].slot - 1;
+		} else {
+			struct aa_perms perms;
+
+			perms = compute_perms_entry(accept1, accept2, version);
+			slot = alloc_perms(&it, 1);
+			if (slot == INTERN_INVALID)
+				goto out;
+			it.perms[slot] = perms;
+			if (!bind_intern(&it, key, slot, false))
+				goto out;
+			AA_DEBUG(DEBUG_UNPACK,
+				 "perms[%d]: (0x%x/0x%x/0x%x//0x%x/0x%x//0x%x), converted from accept1: 0x%x, accept2: 0x%x, first seen at state %d",
+				 slot, perms.allow, perms.deny, perms.prompt,
+				 perms.audit, perms.quiet, perms.xindex,
+				 accept1, accept2, state);
+		}
+		ACCEPT_TABLE(dfa)[state] = slot;
+		ACCEPT_TABLE2(dfa)[state] = 0;
+	}
+	publish_perms(&it, policy);
+	error = 0;
+out:
+	free_intern(&it);
+	return error;
 }
 
 int aa_compat_map_file(struct aa_policydb *policy)
 {
-	policy->perms = compute_fperms(policy->dfa, &policy->size);
-	if (!policy->perms)
-		return -ENOMEM;
+	struct aa_dfa *dfa = policy->dfa;
+	struct perms_intern it;
+	unsigned int state, state_count;
+	int error = -ENOMEM;
 
-	remap_dfa_accept(policy->dfa, 2);
+	AA_BUG(!dfa);
 
-	return 0;
+	state_count = dfa->tables[YYTD_ID_BASE]->td_lolen;
+	if (!init_intern(&it))
+		goto out;
+
+	for (state = 0; state < state_count; state++) {
+		u32 accept1 = ACCEPT_TABLE(dfa)[state];
+		u32 accept2 = ACCEPT_TABLE2(dfa)[state];
+		u64 key = ((u64)accept1 << 32) | accept2;
+		u32 i = probe_intern(&it, key);
+		u32 slot;
+		bool pair;
+
+		if (it.tab[i].slot) {
+			slot = it.tab[i].slot - 1;
+			pair = it.tab[i].pair;
+		} else {
+			struct aa_perms user, other;
+
+			user = compute_fperms_user(accept1, accept2);
+			other = compute_fperms_other(accept1, accept2);
+			/* single entry when owner and other agree */
+			pair = memcmp(&user, &other, sizeof(user)) != 0;
+			slot = alloc_perms(&it, pair ? 2 : 1);
+			if (slot == INTERN_INVALID)
+				goto out;
+			it.perms[slot] = user;
+			if (pair)
+				it.perms[slot + 1] = other;
+			if (!bind_intern(&it, key, slot, pair))
+				goto out;
+		}
+		ACCEPT_TABLE(dfa)[state] = slot;
+		ACCEPT_TABLE2(dfa)[state] = pair ? ACCEPT_FLAG_OWNER : 0;
+	}
+	publish_perms(&it, policy);
+	error = 0;
+out:
+	free_intern(&it);
+	return error;
 }
-- 
2.51.0

