Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4C31DE8B0
	for <linux-security-module@vger.kernel.org>; Fri, 22 Nov 2024 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286065; cv=none; b=Z2p75t2STDe63vvXKtdTy6K+qp+TgQNMqEbTTyNAefqxoxss6EzulJ8vJeVlqurn3ZgyNtrW05dCK4AcetZbHm4WNi4luSHSg/gXPZokOFzHya/bVWBlkpZrgMEKr7YymjFPCBUhackufn6doSdNArSFP/EWg57UOvxL0tAhTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286065; c=relaxed/simple;
	bh=r9ftnbbE8+eDuDA3+7n9COnZvjC1aYV3g18xqvTZxnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFy3DaCiNYpUfvb/FJVjRERhMTNHErj1P8fnyyPcRWpqHG8rTIcH6jTjCSmjLy2P1T22GGVbX5i1PNA+S7ejodpeF1NAmCPUzHtkuSuzIqctmaJa7p2ThDxKH3hnb8grH9xgbiL1kaoa3MfXjMUFsL8GjGiSgmZ6Jh8Tu0r7Th4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=rsDw6lvl; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="rsDw6lvl"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XvyKR1C0Bzjcn;
	Fri, 22 Nov 2024 15:34:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732286059;
	bh=Tr09ZZYMmyRN9g3gpEskXCFWHcXDgxBCb8vxALpa40g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rsDw6lvl4iF2+us577286u/6fbvYgIUoVM04ftvujWeYE4UqaiMENZ+5R0/XXarIp
	 qN1kw68U1e1VqslNRj1wXqYbslk7JnGfuuyrqby4T/Q1mVsMYLtoB5Tn5HWFV9hHv+
	 7cSz8vS++DEVobITGRCfv0N2XB+BV2zYilr+chJ8=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XvyKQ2jynzlnp;
	Fri, 22 Nov 2024 15:34:18 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 12/23] landlock: Align partial refer access checks with final ones
Date: Fri, 22 Nov 2024 15:33:42 +0100
Message-ID: <20241122143353.59367-13-mic@digikod.net>
In-Reply-To: <20241122143353.59367-1-mic@digikod.net>
References: <20241122143353.59367-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Fix a logical issue that could have been visible if the source or the
destination of a rename/link action was allowed for either the source or
the destination but not both.  However, this logical bug is unreachable
because either:
- the rename/link action is allowed by the access rights tied to the
  same mount point (without relying on access rights in a parent mount
  point) and the access request is allowed (i.e. allow_parent1 and
  allow_parent2 are true in current_check_refer_path),
- or a common rule in a parent mount point updates the access check for
  the source and the destination (cf. is_access_to_paths_allowed).

See the following layout1.refer_part_mount_tree_is_allowed test that
work with and without this fix.

This fix does not impact current code but it is required for the audit
support.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241122143353.59367-13-mic@digikod.net
---

Changes since v2:
- New patch.
---
 security/landlock/fs.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 171012efb559..ddadc465581e 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -567,6 +567,12 @@ static void test_no_more_access(struct kunit *const test)
 #undef NMA_TRUE
 #undef NMA_FALSE
 
+static bool is_layer_masks_allowed(
+	layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
+{
+	return !memchr_inv(layer_masks, 0, sizeof(*layer_masks));
+}
+
 /*
  * Removes @layer_masks accesses that are not requested.
  *
@@ -584,7 +590,8 @@ scope_to_request(const access_mask_t access_request,
 
 	for_each_clear_bit(access_bit, &access_req, ARRAY_SIZE(*layer_masks))
 		(*layer_masks)[access_bit] = 0;
-	return !memchr_inv(layer_masks, 0, sizeof(*layer_masks));
+
+	return is_layer_masks_allowed(layer_masks);
 }
 
 #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
@@ -773,9 +780,14 @@ static bool is_access_to_paths_allowed(
 	if (WARN_ON_ONCE(domain->num_layers < 1 || !layer_masks_parent1))
 		return false;
 
+	allowed_parent1 = is_layer_masks_allowed(layer_masks_parent1);
+
 	if (unlikely(layer_masks_parent2)) {
 		if (WARN_ON_ONCE(!dentry_child1))
 			return false;
+
+		allowed_parent2 = is_layer_masks_allowed(layer_masks_parent2);
+
 		/*
 		 * For a double request, first check for potential privilege
 		 * escalation by looking at domain handled accesses (which are
-- 
2.47.0

