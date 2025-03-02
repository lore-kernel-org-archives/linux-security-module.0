Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5371E1E9B20;
	Sun,  2 Mar 2025 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740931631; cv=none; b=M2CUrG1lZ+dctFKufdCxjxFskf7nIT0SNdWYbrFTVNvGQx4RmHqlgg264e+2hYssLJDGBBXLbtYuZxNLh2xMdSIQhImpMpr1f/tVz7W6DtIBeynCNxDZ1uASYPD1dZzBB3ftmKFQIqmlDV2QOsKqhCop7YhEkH0EDu70nxNd7F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740931631; c=relaxed/simple;
	bh=b4zervl14GW1lM0RoQVhCTLqxK68z0fD6ACmcGqCLUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYq9hOdjuLGIAJdyOReS9s+qJXMLV0pmz+0xAlx4+XSzXIiBmTyKlHBkKxXaNqeTBN2n3WRqBbHJQKl715LSaqKhV8FIiM4idbkSz1hakz0t/rPTP3vgBN4VuDBcUrKGcvxEGqokAulu5d6kUHpGL58cT2OPOnMdnbRFkOK7fsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=SJbl8DHf; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="SJbl8DHf"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740931628;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrrmxCSXObAFhEIo/8fh8weOhY7nqO46PR4GZl5VqBk=;
	b=SJbl8DHfCbWjEsjgne1Kob32i8p6jeDt6GHFv4OHAtoWeQ3lqXQcKH4uFnMbjiXjMxOD6a
	0yRMpAHp77D88bW+DSL4gMGtBcz/cn0z41hBCSIhjBCucvOxUc1Ibv6JN4PdD4Dq6KUXPl
	ZaqJkLCDLg8IMc7i9s1tWJ3YLbESgH/3IhrQqjeQVb15+7Cxff/WR+OmoH+76vSvXTLDJy
	ShYO5VNs0yw2fJWUyo1hI+voMdz6a1l9KdGkua3ARXCyFgGYAy3FWIW2apEV5XIgWzPAPq
	VFeNDqXGoXU2MmvoP06ER9PS9efSClP7dAz0a9k4nAWEOazqkc6cMGnVZqroFA==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	cocci@inria.fr,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	linux-mtd@lists.infradead.org
Subject: [PATCH v2 06/11] ubifs: reorder capability check last
Date: Sun,  2 Mar 2025 17:06:42 +0100
Message-ID: <20250302160657.127253-5-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-1-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

capable() calls refer to enabled LSMs whether to permit or deny the
request.  This is relevant in connection with SELinux, where a
capability check results in a policy decision and by default a denial
message on insufficient permission is issued.
It can lead to three undesired cases:
  1. A denial message is generated, even in case the operation was an
     unprivileged one and thus the syscall succeeded, creating noise.
  2. To avoid the noise from 1. the policy writer adds a rule to ignore
     those denial messages, hiding future syscalls, where the task
     performs an actual privileged operation, leading to hidden limited
     functionality of that task.
  3. To avoid the noise from 1. the policy writer adds a rule to permit
     the task the requested capability, while it does not need it,
     violating the principle of least privilege.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Acked-by: Richard Weinberger <richard@nod.at>
---
v2: split into two patches for each subsystem
---
 fs/ubifs/budget.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/budget.c b/fs/ubifs/budget.c
index d76eb7b39f56..6137aeadec3f 100644
--- a/fs/ubifs/budget.c
+++ b/fs/ubifs/budget.c
@@ -256,8 +256,9 @@ long long ubifs_calc_available(const struct ubifs_info *c, int min_idx_lebs)
  */
 static int can_use_rp(struct ubifs_info *c)
 {
-	if (uid_eq(current_fsuid(), c->rp_uid) || capable(CAP_SYS_RESOURCE) ||
-	    (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)))
+	if (uid_eq(current_fsuid(), c->rp_uid) ||
+	    (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)) ||
+	    capable(CAP_SYS_RESOURCE))
 		return 1;
 	return 0;
 }
-- 
2.47.2

