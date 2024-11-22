Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC1F1DF27D
	for <linux-security-module@vger.kernel.org>; Fri, 22 Nov 2024 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286066; cv=none; b=eguHJpY520J8olPm1n4hdAT5F+KgBqagdkjBnsystu/0HcmDkdNrdtTUKFkSkZsK1l9A5ENU3KfZqipkCkpHb+YU3q3mq8lobyEbi52Kw4JnCJ3uqUDWPt+LyFpO2/y5igYpmfeslAm+i3D0VHROkTo5qh+0eh3DQNsNxTSTwEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286066; c=relaxed/simple;
	bh=nlZU8WDPKtn1L81Yi1gEClvOBIb9Janj80e3MicsfYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8ohRK2YMHtvSzJIrJo7lEl+eC5hKrKoK0ji210VbQhDtTcMAfUS/xp7/TjV1z2ZaeSiOekRYigxdQ4LBqgbOjapAOY152nhCroxS3raCbBwQRcbtgaQaNrdMY/+5uG1neo3UAODLrH935Y1QMdbX4DFtzn7k2P5ZoyBAM2I8Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DgjbOs6X; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DgjbOs6X"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XvyKT4g5Pzb4c;
	Fri, 22 Nov 2024 15:34:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732286061;
	bh=vQ9EwPFoFKamnGETMYh8GoEgBYciQrBD4rSrzQG+2aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DgjbOs6XxKkJcWhOo3zz5Y16Sf1LETDM09N5FLNrIsCNNo8M1tcLy0Asnj1NfliGo
	 jy9TUI1MtpdXI06NaElU8HgO2GONcyvApI7uGTHE4zr12UUyf6Igx/wBnes/0qsF8N
	 ElO1kbsWsSLngzwhLRqlU4U4KgcoTuDXD1/CV6fQ=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XvyKT03sNzn9h;
	Fri, 22 Nov 2024 15:34:21 +0100 (CET)
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
Subject: [PATCH v3 14/23] landlock: Optimize file path walks and prepare for audit support
Date: Fri, 22 Nov 2024 15:33:44 +0100
Message-ID: <20241122143353.59367-15-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20241122143353.59367-15-mic@digikod.net
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
2.47.0

