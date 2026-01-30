Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E213B38A9D4
	for <linux-security-module@vger.kernel.org>; Fri, 30 Jan 2026 22:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769812805; cv=none; b=JLA4o0odnK5kxX5oWO8EexXll5kI4Xb5+W+h/QUWg87TL8W1/JSfYG+fzPnlJj4X7X6YliGlehSAvuPkCZ5ZhYKpVRnVORMxNMboh8+lb6YVZZadYRyyC3GO0zvd/9ucTtZHQ6pGffJ1GrTjBt37suDuODD12dcmkc1wPUDplFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769812805; c=relaxed/simple;
	bh=T8hGXOolp0MlCuJ57QwSaSxARrwYXxeLvTHI4xeBR5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sLpH6mE4T6StMLKAMScvjoFfa1lsNQmiJ4tAXzAaw/DGJGkHjtu89Xnl36axey3hVl/fTrD9ay5RV56Utbyt7m0YabZ8llwEMXMsMQHaUu1U9+pi825JAzmmxs+MDhvNWtTBgkO1rG9Th3khzU8q3OgfjBbJ+ysrHaMpnlwkeuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=c2K5XRYE; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="c2K5XRYE"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-45c733ccc32so1665242b6e.0
        for <linux-security-module@vger.kernel.org>; Fri, 30 Jan 2026 14:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769812803; x=1770417603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+pB22RqagYfWUxCP3mEi/hOUp+RDnbPOdedWJTMM5zA=;
        b=c2K5XRYEtFKWBih7qS+E20oZ58uIZMWf3xYe5Gm2CCvp+jred4nl0vKUoK7/awXWbf
         h7spSb8m8+PTxFf2LPgu33GS88AZJi5W4bDosH4vOfkgHkLhSYZY/hX3GEEW3Ty+refT
         96SQFajmWTK2hE0gYZ60egV9yeuGZ4Fic5S4K1duiWXEKeCnMokRYiT2y4NsMnwNJHh9
         gRglk2/JKZ/DSat9FVQa+7wBxDAjfutdKan+d34eIREj5m+nJr780xUHfWHZwwQPkf32
         0DMh0UEwiO9Fqntf04DOYFSc6FEXojtx1jrkswCrG53zcnHVr3wCTZuRoBNguqQhkwLJ
         N0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812803; x=1770417603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+pB22RqagYfWUxCP3mEi/hOUp+RDnbPOdedWJTMM5zA=;
        b=tY1w0r06Jf2hqjRdq9r9dgdxzVEOJCL+HS61UcnIJL3ckIqzUt/i+2Q52z+Gg6ALRW
         Hy4bT/7WX+lTNhtjix7KHM1nTItgL9hJTuKDxtDpBbMdpNM26/A8gCh8/jK8e58X7BJZ
         1cXriyQgf/ZBFlb4WHuLh3IDh0aVcWikYnxBrTa9rNcvSzy3YOkW7eaj+VPmV+A5v9mO
         TA1TKjIpqGUu2GyW1Kk70AeEwy8O2OVU0RIJyeaerhA0Ixtw2tQSgb7r6qEBdnUC/92Y
         KkV3x8XJfKYyAL3AoG4yyqobKzP3EFzr0UI2vF63AuLjvEmZf1yb3Lu+o9ck4I7AJtBI
         KRNg==
X-Forwarded-Encrypted: i=1; AJvYcCXxJ4oJfVtOLP5mvBojaFsDACWokFrLf26JkoWgOW3bkOPcg045s7kgfYBJSo6kFyAxdj25M+fEtCgSGepPhafIsL3D/s0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt1XGRg9ucWiJDZzCQEGAqKb9Iw9C7zyyPCpjMMsYYi94odyoL
	iiUW0XsOHB3NdJ5RZOtdIsOOh0oonzLLZqWOfXAAmvO0fUk4jIvscX4EPbpKJ4aagg4=
X-Gm-Gg: AZuq6aILEKNkTVpLC8j0uPSoYtNCSR3OE2QJY8ZKXvqVg8TmfJ4EXUogFqxUADNF9q6
	BIjfcn/3mdWgAZXIChZZFPMsexWHxb+1BULCny7txywSxSMPj4inDTf6k77LmLePETw9qIM63MW
	prClP96DfIUYJ3l8UC1NuLsm6ShgPRCyXrZQwa1xoiOw2hsDZo/AWrEbqQy/SM1RSUN7eji9ulq
	lqWdoer+4LMss+1guAwgmXUIrSkvZdFOtROkS93207R9zDO9QEo/ZLCRnVBqHL8yPw4LYQ256Y8
	owPgVrbDU2viddCSWJAQBMMJ6KxyzJB2+TNK/Qb52l+OC4XcdMTK1IdcibpebRDO7ZvHteKQtcP
	MidaAXBECmvWB3a6w94Ftis9tKU3Is6x8lxeoC3pf5TIeVYjg9EqEnZqjbDxzk31QwHuMhr8=
X-Received: by 2002:a05:6808:a604:10b0:45f:3592:407 with SMTP id 5614622812f47-45f35920ba8mr1660637b6e.50.1769812802725;
        Fri, 30 Jan 2026 14:40:02 -0800 (PST)
Received: from [127.0.1.1] ([2a09:bac5:947d:4e6::7d:80])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08f20e38sm5400250b6e.10.2026.01.30.14.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:40:02 -0800 (PST)
From: Frederick Lawler <fred@cloudflare.com>
Date: Fri, 30 Jan 2026 16:39:56 -0600
Subject: [PATCH v5 3/3] ima: Use kstat.ctime as a fallback change detection
 for stacked fs
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-xfs-ima-fixup-v5-3-57e84ea91712@cloudflare.com>
References: <20260130-xfs-ima-fixup-v5-0-57e84ea91712@cloudflare.com>
In-Reply-To: <20260130-xfs-ima-fixup-v5-0-57e84ea91712@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org, kernel-team@cloudflare.com, 
 Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4229; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=T8hGXOolp0MlCuJ57QwSaSxARrwYXxeLvTHI4xeBR5g=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBpfTM90njNeLmeSYJx0vJMg7Uxm7oWturIoalSA
 EGSx8/4zk+JAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaX0zPQAKCRCrJbR2A5LT
 bTZ0D/4/sr85rwcj53ELmM18BnzS4sRSHO68A3Uu/OswNtfrYNsDL401x9OP9H83vNTcwc+DO/k
 fAcuXEaNki3PfyKYixVeCBUI36y5m9/wtYKfoj9t0jArWQsWDZFhYI8FfDdfEznfNggZktwSVTx
 9ZlaL0S3yRC1WYhLRswZ+ow8yBjm3R6UEy6SnZrikM4dVw9AwXLCCAzdgC3bEsbYBjm19Yt2mIg
 vVHx271R2Rx5MKPF8/yUBp3pSuEa2EsYJHLB/pzVzarq84a3g2ozS3jzaeiYrS6CwzDloQZ8WwK
 osRDYBmVfkIzc3QsnbZeCclpfKX8RvGKUOpgPTArJ8roFDWGggOHawXlcU+tEAvs6pPkNH0Dbmg
 z4g0itAiDBmmgRiV14azZkX0TquPyKYwHzIiL/PlhjkIwMbewACOfwlkWY+FE93xF0cvWUgKU1w
 SjxYWK8RReLh0gH7uoSVcD6KdYAx/GG2BJElHBgW5AlTiPnK3Kkxl7fGIFINzpUCAQB1weNYR7Z
 /kUhPVhGcRA9KtL2biMmTLwc14ORtpGMibMg2Lz8O+3Iu500TyhO5zMFIfjT+CHvHhW5K5VgSTc
 ar3yVpOAjLAQjHW3bfMJlaBFFeKH1Tw2h7L+aTWAPk47z6NcQggMbHW8adMXVkuxi5dw29grqhd
 L3ZPpCHRhrmAg3g==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

IMA performs unnecessary measurements on files in stacked file systems
that do not set kstat.change_cookie to an inode's i_version.

For example: TMPFS (upper) is stacked onto XFS (lower).
Actions files result in re-measurement because commit 1cf7e834a6fb
("xfs: switch to multigrain timestamps") introduced multigrain
timestamps into XFS which changed the kstat.change_cookie semantics
to no longer supply an i_version to compare against in
integrity_inode_attributes_changed(). Once the inode is in TMPFS,
the change detection behavior operates as normal because TMPFS updates
kstat.change_cookie to the i_version.

Instead, fall back onto a ctime comparison. This also gives file systems
that do not support i_version an opportunity avoid the same behavior,
as they're more likely to have ctime support.

timespec64_to_ns() is chosen to avoid adding extra storage to
integrity_inode_attributes by leveraging the existing version field.

Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
Fixes: 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 include/linux/integrity.h         |  6 +++++-
 security/integrity/ima/ima_api.c  | 11 ++++++++---
 security/integrity/ima/ima_main.c |  2 +-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index 382c783f0fa3ae4a938cdf9559291ba1903a378e..ec2c94907f417c4a71ecce29ac79edac9bc2c6f8 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -10,6 +10,7 @@
 #include <linux/fs.h>
 #include <linux/iversion.h>
 #include <linux/kernel.h>
+#include <linux/time64.h>
 
 enum integrity_status {
 	INTEGRITY_PASS = 0,
@@ -58,6 +59,9 @@ integrity_inode_attrs_stat_changed
 	if (stat->result_mask & STATX_CHANGE_COOKIE)
 		return stat->change_cookie != attrs->version;
 
+	if (stat->result_mask & STATX_CTIME)
+		return timespec64_to_ns(&stat->ctime) != (s64)attrs->version;
+
 	return true;
 }
 
@@ -84,7 +88,7 @@ integrity_inode_attrs_changed(const struct integrity_inode_attributes *attrs,
 	 * only for IMA if vfs_getattr_nosec() fails.
 	 */
 	if (!file || vfs_getattr_nosec(&file->f_path, &stat,
-				       STATX_CHANGE_COOKIE,
+				       STATX_CHANGE_COOKIE | STATX_CTIME,
 				       AT_STATX_SYNC_AS_STAT))
 		return !IS_I_VERSION(inode) ||
 		       !inode_eq_iversion(inode, attrs->version);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c35ea613c9f8d404ba4886e3b736c3bab29d1668..e47d6281febc15a0ac1bd2ea1d28fea4d0cd5c58 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -272,10 +272,15 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 	 * to an initial measurement/appraisal/audit, but was modified to
 	 * assume the file changed.
 	 */
-	result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
+	result = vfs_getattr_nosec(&file->f_path, &stat,
+				   STATX_CHANGE_COOKIE | STATX_CTIME,
 				   AT_STATX_SYNC_AS_STAT);
-	if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
-		i_version = stat.change_cookie;
+	if (!result) {
+		if (stat.result_mask & STATX_CHANGE_COOKIE)
+			i_version = stat.change_cookie;
+		else if (stat.result_mask & STATX_CTIME)
+			i_version = timespec64_to_ns(&stat.ctime);
+	}
 	hash.hdr.algo = algo;
 	hash.hdr.length = hash_digest_size[algo];
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 8cb17c9d446caaa5a98f5ec8f027c17ba7babca8..776db158b0bd8a0d053729ac0cc15af8b6020a98 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -199,7 +199,7 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 					    &iint->atomic_flags);
 		if ((iint->flags & IMA_NEW_FILE) ||
 		    vfs_getattr_nosec(&file->f_path, &stat,
-				      STATX_CHANGE_COOKIE,
+				      STATX_CHANGE_COOKIE | STATX_CTIME,
 				      AT_STATX_SYNC_AS_STAT) ||
 		    integrity_inode_attrs_stat_changed(&iint->real_inode,
 						       &stat)) {

-- 
2.43.0

