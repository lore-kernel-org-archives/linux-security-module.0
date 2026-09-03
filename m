Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F063515D1
	for <linux-security-module@vger.kernel.org>; Thu,  3 Sep 2026 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420429; cv=none; b=OgGGBmVoLC/BuUmnis1/W+5QX/XajXFHBO01Mc2lraQUykWLbXrYhIrSGfVLWid5fhE6Q8kRzpX7xd1gkxS53WeAUXnVB2wkBL1LXnoWlNd+Nq4JBwip4VEuTkVCnHg+cpUZs+IKR2qA2ltnAkVVxkvksdgBi5G77eX3UdwkLZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420429; c=relaxed/simple;
	bh=X6wygyM7bHhRtMnfnptFuRnjEVCOuJmtTCh4Ce9BLwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nwGMx0GmWa8XTUhmQskSNCZlwfa+mZKNlpTQqMmkIMvYVwiMFgUbwlNjlSOq0lYX0og5m9gJTOBvWIfTte8NgD+3sDvOAEqPhZIKOaXd/BdaCpU4okFYWtIVMvxSLNjGnnsRcoOdzzT5Rj0lKJP5iUObLRCGLJw3NXsVHd+J++Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Ur126TUR; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Ur126TUR"
Received: from sec-questing-amd64 (lfbn-idf3-1-218-1.w90-22.abo.wanadoo.fr [90.22.217.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 672064000D;
	Thu,  3 Sep 2026 07:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788420418;
	bh=YyvOTlskMC9s9Q9sXMx/FSnZ33YDjwHo8fsc870gJbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Ur126TURcEFBeVokEUcGuzKX/z5M1pJxyfmCG2bdeaZ4GWfE7cvaAchetSO7x4awX
	 yHkqIZiF2kZ2wMJf7lLt+hH6h/ZutR4SFFh2+V6LvOgLJrxipIKp5vIuYhTDuMgnko
	 tE/8ci9XHc/5e525gJeJ2A+SOKT4n8kRgno6pW3h7mHPOk8ZRviO1Qe+o2A/62QImS
	 D8o1TMv2SK3yQa57i7COhDl32dWOMUuKEwMCYDofzvmnZZWNPpYc5vlKrQzb3RwgkS
	 ZNOzBZxwWTr7NU7ugMuSB4hEkegB7aQk8qPKEDqzFsPLLonvci6ODfF5nmRoZh2J0C
	 eYAA8hOtzzhVSupQJUQWp+i9DwpyASKwYl0En22l49yVkHYyiP0gfbzDC1gaefrqKc
	 YTrdW9usVMvhqDTviPjcYHYojQnU9OAr+Aj753BS8nNFZgfQSKxXieRSDTfgSxe7x3
	 QEhb+XVRyHVhKuJAW8SBSbbI1c5HK2x4DJidWdIwGNyB20gnG48p2vOzBvt7PKxCGC
	 UMqcEx7kAX7kjqceLkyOXo6J0cRjwvM/Shmm7Mqqrd8b9IQesWX8vsb3HI0iARchUF
	 Y0pZEFWAUdfVlZBty8W1c8WzzE6Rbrygg5ZJ1YnD58BZAinEUG/fuLN2dr1DGpT78O
	 klXxX6jodao873eiTT43QMEI=
From: =?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: [PATCH] apparmor: fix table_size() integer overflow on 32 bit
Date: Thu,  3 Sep 2026 09:25:51 +0200
Message-ID: <20260903072650.13160-1-maxime.belair@canonical.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

table_size() checks ALIGN(sizeof(struct table_header) + len * el_size, 8)
in size_t, where @len is td_lolen, a u32 user-provided value from the
policy blob. On 32 bit kernels both operations can overflow.

Triggering this bug allows to:
 - overflow a 16 byte allocation with up to 4GiB of policy data
 - store the table header at address ZERO_SIZE_PTR (kvzalloc(0))

However, this bug requires CAP_MAC_ADMIN, only affects 32 bit kernels,
and the copy runs until the machine is destroyed, so it gives no
controllable primitive and is therefore not a security issue.

Compute the size with the checked helpers and return 0 when the result is
not representable, so the callers can reject the table. A valid table is
never 0 bytes, the header alone is 12.

64 bit kernels cannot overflow (these structs are 32 bit), and are hence
not affected.

Fixes: e06f75a6a2b4 ("AppArmor: dfa match engine")
Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
---
 security/apparmor/include/match.h | 11 ++++++++++-
 security/apparmor/match.c         |  6 +++++-
 security/apparmor/policy_unpack.c |  5 +++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/include/match.h b/security/apparmor/include/match.h
index f7bd7855f1bd..66485f76d331 100644
--- a/security/apparmor/include/match.h
+++ b/security/apparmor/include/match.h
@@ -12,6 +12,7 @@
 #define __AA_MATCH_H
 
 #include <linux/kref.h>
+#include <linux/overflow.h>
 
 #define DFA_NOMATCH			0
 #define DFA_START			1
@@ -120,7 +121,15 @@ struct aa_dfa {
 
 static inline size_t table_size(size_t len, size_t el_size)
 {
-	return ALIGN(sizeof(struct table_header) + len * el_size, 8);
+	size_t size;
+
+	/* Need check_*_overflow for 32 bit machines */
+	if (check_mul_overflow(len, el_size, &size) ||
+	    check_add_overflow(size, sizeof(struct table_header), &size) ||
+	    size > SIZE_MAX - 7)
+		return 0;
+
+	return ALIGN(size, 8);
 }
 
 #define aa_state_t unsigned int
diff --git a/security/apparmor/match.c b/security/apparmor/match.c
index 7713484f6a36..825811d566b9 100644
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -58,7 +58,7 @@ static struct table_header *unpack_table(const char *blob, size_t bsize)
 	if (th.td_lolen == 0)
 		goto out;
 	tsize = table_size(th.td_lolen, th.td_flags);
-	if (bsize < tsize)
+	if (!tsize || bsize < tsize)
 		goto out;
 
 	table = kvzalloc(tsize, GFP_KERNEL);
@@ -281,6 +281,10 @@ static struct table_header *remap_data16_to_data32(struct table_header *old)
 	u32 i;
 
 	tsize = table_size(old->td_lolen, YYTD_DATA32);
+	if (!tsize) {
+		kvfree(old);
+		return NULL;
+	}
 	new = kvzalloc(tsize, GFP_KERNEL);
 	if (!new) {
 		kvfree(old);
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index f1fc48e72d0e..3c744f99a15c 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1052,6 +1052,11 @@ static int unpack_pdb(struct aa_ext *e, struct aa_policydb **policy,
 		u16 tdflags = pdb->dfa->tables[YYTD_ID_ACCEPT]->td_flags;
 		size_t tsize = table_size(noents, tdflags);
 
+		if (!tsize) {
+			*info = "invalid dfa flags table size";
+			error = -EPROTO;
+			goto fail;
+		}
 		pdb->dfa->tables[YYTD_ID_ACCEPT2] = kvzalloc(tsize, GFP_KERNEL);
 		if (!pdb->dfa->tables[YYTD_ID_ACCEPT2]) {
 			*info = "failed to alloc dfa flags table";
-- 
2.51.0

