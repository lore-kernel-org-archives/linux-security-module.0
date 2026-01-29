Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16278291C10
	for <linux-security-module@vger.kernel.org>; Thu, 29 Jan 2026 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710047; cv=none; b=UtEQazwapPLRHVivimv7+SVhwwpuH4elcIC623YRJflnzA+85C+e2qkGRUU3sDNqBqJ7pDsZtnCFDcbJCZRFKs1H/PctVXlyPTEEIn+NnIEdglmET0rB0YJ2XxpHqhGp8utKYr7uofGXerN1EIw+M3ubz8tXAIziw5ZmninaTt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710047; c=relaxed/simple;
	bh=UfcjX6PD57Tddf2CUuA6OuV0cBIaE9mIGquDAr/FgWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P8qo7m+UrudxxW0+2XpJgsHiDttfw9nCiiw2+ym+AzkiEKswc9af7ZRV7mtjJ7v1Dh1qT2q08HvNfiiJocTU0rgUyuQnCIMrkS/XHgUKSkuAzzyeRhBI5Jmj1pUxSIryVYMQyz2R6zPqcJWhrvI0LfRNBKYzB4nNqTXpYFxgeeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Ktb97qg8; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ktb97qg8"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-662feac825eso630951eaf.3
        for <linux-security-module@vger.kernel.org>; Thu, 29 Jan 2026 10:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769710043; x=1770314843; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UXMLINgWhmW9f3bh1muLdbRbRzKXOeJnFod4/xART8E=;
        b=Ktb97qg8EF057Uk2lifhB8ASItSdu5T9n1nfSpW0SAH6klpIDRAplds6a/mbK0J/to
         BjRWB+IlGx9tgcJi0eHOAQt4DBI+sOcLLNyAHR88x6LE90GKzzAAG2Pw1RnzEJlh9oBu
         pss2XjixJR5kkhDJhfs3/g50uehaquM80W4ucW+Iv5p5tJ1b0pwyPYyqUi2u7AcS5PsA
         Ntzf5Oeqey5f798iC/3o+vA1cF9uBde1Xvcl1VjNHtHu7T/ohzcBQZhdBy/K7Q2XQgl/
         PAd7et3Hyz7eE8Q3QcOFhEHkmODt3qEdS6fiTiqnvE7RPQ4iHDw0CNwNt+Ef0xHv9aGh
         gXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769710043; x=1770314843;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXMLINgWhmW9f3bh1muLdbRbRzKXOeJnFod4/xART8E=;
        b=b8569BQHnm5UZWHtwApjCcwCuu4Ki2W7GyOJBi5+Hg2DAJaMiPFnHhdgAi6bokjk5Z
         8tSsa+Q0AVob6h9Rts340IaT1tQ1+pbdIKq49MyhaQVJNSmAjhjs9GNCncOu+rHKeUPN
         KDpbD2U1By4Pu8NZMQ9ztSgiGSXG/FTw5S/Z+UyIf61VMBAGvpmdy5dFURGjG6Q59BuR
         omW4bqjUwOP3TUPW/XJaDADvoP0w8EBvLmqthBx9VYxsBOvKx8A0z9mV+eJlW2dXO36w
         CzQGv8iVRwqw+S9+32wfE6pEsV0INJ86PGGDji4dCORg/zE9BWvDddVWmcvqbYz3Y6zu
         MYww==
X-Forwarded-Encrypted: i=1; AJvYcCWvrjR6fKSxQUYg3y4sq4V9hRVbv4x4L/Z6g0vaa3agfTJrqbrOGMSUVLye+tyHRtt+Tvy+l30R4viqPSzbd2iYRDiSk1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6YvIzqR4hVE62WQRFzARY1l98+Iw+o6XupUcNXquNXSpWVtpl
	hqqY/GLY2yiAfmvFLhu9mdjA5+18hGodZIYkvi3q2ww7gjj+Rpx1mejTrAqwbIUx5uo=
X-Gm-Gg: AZuq6aKLUnf/+D8JCYyuNfQCh3whBzAMAvcakMBcjozob910M/GdsFNMZBBZGu9nK5P
	HqAXgTq3BjC/XQJ0LYTXwTn42sA0UYcTcgiLABTb13DUZZuu5fHbLhG6N/f9qtEsFuAu/IeKDnn
	LAhJ3uFxEKSmoROw1q1t4cwWk5VqVg5D/l5cx28mRheOZIRi+X1CPoC7wV1mIYIcmEPr++LuDZK
	dzfRs/TFsXk6xnn1gKHMpAAtph38zYKddG68RlNLC2PoRENnq2J+uEP0syKY5TRxTRhR9X+EzWO
	+MWiadtJNDtx6OogZsaPfnl0K3uWthzPedna/1/M1fh37mC3BzvE0I1D9uuOn124MHkpYJiLofe
	UJKSi0YRXCtHvA8iEF+HM837IR/Sipmyke/hcDOVu/uuKnsQKUa1WWE2akmr4pRWiw6kOla8=
X-Received: by 2002:a05:6820:2228:b0:662:ede9:b9af with SMTP id 006d021491bc7-6630f35805amr205086eaf.51.1769710042887;
        Thu, 29 Jan 2026 10:07:22 -0800 (PST)
Received: from [127.0.1.1] ([2a09:bac5:947d:4e6::7d:7a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662f9963799sm3448584eaf.7.2026.01.29.10.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 10:07:22 -0800 (PST)
From: Frederick Lawler <fred@cloudflare.com>
Date: Thu, 29 Jan 2026 12:07:16 -0600
Subject: [PATCH v4] ima: Fallback to ctime check for FS without
 kstat.change_cookie
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-xfs-ima-fixup-v4-1-6bb89df7b6a3@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIANOhe2kC/23OwW7CMAwG4FdBOS9TbEOactrEZccduE0cTJqMS
 EBRAhUI9d0xnSZN7Y629X/+76qEnEJRy9ld5dClktqjDPOXmfI7Pn4HnRqZFRpcAALqayw6HVj
 HdL2cdE1QOcMWPXolmVMOchi8L/X5vl59qI2sd6mc23wbvnQwHH9ArEdgBxq05QoqX1MdK//m9
 +2liXvO4dW3h+cTiVoDky5D1DVAW2sMEOA4+mzS4e93IdCMCRQiEmHgxm3NnP4l6C8xaUFCoCF
 asGN2ZCdE3/cP2QBsSHcBAAA=
X-Change-ID: 20251212-xfs-ima-fixup-931780a62c2c
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10871; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=UfcjX6PD57Tddf2CUuA6OuV0cBIaE9mIGquDAr/FgWU=;
 b=kA0DAAoBqyW0dgOS020ByyZiAGl7odmiEWU8dyRlugLK6KV/lkEm+RG89yHbBIgdF985X44f3
 4kCMwQAAQoAHRYhBMs0GoxWa7U8e+M57asltHYDktNtBQJpe6HZAAoJEKsltHYDktNtUJMQAN6Y
 7AarUh/aEQV1tIzJUoze3F/mf6ZepBpNIHt16FTw3QU0GXrqWfikNaa5dH1bc+dKlHgEyg06dwa
 tVL+EYhbfRrTeF0juKECv4TuX+0zHc3bbm0d+of6qYXTr6o4iW/T69l34Hvfd6MAYx7L6ufqVo1
 +IP8VsAqbRkLxSm99WgC/B5iF7iOvYwwpZDg4apJxrxu55Z9dldViMFXpIg3UQKLTAwx+9dPUOt
 v0Y/GO31El7H1Xn/7Eys5biHP9NFiXFKZeHO+mV69Yy881AG/D9SFSdjcQfsoFPWLr4eiD6i2pF
 /AlVuAhOCc9IhpZ9+T40MLasVsXTpKJnYJh4rHfogYKiHUFSVTGJUxskSzMyu3NJCAisGBoUaUT
 0CnhHmRxxqY7wdD31PksXtar8YSdifHUu63gUUo2nKRNjzP6CCxIgAcWlS2dg5GZoyjv5TvYoyw
 95NPSmXbNHiSISDLFvgpZfk4utifFgpU3BojZN2fuar2D/k+U+K1HkZKfayEjl453QLygGhJKc4
 APZ/XTQPAIJlFzFwV+zVYwxebLrR4zU8mQ8kN2xnIvWebZEUb3EXXMjBA5TaNOK1Mprbga8PAXp
 V+AJQfHpep/Ld6jWqSeYmkqxpTgLYHz0hcG9x3TfFT/40g2Gwtx2TeabiSLQJw3pFw0UCEIOLkw
 +pBgj
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

Commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
introduced a means to track change detection for an inode
via ctime updates, opposed to setting kstat.change_cookie to
an i_version when calling into xfs_vn_getattr().

This introduced a regression for IMA such that an action
performed on a LOWER inode on a stacked file systems always
requires a re-evaluation if the LOWER file system does not
leverage kstat.change_cookie to track inode i_version or lacks
i_version support all together.

In the case of stacking XFS on XFS, an action on either the LOWER or UPPER
will require re-evaluation. Stacking TMPFS on XFS for instance, once the
inode is UPPER is mutated, IMA resumes normal behavior because TMPFS
leverages generic_fillattr() to update the change cookie.

This is because IMA caches kstat.change_cookie to compare against an
inode's i_version directly in integrity_inode_attrs_changed(), and thus
could be out of date depending on how file systems set
kstat.change_cookie.

To address this, require integrity_inode_attrs_changed() to query
vfs_getattr_nosec() to compare the cached version against
kstat.change_cookie directly. This ensures that when updates occur,
we're accessing the same changed inode version on changes, and fallback
to compare against kstat.ctime when STATX_CHANGE_COOKIE is missing from
result mask.

Lastly, because EVM still relies on querying and caching a inode's
i_version directly, the integrity_inode_attrs_changed() falls back to the
original inode.i_version != cached comparison.

Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
Fixes: 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
Suggested-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
We uncovered a case in kernels >= 6.13 where XFS is no longer updating
struct kstat.change_cookie on i_op getattr() access calls. Instead, XFS is
using multigrain ctime (as well as other file systems) for
change detection in commit 1cf7e834a6fb ("xfs: switch to
multigrain timestamps").

Because file systems may implement i_version as they see fit, IMA
caching may be behind as well as file systems that don't support/export
i_version. Thus we're proposing to compare against the kstat.change_cookie
directly to the cached version, and fall back to a ctime guard when
that's not updated.

EVM is largely left alone since there's no trivial way to query a file
directly in the LSM call paths to obtain kstat.change_cookie &
kstat.ctime to cache. Thus retains accessing i_version directly.

Regression tests will be added to the Linux Test Project instead of
selftest to help catch future file system changes that may impact
future evaluation of IMA.

I'd like this to be backported to at least 6.18 if possible.

Below is a simplified test that demonstrates the issue:

_fragment.config_
CONFIG_XFS_FS=y
CONFIG_OVERLAY_FS=y
CONFIG_IMA=y
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y

_./test.sh_

IMA_POLICY="/sys/kernel/security/ima/policy"
TEST_BIN="/bin/date"
MNT_BASE="/tmp/ima_test_root"

mkdir -p "$MNT_BASE"
mount -t tmpfs tmpfs "$MNT_BASE"
mkdir -p "$MNT_BASE"/{xfs_disk,upper,work,ovl}

dd if=/dev/zero of="$MNT_BASE/xfs.img" bs=1M count=300
mkfs.xfs -q "$MNT_BASE/xfs.img"
mount "$MNT_BASE/xfs.img" "$MNT_BASE/xfs_disk"
cp "$TEST_BIN" "$MNT_BASE/xfs_disk/test_prog"

mount -t overlay overlay -o \
"lowerdir=$MNT_BASE/xfs_disk,upperdir=$MNT_BASE/upper,workdir=$MNT_BASE/work" \
"$MNT_BASE/ovl"

echo "audit func=BPRM_CHECK uid=$(id -u nobody)" > "$IMA_POLICY"

target_prog="$MNT_BASE/ovl/test_prog"
setpriv --reuid nobody "$target_prog"
setpriv --reuid nobody "$target_prog"
setpriv --reuid nobody "$target_prog"

audit_count=$(dmesg | grep -c "file=\"$target_prog\"")

if [[ "$audit_count" -eq 1 ]]; then
        echo "PASS: Found exactly 1 audit event."
else
        echo "FAIL: Expected 1 audit event, but found $audit_count."
        exit 1
fi
---
Changes in v4:
- No functional changes.
- Add Reviewed-by & Fixes tags.
- Link to v3: https://lore.kernel.org/r/20260122-xfs-ima-fixup-v3-1-20335a8aa836@cloudflare.com

Changes in v3:
- Prefer timespec64_to_ns() to leverage attr.version. [Roberto]
- s/TPMFS/TMPFS/ in description.
- Link to v2: https://lore.kernel.org/r/20260120-xfs-ima-fixup-v2-1-f332ead8b043@cloudflare.com

Changes in v2:
- Updated commit description + message to clarify the problem.
- compare struct timespec64 to avoid collision possibility [Roberto].
- Don't check inode_attr_changed() in ima_check_last_writer()
- Link to v1: https://lore.kernel.org/r/20260112-xfs-ima-fixup-v1-1-8d13b6001312@cloudflare.com

Changes since RFC:
- Remove calls to I_IS_VERSION()
- Function documentation/comments
- Abide IMA/EVM change detection fallback invariants
- Combined ctime guard into version for attributes struct
- Link to RFC: https://lore.kernel.org/r/20251229-xfs-ima-fixup-v1-1-6a717c939f7c@cloudflare.com
---
 include/linux/integrity.h         | 35 +++++++++++++++++++++++++++++++----
 security/integrity/evm/evm_main.c |  5 ++---
 security/integrity/ima/ima_api.c  | 11 ++++++++---
 security/integrity/ima/ima_main.c | 17 ++++++++++-------
 4 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index f5842372359be5341b6870a43b92e695e8fc78af..034f0a1ed48ca8c19c764e302bbfc555dad92cde 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -9,6 +9,8 @@
 
 #include <linux/fs.h>
 #include <linux/iversion.h>
+#include <linux/kernel.h>
+#include <linux/time64.h>
 
 enum integrity_status {
 	INTEGRITY_PASS = 0,
@@ -51,14 +53,39 @@ integrity_inode_attrs_store(struct integrity_inode_attributes *attrs,
 
 /*
  * On stacked filesystems detect whether the inode or its content has changed.
+ *
+ * Must be called in process context.
  */
 static inline bool
 integrity_inode_attrs_changed(const struct integrity_inode_attributes *attrs,
-			      const struct inode *inode)
+			      struct file *file, struct inode *inode)
 {
-	return (inode->i_sb->s_dev != attrs->dev ||
-		inode->i_ino != attrs->ino ||
-		!inode_eq_iversion(inode, attrs->version));
+	struct kstat stat;
+
+	might_sleep();
+
+	if (inode->i_sb->s_dev != attrs->dev || inode->i_ino != attrs->ino)
+		return true;
+
+	/*
+	 * EVM currently relies on backing inode i_version. While IS_I_VERSION
+	 * is not a good indicator of i_version support, this still retains
+	 * the logic such that a re-evaluation should still occur for EVM, and
+	 * only for IMA if vfs_getattr_nosec() fails.
+	 */
+	if (!file || vfs_getattr_nosec(&file->f_path, &stat,
+				       STATX_CHANGE_COOKIE | STATX_CTIME,
+				       AT_STATX_SYNC_AS_STAT))
+		return !IS_I_VERSION(inode) ||
+			!inode_eq_iversion(inode, attrs->version);
+
+	if (stat.result_mask & STATX_CHANGE_COOKIE)
+		return stat.change_cookie != attrs->version;
+
+	if (stat.result_mask & STATX_CTIME)
+		return timespec64_to_ns(&stat.ctime) != (s64)attrs->version;
+
+	return true;
 }
 
 
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 73d500a375cb37a54f295b0e1e93fd6e5d9ecddc..6a4e0e246005246d5700b1db590c1759242b9cb6 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -752,9 +752,8 @@ bool evm_metadata_changed(struct inode *inode, struct inode *metadata_inode)
 	bool ret = false;
 
 	if (iint) {
-		ret = (!IS_I_VERSION(metadata_inode) ||
-		       integrity_inode_attrs_changed(&iint->metadata_inode,
-						     metadata_inode));
+		ret = integrity_inode_attrs_changed(&iint->metadata_inode,
+						    NULL, metadata_inode);
 		if (ret)
 			iint->evm_status = INTEGRITY_UNKNOWN;
 	}
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
index 5770cf691912aa912fc65280c59f5baac35dd725..8ac42b03740eb93bf23b15cb9039af6cd32aa999 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -28,6 +28,7 @@
 #include <linux/iversion.h>
 #include <linux/evm.h>
 #include <linux/crash_dump.h>
+#include <linux/time64.h>
 
 #include "ima.h"
 
@@ -199,10 +200,13 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 					    &iint->atomic_flags);
 		if ((iint->flags & IMA_NEW_FILE) ||
 		    vfs_getattr_nosec(&file->f_path, &stat,
-				      STATX_CHANGE_COOKIE,
-				      AT_STATX_SYNC_AS_STAT) ||
-		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
-		    stat.change_cookie != iint->real_inode.version) {
+			    STATX_CHANGE_COOKIE | STATX_CTIME,
+			    AT_STATX_SYNC_AS_STAT) ||
+		    ((stat.result_mask & STATX_CHANGE_COOKIE) ?
+		      stat.change_cookie != iint->real_inode.version :
+		      (!(stat.result_mask & STATX_CTIME) ||
+			timespec64_to_ns(&stat.ctime) !=
+			(s64)iint->real_inode.version))) {
 			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
 			iint->measured_pcrs = 0;
 			if (update)
@@ -328,9 +332,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	real_inode = d_real_inode(file_dentry(file));
 	if (real_inode != inode &&
 	    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
-		if (!IS_I_VERSION(real_inode) ||
-		    integrity_inode_attrs_changed(&iint->real_inode,
-						  real_inode)) {
+		if (integrity_inode_attrs_changed(&iint->real_inode,
+						  file, real_inode)) {
 			iint->flags &= ~IMA_DONE_MASK;
 			iint->measured_pcrs = 0;
 		}

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251212-xfs-ima-fixup-931780a62c2c

Best regards,
-- 
Frederick Lawler <fred@cloudflare.com>

