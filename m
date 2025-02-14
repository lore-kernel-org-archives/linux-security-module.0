Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABF917E;
	Fri, 14 Feb 2025 21:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569340; cv=none; b=g4x7QjoIWw/DfJslj1eYRyKXu50X3jbQXGIEBb2eDKrz99NcJTpI2p+VvGB5u3hAYlSR1Brql5J5MGXaj0msQXJ/PskyWM4VSTOCDc8qJH+pkiWu3hKcjfaPC89YBE2It9JabQH4HGkBaCB8de1denaHxrYP32H81l2Eh8LlJmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569340; c=relaxed/simple;
	bh=XLuOrzEjQyaY0IUo+vLho14NvkAMHT6hDckayFLuutc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OBZpNACX5cupor/PyICmB5QK8+j3xnRKxiyjNDkUU9+6N5/nAXUJNghMhqZugbOn2q9/P5e3jthOuP9htkysoDpAOSWmIoIm5HJH0T8w522JcIhQE3q5egWgEEPMFyVUHvu3eGc2tmu2FnfnBqJWPTXR9QEpfhiG7BGOeTmjF5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TWlgVVC5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TWlgVVC5"
Received: by linux.microsoft.com (Postfix, from userid 1212)
	id 0A811203F3FE; Fri, 14 Feb 2025 13:42:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A811203F3FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739569338;
	bh=fF42Nb38qJ+ivB+Q+dFwY6ajo+AlrWRTG8wb/UHK5kg=;
	h=From:To:Cc:Subject:Date:From;
	b=TWlgVVC5HsuhpzcrXWS7fqv5KDvU9y+CPhuTJ7ssyDv6W8FMIBI3oPDWx3AomPiYH
	 NVCM40jnUynDdrQdSV5g6HbIzI7grLpiEyFAPlBApE7eg7rc4ACPygUatMLF4gncgS
	 Sft7ewXLjsuesP/x01ou7SppDSMTSXyTrke9flgo=
From: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
To: corbet@lwn.net,
	jmorris@namei.org,
	serge@hallyn.com,
	eparis@redhat.com,
	paul@paul-moore.com
Cc: linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-audit@redhat.com,
	linux-kernel@vger.kernel.org,
	Jasjiv Singh <jasjivsingh@linux.microsoft.com>
Subject: [RFC PATCH] ipe: add errno field to IPE policy load auditing
Date: Fri, 14 Feb 2025 13:41:59 -0800
Message-Id: <1739569319-22015-1-git-send-email-jasjivsingh@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Users of IPE require a way to identify when and why an operation fails,
allowing them to both respond to violations of policy and be notified
of potentially malicious actions on their systems with respect to IPE.

This patch introduces a new error field to the AUDIT_IPE_POLICY_LOAD 
event to log policy loading failures. Currently, IPE only logs successful 
policy loads, but not failures. Tracking failures is crucial to detect 
malicious attempts and ensure a complete audit trail for security events.

The new error field will capture the following error codes:

-EBADMSG: Policy is invalid
-ENOMEM: Out of memory (OOM)
-ERANGE: Policy version number overflow
-EINVAL: Policy version parsing error

Here are some examples of the updated audit record types:

AUDIT_IPE_POLICY_LOAD(1422):

audit: AUDIT1422 policy_name="boot_verified" policy_version=0.0.0
  policy_digest=sha256:820EEA5B40CA42B51F68962354BA083122A20BB846F2676
  auid=4294967295 ses=4294967295 lsm=ipe res=1 errno=0
The above record shows a new policy has been successfully loaded into 
the kernel with the policy name, version, and hash with the errno=0.

AUDIT_IPE_POLICY_LOAD(1422) with error:

audit: AUDIT1422 policy_name="boot_verified" policy_version=0.0.0
  policy_digest=sha256:820EEA5B40CA42B51F68962354BA083122A20BB846F2676
  auid=4294967295 ses=4294967295 lsm=ipe res=0 errno=-74

The above record shows a policy load failure due to an invalid policy.

By adding this error field, we ensure that all policy load attempts, 
whether successful or failed, are logged, providing a comprehensive 
audit trail for IPE policy management.

Signed-off-by: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
---
 Documentation/admin-guide/LSM/ipe.rst | 17 ++++++++++++-----
 security/ipe/audit.c                  | 17 ++++++++++++++---
 security/ipe/policy.c                 |  4 +++-
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
index f93a467db628..2143165f48c9 100644
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
@@ -450,7 +450,14 @@ Field descriptions:
 +----------------+------------+-----------+---------------------------------------------------+
 | res            | integer    | No        | The result of the audited operation(success/fail) |
 +----------------+------------+-----------+---------------------------------------------------+
-
+| errno          | integer    | No        | The result of the policy error as follows:        |
+|                |            |           |                                                   |
+|                |            |           | +  0: no error                                    |
+|                |            |           | +  -EBADMSG: policy is invalid                    |
+|                |            |           | +  -ENOMEM: out of memory (OOM)                   |
+|                |            |           | +  -ERANGE: policy version number overflow        |
+|                |            |           | +  -EINVAL: policy version parsing error          |
++----------------+------------+-----------+---------------------------------------------------+
 
 1404 AUDIT_MAC_STATUS
 ^^^^^^^^^^^^^^^^^^^^^
diff --git a/security/ipe/audit.c b/security/ipe/audit.c
index f05f0caa4850..f810f7004498 100644
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
@@ -253,6 +255,8 @@ void ipe_audit_policy_activation(const struct ipe_policy *const op,
  */
 void ipe_audit_policy_load(const struct ipe_policy *const p)
 {
+	int res = 0;
+	int err = 0;
 	struct audit_buffer *ab;
 
 	ab = audit_log_start(audit_context(), GFP_KERNEL,
@@ -260,10 +264,17 @@ void ipe_audit_policy_load(const struct ipe_policy *const p)
 	if (!ab)
 		return;
 
-	audit_policy(ab, AUDIT_POLICY_LOAD_FMT, p);
-	audit_log_format(ab, " auid=%u ses=%u lsm=ipe res=1",
+	if (!IS_ERR(p)) {
+		audit_policy(ab, AUDIT_POLICY_LOAD_FMT, p);
+		res = 1;
+	} else {
+		audit_log_format(ab, AUDIT_POLICY_LOAD_NULL_FMT);
+		err = PTR_ERR(p);
+	}
+
+	audit_log_format(ab, " auid=%u ses=%u lsm=ipe res=%d errno=%d",
 			 from_kuid(&init_user_ns, audit_get_loginuid(current)),
-			 audit_get_sessionid(current));
+			 audit_get_sessionid(current), res, err);
 
 	audit_log_end(ab);
 }
diff --git a/security/ipe/policy.c b/security/ipe/policy.c
index b628f696e32b..0f616e9fbe61 100644
--- a/security/ipe/policy.c
+++ b/security/ipe/policy.c
@@ -202,7 +202,9 @@ struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
 	return new;
 err:
 	ipe_free_policy(new);
-	return ERR_PTR(rc);
+	new = ERR_PTR(rc);
+	ipe_audit_policy_load(new);
+	return new;
 }
 
 /**
-- 
2.34.1

