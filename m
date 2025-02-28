Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEA923F370;
	Fri, 28 Feb 2025 23:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740784271; cv=none; b=kvhxkb3n25cbV/tuYyQuORCqM4hWRxaOLKWNPxcRwyAK8AreCjkufDIKh1+hcViMdHdpTyb8a4Xuy611u6SBZyIgDgSKLP/7Zhd8WHh/s+q75c4OwqlahKNy77QSBjug7Pd73DsD3939qxmlpfXgeVy0B/ZhuRpURG2V2xpBwtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740784271; c=relaxed/simple;
	bh=CO5S5DajnDPwG34GhKoT/zvuV/gpd9B5vkm8ffwNCbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NrDwoDQyGmRuJIv+HGYRoQ0uRpoK+iBiDRefXFG4gp+jmvNBYAFXab2srqJ6hFnkRSs2dE4IL4jqrg5W+h5BfnVsZAXVcRhNc+bDCXws/x6cyntb7AoPGi8tzKz9dE6dXHdtUJ7AaKfsTG2NqaJnJHm1V1fXPSgWMD9tUGLr2zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QZAhk0ys; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QZAhk0ys"
Received: by linux.microsoft.com (Postfix, from userid 1212)
	id C7001210D0EB; Fri, 28 Feb 2025 15:11:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C7001210D0EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740784266;
	bh=dUUTfNXiktUwy4B8mz5W2W3rISoz7EQbq4EEUSSrGmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZAhk0ys7k1FhkNMJ4YAq+VQUt3b3Xatwb5xSAAQWy3kJIap7nKshwcTFQGs/X6Ly
	 REGesEmQiP0ef3NSBRxu3I/f78YeenjahgAhiHHXW7Bi++pgJdkAHl6wfWaDtVYdec
	 52a4+/DG+3GDbL6c2vPsP+DNLh3FaVrOPqW7Ilmg=
From: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
To: wufan@kernel.org
Cc: audit@vger.kernel.org,
	corbet@lwn.net,
	eparis@redhat.com,
	jasjivsingh@linux.microsoft.com,
	jmorris@namei.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	paul@paul-moore.com
Subject: [PATCH v3] ipe: add errno field to IPE policy load auditing
Date: Fri, 28 Feb 2025 15:11:05 -0800
Message-Id: <1740784265-19829-1-git-send-email-jasjivsingh@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <CAKtyLkFyqFCcqUi7TPn9niUwYcHwv8nVq-joKc8kd8tFg58p-Q@mail.gmail.com>
References: <CAKtyLkFyqFCcqUi7TPn9niUwYcHwv8nVq-joKc8kd8tFg58p-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Users of IPE require a way to identify when and why an operation fails,
allowing them to both respond to violations of policy and be notified
of potentially malicious actions on their systems with respect to IPE.

This patch introduces a new error field to the AUDIT_IPE_POLICY_LOAD event
to log policy loading failures. Currently, IPE only logs successful policy 
loads, but not failures. Tracking failures is crucial to detect malicious 
attempts and ensure a complete audit trail for security events.

The new error field will capture the following error codes:

* 0: no error
* -EPERM: Insufficient permission
* -EEXIST: Same name policy already deployed
* -EBADMSG: policy is invalid
* -ENOMEM: out of memory (OOM)
* -ERANGE: policy version number overflow
* -EINVAL: policy version parsing error

Here are some examples of the updated audit record types:

AUDIT_IPE_POLICY_LOAD(1422):
audit:  AUDIT1422 policy_name="Test_Policy" policy_version=0.0.1 
policy_digest=sha256:84EFBA8FA71E62AE0A537FAB962F8A2BD1053964C4299DCA
92BFFF4DB82E86D3 auid=1000 ses=3 lsm=ipe res=1 errno=0

The above record shows a new policy has been successfully loaded into
the kernel with the policy name, version, and hash with the errno=0.

AUDIT_IPE_POLICY_LOAD(1422) with error:

audit: AUDIT1422 policy_name=? policy_version=? policy_digest=?
auid=1000 ses=3 lsm=ipe res=0 errno=-74

The above record shows a policy load failure due to an invalid policy
(-EBADMSG).

By adding this error field, we ensure that all policy load attempts, 
whether successful or failed, are logged, providing a comprehensive 
audit trail for IPE policy management.

Signed-off-by: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
---
 Documentation/admin-guide/LSM/ipe.rst | 19 ++++++++++++++-----
 security/ipe/audit.c                  | 15 ++++++++++++---
 security/ipe/fs.c                     | 16 +++++++++++-----
 security/ipe/policy_fs.c              | 18 +++++++++++++-----
 4 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
index f93a467db628..5dbf54471fab 100644
--- a/Documentation/admin-guide/LSM/ipe.rst
+++ b/Documentation/admin-guide/LSM/ipe.rst
@@ -423,7 +423,7 @@ Field descriptions:
 
 Event Example::
 
-   type=1422 audit(1653425529.927:53): policy_name="boot_verified" policy_version=0.0.0 policy_digest=sha256:820EEA5B40CA42B51F68962354BA083122A20BB846F26765076DD8EED7B8F4DB auid=4294967295 ses=4294967295 lsm=ipe res=1
+   type=1422 audit(1653425529.927:53): policy_name="boot_verified" policy_version=0.0.0 policy_digest=sha256:820EEA5B40CA42B51F68962354BA083122A20BB846F26765076DD8EED7B8F4DB auid=4294967295 ses=4294967295 lsm=ipe res=1 errno=0
    type=1300 audit(1653425529.927:53): arch=c000003e syscall=1 success=yes exit=2567 a0=3 a1=5596fcae1fb0 a2=a07 a3=2 items=0 ppid=184 pid=229 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=4294967295 comm="python3" exe="/usr/bin/python3.10" key=(null)
    type=1327 audit(1653425529.927:53): PROCTITLE proctitle=707974686F6E3300746573742F6D61696E2E7079002D66002E2E
 
@@ -436,11 +436,11 @@ Field descriptions:
 +----------------+------------+-----------+---------------------------------------------------+
 | Field          | Value Type | Optional? | Description of Value                              |
 +================+============+===========+===================================================+
-| policy_name    | string     | No        | The policy_name                                   |
+| policy_name    | string     | Yes       | The policy_name                                   |
 +----------------+------------+-----------+---------------------------------------------------+
-| policy_version | string     | No        | The policy_version                                |
+| policy_version | string     | Yes       | The policy_version                                |
 +----------------+------------+-----------+---------------------------------------------------+
-| policy_digest  | string     | No        | The policy hash                                   |
+| policy_digest  | string     | Yes       | The policy hash                                   |
 +----------------+------------+-----------+---------------------------------------------------+
 | auid           | integer    | No        | The login user ID                                 |
 +----------------+------------+-----------+---------------------------------------------------+
@@ -450,7 +450,16 @@ Field descriptions:
 +----------------+------------+-----------+---------------------------------------------------+
 | res            | integer    | No        | The result of the audited operation(success/fail) |
 +----------------+------------+-----------+---------------------------------------------------+
-
+| errno          | integer    | No        | The result of the policy error as follows:        |
+|                |            |           |                                                   |
+|                |            |           | +  0: no error                                    |
+|                |            |           | +  -EPERM: Insufficient permission                |
+|                |            |           | +  -EEXIST: Same name policy already deployed     |
+|                |            |           | +  -EBADMSG: policy is invalid                    |
+|                |            |           | +  -ENOMEM: out of memory (OOM)                   |
+|                |            |           | +  -ERANGE: policy version number overflow        |
+|                |            |           | +  -EINVAL: policy version parsing error          |
++----------------+------------+-----------+---------------------------------------------------+
 
 1404 AUDIT_MAC_STATUS
 ^^^^^^^^^^^^^^^^^^^^^
diff --git a/security/ipe/audit.c b/security/ipe/audit.c
index f05f0caa4850..8df307bb2bab 100644
--- a/security/ipe/audit.c
+++ b/security/ipe/audit.c
@@ -21,6 +21,8 @@
 
 #define AUDIT_POLICY_LOAD_FMT "policy_name=\"%s\" policy_version=%hu.%hu.%hu "\
 			      "policy_digest=" IPE_AUDIT_HASH_ALG ":"
+#define AUDIT_POLICY_LOAD_FAIL_FMT "policy_name=? policy_version=? "\
+				   "policy_digest=?"
 #define AUDIT_OLD_ACTIVE_POLICY_FMT "old_active_pol_name=\"%s\" "\
 				    "old_active_pol_version=%hu.%hu.%hu "\
 				    "old_policy_digest=" IPE_AUDIT_HASH_ALG ":"
@@ -254,16 +256,23 @@ void ipe_audit_policy_activation(const struct ipe_policy *const op,
 void ipe_audit_policy_load(const struct ipe_policy *const p)
 {
 	struct audit_buffer *ab;
+	int err = 0;
 
 	ab = audit_log_start(audit_context(), GFP_KERNEL,
 			     AUDIT_IPE_POLICY_LOAD);
 	if (!ab)
 		return;
 
-	audit_policy(ab, AUDIT_POLICY_LOAD_FMT, p);
-	audit_log_format(ab, " auid=%u ses=%u lsm=ipe res=1",
+	if (!IS_ERR(p)) {
+		audit_policy(ab, AUDIT_POLICY_LOAD_FMT, p);
+	} else {
+		audit_log_format(ab, AUDIT_POLICY_LOAD_FAIL_FMT);
+		err = PTR_ERR(p);
+	}
+
+	audit_log_format(ab, " auid=%u ses=%u lsm=ipe res=%d errno=%d",
 			 from_kuid(&init_user_ns, audit_get_loginuid(current)),
-			 audit_get_sessionid(current));
+			 audit_get_sessionid(current), !err, err);
 
 	audit_log_end(ab);
 }
diff --git a/security/ipe/fs.c b/security/ipe/fs.c
index 5b6d19fb844a..da51264a1d0f 100644
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
@@ -161,8 +165,10 @@ static ssize_t new_policy(struct file *f, const char __user *data,
 	ipe_audit_policy_load(p);
 
 out:
-	if (rc < 0)
+	if (rc < 0) {
 		ipe_free_policy(p);
+		ipe_audit_policy_load(ERR_PTR(rc));
+	}
 	kfree(copy);
 	return (rc < 0) ? rc : len;
 }
diff --git a/security/ipe/policy_fs.c b/security/ipe/policy_fs.c
index 3bcd8cbd09df..5f4a8e92bdcf 100644
--- a/security/ipe/policy_fs.c
+++ b/security/ipe/policy_fs.c
@@ -12,6 +12,7 @@
 #include "policy.h"
 #include "eval.h"
 #include "fs.h"
+#include "audit.h"
 
 #define MAX_VERSION_SIZE ARRAY_SIZE("65535.65535.65535")
 
@@ -292,21 +293,28 @@ static ssize_t update_policy(struct file *f, const char __user *data,
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
 	inode_unlock(root);
 
+out:
 	kfree(copy);
-	if (rc)
+	if (rc) {
+		ipe_audit_policy_load(ERR_PTR(rc));
 		return rc;
+	}
 
 	return len;
 }
-- 
2.34.1

