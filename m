Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0211F5831;
	Thu, 13 Mar 2025 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741902673; cv=none; b=reFQGRibYDknPsDGsZRa4uO/X7fB6DUDx+eFpfOrNnQO3A40iJHdNzHRkaODYBNjmkwI0Z/VCo5etdrPxu9P8ZHu3oT4/5m81l+/m6GEKTkaKdcEjwZRNtZ/jPkXU7xXIlJ2OPddx53a2K2IwjjwW5lTyy9MuqwCA8xCKwo0Lgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741902673; c=relaxed/simple;
	bh=r9TNLlp5OKYhkuZeiAxJwumJ+WZr3O8+EcxfdTWbeMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ax5FVFO/Q8pOTCIYDQeCVgDMQ/CHOXlJsdKqW7CS+B6sZFZDzAyytXoaSHFSXtnuDXskp+ZNHqsI2udmJ0S6apu38ZhrxpEKwS4hPEvkR2nspgz08Gmpu42cQQbjkUpS6wcUOQXxyOvR8UECVF7F4gay25a1dBheHlReF1jYmtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=D8ZL3Xuf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="D8ZL3Xuf"
Received: by linux.microsoft.com (Postfix, from userid 1212)
	id 076172033432; Thu, 13 Mar 2025 14:51:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 076172033432
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741902671;
	bh=sbjOUH9Jho/u168a9snzWviyAw0z+2VxqGP9mNcIV98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D8ZL3XufCrdVVgb91fFXQnAnsko962oxp9IkjujQUoeD3mI+/A91PPYdDg/Ge0PCV
	 AMrsPr1Wzf+dmRo4A0TMrgcqn55HITU/Ki8gCqPYPq2v48yEPS27eTeJnr4zhKSAES
	 EHy0O6EwiuM0iQPK0hR99iKUANU8e5iGOCv4kkjE=
From: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
To: corbet@lwn.net,
	jmorris@namei.org,
	serge@hallyn.com,
	eparis@redhat.com,
	paul@paul-moore.com
Cc: linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jasjiv Singh <jasjivsingh@linux.microsoft.com>
Subject: [PATCH v5 1/1] ipe: add errno field to IPE policy load auditing
Date: Thu, 13 Mar 2025 14:51:01 -0700
Message-Id: <1741902661-31767-2-git-send-email-jasjivsingh@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741902661-31767-1-git-send-email-jasjivsingh@linux.microsoft.com>
References: <1741902661-31767-1-git-send-email-jasjivsingh@linux.microsoft.com>
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

* -ENOKEY: Key used to sign the IPE policy not found in the keyring
* -ESTALE: Attempting to update an IPE policy with an older version
* -EKEYREJECTED: IPE signature verification failed
* -ENOENT: Policy was deleted while updating
* -EEXIST: Same name policy already deployed
* -ERANGE: Policy version number overflow
* -EINVAL: Policy version parsing error
* -EPERM: Insufficient permission
* -ENOMEM: Out of memory (OOM)
* -EBADMSG: Policy is invalid

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
 Documentation/admin-guide/LSM/ipe.rst | 69 +++++++++++++++++++--------
 security/ipe/audit.c                  | 19 ++++++--
 security/ipe/fs.c                     | 25 ++++++----
 security/ipe/policy.c                 | 17 ++++---
 security/ipe/policy_fs.c              | 28 ++++++++---
 5 files changed, 113 insertions(+), 45 deletions(-)

diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
index f93a467db628..dc7088451f9d 100644
--- a/Documentation/admin-guide/LSM/ipe.rst
+++ b/Documentation/admin-guide/LSM/ipe.rst
@@ -423,7 +423,7 @@ Field descriptions:
 
 Event Example::
 
-   type=1422 audit(1653425529.927:53): policy_name="boot_verified" policy_version=0.0.0 policy_digest=sha256:820EEA5B40CA42B51F68962354BA083122A20BB846F26765076DD8EED7B8F4DB auid=4294967295 ses=4294967295 lsm=ipe res=1
+   type=1422 audit(1653425529.927:53): policy_name="boot_verified" policy_version=0.0.0 policy_digest=sha256:820EEA5B40CA42B51F68962354BA083122A20BB846F26765076DD8EED7B8F4DB auid=4294967295 ses=4294967295 lsm=ipe res=1 errno=0
    type=1300 audit(1653425529.927:53): arch=c000003e syscall=1 success=yes exit=2567 a0=3 a1=5596fcae1fb0 a2=a07 a3=2 items=0 ppid=184 pid=229 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=4294967295 comm="python3" exe="/usr/bin/python3.10" key=(null)
    type=1327 audit(1653425529.927:53): PROCTITLE proctitle=707974686F6E3300746573742F6D61696E2E7079002D66002E2E
 
@@ -433,24 +433,55 @@ This record will always be emitted in conjunction with a ``AUDITSYSCALL`` record
 
 Field descriptions:
 
-+----------------+------------+-----------+---------------------------------------------------+
-| Field          | Value Type | Optional? | Description of Value                              |
-+================+============+===========+===================================================+
-| policy_name    | string     | No        | The policy_name                                   |
-+----------------+------------+-----------+---------------------------------------------------+
-| policy_version | string     | No        | The policy_version                                |
-+----------------+------------+-----------+---------------------------------------------------+
-| policy_digest  | string     | No        | The policy hash                                   |
-+----------------+------------+-----------+---------------------------------------------------+
-| auid           | integer    | No        | The login user ID                                 |
-+----------------+------------+-----------+---------------------------------------------------+
-| ses            | integer    | No        | The login session ID                              |
-+----------------+------------+-----------+---------------------------------------------------+
-| lsm            | string     | No        | The lsm name associated with the event            |
-+----------------+------------+-----------+---------------------------------------------------+
-| res            | integer    | No        | The result of the audited operation(success/fail) |
-+----------------+------------+-----------+---------------------------------------------------+
-
++----------------+------------+-----------+-------------------------------------------------------------+
+| Field          | Value Type | Optional? | Description of Value                                        |
++================+============+===========+=============================================================+
+| policy_name    | string     | Yes       | The policy_name                                             |
++----------------+------------+-----------+-------------------------------------------------------------+
+| policy_version | string     | Yes       | The policy_version                                          |
++----------------+------------+-----------+-------------------------------------------------------------+
+| policy_digest  | string     | Yes       | The policy hash                                             |
++----------------+------------+-----------+-------------------------------------------------------------+
+| auid           | integer    | No        | The login user ID                                           |
++----------------+------------+-----------+-------------------------------------------------------------+
+| ses            | integer    | No        | The login session ID                                        |
++----------------+------------+-----------+-------------------------------------------------------------+
+| lsm            | string     | No        | The lsm name associated with the event                      |
++----------------+------------+-----------+-------------------------------------------------------------+
+| res            | integer    | No        | The result of the audited operation(success/fail)           |
++----------------+------------+-----------+-------------------------------------------------------------+
+| errno          | integer    | No        | Error code from policy loading operations (see table below) |
++----------------+------------+-----------+-------------------------------------------------------------+
+
+Policy error codes (errno):
+
+The following table lists the error codes that may appear in the errno field while loading or updating the policy:
+
++----------------+--------------------------------------------------------+
+| Error Code     | Description                                            |
++================+========================================================+
+| 0              | Success                                                |
++----------------+--------------------------------------------------------+
+| -EPERM         | Insufficient permission                                |
++----------------+--------------------------------------------------------+
+| -EEXIST        | Same name policy already deployed                      |
++----------------+--------------------------------------------------------+
+| -EBADMSG       | Policy is invalid                                      |
++----------------+--------------------------------------------------------+
+| -ENOMEM        | Out of memory (OOM)                                    |
++----------------+--------------------------------------------------------+
+| -ERANGE        | Policy version number overflow                         |
++----------------+--------------------------------------------------------+
+| -EINVAL        | Policy version parsing error                           |
++----------------+--------------------------------------------------------+
+| -ENOKEY        | Key used to sign the IPE policy not found in keyring   |
++----------------+--------------------------------------------------------+
+| -EKEYREJECTED  | Policy signature verification failed                   |
++----------------+--------------------------------------------------------+
+| -ESTALE        | Attempting to update an IPE policy with older version  |
++----------------+--------------------------------------------------------+
+| -ENOENT        | Policy was deleted while updating                      |
++----------------+--------------------------------------------------------+
 
 1404 AUDIT_MAC_STATUS
 ^^^^^^^^^^^^^^^^^^^^^
diff --git a/security/ipe/audit.c b/security/ipe/audit.c
index f05f0caa4850..9668ecc5acd5 100644
--- a/security/ipe/audit.c
+++ b/security/ipe/audit.c
@@ -21,6 +21,8 @@
 
 #define AUDIT_POLICY_LOAD_FMT "policy_name=\"%s\" policy_version=%hu.%hu.%hu "\
 			      "policy_digest=" IPE_AUDIT_HASH_ALG ":"
+#define AUDIT_POLICY_LOAD_NULL_FMT "policy_name=? policy_version=? "\
+				   "policy_digest=?"
 #define AUDIT_OLD_ACTIVE_POLICY_FMT "old_active_pol_name=\"%s\" "\
 				    "old_active_pol_version=%hu.%hu.%hu "\
 				    "old_policy_digest=" IPE_AUDIT_HASH_ALG ":"
@@ -248,22 +250,29 @@ void ipe_audit_policy_activation(const struct ipe_policy *const op,
 }
 
 /**
- * ipe_audit_policy_load() - Audit a policy being loaded into the kernel.
- * @p: Supplies a pointer to the policy to audit.
+ * ipe_audit_policy_load() - Audit a policy loading event.
+ * @p: Supplies a pointer to the policy to audit or an error pointer.
  */
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
+		audit_log_format(ab, AUDIT_POLICY_LOAD_NULL_FMT);
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
index 5b6d19fb844a..f40e50bfd2e7 100644
--- a/security/ipe/fs.c
+++ b/security/ipe/fs.c
@@ -133,6 +133,8 @@ static ssize_t getenforce(struct file *f, char __user *data,
  * * %-ERANGE			- Policy version number overflow
  * * %-EINVAL			- Policy version parsing error
  * * %-EEXIST			- Same name policy already deployed
+ * * %-ENOKEY			- Policy signing key not found
+ * * %-EKEYREJECTED		- Policy signature verification failed
  */
 static ssize_t new_policy(struct file *f, const char __user *data,
 			  size_t len, loff_t *offset)
@@ -141,12 +143,17 @@ static ssize_t new_policy(struct file *f, const char __user *data,
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
+		copy = NULL;
+		goto out;
+	}
 
 	p = ipe_new_policy(NULL, 0, copy, len);
 	if (IS_ERR(p)) {
@@ -158,12 +165,14 @@ static ssize_t new_policy(struct file *f, const char __user *data,
 	if (rc)
 		goto out;
 
-	ipe_audit_policy_load(p);
-
 out:
-	if (rc < 0)
-		ipe_free_policy(p);
 	kfree(copy);
+	if (rc < 0) {
+		ipe_free_policy(p);
+		ipe_audit_policy_load(ERR_PTR(rc));
+	} else {
+		ipe_audit_policy_load(p);
+	}
 	return (rc < 0) ? rc : len;
 }
 
diff --git a/security/ipe/policy.c b/security/ipe/policy.c
index b628f696e32b..1c58c29886e8 100644
--- a/security/ipe/policy.c
+++ b/security/ipe/policy.c
@@ -84,8 +84,11 @@ static int set_pkcs7_data(void *ctx, const void *data, size_t len,
  * ipe_new_policy.
  *
  * Context: Requires root->i_rwsem to be held.
- * Return: %0 on success. If an error occurs, the function will return
- * the -errno.
+ * Return:
+ * * %0	- Success
+ * * %-ENOENT	- Policy was deleted while updating
+ * * %-EINVAL	- Policy name mismatch
+ * * %-ESTALE	- Policy version too old
  */
 int ipe_update_policy(struct inode *root, const char *text, size_t textlen,
 		      const char *pkcs7, size_t pkcs7len)
@@ -146,10 +149,12 @@ int ipe_update_policy(struct inode *root, const char *text, size_t textlen,
  *
  * Return:
  * * a pointer to the ipe_policy structure	- Success
- * * %-EBADMSG					- Policy is invalid
- * * %-ENOMEM					- Out of memory (OOM)
- * * %-ERANGE					- Policy version number overflow
- * * %-EINVAL					- Policy version parsing error
+ * * %-EBADMSG				- Policy is invalid
+ * * %-ENOMEM				- Out of memory (OOM)
+ * * %-ERANGE				- Policy version number overflow
+ * * %-EINVAL				- Policy version parsing error
+ * * %-ENOKEY				- Policy signing key not found
+ * * %-EKEYREJECTED			- Policy signature verification failed
  */
 struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
 				  const char *pkcs7, size_t pkcs7len)
diff --git a/security/ipe/policy_fs.c b/security/ipe/policy_fs.c
index 3bcd8cbd09df..8fa69506b8d5 100644
--- a/security/ipe/policy_fs.c
+++ b/security/ipe/policy_fs.c
@@ -12,6 +12,7 @@
 #include "policy.h"
 #include "eval.h"
 #include "fs.h"
+#include "audit.h"
 
 #define MAX_VERSION_SIZE ARRAY_SIZE("65535.65535.65535")
 
@@ -282,8 +283,13 @@ static ssize_t getactive(struct file *f, char __user *data,
  * On success this updates the policy represented by $name,
  * in-place.
  *
- * Return: Length of buffer written on success. If an error occurs,
- * the function will return the -errno.
+ * Return:
+ * * Length of buffer written		- Success
+ * * %-EPERM				- Insufficient permission
+ * * %-ENOMEM				- Out of memory (OOM)
+ * * %-ENOENT				- Policy was deleted while updating
+ * * %-EINVAL				- Policy name mismatch
+ * * %-ESTALE				- Policy version too old
  */
 static ssize_t update_policy(struct file *f, const char __user *data,
 			     size_t len, loff_t *offset)
@@ -292,21 +298,29 @@ static ssize_t update_policy(struct file *f, const char __user *data,
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
+		copy = NULL;
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

