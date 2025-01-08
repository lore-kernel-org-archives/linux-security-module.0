Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5718A200127
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351054; cv=none; b=BLWuIUOGODdwJinqR3dW67eLmeiuzZGY/Aia8JmrSNxJfa30BqWVMrL8Wvn0PZkpSpk9KDnIY6hMb1zJKHQVkMnvjbrdbCZSai5u8buL8uAnGWx44dStVJHCzjWcn+x67RsG2wHWe0wmBrfu99bipYOk2hsroE8nynuzx/1wpoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351054; c=relaxed/simple;
	bh=7ibfBYEi6f3gRg6pygE5JOGwb52bRToRkj9Kef1B8ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ve68zjQvses1QQVJ+WFTQxLlnIWO1wpfkFPzCTawUgZ2QPUwpvUQHKrq8b1zGR2Eg+HK/7AdhhTxOzecYLL1oqTw6CkNf1VLehDm9QCRqJ6EMzkdYE/FIsSXS1yAxQEFjX5smUqG9rZCQHc/PR/SpvEaPTg0fM5I4/mlSpjczxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=EE6astl+; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="EE6astl+"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSsfC2vR0zrLS;
	Wed,  8 Jan 2025 16:44:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736351043;
	bh=St27lDxiIu3v5ST9RZRvjuRVlErWHof4RK6UwUhVE6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EE6astl+NKDQZY4iKCq9GAxWqt3IG1EENFRkpE8H4fDeq6O/LM8chyhOGtDypQiPq
	 d/hSPBLSQ9cJyWAPawwpK0HiukFyXm9zAHfl4hHdcaOfIbMxbmVGYDN2sFqhjkzChJ
	 ayrLksfAHMq35lCSixBfhEwAFr4/7LitgPrcg73I=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSsfB4Ypyz2F3;
	Wed,  8 Jan 2025 16:44:02 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
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
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 11/30] landlock: Align partial refer access checks with final ones
Date: Wed,  8 Jan 2025 16:43:19 +0100
Message-ID: <20250108154338.1129069-12-mic@digikod.net>
In-Reply-To: <20250108154338.1129069-1-mic@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20250108154338.1129069-12-mic@digikod.net
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
2.47.1

