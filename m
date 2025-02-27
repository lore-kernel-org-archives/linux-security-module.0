Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34732777F0;
	Thu, 27 Feb 2025 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696392; cv=none; b=fZRVUkxL0uVMXT+3N8673swZoQFpui0ZIYG0Td0wVlAJ66buOlYTLVLC6iVYpzWMQCyBwNsVuqV5YkpxKC+IN/RcOIpX61Mni3xUked7VKCcQ7zjJwECIXUWDRMUcnHYxI+500D0/eIogkHhI6ncixcrTymtT069WFU9Hs442WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696392; c=relaxed/simple;
	bh=Q6Pa0KhEvlHtwBQPvl7cH5V19cFDAgMxXJL/DJvUHCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DYwWZGAt8YGiF6FZTra8ae69WYheXPRlNaiJ6cUn28yfRCspvZmDyCprjgi734oeeeTkoZIwUFP0YbluAgh88zBCDNSHCEjY4VWy/d3I/E5iK6CexKSUSx+JDmuOSM8nHpP2DGVRUkA8lJse9rLJqOnozaLghldODgnyXJZd8Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lGVeiR+E; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lGVeiR+E"
Received: by linux.microsoft.com (Postfix, from userid 1212)
	id 7133E210D0F2; Thu, 27 Feb 2025 14:46:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7133E210D0F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740696390;
	bh=aqBCcjB1GK85ZkCy3eKDq7vjs8P7hOhb3Um+ZUwqHwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lGVeiR+EmAAjP23a2cMbYaJvaa52eX7lDcBNK530Z/qjh+OgbQCPGO+GBwkePJJIv
	 sRekI3vtPozpaqqLxu0ar47xgem/MoE5SfVVkidjhVlp3IczOUsC5AA+m/cnC1wCr9
	 oFglWIUtRtych1UOaEmbzyNy34PNtqAayX0ryTpQ=
From: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
To: wufan@kernel.org
Cc: audit@vger.kernel.org,
	corbet@lwn.net,
	eparis@redhat.com,
	jasjivsingh@linux.microsoft.com,
	jmorris@namei.org,
	linux-audit@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	paul@paul-moore.com
Subject: [PATCH v2] ipe: add errno field to IPE policy load auditing
Date: Thu, 27 Feb 2025 14:46:17 -0800
Message-Id: <1740696377-3986-1-git-send-email-jasjivsingh@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <CAKtyLkFg2+8ciy4DM=g+vcTVvuRPNL2SHbN+m9ObErxtYXZYPw@mail.gmail.com>
References: <CAKtyLkFg2+8ciy4DM=g+vcTVvuRPNL2SHbN+m9ObErxtYXZYPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thanks for reviewing it. Here's the example generated from real logs:

AUDIT_IPE_POLICY_LOAD(1422):
audit:  AUDIT1422 policy_name="Test_Policy" policy_version=0.0.1 
policy_digest =sha256:84EFBA8FA71E62AE0A537FAB962F8A2BD1053964C4
299DCA92BFFF4DB82E86D3 auid=1000 ses=3 lsm=ipe res=1 errno=0

The above record shows a new policy has been successfully loaded into
the kernel with the policy name, version, and hash with the errno=0.

AUDIT_IPE_POLICY_LOAD(1422) with error:

audit: AUDIT1422 policy_name=? policy_version=? policy_digest=?
auid=1000 ses=3 lsm=ipe res=0 errno=-74

The above record shows a policy load failure due to an invalid policy.

I have updated the failure cases in new_policy() and update_policy(),
which covers each case as well.
 
Signed-off-by: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
---
 Documentation/admin-guide/LSM/ipe.rst |  2 ++
 security/ipe/audit.c                  | 10 ++++------
 security/ipe/fs.c                     | 17 ++++++++++++-----
 security/ipe/policy.c                 |  4 +---
 security/ipe/policy_fs.c              | 24 +++++++++++++++++++-----
 5 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
index 2143165f48c9..5dbf54471fab 100644
--- a/Documentation/admin-guide/LSM/ipe.rst
+++ b/Documentation/admin-guide/LSM/ipe.rst
@@ -453,6 +453,8 @@ Field descriptions:
 | errno          | integer    | No        | The result of the policy error as follows:        |
 |                |            |           |                                                   |
 |                |            |           | +  0: no error                                    |
+|                |            |           | +  -EPERM: Insufficient permission                |
+|                |            |           | +  -EEXIST: Same name policy already deployed     |
 |                |            |           | +  -EBADMSG: policy is invalid                    |
 |                |            |           | +  -ENOMEM: out of memory (OOM)                   |
 |                |            |           | +  -ERANGE: policy version number overflow        |
diff --git a/security/ipe/audit.c b/security/ipe/audit.c
index f810f7004498..8df307bb2bab 100644
--- a/security/ipe/audit.c
+++ b/security/ipe/audit.c
@@ -21,7 +21,7 @@
 
 #define AUDIT_POLICY_LOAD_FMT "policy_name=\"%s\" policy_version=%hu.%hu.%hu "\
 			      "policy_digest=" IPE_AUDIT_HASH_ALG ":"
-#define AUDIT_POLICY_LOAD_NULL_FMT "policy_name=? policy_version=? "\
+#define AUDIT_POLICY_LOAD_FAIL_FMT "policy_name=? policy_version=? "\
 				   "policy_digest=?"
 #define AUDIT_OLD_ACTIVE_POLICY_FMT "old_active_pol_name=\"%s\" "\
 				    "old_active_pol_version=%hu.%hu.%hu "\
@@ -255,9 +255,8 @@ void ipe_audit_policy_activation(const struct ipe_policy *const op,
  */
 void ipe_audit_policy_load(const struct ipe_policy *const p)
 {
-	int res = 0;
-	int err = 0;
 	struct audit_buffer *ab;
+	int err = 0;
 
 	ab = audit_log_start(audit_context(), GFP_KERNEL,
 			     AUDIT_IPE_POLICY_LOAD);
@@ -266,15 +265,14 @@ void ipe_audit_policy_load(const struct ipe_policy *const p)
 
 	if (!IS_ERR(p)) {
 		audit_policy(ab, AUDIT_POLICY_LOAD_FMT, p);
-		res = 1;
 	} else {
-		audit_log_format(ab, AUDIT_POLICY_LOAD_NULL_FMT);
+		audit_log_format(ab, AUDIT_POLICY_LOAD_FAIL_FMT);
 		err = PTR_ERR(p);
 	}
 
 	audit_log_format(ab, " auid=%u ses=%u lsm=ipe res=%d errno=%d",
 			 from_kuid(&init_user_ns, audit_get_loginuid(current)),
-			 audit_get_sessionid(current), res, err);
+			 audit_get_sessionid(current), !err, err);
 
 	audit_log_end(ab);
 }
diff --git a/security/ipe/fs.c b/security/ipe/fs.c
index 5b6d19fb844a..40805b13ee2c 100644
--- a/security/ipe/fs.c
+++ b/security/ipe/fs.c
@@ -141,12 +141,16 @@ static ssize_t new_policy(struct file *f, const char __user *data,
 	char *copy = NULL;
 	int rc = 0;
 
-	if (!file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN))
-		return -EPERM;
+	if (!file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN)) {
+		rc = -EPERM;
+		goto out;
+	}
 
 	copy = memdup_user_nul(data, len);
-	if (IS_ERR(copy))
-		return PTR_ERR(copy);
+	if (IS_ERR(copy)) {
+		rc = PTR_ERR(copy);
+		goto out;
+	}
 
 	p = ipe_new_policy(NULL, 0, copy, len);
 	if (IS_ERR(p)) {
@@ -161,8 +165,11 @@ static ssize_t new_policy(struct file *f, const char __user *data,
 	ipe_audit_policy_load(p);
 
 out:
-	if (rc < 0)
+	if (rc < 0) {
 		ipe_free_policy(p);
+		p = ERR_PTR(rc);
+		ipe_audit_policy_load(p);
+	}
 	kfree(copy);
 	return (rc < 0) ? rc : len;
 }
diff --git a/security/ipe/policy.c b/security/ipe/policy.c
index 0f616e9fbe61..b628f696e32b 100644
--- a/security/ipe/policy.c
+++ b/security/ipe/policy.c
@@ -202,9 +202,7 @@ struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
 	return new;
 err:
 	ipe_free_policy(new);
-	new = ERR_PTR(rc);
-	ipe_audit_policy_load(new);
-	return new;
+	return ERR_PTR(rc);
 }
 
 /**
diff --git a/security/ipe/policy_fs.c b/security/ipe/policy_fs.c
index 3bcd8cbd09df..74f4e7288331 100644
--- a/security/ipe/policy_fs.c
+++ b/security/ipe/policy_fs.c
@@ -12,6 +12,7 @@
 #include "policy.h"
 #include "eval.h"
 #include "fs.h"
+#include "audit.h"
 
 #define MAX_VERSION_SIZE ARRAY_SIZE("65535.65535.65535")
 
@@ -288,25 +289,38 @@ static ssize_t getactive(struct file *f, char __user *data,
 static ssize_t update_policy(struct file *f, const char __user *data,
 			     size_t len, loff_t *offset)
 {
+	const struct ipe_policy *p = NULL;
 	struct inode *root = NULL;
 	char *copy = NULL;
 	int rc = 0;
 
-	if (!file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN))
-		return -EPERM;
+	if (!file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN)) {
+		rc = -EPERM;
+		goto out;
+	}
 
 	copy = memdup_user(data, len);
-	if (IS_ERR(copy))
-		return PTR_ERR(copy);
+	if (IS_ERR(copy)) {
+		rc = PTR_ERR(copy);
+		goto out;
+	}
 
 	root = d_inode(f->f_path.dentry->d_parent);
 	inode_lock(root);
 	rc = ipe_update_policy(root, NULL, 0, copy, len);
+	if (rc < 0) {
+		inode_unlock(root);
+		goto out;
+	}
 	inode_unlock(root);
 
+out:
 	kfree(copy);
-	if (rc)
+	if (rc) {
+		p = ERR_PTR(rc);
+		ipe_audit_policy_load(p);
 		return rc;
+	}
 
 	return len;
 }
-- 
2.34.1

