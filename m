Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7644630F7E9
	for <linux-security-module@vger.kernel.org>; Mon,  9 Feb 2026 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770672121; cv=none; b=r6IDYtyfYizqz2NtB37iauA375RLVPL46/B9TEOtA8K4Cm9vgQMvQg8zFBmKTrPT7s8ojW0d8ObD/ygrHqK89ZF25nteErLPtZA9e7nCI68v8u/Ab+gh4Qh8uDnl2WLM4gUBxJeGUDII+5o9/N2CgMRIdYl5+cZsPdFgalct1w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770672121; c=relaxed/simple;
	bh=ztNZlDveaPUFY/UJADcT7rgx3Ng5Aaxpnl+M/Z3Ef+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GSnZl+FfR8BGMAKGTasxmWJmZ8LN9Kb+MIP03LArM5ijQGKJFA9Ee8dUsBjAv+CnDS1fa7cHNIH19rHrMeeQPoruxeZq0F2cGph2kJO0W4lCrGU1GUgpW8heKojXJtHpeXA4C6ZbQz4655g79tbEMxeoDbY8bMPg67ktSLoTREk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AdkOuKxV; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AdkOuKxV"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4044854464fso3031667fac.3
        for <linux-security-module@vger.kernel.org>; Mon, 09 Feb 2026 13:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1770672116; x=1771276916; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEOdTViLab98einqbzjv+bLBxVlmu1ZicZOYO4doJ/M=;
        b=AdkOuKxV/l1Cmjz1/n3r/3oBXUiNUVTkh6X8ih1Pop6/Tsq/w+gl6jvZ3Kw/35S6Xg
         a2IcnySyTuFFoo5VIXn8W4umLNPePWhmpIlXD8SP5YnU+Y2L29nlWJuUg5VCPGHl8PhM
         kPuUJMCqmIXvz/BvDAtrk+smBfGNVuP4KnDgZB7Yuzx6aeVGzX8XHDGdM1uQrtweBhnA
         hXn1mqQIL0c0M81zb3WPzSknt+5GHJv1Bap65LiM/8UYL4ULmNqQy5NtgvHvmTkxfF5Y
         7gimRU7WepRoQxMRiU/cpuebB+P8xudaUetb3FDIVQZEEoKRJXk4scbprhv8E/vdtK6b
         2LuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770672116; x=1771276916;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EEOdTViLab98einqbzjv+bLBxVlmu1ZicZOYO4doJ/M=;
        b=nHzhbHhSTddWkX0CmduvYLQfLpCFgU2TKGwlOnQXxCI4r6Falioi6tOcJxePpv21up
         FnQ+jslcvvIUjhe493F9WdwGDW+pQN0Tet4qAlNRBuToKroSp/r2YvId3KfjCatrB3bp
         ZRqzWVo0vbYzdqPXQjEmhnHfkPyMNKXHILNc1PiBevavWgUzv7OyVlPfsGDSYLIB4jjC
         /R0qo+a8Zm+z2bEGZB/FRZxGARaZhwNiXqKXI3bKU1DJ7PhHE5LeNz0DdU5nTCw087fJ
         ATyoEcA8VzU7KSDuxQcNZSk+opv/IRE8i+kv5NfFCOiQV2ITxw9a5PhYuTdVoVnbX66U
         8zdA==
X-Forwarded-Encrypted: i=1; AJvYcCVoczlARyfVFzA7wbn7QhRZDEq+w8Mdfbv4HZbw1UO+jC++nHJ72NVgaJVvDk5hgQ5lHzOUt4xsTpmlYvE6RSl4gmBbxpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOzA1dxNOW6RWOGw/NlqLnn40Vj6tmsytt/hPBe25C0RoQ7WqZ
	VFlDBTlzTxIAVqJfHtxrhJiSDdDMLhTHLsKq67wdbkf3DbUckXyMc79K4M1EZuuQL6A=
X-Gm-Gg: AZuq6aI4mtTk91Cn7jBYFTVM/SNCPQGEUXk0fYb1abv2SBGjNd/0DpQAs9oJntK8FCi
	zAcdTIz7emcyW2x3HlbVcFv0ZJeXI7Moktw7CnPJQJHKV+sXWdgHA4haZVh30S765+77/Cj7dKA
	ibbJ8LQ6HG4WJSWkAeHdMWvsqRutnz5yO2ub8JI5j4CAvahSMpQu79kUQOt5zf0DEna3CHveeOW
	avx8gZvEU5f9pA8iVWzzIJEIIgk+qlCXBebTyRPV0Dg3sYJYU3BTgQktF94UL6eCENvu1mjyuT+
	rxxz1h7sKMuCmJSe6JI5LELxH0bAj8/Iot7KmcVqkztT9xZY/YsBbzvRkRdceLV3gavZ3TT+mqp
	lRhPFDyJwo/5Jd/kw5gk7B2GFl/Eczo9FNixUupeiRbR1asNZ7rqExxM2CCMShpJvEgVTtmi5Jg
	==
X-Received: by 2002:a05:6820:1689:b0:66e:d9c5:ad53 with SMTP id 006d021491bc7-66ed9c5b0b7mr3532440eaf.34.1770672116144;
        Mon, 09 Feb 2026 13:21:56 -0800 (PST)
Received: from [127.0.1.1] ([2a09:bac5:947d:1b37::2b6:46])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66d390b935asm6591730eaf.5.2026.02.09.13.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 13:21:55 -0800 (PST)
From: Frederick Lawler <fred@cloudflare.com>
Date: Mon, 09 Feb 2026 15:21:50 -0600
Subject: [PATCH v6 3/3] ima: Use kstat.ctime as a fallback for change
 detection
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-xfs-ima-fixup-v6-3-72f576f90e67@cloudflare.com>
References: <20260209-xfs-ima-fixup-v6-0-72f576f90e67@cloudflare.com>
In-Reply-To: <20260209-xfs-ima-fixup-v6-0-72f576f90e67@cloudflare.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4301; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=ztNZlDveaPUFY/UJADcT7rgx3Ng5Aaxpnl+M/Z3Ef+Q=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBpik/uqKQQioRcbHzyxd0bXzo3VM3vGk+7dbzuj
 N2KQ20tVoiJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaYpP7gAKCRCrJbR2A5LT
 bdGoEADcOZn+QasfYluvP2C6autDQWR7y9dc4cDhBWt32bXHpyJE+6zt7qEk1qi8wunHSwImqOp
 cPfEAfzrZPvnY/6+himefudeSXKSR71TzZn1MbxL1FLxbnpxlYQpTCvKbWHzjz8Mo72wsVVbCYW
 OxTA5yU2K3v3Op4z7hRDfH+w1dBYF9lAtPTxX/1nr14Uqt1s5/7narziUiJb4enRb+xF0yM5VFz
 TheiRBJAJkdf8F/5gNPkQHYNteAQSJitZ1KziY9hQ1zHskQLpb1b1RBkIgMWs1UA9cePCgDfiXV
 58g+Wv6aLuPkBQRARiWez5Rh7itkw1LSxW+8PAKVesMwWKMb6CQEYgDCjmI5dsUQ7BnTwWEpfUC
 wCa33F9VO4cFOn4dNS6Qtxc9/wpUCN3KYkId8XzXybAY3SYYj40By5w3noEPU+8rfHMvpMorApM
 RiDWXhQgTAbCpNrympaLOliuYUFrwwrgw1e5Uv3Dxn2ejjhgtILGrJKJ7wAsSUOKAsck2X1fYUD
 iyDG3gB3GpAXF4StVHmuA3rqeG4zaweq3Ir+al7LqzgLdicdK00NiQCALTHXYc+zJ7fqy/njV1b
 m2BWzyrqmNb83Bors9j0fl9KpcrECKm67FkcDfJnoObOYJ0tR2g++IkWwypLjAdYL9x+8fIaxT5
 PinBdX15AGcqMYQ==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

IMA performs unnecessary measurements on files in file systems
that do not set STATX_CHANGE_COOKIE in the vfs_getattr_nosec()'s
result mask.

Commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps") introduced
multigrain timestamps to XFS, and this made XFS no longer report an
inode's i_version used by ima_collect_measurement() for change detection.

Additionally, ima_check_last_writer() & integrity_inode_attributes_change()
think there's a change for a file, when there may have not been.

Most file systems already use ctime for change detection, therefore, make
IMA fall back to compare against ctime when a file system does not report
an i_version to the kstat.change_cookie.

If neither fields are reported by vfs_getattr_nosec(), assume the file
changed.

timespec64_to_ns() is chosen to avoid adding extra storage to
integrity_inode_attributes by leveraging the existing version field.

XFS is just one example. There may be more file systems that adopt
multigrain timestamps in the future.

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

