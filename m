Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055A13C73E1
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982686; cv=none; b=GIRGMZHWYFMrmoYRMTIGcp0PGAs2kZ6Te7snqdQp8uN/8hLIf0Zg9J6SCLZhWN2tljQvwGcdVts6ysBikS+t9W2etjTBRlWY9zD44jKzwq6KDKDZXhOUCrZ2HyYOsBkM9CAoww2WbTytECiEQOTjh8QKDD+jcP+and3mOtKASg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982686; c=relaxed/simple;
	bh=3UdmNZbim5XGw6/6tAVi8wsONhfQi1lHvtpKuyErfvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUBwlFrDBncYDGwDYWk/OHsQHN3A3Qeih9xgFMjhiAj8tqna+OJjmACplLmwbYylWifmedwg2dB9kJbhf2qSQ3NCurhRRgy3dSDmI98P/Nr3Acr5OFUdzEAw/JkANxNpYTYqfemKzLnPi6NGvfGZUvk2CdRpu/+O94r9Byzz0KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SV40quUM; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SV40quUM"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdcaso14472027b3.3
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 12:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788982684; x=1789587484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EkCEHurDTlOHDlrBUCUNQwXmIR2I592Pn8PkaAk7zk8=;
        b=SV40quUM2PemiShLAriX8Uu8SxRM3gM9ezwq09rWE7WCz1bwOsw5mYcNfk8Ez8oo0x
         eiAXdBMiYA8rRzsVx+2q2mL5nG2llDGViuebV4a9DNtvdBiTXxENdorMWy41RdlFgqBC
         KELGl6BQZkGHk7YQR1zoHqUkqUldqrFu8AqXH73WkP2AvZIxVnwn9R8QNHimJ8Jl13f5
         fOQ3S9W+zQa7LImWk3Nm0IQbmAWzsXemX11IaAHEKAFIOvRklPWk6MrUULUmFgcscpH5
         naWzdroQSnPf/xf5IPywLPawOtHVxsn+vXxWquaAtXDyg948zwbj8IjGYEXuRVtOPMjY
         2FvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982684; x=1789587484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EkCEHurDTlOHDlrBUCUNQwXmIR2I592Pn8PkaAk7zk8=;
        b=mS+9m0abrLAPURJWvV2Rq8t0yyeUOyalCUS8/H8Ufs0KOM2aNjFmjwHpZz3ghX0x3I
         2nU63d7KNzD/+kEGsVAOe6tm3Sy1RkcFqurw26UkQSMQ3Zi19Ic5GRlv0SnSZw+gZ+Vb
         2jXwxq7NNqhshy4O/4lJXVfVFLPXgeHlbnS0KvuU/6chf3SSEuwjUHZlHiwdTI7qeJkM
         Ql1plnjPtoD+j2GU/CFjBK2mDFlI7HI0HVb9W9aqAAOi4vVYUWHa9lMJS+CS0cfmiPya
         RYgPBZeJisCGKOeS5393/GQNmDLhoEzqkV5QPUry6vFuHbooEqbCCa4wieBMBFwtw70D
         p8rw==
X-Forwarded-Encrypted: i=1; AKwUvBx5BOCS1SmR/Z+NZ6uwdC+NQ5RQU4/uTjf/YtYARCrNAWAi+NgkcC2g+WKiqeDZ0Cm/PqlPm5DEVPOyjFW31fD4i3eVZwI=@vger.kernel.org
X-Gm-Message-State: AFuF++m7VPvO5JUGaW0qGetbU+bycaawfw3x+ilfOj/tLk25EeElmMvH
	0AXz5DXO3HfVgfxUmcfgxkIla95mdyReYUZ7o6dMvPd6lJzzworNL8/Y
X-Gm-Gg: AYBFou0GcdFP//6IX0qacIf4YQN4pkfJHR2NfNX+JzARUEDmZOoEICRYoPIXa/lNoTs
	h3jGjHq6ShONk+rGR0OGZ7Up3+WaeBxK1uWW7AnAcfOwpoMoidE216Gygp/KDifrBObwyhYsuAe
	NiAy3vb3f8hyNglw5QzjwTqhH1hCR30xv0qja/KQ1KU2BVWvrlq6esg27oQc+Fyaxb3e/+E7EPl
	0yqUDf3apE2LvgIrkzUEZEkiBU7mPY5Lu4rkYK+Eam9p60FlhwUgYC28DgSvbhXvCYXaIOwjy+e
	NCqo+WYcAYkJRe6dTjp9ykFtaXl6c0I3avIIklaBT0aPss4pO78FGtPF+UVXezCsRCNKsoUwU2A
	l8VXGRjQLKoXmRscijZFqG1mlwprAP6E3iHJW3K+RvupMpchhITAUIl17FCNgVyRiyUiMXITNMP
	eaW2H1S/w120bPo/NAhMxveO9uURnvRW75lh8R5JI5kxOz+CeLG9CJM5hf5b0pNU2Z4KEaWZ+nB
	zCg6naAA/15WRYZFhl7CjSjHRxA9uLi
X-Received: by 2002:a05:690c:6610:b0:881:392b:23db with SMTP id 00721157ae682-881392b4020mr15749527b3.11.1788982683732;
        Wed, 09 Sep 2026 12:38:03 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:bae:bfc2:7e96:e5c8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871493155d3sm115277577b3.16.2026.09.09.12.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:38:03 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: casey@schaufler-ca.com,
	gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	jolsa@kernel.org,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v3 07/15] lsm: Add the bpf_lsm_policy_apply_bprm kfunc
Date: Wed,  9 Sep 2026 15:37:10 -0400
Message-ID: <20260909193719.518517-8-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909193719.518517-1-utilityemal77@gmail.com>
References: <20260909193719.518517-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the kfunc applying a policy object to an execution:

  bpf_lsm_policy_apply_bprm(object, bprm, flags)        KF_SLEEPABLE

It asks the LSM owning @object, through the bprm_apply_policy_object
hook, to restrict the credentials prepared in @bprm, so that the
executed task starts confined by the policy.  The meaning of @flags
and the composition with restrictions the credentials already carry
are the owning LSM's; an LSM without execution policy support makes
the call fail with -EOPNOTSUPP.

The kfunc runs the hook in a root memcg charging scope: the policy
restricts the execution on behalf of the BPF program, not of the
mediated task, so what the owning LSM allocates to compute it, e.g.
Landlock's merged domain, is not charged to the task the program
supervises.

The filter makes the kfunc exclusive to the sleepable LSM programs
attached to the bprm_creds_for_exec() or bprm_creds_from_file()
hooks, the only contexts where the bprm's credentials are prepared
but not yet committed.  The verifier's argument typing does not draw
this boundary on its own: a trusted struct linux_binprm pointer is
also available at the other bprm hooks -- bprm_check_security(),
which runs per binfmt while an interpreter may still rewrite the
execution, and bprm_committing_creds()/bprm_committed_creds(), which
run at or past the point of no return, where the prepared
credentials are frozen or installed -- and to tp_btf programs via
the sched_prepare_exec and sched_process_exec tracepoints, which
resolve kfuncs from the same registration bucket as LSM programs.
The attach-point filter, not the argument type, is the authorization
boundary.

No filter case is needed for BPF_LSM_CGROUP programs: since
commit 5b038319be44 ("bpf: Reject sleepable BPF_LSM_CGROUP programs
at load time") they cannot be sleepable, so KF_SLEEPABLE already
excludes them.

Cc: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v2->v3:
        - Drop the BPF_LSM_CGROUP case from the kfunc filter: since
          commit 5b038319be44 ("bpf: Reject sleepable BPF_LSM_CGROUP
          programs at load time") such programs cannot be sleepable, so
          KF_SLEEPABLE already excludes them from the apply kfunc.
        - Document, in the commit message and the filter comment, why the
          attach-point filter rather than the verifier's argument typing
          is the authorization boundary.

 security/bpf_lsm_kfuncs.c | 68 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/security/bpf_lsm_kfuncs.c b/security/bpf_lsm_kfuncs.c
index 43a4bf57fd31..857e9a316d1c 100644
--- a/security/bpf_lsm_kfuncs.c
+++ b/security/bpf_lsm_kfuncs.c
@@ -2,16 +2,25 @@
 
 /* BPF kfuncs exposing LSM policy objects. */
 
+#include <linux/binfmts.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/cfi.h>
 #include <linux/init.h>
 #include <linux/lsm_hooks.h>
+#include <linux/memcontrol.h>
+#include <linux/sched/mm.h>
 #include <linux/security.h>
 
 #include "lsm.h"
 
+/* The sleepable LSM hooks bpf_lsm_policy_apply_bprm() may be called from. */
+BTF_SET_START(bpf_lsm_policy_bprm_hooks)
+BTF_ID(func, bpf_lsm_bprm_creds_for_exec)
+BTF_ID(func, bpf_lsm_bprm_creds_from_file)
+BTF_SET_END(bpf_lsm_policy_bprm_hooks)
+
 __bpf_kfunc_start_defs();
 
 /**
@@ -44,6 +53,49 @@ bpf_lsm_policy_acquire(struct lsm_policy_object *object)
 	return NULL;
 }
 
+/**
+ * bpf_lsm_policy_apply_bprm - Apply a policy object to exec credentials
+ * @object: policy object to apply
+ * @bprm: execution context providing the prepared credentials to
+ *        restrict
+ * @flags: flags defined by the LSM owning @object
+ *
+ * Ask the LSM owning @object to restrict the credentials prepared in
+ * @bprm with it, so that the executed task starts confined by the
+ * policy.  How the policy composes with restrictions the credentials
+ * already carry, and the meaning of @flags, are defined by the owning
+ * LSM.  @object is only borrowed: the caller keeps its reference.
+ * The hook runs in a root memcg charging scope: policy the LSM
+ * computes on behalf of the program is not charged to the mediated
+ * task.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the LSM owning @object does
+ * not support applying policy to an execution, -EINVAL on unsupported
+ * @flags, other negative values on LSM-specific failures.
+ */
+__bpf_kfunc int bpf_lsm_policy_apply_bprm(struct lsm_policy_object *object,
+					  struct linux_binprm *bprm, u32 flags)
+{
+	struct lsm_static_call *scall;
+	struct mem_cgroup *old_memcg;
+	int err;
+
+	lsm_for_each_hook(scall, bprm_apply_policy_object) {
+		if (scall->hl->lsmid->id != object->lsmid)
+			continue;
+		/*
+		 * The hook runs on behalf of the BPF program, not of the
+		 * mediated task: charge its allocations to the root memcg.
+		 */
+		old_memcg = set_active_memcg(root_mem_cgroup);
+		err = scall->hl->hook.bprm_apply_policy_object(bprm, object,
+							       flags);
+		set_active_memcg(old_memcg);
+		return err;
+	}
+	return -EOPNOTSUPP;
+}
+
 /**
  * bpf_lsm_policy_from_fd - Get an LSM policy object from a fd
  * @fd: file descriptor referring to a policy object, resolved in the
@@ -115,6 +167,7 @@ __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_lsm_policy_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_lsm_policy_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_lsm_policy_apply_bprm, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_lsm_policy_from_fd,
 	     KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_lsm_policy_release, KF_RELEASE)
@@ -124,6 +177,8 @@ BTF_ID_LIST(bpf_lsm_policy_dtor_ids)
 BTF_ID(struct, lsm_policy_object)
 BTF_ID(func, bpf_lsm_policy_release_dtor)
 
+BTF_ID_LIST_SINGLE(bpf_lsm_policy_apply_bprm_ids, func,
+		   bpf_lsm_policy_apply_bprm)
 BTF_ID_LIST_SINGLE(bpf_lsm_policy_from_fd_ids, func, bpf_lsm_policy_from_fd)
 
 /*
@@ -132,6 +187,12 @@ BTF_ID_LIST_SINGLE(bpf_lsm_policy_from_fd_ids, func, bpf_lsm_policy_from_fd)
  * kfuncs requires a filter.  A policy object fd is only meaningful in
  * the fd table of the task that set the object up: the fd kfunc is
  * exclusive to syscall programs, which run in that task's context.
+ * Applying policy to an execution is exclusive to the sleepable bprm
+ * LSM hooks the operation is specified for.  The bprm argument's type
+ * alone does not draw that boundary: other bprm hooks and the tp_btf
+ * exec tracepoints, which share the LSM programs' kfunc bucket, also
+ * provide a trusted bprm pointer outside the window where the
+ * prepared credentials may still be updated.
  */
 static int bpf_lsm_policy_kfunc_filter(const struct bpf_prog *prog,
 				       u32 kfunc_id)
@@ -141,11 +202,18 @@ static int bpf_lsm_policy_kfunc_filter(const struct bpf_prog *prog,
 
 	switch (prog->type) {
 	case BPF_PROG_TYPE_SYSCALL:
+		if (kfunc_id == bpf_lsm_policy_apply_bprm_ids[0])
+			return -EACCES;
 		return 0;
 	case BPF_PROG_TYPE_LSM:
 		if (kfunc_id == bpf_lsm_policy_from_fd_ids[0])
 			return -EACCES;
 
+		if (kfunc_id == bpf_lsm_policy_apply_bprm_ids[0] &&
+		    !btf_id_set_contains(&bpf_lsm_policy_bprm_hooks,
+					 prog->aux->attach_btf_id))
+			return -EACCES;
+
 		return 0;
 	default:
 		return -EACCES;
-- 
2.55.0

