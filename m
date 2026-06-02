Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59598371048
	for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2026 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431826; cv=none; b=S0ugTpKwzl6wEMnrWdskGB11wqY65li1VnkHYwXLkoNMCeT9Et5GQaoqoMY1yORSVmTzAe6HCUBTA/9wqCpDYXTvotkok/4gS5fdtICD38LUgTH2yFttc+zF37mxggmUcHWkCR97RvLq6i9OnUK8/XWCBPsYfnwQ4cxlNnmDlrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431826; c=relaxed/simple;
	bh=sXkjmkK74bAjCTbUH7GY/HNenn3GLRPnj/nxBCl8jzA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ci9mGdlG9nEYEGd8GirOlK/FcVrjmgArq5JxV3HKDMVfEA33db616rsQzknHY013OfcBRFWr0HWtoPfZs84gvEI9QdWMnenwosxZWU0bTZnpTjn1TJS/tDAJxRaWym+gqXz1f1b02XTs986zyaH/O5Le9e5k81+Xrl61ky0jurI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=crXAZUya; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="crXAZUya"
Received: from narnia.corp.microsoft.com (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8D02E20B7168;
	Tue,  2 Jun 2026 13:23:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8D02E20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780431811;
	bh=WFecIQ98XfaYQ+gjeliSB3TT+BCrkeb2otJBsCrpUAM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=crXAZUya2uBWH55KKNTTWREhfbfOHcuSpp9iIrQRyKVDzfMBx9aWVnwCA9wRjDqg6
	 wQWT8xdEC7SI3v45JOjRsjYcUJRF52gLQ9IGDz/2YNLGQMARoB8hJXjO11uQKNewO0
	 5VzfySp5BSq4f2Mxm1tdEa4OmG916PCDClKnhotQ=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: "Paul Moore" <paul@paul-moore.com>,
	"Fan Wu" <wufan@kernel.org>,
	"Blaise Boscaccy" <bboscaccy@linux.microsoft.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 2/3] security, ipe: Remove LSM_INT_VERDICT_UNEXPECTED support
Date: Tue,  2 Jun 2026 13:23:21 -0700
Message-ID: <20260602202336.3579863-3-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602202336.3579863-1-bboscaccy@linux.microsoft.com>
References: <20260602202336.3579863-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit cf5d6b993a43 ("hornet: fix TOCTOU in signed program
verification") LSM_INT_VERDICT_UNEXPECTED was no longer being produced
by any LSMs. Remove support for the orphaned enum value from IPE and
the set of possible verdicts.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 Documentation/admin-guide/LSM/Hornet.rst | 3 ---
 Documentation/admin-guide/LSM/ipe.rst    | 6 +-----
 Documentation/security/ipe.rst           | 3 +--
 include/linux/security.h                 | 1 -
 security/ipe/audit.c                     | 1 -
 security/ipe/eval.c                      | 2 --
 security/ipe/policy.h                    | 1 -
 security/ipe/policy_parser.c             | 2 --
 8 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/LSM/Hornet.rst b/Documentation/admin-guide/LSM/Hornet.rst
index a369bc11408f4..13dcf686ead71 100644
--- a/Documentation/admin-guide/LSM/Hornet.rst
+++ b/Documentation/admin-guide/LSM/Hornet.rst
@@ -47,9 +47,6 @@ make policy decisions based on the verification outcome:
 ``LSM_INT_VERDICT_FAULT``
   A system error occurred during verification.
 
-``LSM_INT_VERDICT_UNEXPECTED``
-  An unexpected map hash value was encountered.
-
 ``LSM_INT_VERDICT_BADSIG``
   The signature or a map hash failed verification.
 
diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
index d68ba9d98859e..a525b4cbb4f09 100644
--- a/Documentation/admin-guide/LSM/ipe.rst
+++ b/Documentation/admin-guide/LSM/ipe.rst
@@ -736,7 +736,7 @@ bpf_signature
    ``IPE_PROP_BPF_SIGNATURE`` config option.
    The format of this property is::
 
-      bpf_signature=(NONE|OK|UNSIGNED|PARTIALSIG|UNKNOWNKEY|UNEXPECTED|FAULT|BADSIG)
+      bpf_signature=(NONE|OK|UNSIGNED|PARTIALSIG|UNKNOWNKEY|FAULT|BADSIG)
 
    The possible values correspond to the integrity verdicts from Hornet:
 
@@ -762,10 +762,6 @@ bpf_signature
 
          The keyring requested by the user is invalid.
 
-      ``UNEXPECTED``
-
-         An unexpected map hash value was encountered during verification.
-
       ``FAULT``
 
          A system error occurred during signature verification.
diff --git a/Documentation/security/ipe.rst b/Documentation/security/ipe.rst
index c51dcb16a377b..6a8d28a1b6be0 100644
--- a/Documentation/security/ipe.rst
+++ b/Documentation/security/ipe.rst
@@ -439,8 +439,7 @@ The hook flow is:
      ``attr->fd_array``. The function produces one of
      ``LSM_INT_VERDICT_OK``, ``LSM_INT_VERDICT_UNSIGNED``,
      ``LSM_INT_VERDICT_BADSIG``, ``LSM_INT_VERDICT_PARTIALSIG``,
-     ``LSM_INT_VERDICT_UNKNOWNKEY``, ``LSM_INT_VERDICT_UNEXPECTED``, or
-     ``LSM_INT_VERDICT_FAULT``.
+     ``LSM_INT_VERDICT_UNKNOWNKEY``, or ``LSM_INT_VERDICT_FAULT``.
   3. Hornet calls ``security_bpf_prog_load_post_integrity()`` with the
      resulting verdict and its ``lsm_id``. IPE's
      ``ipe_bpf_prog_load_post_integrity`` handler does **not** enforce
diff --git a/include/linux/security.h b/include/linux/security.h
index 598cd2eb1dcd5..2476ece76db73 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -107,7 +107,6 @@ enum lsm_integrity_verdict {
 	LSM_INT_VERDICT_UNSIGNED,
 	LSM_INT_VERDICT_PARTIALSIG,
 	LSM_INT_VERDICT_UNKNOWNKEY,
-	LSM_INT_VERDICT_UNEXPECTED,
 	LSM_INT_VERDICT_FAULT,
 	LSM_INT_VERDICT_BADSIG,
 };
diff --git a/security/ipe/audit.c b/security/ipe/audit.c
index 77bbf04d950bd..a2ae22cbc61ed 100644
--- a/security/ipe/audit.c
+++ b/security/ipe/audit.c
@@ -69,7 +69,6 @@ static const char *const audit_prop_names[__IPE_PROP_MAX] = {
 	"bpf_signature=UNSIGNED",
 	"bpf_signature=PARTIALSIG",
 	"bpf_signature=UNKNOWNKEY",
-	"bpf_signature=UNEXPECTED",
 	"bpf_signature=FAULT",
 	"bpf_signature=BADSIG",
 	"bpf_keyring=BUILTIN",
diff --git a/security/ipe/eval.c b/security/ipe/eval.c
index 23ae1edf896b0..58a168e9ebe2b 100644
--- a/security/ipe/eval.c
+++ b/security/ipe/eval.c
@@ -374,8 +374,6 @@ static bool evaluate_property(const struct ipe_eval_ctx *const ctx,
 		return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_PARTIALSIG);
 	case IPE_PROP_BPF_SIG_UNKNOWNKEY:
 		return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_UNKNOWNKEY);
-	case IPE_PROP_BPF_SIG_UNEXPECTED:
-		return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_UNEXPECTED);
 	case IPE_PROP_BPF_SIG_FAULT:
 		return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_FAULT);
 	case IPE_PROP_BPF_SIG_BADSIG:
diff --git a/security/ipe/policy.h b/security/ipe/policy.h
index 748bea92beb19..ba4f529da7d72 100644
--- a/security/ipe/policy.h
+++ b/security/ipe/policy.h
@@ -45,7 +45,6 @@ enum ipe_prop_type {
 	IPE_PROP_BPF_SIG_UNSIGNED,
 	IPE_PROP_BPF_SIG_PARTIALSIG,
 	IPE_PROP_BPF_SIG_UNKNOWNKEY,
-	IPE_PROP_BPF_SIG_UNEXPECTED,
 	IPE_PROP_BPF_SIG_FAULT,
 	IPE_PROP_BPF_SIG_BADSIG,
 	IPE_PROP_BPF_KEYRING_BUILTIN,
diff --git a/security/ipe/policy_parser.c b/security/ipe/policy_parser.c
index 71f63de56616b..b2b807620d89a 100644
--- a/security/ipe/policy_parser.c
+++ b/security/ipe/policy_parser.c
@@ -287,7 +287,6 @@ static const match_table_t property_tokens = {
 	{IPE_PROP_BPF_SIG_UNSIGNED,	"bpf_signature=UNSIGNED"},
 	{IPE_PROP_BPF_SIG_PARTIALSIG,	"bpf_signature=PARTIALSIG"},
 	{IPE_PROP_BPF_SIG_UNKNOWNKEY,	"bpf_signature=UNKNOWNKEY"},
-	{IPE_PROP_BPF_SIG_UNEXPECTED,	"bpf_signature=UNEXPECTED"},
 	{IPE_PROP_BPF_SIG_FAULT,	"bpf_signature=FAULT"},
 	{IPE_PROP_BPF_SIG_BADSIG,	"bpf_signature=BADSIG"},
 	{IPE_PROP_BPF_KEYRING_BUILTIN,	"bpf_keyring=BUILTIN"},
@@ -350,7 +349,6 @@ static int parse_property(char *t, struct ipe_rule *r)
 	case IPE_PROP_BPF_SIG_UNSIGNED:
 	case IPE_PROP_BPF_SIG_PARTIALSIG:
 	case IPE_PROP_BPF_SIG_UNKNOWNKEY:
-	case IPE_PROP_BPF_SIG_UNEXPECTED:
 	case IPE_PROP_BPF_SIG_FAULT:
 	case IPE_PROP_BPF_SIG_BADSIG:
 	case IPE_PROP_BPF_KEYRING_BUILTIN:
-- 
2.53.0

