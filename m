Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3E63CFF61;
	Mon, 20 Apr 2026 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776720431; cv=none; b=ZPyiH0hzPB5VID6jza1yS13IbU9cXO7oe3Y0EdWTvnRrxxb4tTG3jmhMkTPs/Qffrqm5ZeLDhtTtWP7A98sIk2smnUJdTcdzDQIjHDO6DguM9//ufYxEnq9sXEqccvTuxeJacsI6FRmWQXmEyKJ8AvUIfHno7uezjCRpCAhxQM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776720431; c=relaxed/simple;
	bh=mK0kfiiF1+QgYq7a1b5dyXcyj14RB0kEwrkVTWcoWkQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeUnCckD15euzwVTGx9PsHcP68aFPePi8SaMGWqKEef/ZdPsTWlrKFI6li0Tkph7VUmOkWsH+DQeuaWf2qchfY74q/y8n5gwJK/Fxqglyw4JHhGrCXU1TuT4UxotBkegafM3NRzbvMG33pbvJllHAuvg9GejctI8EqYmfryhLPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ItNm9u+F; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ItNm9u+F"
Received: from narnia.corp.microsoft.com (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6368120B6F15;
	Mon, 20 Apr 2026 14:27:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6368120B6F15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776720430;
	bh=s7ACBVhFfEKsYGrh1iaguG9Ex1XCRwNmVtrv+rOPiC8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ItNm9u+F6uek1HBAicDo8K+dirnMEOWeMkr8g0HuBDt5z2pzAAk+N+CX8Zljs3hD8
	 N3IOFGHeJizmfZkFqhKCFrnJCwJ8AGaI0Ut6/yHSPTjVs3+sPg/mY39H8hU57fNc7c
	 tMPOiQdCmXuc2iowzLae3mByi+hiUM2Unm2NaSCc=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Paul Moore" <paul@paul-moore.com>,
	"James Morris" <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	James.Bottomley@HansenPartnership.com,
	dhowells@redhat.com,
	"Fan Wu" <wufan@kernel.org>,
	"Ryan Foster" <foster.ryan.r@gmail.com>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	"Song Liu" <song@kernel.org>
Subject: [PATCH v5 04/10] lsm: framework for BPF integrity verification
Date: Mon, 20 Apr 2026 14:26:36 -0700
Message-ID: <20260420212653.438685-5-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420212653.438685-1-bboscaccy@linux.microsoft.com>
References: <20260420212653.438685-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Moore <paul@paul-moore.com>

Add a new LSM hook and two new LSM hook callbacks to support LSMs that
perform integrity verification, e.g. digital signature verification,
of BPF programs.

While the BPF subsystem does implement a signature verification scheme,
it does not satisfy a number of existing requirements, adding support
for BPF program integrity verification to the LSM framework allows
administrators to select additional integrity verification mechanisms
to meet these needs while also providing a mechanism for future
expansion.  Additional on why this is necessary can be found at the
lore archive link below:

https://lore.kernel.org/linux-security-module/CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com/

The LSM-based BPF integrity verification mechanism works within the
existing security_bpf_prog_load() hook called by the BPF subsystem.
It adds an additional dedicated integrity callback and a new LSM
hook/callback to be called from within LSMs implementing integrity
verification.

The first new callback, bpf_prog_load_integrity(), located within the
security_bpf_prog_load() hook, is necessary to ensure that the integrity
verification callbacks are executed before any of the existing LSMs
are executed via the bpf_prog_load() callback.  Reusing the existing
bpf_prog_load() callback for integrity verification could result in LSMs
not having access to the integrity verification results when asked to
authorize the BPF program load in the bpf_prog_load() callback.

The new LSM hook, security_bpf_prog_load_post_integrity(), is intended
to be called from within LSMs performing BPF program integrity
verification.  It is used to report the verdict of the integrity
verification to other LSMs enforcing access control policy on BPF
program loads.  LSMs enforcing such access controls should register a
bpf_prog_load_post_integrity() callback to receive integrity verdicts.

More information on these new callbacks and hook can be found in the
code comments in this patch.

Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 include/linux/lsm_hook_defs.h |  5 +++
 include/linux/security.h      | 25 ++++++++++++
 security/security.c           | 75 +++++++++++++++++++++++++++++++++--
 3 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 8c42b4bde09c0..4971d3c36d5b4 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -434,6 +434,11 @@ LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
 LSM_HOOK(int, 0, bpf_map_create, struct bpf_map *map, union bpf_attr *attr,
 	 struct bpf_token *token, bool kernel)
 LSM_HOOK(void, LSM_RET_VOID, bpf_map_free, struct bpf_map *map)
+LSM_HOOK(int, 0, bpf_prog_load_post_integrity, struct bpf_prog *prog,
+	 union bpf_attr *attr, struct bpf_token *token, bool kernel,
+	 const struct lsm_id *lsmid, enum lsm_integrity_verdict verdict)
+LSM_HOOK(int, 0, bpf_prog_load_integrity, struct bpf_prog *prog,
+	 union bpf_attr *attr, struct bpf_token *token, bool kernel)
 LSM_HOOK(int, 0, bpf_prog_load, struct bpf_prog *prog, union bpf_attr *attr,
 	 struct bpf_token *token, bool kernel)
 LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free, struct bpf_prog *prog)
diff --git a/include/linux/security.h b/include/linux/security.h
index ee88dd2d2d1f7..b3fd04baa78d0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -67,6 +67,7 @@ enum fs_value_type;
 struct watch;
 struct watch_notification;
 struct lsm_ctx;
+struct lsm_id;
 
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
@@ -100,6 +101,14 @@ enum lsm_integrity_type {
 	LSM_INT_FSVERITY_BUILTINSIG_VALID,
 };
 
+enum lsm_integrity_verdict {
+	LSM_INT_VERDICT_NONE = 0,
+	LSM_INT_VERDICT_OK,
+	LSM_INT_VERDICT_UNSIGNED,
+	LSM_INT_VERDICT_PARTIALSIG,
+	LSM_INT_VERDICT_BADSIG,
+};
+
 /*
  * These are reasons that can be passed to the security_locked_down()
  * LSM hook. Lockdown reasons that protect kernel integrity (ie, the
@@ -2270,6 +2279,12 @@ extern int security_bpf_prog(struct bpf_prog *prog);
 extern int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
 				   struct bpf_token *token, bool kernel);
 extern void security_bpf_map_free(struct bpf_map *map);
+extern int security_bpf_prog_load_post_integrity(struct bpf_prog *prog,
+					union bpf_attr *attr,
+					struct bpf_token *token,
+					bool kernel,
+					const struct lsm_id *lsmid,
+					enum lsm_integrity_verdict verdict);
 extern int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
 				  struct bpf_token *token, bool kernel);
 extern void security_bpf_prog_free(struct bpf_prog *prog);
@@ -2304,6 +2319,16 @@ static inline int security_bpf_map_create(struct bpf_map *map, union bpf_attr *a
 static inline void security_bpf_map_free(struct bpf_map *map)
 { }
 
+static inline int security_bpf_prog_load_post_integrity(struct bpf_prog *prog,
+					  union bpf_attr *attr,
+					  struct bpf_token *token,
+					  bool kernel,
+					  const struct lsm_id *lsmid,
+					  enum lsm_integrity_verdict verdict)
+{
+	return 0;
+}
+
 static inline int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
 					 struct bpf_token *token, bool kernel)
 {
diff --git a/security/security.c b/security/security.c
index a26c1474e2e49..bb78f7e45a98f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5233,6 +5233,50 @@ int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
 	return rc;
 }
 
+/**
+ * security_bpf_prog_load_post_integrity() - Check if the BPF prog is allowed
+ * @prog: BPF program object
+ * @attr: BPF syscall attributes used to create BPF program
+ * @token: BPF token used to grant user access to BPF subsystem
+ * @kernel: whether or not call originated from kernel
+ * @lsmid: LSM ID of the LSM providing @verdict
+ * @verdict: result of the integrity verification
+ *
+ * See the comment block for the security_bpf_prog_load() LSM hook.
+ *
+ * This LSM hook is intended to be called from within the
+ * bpf_prog_load_integrity() callback that is part of the
+ * security_bpf_prog_load() hook; kernel subsystems outside the scope of the
+ * LSM framework should not call this hook directly.
+ *
+ * If the LSM calling into this hook receives a non-zero error code, it should
+ * return the same error code back to its caller.  If this hook returns a zero,
+ * it does not necessarily mean that all of the enabled LSMs have authorized
+ * the BPF program load, as there may be other LSMs implementing BPF integrity
+ * checks which have yet to execute.  However, if a zero is returned, the LSM
+ * calling into this hook should continue and return zero back to its caller.
+ *
+ * LSMs which implement the bpf_prog_load_post_integrity() callback and
+ * determine that a particular BPF program load is not authorized may choose to
+ * either return an error code for immediate rejection, or store their decision
+ * in their own LSM state attached to @prog, later returning an error code in
+ * the bpf_prog_load() callback.  An immediate error code return is in keeping
+ * with the "fail fast" practice, but waiting until the bpf_prog_load()
+ * callback allows the LSM to consider multiple different integrity verdicts.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
+int security_bpf_prog_load_post_integrity(struct bpf_prog *prog,
+					  union bpf_attr *attr,
+					  struct bpf_token *token,
+					  bool kernel,
+					  const struct lsm_id *lsmid,
+					  enum lsm_integrity_verdict verdict)
+{
+	return call_int_hook(bpf_prog_load_post_integrity, prog, attr, token,
+			     kernel, lsmid, verdict);
+}
+
 /**
  * security_bpf_prog_load() - Check if loading of BPF program is allowed
  * @prog: BPF program object
@@ -5241,8 +5285,24 @@ int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
  * @kernel: whether or not call originated from kernel
  *
  * Perform an access control check when the kernel loads a BPF program and
- * allocates associated BPF program object. This hook is also responsible for
- * allocating any required LSM state for the BPF program.
+ * allocates the associated BPF program object. This hook is also responsible
+ * for allocating any required LSM state for the BPF program.
+ *
+ * This hook calls two LSM callbacks: bpf_prog_load_integrity() and
+ * bpf_prog_load().  The bpf_prog_load_integrity() callback is for those LSMs
+ * that wish to implement integrity verifications of BPF programs, e.g.
+ * signature verification, while the bpf_prog_load() callback is for general
+ * authorization of the BPF program load.  Performing both verification and
+ * authorization in a single callback, with arbitrary LSM ordering, would be
+ * a challenge.
+ *
+ * LSMs which implement the bpf_prog_load_integrity() callback should call into
+ * the security_bpf_prog_load_post_integrity() hook with their integrity
+ * verdict.  LSMs which implement BPF program integrity policy can register a
+ * callback for the security_bpf_prog_load_post_integrity() hook and
+ * either update their own internal state based on the verdict, or immediately
+ * reject the BPF program load with an error code.  See the comment block for
+ * security_bpf_prog_load_post_integrity() for more information.
  *
  * Return: Returns 0 on success, error on failure.
  */
@@ -5255,9 +5315,18 @@ int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
 	if (unlikely(rc))
 		return rc;
 
+	rc = call_int_hook(bpf_prog_load_integrity, prog, attr, token, kernel);
+	if (unlikely(rc))
+		goto err;
+
 	rc = call_int_hook(bpf_prog_load, prog, attr, token, kernel);
 	if (unlikely(rc))
-		security_bpf_prog_free(prog);
+		goto err;
+
+	return rc;
+
+err:
+	security_bpf_prog_free(prog);
 	return rc;
 }
 
-- 
2.53.0

