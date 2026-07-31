Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAF230D40D
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 02:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464486; cv=none; b=raBrgbqgR3Ik4HrvNZsfXQ/3PIzX7blx+KSaoBhXEGMvG0PiDmrDXQiETpNuOW3k4xsXGenTcN7bniARbEoTTV+kfJwht9jdR+6GlXC5N4ILyf/GRhyAjOmDUiBlmI8XJm5JGlE73WtKygLwvWf/tURIDPJPWeB22OTwY7HdS5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464486; c=relaxed/simple;
	bh=bMDEDdCfxgq2K0qqDR8vs2QrKB8d6z+6EloqlgwtX/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WajpjNJ6/FWRkvSXaWrD6psVeEt8P8PP68v6L08+9VvWJfzOk3QYMAbuRcKCfd+XeQq5ENc3ezYVcm9HyGm1+o8xSo8C8MoaPWWm2KiZGVbA8BEuelySN+EnE5w2I/4gCGZx/GS4giHbWl691mUQrXBlBz2Pi/QpFS6Og1gxYNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAxCK+Ko; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAxCK+Ko"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6681e7911b0so551092d50.0
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jul 2026 19:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785464481; x=1786069281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oFgeHGuQz0CJY+tXoH6+LNvpN+Gw0GAfvG1RIFPOUvo=;
        b=CAxCK+KopSlWXCjBdr7rSOpm54K7iN627+A5tCF+tgeClhmUe/Xlm46OS2IcyRanSB
         /oh5QmDu1IiYS9lJKqsK9zFjL+FP5mq+wnVZQP+Zk1H8qoVGO6/1bgnmi6WQu2UUyV0q
         3RZ5fJo4skSURN//vhdg7cpn+Hi2zmt7utGHYDywfsQvTXiLMgfmafZPNN+QBM7Db5M4
         65Lt5tUNLAC/xED/hHjt/+9T9j9JhEilApA7cLutOc8Vo5hycd1o2sB9dY9baAVTrJp1
         i/lgXzW4d+Tj7AdM/DfnwqGgp+DeDEY3zY+nmnzXxr98b26skDf9Wrqdw43VxRtrG7Xs
         IuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785464481; x=1786069281;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oFgeHGuQz0CJY+tXoH6+LNvpN+Gw0GAfvG1RIFPOUvo=;
        b=iA6OnAYXvRpBMKxVLkIetbTZXjG6lP4xDoDObibzQp9zQ+zVzEbOuij2oi0uc+Hjlf
         WS2MZ7PQqIKLfL9CBAGrm9nv2mkIuxgdm6SwuBoB9APu/AtXeP43lxaMln4cWs07z0nH
         /oFJ9DyRJMHdx/CQ9aYAIcpz18rpWSxRBJCvXs4qiOS6BCfFyl9BFquyEnW11FfEB78G
         O9yi6A4ffxWCZybjyFKZfeB/iTJDVpSTn5XUL1Lvg/qi7hoTQeB3rSmq72FbvPIqnNmf
         JBy9aVbQQcO9e7SjiJfTlpg2bRTeHLQaCBZXS7bpX3w6OpgMd45taVkLSoGKAiyL+Zph
         37iA==
X-Forwarded-Encrypted: i=1; AHgh+RoScSe4cy0Tqn3JHJavOxZqME2JqMJhOG6s6J0zcQmWOlkA0qDZpQM+D4lHsR27WfItoOEdNZCdeIreJSp82vAHL5ez8iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTxqDT72CMSSeKlnNBggnbxu+fQiGXj7oq6VMmOYBAG/YGCGMt
	DAJGEoBwgrCilowXXJvd6Ax3G8ZbfkAuhsqSALh/hbYT5ENZEF0lq4c3
X-Gm-Gg: AR+sD11AEDqwtIw4BqjxvZ6qVJcCdoEL3wDcde66pnpyhFGZU2/cInxJPcUclk1DGQj
	4fHvYHmU9Es1fUsdey3iaFB8mGz783WwpCAuBZd7/Ec1iMHSjDsxJN/JUcWbZGE+tfZt1ZwHTMr
	hqKFb/KZFbVEaMZODeVr1fE/Xuvk+tEujTXY9gp1qlYqKT1Bb5kGA2TDgBZ7wetmo33Z+8khl9l
	QAJ+FEah+Mp+9KTmUCLCKhH6cmWR58BjMm9T/eY7FR/qLFQOxB2ZdKGRKhq4SX8/n6pnbJ1gjRc
	1DfXf6Ya/2n+GUQWL9R+MTPmJ7gagQAc2jGZKDoUmTUG6tGrXhTA/sV1IILMnpfdc/JCj9KvQwo
	Ueq7+i3kCCazVdIeEIk+HtKes9qn5IuIyxqx4NgyEi/BRLA1vGpJY1w1XAgTr4zB//fe2XfZ3Ru
	XKoYxea/a5I2FYE0ptSVkJbcXjLnavW/Sd+DFA0+hDrMlloQI0D8AfT83BPV67Kj9AoLuSvLOrC
	cHAFz0qOr9XMtaDZ0kTrQQ=
X-Received: by 2002:a05:690c:d90:b0:81e:8b74:b35c with SMTP id 00721157ae682-81fcbae24c5mr799387b3.36.1785464481061;
        Thu, 30 Jul 2026 19:21:21 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:e94:8a83:feea:6720])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fb8b26e8bsm20519047b3.47.2026.07.30.19.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:21:20 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next 06/13] landlock: Implement the LSM policy kptr hooks
Date: Thu, 30 Jul 2026 22:20:39 -0400
Message-ID: <20260731022047.189137-7-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731022047.189137-1-utilityemal77@gmail.com>
References: <20260731022047.189137-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement the generic LSM hooks backing the BPF-owned Landlock
kfuncs.  The new code is gated on CONFIG_BPF_LSM, the only
configuration where the kfuncs calling the hooks exist.

The policy objects travel in the Landlock member of union
lsm_policy_kptr as struct bpf_landlock_ruleset handles, the
BTF-visible type the verifier tracks; bpf.c is the only place
converting between the handle and struct landlock_ruleset.

- policy_kptr_from_fd() translates a ruleset fd, created with
  landlock_create_ruleset(2) and populated with landlock_add_rule(2),
  into an owned landlock_ruleset reference.  The fd is validated the
  same way as for the Landlock syscalls (ruleset file type,
  FMODE_CAN_READ).

- policy_kptr_put() releases such a reference.  The free is always
  deferred as the hook may be reached from BPF object destructors
  that cannot sleep.

- bprm_enforce_policy_kptr() shares the landlock_restrict_self(2)
  path: it calls landlock_prepare_restriction() on the credentials
  prepared in the binprm and stages the computed restriction in
  their Landlock blob.  Nothing is applied at this point, and there
  is no flag logic of its own: a new landlock_restrict_self(2)
  feature implemented in the shared helpers works here as well.  The
  only divergence is the flag mask: LANDLOCK_RESTRICT_SELF_TSYNC is
  rejected with -EINVAL because the restriction targets the
  execution, not the calling threads.  The restriction is computed in
  a root memcg charging scope: the domain confines the execution on
  behalf of the BPF program, so its GFP_KERNEL_ACCOUNT allocations
  are not charged to the mediated task.

The staged restriction is enforced by a bprm_committing_creds() hook
with the same landlock_apply_restriction() call as the syscall, past
the exec point of no return: a failed execution can no longer return
to the calling program at that point and the application cannot
fail, so an execution either starts confined by the domain or leaves
the calling task untouched.  The applied layer is accounted in
domain_exec: for audit, the confined execution is the one that
enforced the domain, so the LOG_SAME_EXEC and LOG_NEW_EXEC flags
follow the executed program.  There is no no_new_privs/CAP_SYS_ADMIN
precondition here: gating who may load a policy-applying BPF program
is the BPF attachment's privilege model.

The staged restriction's lifetime is fully covered: a second
bprm_enforce_policy_kptr() call on the same execution releases and
replaces the previously staged restriction. An execution failing
before the point of no return releases it through hook_cred_free()
when the prepared credentials are aborted, and the application
clears the staging field so committed task credentials never carry
a staged restriction.  The credential copy helpers
(hook_cred_transfer(), landlock_cred_copy()) uphold that invariant by
never copying a staged restriction.

Cc: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/landlock/Makefile  |   2 +
 security/landlock/bpf.c     | 130 ++++++++++++++++++++++++++++++++++++
 security/landlock/bpf.h     |  21 ++++++
 security/landlock/cred.c    |  16 ++++-
 security/landlock/cred.h    |  18 +++++
 security/landlock/limits.h  |   4 ++
 security/landlock/ruleset.c |   2 +-
 security/landlock/setup.c   |   2 +
 8 files changed, 191 insertions(+), 4 deletions(-)
 create mode 100644 security/landlock/bpf.c
 create mode 100644 security/landlock/bpf.h

diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index ffa7646d99f3..9ba28c06b5ac 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -16,3 +16,5 @@ landlock-$(CONFIG_AUDIT) += \
 	id.o \
 	audit.o \
 	domain.o
+
+landlock-$(CONFIG_BPF_LSM) += bpf.o
diff --git a/security/landlock/bpf.c b/security/landlock/bpf.c
new file mode 100644
index 000000000000..cf89062d35a7
--- /dev/null
+++ b/security/landlock/bpf.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock - LSM policy kptr hooks
+ *
+ * Implementation of the LSM hooks backing the Landlock kfuncs
+ *
+ * Copyright © 2026 Justin Suess <utilityemal77@gmail.com>
+ */
+
+#include <linux/binfmts.h>
+#include <linux/cred.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/lsm_hooks.h>
+#include <linux/memcontrol.h>
+#include <linux/sched/mm.h>
+#include <uapi/linux/landlock.h>
+
+#include "bpf.h"
+#include "cred.h"
+#include "limits.h"
+#include "ruleset.h"
+#include "setup.h"
+
+static int hook_policy_kptr_from_fd(int fd, union lsm_policy_kptr *policy)
+{
+	struct landlock_ruleset *ruleset;
+
+	ruleset = landlock_get_ruleset_from_fd(fd, FMODE_CAN_READ);
+	if (IS_ERR(ruleset))
+		return PTR_ERR(ruleset);
+
+	policy->landlock.ruleset = (struct bpf_landlock_ruleset *)ruleset;
+	return 0;
+}
+
+static void hook_policy_kptr_put(union lsm_policy_kptr *policy)
+{
+	struct landlock_ruleset *ruleset =
+		(struct landlock_ruleset *)policy->landlock.ruleset;
+
+	/*
+	 * May be called from a BPF object destructor that cannot sleep,
+	 * whereas dropping the last ruleset reference frees it and may
+	 * sleep: always defer the free.
+	 */
+	landlock_put_ruleset_deferred(ruleset);
+}
+
+/* Charging scope for the BPF-driven domain allocations: root, i.e. nobody. */
+static struct mem_cgroup *get_bpf_memcg(void)
+{
+#ifdef CONFIG_MEMCG
+	return root_mem_cgroup;
+#else
+	return NULL;
+#endif /* CONFIG_MEMCG */
+}
+
+static int hook_bprm_enforce_policy_kptr(struct linux_binprm *bprm,
+					 union lsm_policy_kptr *policy,
+					 u32 flags)
+{
+	struct landlock_cred_security *bprm_llcred = landlock_cred(bprm->cred);
+	struct landlock_ruleset *ruleset =
+		(struct landlock_ruleset *)policy->landlock.ruleset;
+	struct landlock_restriction restriction;
+	struct mem_cgroup *old_memcg;
+	int err;
+
+	/*
+	 * Same flags as landlock_restrict_self(2), except
+	 * LANDLOCK_RESTRICT_SELF_TSYNC: the restriction targets the
+	 * execution, not the calling threads.
+	 */
+	if ((flags | LANDLOCK_MASK_RESTRICT_BINPRM) !=
+	    LANDLOCK_MASK_RESTRICT_BINPRM)
+		return -EINVAL;
+
+	/*
+	 * The domain confines the execution on behalf of the BPF
+	 * program, not of the mediated task: do not charge the task's
+	 * memcg for it.
+	 */
+	old_memcg = set_active_memcg(get_bpf_memcg());
+	err = landlock_prepare_restriction(bprm_llcred, ruleset, flags,
+					   &restriction);
+	set_active_memcg(old_memcg);
+	if (err)
+		return err;
+
+	/*
+	 * Stages the restriction until the point of no return of the
+	 * execution, replacing (and releasing) any previously staged
+	 * one.  Nothing is enforced yet: an execution that fails before
+	 * committing its credentials drops the staged restriction in
+	 * hook_cred_free() with no effect on the calling task.
+	 */
+	landlock_put_ruleset(bprm_llcred->staged.domain);
+	bprm_llcred->staged = restriction;
+	return 0;
+}
+
+static void hook_bprm_committing_creds(const struct linux_binprm *bprm)
+{
+	struct landlock_cred_security *bprm_llcred = landlock_cred(bprm->cred);
+	struct landlock_restriction restriction;
+
+	if (!bprm_llcred->staged.domain)
+		return;
+
+	restriction = bprm_llcred->staged;
+	bprm_llcred->staged = (struct landlock_restriction){};
+
+	landlock_apply_restriction(bprm_llcred, &restriction);
+}
+
+static struct security_hook_list landlock_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(policy_kptr_from_fd, hook_policy_kptr_from_fd),
+	LSM_HOOK_INIT(policy_kptr_put, hook_policy_kptr_put),
+	LSM_HOOK_INIT(bprm_enforce_policy_kptr, hook_bprm_enforce_policy_kptr),
+	LSM_HOOK_INIT(bprm_committing_creds, hook_bprm_committing_creds),
+};
+
+__init void landlock_add_bpf_hooks(void)
+{
+	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
+			   &landlock_lsmid);
+}
diff --git a/security/landlock/bpf.h b/security/landlock/bpf.h
new file mode 100644
index 000000000000..e57729e6a564
--- /dev/null
+++ b/security/landlock/bpf.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock - LSM policy kptr hooks
+ *
+ * Copyright © 2026 Justin Suess <utilityemal77@gmail.com>
+ */
+
+#ifndef _SECURITY_LANDLOCK_BPF_H
+#define _SECURITY_LANDLOCK_BPF_H
+
+#include <linux/init.h>
+
+#ifdef CONFIG_BPF_LSM
+__init void landlock_add_bpf_hooks(void);
+#else /* CONFIG_BPF_LSM */
+static inline void landlock_add_bpf_hooks(void)
+{
+}
+#endif /* CONFIG_BPF_LSM */
+
+#endif /* _SECURITY_LANDLOCK_BPF_H */
diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index 13b3952c31c5..efbfd0c20475 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -124,6 +124,12 @@ static void hook_cred_transfer(struct cred *const new,
 
 	landlock_get_ruleset(old_llcred->domain);
 	*landlock_cred(new) = *old_llcred;
+
+#ifdef CONFIG_BPF_LSM
+	/* Only bprm credentials own a staged restriction: never copied. */
+	WARN_ON_ONCE(landlock_cred(new)->staged.domain);
+	landlock_cred(new)->staged = (struct landlock_restriction){};
+#endif /* CONFIG_BPF_LSM */
 }
 
 static int hook_cred_prepare(struct cred *const new,
@@ -135,10 +141,14 @@ static int hook_cred_prepare(struct cred *const new,
 
 static void hook_cred_free(struct cred *const cred)
 {
-	struct landlock_ruleset *const dom = landlock_cred(cred)->domain;
+	struct landlock_cred_security *const llcred = landlock_cred(cred);
+
+	landlock_put_ruleset_deferred(llcred->domain);
 
-	if (dom)
-		landlock_put_ruleset_deferred(dom);
+#ifdef CONFIG_BPF_LSM
+	/* Releases a restriction staged for an aborted execution. */
+	landlock_put_ruleset_deferred(llcred->staged.domain);
+#endif /* CONFIG_BPF_LSM */
 }
 
 #ifdef CONFIG_AUDIT
diff --git a/security/landlock/cred.h b/security/landlock/cred.h
index 1d5039b46ce7..74f8c9808dc4 100644
--- a/security/landlock/cred.h
+++ b/security/landlock/cred.h
@@ -60,6 +60,18 @@ struct landlock_cred_security {
 	 */
 	struct landlock_ruleset *domain;
 
+#ifdef CONFIG_BPF_LSM
+	/**
+	 * @staged: Restriction staged by the bprm_enforce_policy_kptr() hook,
+	 * owning its domain reference and applied at the point of no return of
+	 * the execution (bprm_committing_creds).  Only ever set on the
+	 * credentials prepared for an execution, between the staging and
+	 * either the application or the release of the aborted credentials;
+	 * committed task credentials never carry a staged restriction.
+	 */
+	struct landlock_restriction staged;
+#endif /* CONFIG_BPF_LSM */
+
 #ifdef CONFIG_AUDIT
 	/**
 	 * @domain_exec: Bitmask identifying the domain layers that were enforced by
@@ -100,6 +112,12 @@ static inline void landlock_cred_copy(struct landlock_cred_security *dst,
 	*dst = *src;
 
 	landlock_get_ruleset(src->domain);
+
+#ifdef CONFIG_BPF_LSM
+	/* Only bprm credentials own a staged restriction: never copied. */
+	WARN_ON_ONCE(src->staged.domain);
+	dst->staged = (struct landlock_restriction){};
+#endif /* CONFIG_BPF_LSM */
 }
 
 static inline struct landlock_ruleset *landlock_get_current_domain(void)
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 08d5f2f6d321..0bedfe650ea0 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -37,6 +37,10 @@
 #define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_TSYNC
 #define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - 1)
 
+/* Subset of the restrict-self flags applicable to an execution. */
+#define LANDLOCK_MASK_RESTRICT_BINPRM \
+	(LANDLOCK_MASK_RESTRICT_SELF & ~LANDLOCK_RESTRICT_SELF_TSYNC)
+
 /* clang-format on */
 
 #endif /* _SECURITY_LANDLOCK_LIMITS_H */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 4dd09ea22c84..176c626f9f10 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -520,7 +520,7 @@ static void free_ruleset_work(struct work_struct *const work)
 	free_ruleset(ruleset);
 }
 
-/* Only called by hook_cred_free(). */
+/* For contexts that cannot sleep, e.g. hook_cred_free(). */
 void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
 {
 	if (ruleset && refcount_dec_and_test(&ruleset->usage)) {
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index 47dac1736f10..3b7e18edadfb 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -11,6 +11,7 @@
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
+#include "bpf.h"
 #include "common.h"
 #include "cred.h"
 #include "errata.h"
@@ -68,6 +69,7 @@ static int __init landlock_init(void)
 	landlock_add_task_hooks();
 	landlock_add_fs_hooks();
 	landlock_add_net_hooks();
+	landlock_add_bpf_hooks();
 	landlock_init_id();
 	landlock_initialized = true;
 	pr_info("Up and running.\n");
-- 
2.54.0

