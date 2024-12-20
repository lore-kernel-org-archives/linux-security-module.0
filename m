Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0174E216386;
	Fri, 20 Dec 2024 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705384; cv=none; b=sseX71twUwUTA5cq1tQVvcIFOeG2odu3jCC+07YLzdpr2h6ENUU17rlP6lWh67BWGAHkWhoT4qDBTmtF4YCp7WaDArRWk7RD4WJG0mP7hmGpeWUwdANFEg6z0j/1dVlqiqDrhfj+mnP8/h5Say0GIT0RAyiYPjUBEpXFPxqs1lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705384; c=relaxed/simple;
	bh=efGu4YKNdFCfK0nPKBzhr0Zebmqdqf/uJH68fOcTYhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6Qr9C2ARuFueDEkQ9JQqQtqXTC4tBCpSPuTpw4/YKKMdp6bUeRQInntu6jIqZjyI93kjhsqalHK09bOMEi3O3RcEoWqurClT7zsxspA3J6i72wk3KI5uPuiwVZ/+/goQHGpEivZqDktMjjXJTRahQKiyveQKZ1CJyD7MeGwJ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j66kSUcf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j66kSUcf"
Received: from pwmachine.localnet (230.60.66.37.rev.sfr.net [37.66.60.230])
	by linux.microsoft.com (Postfix) with ESMTPSA id EECF320D4DE1;
	Fri, 20 Dec 2024 06:36:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EECF320D4DE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734705381;
	bh=lyzqrrwINukt3MdLAkyeIZy/ArU9Tl8ADIyl2zh3+Yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j66kSUcfxdFFFuZ9pvOBJBiaUiXK+MNIFOhd42cwsJlRN3mPzY0B/bVfF1G7a4l5R
	 LZkEGTda04CiulYQGr4Eeml/RyCQ0kGweqkrz0QZhYIs10e3Sk3steGwjn4b36q1Lc
	 oQEdHsrB99fKEiEjN5t8ygCcJ8wGnP7Wcm8Ra8Io=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 08/23] landlock: Log ptrace denials
Date: Fri, 20 Dec 2024 15:36:14 +0100
Message-ID: <1908358.tdWV9SEqCh@pwmachine>
In-Reply-To: <20241122143353.59367-9-mic@digikod.net>
References: <20241122143353.59367-1-mic@digikod.net> <20241122143353.59367-9-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Le vendredi 22 novembre 2024, 15:33:38 CET Micka=EBl Sala=FCn a =E9crit :
> Add audit support to ptrace_access_check and ptrace_traceme hooks.
>=20
> Add a new AUDIT_LANDLOCK_DENY record type dedicated to any Landlock
> denials.
>=20
> Log the domain ID restricting the action, the domain's blockers that are
> missing to allow the requested access, and the target task.
>=20
> The blockers are implicit restrictions (e.g. ptrace), or explicit access
> rights (e.g. filesystem), or explicit scopes (e.g. signal).
>=20
> For the ptrace_access_check case, we log the current/parent domain and
> the child task.  For the ptrace_traceme case, we log the parent domain
> and the parent task.  Indeed, the requester is the current task, but the
> action would be performed by the parent task.
>=20
> The quick return for non-landlocked tasks is moved from task_ptrace() to
> each LSM hooks.
>=20
> Audit event sample:
>=20
>   type=3DLL_DENY msg=3Daudit(1732186800.349:44): domain=3D195ba459b
> blockers=3Dptrace opid=3D1 ocomm=3D"systemd" type=3DSYSCALL
> msg=3Daudit(1732186800.349:44): arch=3Dc000003e syscall=3D101 success=3Dn=
o [...]
> pid=3D300 auid=3D0
>=20
> Cc: G=FCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Micka=EBl Sala=FCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241122143353.59367-9-mic@digikod.net
> ---
>=20
> Changes since v2:
> - Log domain IDs as hexadecimal number: this is a more compact notation
>   (i.e. at least one less digit), it improves alignment in logs, and it
>   makes most IDs start with 1 as leading digit (because of the 2^32
>   minimal value).  Do not use the "0x" prefix that would add useless
>   data to logs.
> - Constify function arguments.
>=20
> Changes since v1:
> - Move most audit code to this patch.
> - Rebase on the TCP patch series.
> - Don't log missing access right: simplify and make it generic for rule
>   types.
> - Don't log errno and then don't wrap the error with
>   landlock_log_request(), as suggested by Jeff.
> - Add a WARN_ON_ONCE() check to never dereference null pointers.
> - Only log when audit is enabled.
> - Don't log task's PID/TID with log_task() because it would be redundant
>   with the SYSCALL record.
> - Move the "op" in front and rename "domain" to "denying_domain" to make
>   it more consistent with other entries.
> - Don't update the request with the domain ID but add an helper to get
>   it from the layer masks (and in a following commit with a struct
>   file).
> - Revamp get_domain_id_from_layer_masks() into
>   get_level_from_layer_masks().
> - For ptrace_traceme, log the parent domain instead of the current one.
> - Add documentation.
> - Rename AUDIT_LANDLOCK_DENIAL to AUDIT_LANDLOCK_DENY.
> - Only log the domain ID and the target task.
> - Log "blockers", which are either implicit restrictions (e.g. ptrace)
>   or explicit access rights (e.g. filesystem), or scopes (e.g. signal).
> - Don't log LSM hook names/operations.
> - Pick an audit event ID folling the IPE ones.
> - Add KUnit tests.
> ---
>  include/uapi/linux/audit.h  |   3 +-
>  security/landlock/Makefile  |   2 +-
>  security/landlock/audit.c   | 137 ++++++++++++++++++++++++++++++++++++
>  security/landlock/audit.h   |  52 ++++++++++++++
>  security/landlock/domain.c  |  21 ++++++
>  security/landlock/domain.h  |  17 +++++
>  security/landlock/ruleset.c |   3 +
>  security/landlock/task.c    |  91 ++++++++++++++++++------
>  8 files changed, 302 insertions(+), 24 deletions(-)
>  create mode 100644 security/landlock/audit.c
>  create mode 100644 security/landlock/audit.h
>  create mode 100644 security/landlock/domain.c
>=20
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 75e21a135483..60c909c396c0 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -33,7 +33,7 @@
>   * 1100 - 1199 user space trusted application messages
>   * 1200 - 1299 messages internal to the audit daemon
>   * 1300 - 1399 audit event messages
> - * 1400 - 1499 SE Linux use
> + * 1400 - 1499 access control messages
>   * 1500 - 1599 kernel LSPP events
>   * 1600 - 1699 kernel crypto events
>   * 1700 - 1799 kernel anomaly records
> @@ -146,6 +146,7 @@
>  #define AUDIT_IPE_ACCESS	1420	/* IPE denial or grant */
>  #define AUDIT_IPE_CONFIG_CHANGE	1421	/* IPE config change */
>  #define AUDIT_IPE_POLICY_LOAD	1422	/* IPE policy load */
> +#define AUDIT_LANDLOCK_DENY	1423	/* Landlock denial */
>=20
>  #define AUDIT_FIRST_KERN_ANOM_MSG   1700
>  #define AUDIT_LAST_KERN_ANOM_MSG    1799
> diff --git a/security/landlock/Makefile b/security/landlock/Makefile
> index e1777abbc413..31512ee4b041 100644
> --- a/security/landlock/Makefile
> +++ b/security/landlock/Makefile
> @@ -5,4 +5,4 @@ landlock-y :=3D setup.o syscalls.o object.o ruleset.o \
>=20
>  landlock-$(CONFIG_INET) +=3D net.o
>=20
> -landlock-$(CONFIG_AUDIT) +=3D id.o
> +landlock-$(CONFIG_AUDIT) +=3D id.o domain.o audit.o
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> new file mode 100644
> index 000000000000..eab6b3a8a231
> --- /dev/null
> +++ b/security/landlock/audit.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Landlock LSM - Audit helpers
> + *
> + * Copyright =A9 2023-2024 Microsoft Corporation
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/audit.h>
> +#include <linux/lsm_audit.h>
> +
> +#include "audit.h"
> +#include "domain.h"
> +#include "ruleset.h"
> +
> +static const char *get_blocker(const enum landlock_request_type type)
> +{
> +	switch (type) {
> +	case LANDLOCK_REQUEST_PTRACE:
> +		return "ptrace";
> +	}
> +
> +	WARN_ON_ONCE(1);
> +	return "unknown";
> +}
> +
> +static void log_blockers(struct audit_buffer *const ab,
> +			 const enum landlock_request_type type)
> +{
> +	audit_log_format(ab, "%s", get_blocker(type));
> +}
> +
> +static struct landlock_hierarchy *
> +get_hierarchy(const struct landlock_ruleset *const domain, const size_t
> layer) +{
> +	struct landlock_hierarchy *node =3D domain->hierarchy;
> +	ssize_t i;
> +
> +	if (WARN_ON_ONCE(layer >=3D domain->num_layers))
> +		return node;
> +
> +	for (i =3D domain->num_layers - 1; i > layer; i--) {
> +		if (WARN_ON_ONCE(!node->parent))
> +			break;
> +
> +		node =3D node->parent;
> +	}
> +
> +	return node;
> +}
> +
> +#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
> +
> +static void test_get_hierarchy(struct kunit *const test)
> +{
> +	struct landlock_hierarchy dom0_node =3D {
> +		.id =3D 10,
> +	};
> +	struct landlock_hierarchy dom1_node =3D {
> +		.parent =3D &dom0_node,
> +		.id =3D 20,
> +	};
> +	struct landlock_hierarchy dom2_node =3D {
> +		.parent =3D &dom1_node,
> +		.id =3D 30,
> +	};
> +	struct landlock_ruleset dom2 =3D {
> +		.hierarchy =3D &dom2_node,
> +		.num_layers =3D 3,
> +	};
> +
> +	KUNIT_EXPECT_EQ(test, 10, get_hierarchy(&dom2, 0)->id);
> +	KUNIT_EXPECT_EQ(test, 20, get_hierarchy(&dom2, 1)->id);
> +	KUNIT_EXPECT_EQ(test, 30, get_hierarchy(&dom2, 2)->id);
> +	KUNIT_EXPECT_EQ(test, 30, get_hierarchy(&dom2, -1)->id);
> +}
> +
> +#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> +
> +static bool is_valid_request(const struct landlock_request *const reques=
t)
> +{
> +	if (WARN_ON_ONCE(!request->layer_plus_one))
> +		return false;
> +
> +	return true;
> +}
> +
> +/**
> + * landlock_log_denial - Create audit records related to a denial
> + *
> + * @domain: The domain denying an action.
> + * @request: Detail of the user space request.
> + */
> +void landlock_log_denial(const struct landlock_ruleset *const domain,
> +			 const struct landlock_request *const request)
> +{
> +	struct audit_buffer *ab;
> +	struct landlock_hierarchy *youngest_denied;
> +
> +	if (WARN_ON_ONCE(!domain || !domain->hierarchy || !request))
> +		return;
> +
> +	if (!is_valid_request(request))
> +		return;
> +
> +	if (!audit_enabled)
> +		return;
> +
> +	ab =3D audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
> +			     AUDIT_LANDLOCK_DENY);
> +	if (!ab)
> +		return;
> +
> +	youngest_denied =3D get_hierarchy(domain, request->layer_plus_one - 1);
> +	audit_log_format(ab, "domain=3D%llx blockers=3D", youngest_denied->id);
> +	log_blockers(ab, request->type);
> +	audit_log_lsm_data(ab, &request->audit);
> +	audit_log_end(ab);
> +}
> +
> +#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
> +
> +static struct kunit_case test_cases[] =3D {
> +	/* clang-format off */
> +	KUNIT_CASE(test_get_hierarchy),
> +	{}
> +	/* clang-format on */
> +};
> +
> +static struct kunit_suite test_suite =3D {
> +	.name =3D "landlock_audit",
> +	.test_cases =3D test_cases,
> +};
> +
> +kunit_test_suite(test_suite);
> +
> +#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> diff --git a/security/landlock/audit.h b/security/landlock/audit.h
> new file mode 100644
> index 000000000000..f33095afcd2f
> --- /dev/null
> +++ b/security/landlock/audit.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Landlock LSM - Audit helpers
> + *
> + * Copyright =A9 2023-2024 Microsoft Corporation
> + */
> +
> +#ifndef _SECURITY_LANDLOCK_AUDIT_H
> +#define _SECURITY_LANDLOCK_AUDIT_H
> +
> +#include <linux/audit.h>
> +#include <linux/lsm_audit.h>
> +
> +#include "ruleset.h"
> +
> +enum landlock_request_type {
> +	LANDLOCK_REQUEST_PTRACE =3D 1,
> +};
> +
> +/*
> + * We should be careful to only use a variable of this type for
> + * landlock_log_denial().  This way, the compiler can remove it entirely=
 if
> + * CONFIG_AUDIT is not set.
> + */
> +struct landlock_request {
> +	/* Mandatory fields. */
> +	enum landlock_request_type type;
> +	struct common_audit_data audit;
> +
> +	/**
> +	 * layer_plus_one: First layer level that denies the request + 1.  The
> +	 * extra one is useful to detect uninitialized field.
> +	 */
> +	size_t layer_plus_one;
> +};
> +
> +#ifdef CONFIG_AUDIT
> +
> +void landlock_log_denial(const struct landlock_ruleset *const domain,
> +			 const struct landlock_request *const request);
> +
> +#else /* CONFIG_AUDIT */
> +
> +static inline void
> +landlock_log_denial(const struct landlock_ruleset *const domain,
> +		    const struct landlock_request *const request)
> +{
> +}
> +
> +#endif /* CONFIG_AUDIT */
> +
> +#endif /* _SECURITY_LANDLOCK_AUDIT_H */
> diff --git a/security/landlock/domain.c b/security/landlock/domain.c
> new file mode 100644
> index 000000000000..965e4dc21975
> --- /dev/null
> +++ b/security/landlock/domain.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Landlock LSM - Domain management
> + *
> + * Copyright =A9 2024 Microsoft Corporation
> + */
> +
> +#include "domain.h"
> +#include "id.h"
> +
> +/**
> + * landlock_init_current_hierarchy - Partially initialize
> landlock_hierarchy + *
> + * @hierarchy: The hierarchy to initialize.
> + *
> + * @hierarchy->parent and @hierarchy->usage should already be set.
> + */
> +void landlock_init_current_hierarchy(struct landlock_hierarchy *const
> hierarchy) +{
> +	hierarchy->id =3D landlock_get_id(1);
> +}
> diff --git a/security/landlock/domain.h b/security/landlock/domain.h
> index 015d61fd81ec..f82d831ca0a7 100644
> --- a/security/landlock/domain.h
> +++ b/security/landlock/domain.h
> @@ -4,6 +4,7 @@
>   *
>   * Copyright =A9 2016-2020 Micka=EBl Sala=FCn <mic@digikod.net>
>   * Copyright =A9 2018-2020 ANSSI
> + * Copyright =A9 2024 Microsoft Corporation
>   */
>=20
>  #ifndef _SECURITY_LANDLOCK_DOMAIN_H
> @@ -26,6 +27,13 @@ struct landlock_hierarchy {
>  	 * domain.
>  	 */
>  	refcount_t usage;
> +
> +#ifdef CONFIG_AUDIT
> +	/**
> +	 * @id: Landlock domain ID, sets once at domain creation time.
> +	 */
> +	u64 id;
> +#endif /* CONFIG_AUDIT */
>  };
>=20
>  static inline void
> @@ -45,4 +53,13 @@ static inline void landlock_put_hierarchy(struct
> landlock_hierarchy *hierarchy) }
>  }
>=20
> +#ifdef CONFIG_AUDIT
> +void landlock_init_current_hierarchy(struct landlock_hierarchy *const
> hierarchy); +#else /* CONFIG_AUDIT */
> +static inline void
> +landlock_init_current_hierarchy(struct landlock_hierarchy *const hierarc=
hy)
> +{
> +}
> +#endif /* CONFIG_AUDIT */
> +
>  #endif /* _SECURITY_LANDLOCK_DOMAIN_H */
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index 4b3dfa3e6fcb..7a88fd9b2473 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -21,6 +21,7 @@
>  #include <linux/workqueue.h>
>=20
>  #include "access.h"
> +#include "audit.h"
>  #include "domain.h"
>  #include "limits.h"
>  #include "object.h"
> @@ -503,6 +504,7 @@ static void free_ruleset_work(struct work_struct *con=
st
> work) free_ruleset(ruleset);
>  }
>=20
> +/* Only called by hook_cred_free(). */
>  void landlock_put_ruleset_deferred(struct landlock_ruleset *const rulese=
t)
>  {
>  	if (ruleset && refcount_dec_and_test(&ruleset->usage)) {
> @@ -562,6 +564,7 @@ landlock_merge_ruleset(struct landlock_ruleset *const
> parent, if (err)
>  		goto out_put_dom;
>=20
> +	landlock_init_current_hierarchy(new_dom->hierarchy);
>  	return new_dom;
>=20
>  out_put_dom:
> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index 98894ad1abc7..1decd6f114e8 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c
> @@ -10,12 +10,14 @@
>  #include <linux/cred.h>
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
> +#include <linux/lsm_audit.h>
>  #include <linux/lsm_hooks.h>
>  #include <linux/rcupdate.h>
>  #include <linux/sched.h>
>  #include <net/af_unix.h>
>  #include <net/sock.h>
>=20
> +#include "audit.h"
>  #include "common.h"
>  #include "cred.h"
>  #include "domain.h"
> @@ -38,41 +40,29 @@ static bool domain_scope_le(const struct
> landlock_ruleset *const parent, {
>  	const struct landlock_hierarchy *walker;
>=20
> +	/* Quick return for non-landlocked tasks. */
>  	if (!parent)
>  		return true;
> +
>  	if (!child)
>  		return false;
> +
>  	for (walker =3D child->hierarchy; walker; walker =3D walker->parent) {
>  		if (walker =3D=3D parent->hierarchy)
>  			/* @parent is in the scoped hierarchy of @child. */
>  			return true;
>  	}
> +
>  	/* There is no relationship between @parent and @child. */
>  	return false;
>  }
>=20
> -static bool task_is_scoped(const struct task_struct *const parent,
> -			   const struct task_struct *const child)
> -{
> -	bool is_scoped;
> -	const struct landlock_ruleset *dom_parent, *dom_child;
> -
> -	rcu_read_lock();
> -	dom_parent =3D landlock_get_task_domain(parent);
> -	dom_child =3D landlock_get_task_domain(child);
> -	is_scoped =3D domain_scope_le(dom_parent, dom_child);
> -	rcu_read_unlock();
> -	return is_scoped;
> -}
> -
> -static int task_ptrace(const struct task_struct *const parent,
> -		       const struct task_struct *const child)
> +static int domain_ptrace(const struct landlock_ruleset *const parent,
> +			 const struct landlock_ruleset *const child)
>  {
> -	/* Quick return for non-landlocked tasks. */
> -	if (!landlocked(parent))
> -		return 0;
> -	if (task_is_scoped(parent, child))
> +	if (domain_scope_le(parent, child))
>  		return 0;
> +
>  	return -EPERM;
>  }
>=20
> @@ -92,7 +82,36 @@ static int task_ptrace(const struct task_struct *const
> parent, static int hook_ptrace_access_check(struct task_struct *const
> child, const unsigned int mode)
>  {
> -	return task_ptrace(current, child);
> +	const struct landlock_ruleset *parent_dom, *child_dom;
> +	struct landlock_request request =3D {
> +		.type =3D LANDLOCK_REQUEST_PTRACE,
> +		.audit =3D {
> +			.type =3D LSM_AUDIT_DATA_TASK,
> +			.u.tsk =3D child,
> +		},
> +	};
> +	int err;
> +
> +	/* Quick return for non-landlocked tasks. */
> +	parent_dom =3D landlock_get_current_domain();
> +	if (!parent_dom)
> +		return 0;
> +
> +	rcu_read_lock();
> +	child_dom =3D landlock_get_task_domain(child);
> +	err =3D domain_ptrace(parent_dom, child_dom);
> +	rcu_read_unlock();
> +
> +	/*
> +	 * For the ptrace_access_check case, we log the current/parent domain
> +	 * and the child task.
> +	 */
> +	if (err && !(mode & PTRACE_MODE_NOAUDIT)) {
> +		request.layer_plus_one =3D parent_dom->num_layers;
> +		landlock_log_denial(parent_dom, &request);
> +	}
> +
> +	return err;
>  }
>=20
>  /**
> @@ -109,7 +128,35 @@ static int hook_ptrace_access_check(struct task_stru=
ct
> *const child, */
>  static int hook_ptrace_traceme(struct task_struct *const parent)
>  {
> -	return task_ptrace(parent, current);
> +	const struct landlock_ruleset *parent_dom, *child_dom;
> +	struct landlock_request request =3D {
> +		.type =3D LANDLOCK_REQUEST_PTRACE,
> +		.audit =3D {
> +			.type =3D LSM_AUDIT_DATA_TASK,
> +			.u.tsk =3D parent,
> +		},
> +	};
> +	int err;
> +
> +	child_dom =3D landlock_get_current_domain();
> +	rcu_read_lock();
> +	parent_dom =3D landlock_get_task_domain(parent);
> +	err =3D domain_ptrace(parent_dom, child_dom);
> +
> +	/*
> +	 * For the ptrace_traceme case, we log the domain which is the cause=20
of
> +	 * the denial, which means the parent domain instead of the current
> +	 * domain.  This may look weird because the ptrace_traceme action is a
> +	 * request to be traced, but the semantic is consistent with
> +	 * hook_ptrace_access_check().
> +	 */
> +	if (err) {
> +		request.layer_plus_one =3D parent_dom->num_layers;
> +		landlock_log_denial(parent_dom, &request);
> +	}
> +
> +	rcu_read_unlock();

Nit: in the above function, you do the rcu_read_unlock() before the if.

> +	return err;
>  }
>=20
>  /**



