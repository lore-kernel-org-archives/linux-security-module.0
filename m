Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0761FF1B9
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351051; cv=none; b=ebLcHrZqgu8TQoQu5UE/OZA7NJpU4fGJkalL9HM9/q3lHstWiU5O7QLNJ0Uk/0lgaeV1MRgjraqiKwdqzJFF7fvqjcb1LWJ1As/krok3brEj/dnArzn8/iMMr9EoQbC/k9nw8rkZMUATFsu/mextAUyW8lsUkeB1dMhzdnTmDj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351051; c=relaxed/simple;
	bh=lVrV7J5cM/dM3iWDO/GHHdBWIWG4fgHsItD/DNDeEQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGF5//eEiXmgb+qICK3NAAylW//lgLmXK+aiVVKBCnjDEsoTjv4v+ywnmuK9SO3JICKvJDR08ILcEpr8mzpBUQSo5E8KP5XUs9ET+TnCQFrVFRRItONFs8upAIMHZ5pssVX28szURJJKp6jXEYdTEipQ/DPkJ+StazvM4Rht+0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Z3hdcn8m; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Z3hdcn8m"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSsfG0q3Qz5g6;
	Wed,  8 Jan 2025 16:44:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736351046;
	bh=VyQ3k4Kx2PFxPOjHeB4fbF0Tg3KB0EOFBlUpRjnTNqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3hdcn8mdzC3dOS7hbFk/K0B1Nzvu9i3dX1aRFYcwFnvJ66xQT9u8eivV8ZMh5vFU
	 ZdvwUAouIa8cSHMSQsFD5g6GDKE0OaRF6ZYX6fy+VmXEpUnzHoD125IhNs9y9FE+4F
	 f6APvB8lZmOse/rRTaMvigh1Bi8kM3fV1XZmonys=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSsfF3JjgzKSg;
	Wed,  8 Jan 2025 16:44:05 +0100 (CET)
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
Subject: [PATCH v4 13/30] landlock: Optimize file path walks and prepare for audit support
Date: Wed,  8 Jan 2025 16:43:21 +0100
Message-ID: <20250108154338.1129069-14-mic@digikod.net>
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

Always synchronize access_masked_parent* with access_request_parent*
according to allowed_parent*.  This is required for audit support to be
able to get back to the reason of denial.

In a rename/link action, instead of always checking a rule two times for
the same parent directory of the source and the destination files, only
check it when an action on a child was not already allowed.  This also
enables us to keep consistent allowed_parent* status, which is required
to get back to the reason of denial.

For internal mount points, only upgrade allowed_parent* to true but do
not wrongfully set both of them to false otherwise.  This is also
required to get back to the reason of denial.

This does not impact the current behavior but slightly optimize code and
prepare for audit support that needs to know the exact reason why an
access was denied.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250108154338.1129069-14-mic@digikod.net
---

Changes since v2:
- New patch.
---
 security/landlock/fs.c | 44 ++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index ddadc465581e..01f9d5e78218 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -854,15 +854,6 @@ static bool is_access_to_paths_allowed(
 				     child1_is_directory, layer_masks_parent2,
 				     layer_masks_child2,
 				     child2_is_directory))) {
-			allowed_parent1 = scope_to_request(
-				access_request_parent1, layer_masks_parent1);
-			allowed_parent2 = scope_to_request(
-				access_request_parent2, layer_masks_parent2);
-
-			/* Stops when all accesses are granted. */
-			if (allowed_parent1 && allowed_parent2)
-				break;
-
 			/*
 			 * Now, downgrades the remaining checks from domain
 			 * handled accesses to requested accesses.
@@ -870,15 +861,32 @@ static bool is_access_to_paths_allowed(
 			is_dom_check = false;
 			access_masked_parent1 = access_request_parent1;
 			access_masked_parent2 = access_request_parent2;
+
+			allowed_parent1 =
+				allowed_parent1 ||
+				scope_to_request(access_masked_parent1,
+						 layer_masks_parent1);
+			allowed_parent2 =
+				allowed_parent2 ||
+				scope_to_request(access_masked_parent2,
+						 layer_masks_parent2);
+
+			/* Stops when all accesses are granted. */
+			if (allowed_parent1 && allowed_parent2)
+				break;
 		}
 
 		rule = find_rule(domain, walker_path.dentry);
-		allowed_parent1 = landlock_unmask_layers(
-			rule, access_masked_parent1, layer_masks_parent1,
-			ARRAY_SIZE(*layer_masks_parent1));
-		allowed_parent2 = landlock_unmask_layers(
-			rule, access_masked_parent2, layer_masks_parent2,
-			ARRAY_SIZE(*layer_masks_parent2));
+		allowed_parent1 = allowed_parent1 ||
+				  landlock_unmask_layers(
+					  rule, access_masked_parent1,
+					  layer_masks_parent1,
+					  ARRAY_SIZE(*layer_masks_parent1));
+		allowed_parent2 = allowed_parent2 ||
+				  landlock_unmask_layers(
+					  rule, access_masked_parent2,
+					  layer_masks_parent2,
+					  ARRAY_SIZE(*layer_masks_parent2));
 
 		/* Stops when a rule from each layer grants access. */
 		if (allowed_parent1 && allowed_parent2)
@@ -902,8 +910,10 @@ static bool is_access_to_paths_allowed(
 			 * access to internal filesystems (e.g. nsfs, which is
 			 * reachable through /proc/<pid>/ns/<namespace>).
 			 */
-			allowed_parent1 = allowed_parent2 =
-				!!(walker_path.mnt->mnt_flags & MNT_INTERNAL);
+			if (walker_path.mnt->mnt_flags & MNT_INTERNAL) {
+				allowed_parent1 = true;
+				allowed_parent2 = true;
+			}
 			break;
 		}
 		parent_dentry = dget_parent(walker_path.dentry);
-- 
2.47.1

