Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04682394797
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792232425; cv=none; b=aX326sjiD8fuDk+LlJY90u76ksZ4Z35gnBdju6LFsocWwp8UEYMpS8ANnuJPN1z3E890JF6zwks2IO4a9tQ7zilfnHWnDxxegczXBa8cRZ2307dW69+b2vM1IRXIEpzYuyDa9X5bgnm0bLPbrRvmMaqGy9wp8ebFoHOFsGuqpLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792232425; c=relaxed/simple;
	bh=qvYgQQ27bJ2HtYKs1JkOLRTabfXuEb/wtl6k8qSJMzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROoH/TLn1XGyK3nQky/erG2gunDcY/gVNlPng7Jp9wjJ9AxgFuJfl1RBJi8l2AGxvXZq0sIzraM+jVrM2onlojRD+c3otGDZZ+oGNt4xAotiKczYiB68wSpEWfH0xK7htNpN97cuM7FOJ7aAfBG3tIgQJUWk+VrwkaujCbTkrpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtgNew51; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtgNew51"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e04773687so138945f8f.2
        for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 03:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792232420; x=1792837220; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=80sFfedD2sq6rYCvRyemy6MLvoEYQByYwcWDePFq03o=;
        b=QtgNew51lIr9L0XNRQb8cJip7WephQAnocOHgSgvaNw5zXtJq0h/pNcE0UxgV1ORNA
         meX6UxlHivgc1PXbQXkLPLQtrK3Bqjkx3tYQBZHdIKYR50SRSTUIAkfsp2b7tw6v5CrN
         YHYwJ/zjYozRXr52mTCpixc7mx3BEm5D3vqUnmu3vEIdsVMGmAoXY96A/W9UImxvqeBw
         aNRThKS/gqQR37vQeI7hcLyxfVOHyNK1wNT/rrdQSnxucFisYubPI/Xm3nJcE7edWbA/
         lzLfzqp7dKjFFpRs/X28FzBbaNWD8dBlOwjWVjcSOzvdsqylQBVlHt19dFAaJu3X+LTG
         TfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792232420; x=1792837220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=80sFfedD2sq6rYCvRyemy6MLvoEYQByYwcWDePFq03o=;
        b=gE4BXOWVx+DXdvUUqQRZy/r+TlgJRO2GUJVAbrsqWmqWDlzh+lSlfITT+QpIsf5H4w
         tbaOiHHVrbX01l2QGeHsPtzb+v/lZ4S4zFrodxkj2Au4VnxvR2xRKAgJ9h/fHBDwlHIA
         jJ0s6qp+IpjFO+6YLSNsIkgK5sPtY0VWr57t0VqlmvfrMkgk+45eq5Pyx7jBJxPaE/iy
         rOQsSggTkcbxT4Pfsb7rKEcauNAJeXOSjJ/kR15eUPVciPl5Dy5DvmJKLAVstlL/tU0a
         qFHlzK+oHy3GQyRv5adV9xqSuZbK/VYl97aUc7DKBQgEtPVcM0Gscm/DAZXIyuM34thE
         tJ5A==
X-Forwarded-Encrypted: i=1; AKwUvBxbinj5dAhEaShqFWFARzXjk4KwUHXpX5+yRRi7LKHAQdPDQM5XpZ2m25f+bY3/3gDNtHjThQXJqjD8svIbGll3hsKH5Fo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxaPPeT5Iyl5yNzvBb0X6blULZBA47cZjOE4wufNX62cApLf2u
	T35kUYSKRGoJszg7PRVNqkzVVDb0forZKWGvbXUR1cAcooDcTfHffy2N
X-Gm-Gg: AYBFou02qjbWXK1OkCXjcthY3mnp9BJgVDZEVZQ9Qq0VUB6/0XNYrtsgwUu1EH4rTBJ
	T91MsZPsK2u6Za9An4CZgiqCq24fZLev837LVmXEqdu3NMLop0f1zp9bdcvox6BMpB8ICgphUyC
	tUTcpG1XUSnMarPqeOe9XHSjrcTlqmEbbZvhj089SPQ/gjYjz1iL0SGWGS6Sud8kf+P290vyQ9+
	pVGrQqV+C8+xRTbdN5WlL+MVkRiB2kcT6ZMLZK7JxblWlwp1EVAD0WjnYBOk/hf/yK1FtWx8krS
	l1R9UpgPaH/scRrf55AmybJHNbqeNP/yNYZxcx4EuRSI1zEDRZA6rVPv5FL66UX29DBvfhefoq8
	x511JzMO8LvHU2jO6edGy3vluikIeL5YmOixrdpy4ezlDJiCVaTVT14mIuf81y09SZY64eLKIfC
	eay8x3pYTp2ZyFhC2nVg3bVQp6dBsK3KwlzetHPDXSOP+kA0udKjEsoUMVIWXYIed8dkBVEw7Xh
	URRK3VRt0MGVDAGkvijPnk=
X-Received: by 2002:adf:e187:0:b0:48a:ffc4:72e0 with SMTP id ffacd0b85a97d-48e07975bddmr4206135f8f.4.1792232419772;
        Sat, 17 Oct 2026 03:20:19 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f5177sm10037684f8f.30.2026.10.17.03.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 03:20:19 -0700 (PDT)
Date: Sat, 17 Oct 2026 12:20:12 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Daniel Durning <danieldurning.work@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 6/8] selftests/landlock: Add capability restriction
 tests
Message-ID: <20261017.63923e5027e9@gnoack.org>
References: <20261014082718.1435842-1-mic@digikod.net>
 <20261014082718.1435842-7-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261014082718.1435842-7-mic@digikod.net>

On Wed, Oct 14, 2026 at 10:27:12AM +0200, Mickaël Salaün wrote:
> Add tests to exercise LANDLOCK_PERMISSION_CAPABILITY_USE enforcement.  A
> sandboxed process is denied a handled capability when no rule grants it,
> and an explicit rule restores it.  Unknown capability values above
> CAP_LAST_CAP are accepted at rule-add time yet have no runtime effect,
> because deny-by-default still applies once the domain is enforced.
> Stacking tests cover the per-layer allow/deny combinations, including a
> layer that does not handle the permission, and invalid rule attributes
> return the expected errors.
> 
> Three tests exercise non-standard capability contexts: enforcing a
> domain via CAP_SYS_ADMIN authorization without no_new_privs, restricting
> capabilities gained through the kernel's user namespace ownership bypass
> (cap_capable_helper), and checking CAP_SYS_ADMIN against a descendant
> user namespace, with an unsandboxed positive control, to confirm the
> decision is independent of the target.
> 
> Audit tests verify denied and allowed capabilities, per-member quiet
> interactions, and CAP_OPT_NOAUDIT suppression.  Trace tests cover
> accepted, rejected, and no-op rule adds, and normal, quiet, and
> CAP_OPT_NOAUDIT denials.
> 
> Test coverage for security/landlock is 91.8% of 2864 lines according to
> LLVM 22.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v5:
> https://patch.msgid.link/20261007100255.1333386-7-mic@digikod.net
> - Initialize audit record counts before checking helper failures
>   (reported by Sashiko).
> - Avoid flaky zero-domain assertions when checking that allowed and
>   CAP_OPT_NOAUDIT operations emit no audit access records.
> 
> Changes since v4:
> https://patch.msgid.link/20261002124409.1277970-7-mic@digikod.net
> - Isolate cap_without_nnp in a private UTS namespace before the denied
>   sethostname() check, and clear temporary effective capabilities after
>   the related probes (reported by Sashiko for the isolation issue).
> 
> Changes since v3:
> https://patch.msgid.link/20260726161400.3010511-11-mic@digikod.net
> - Cover the EFAULT result for an invalid capability rule pointer.
> - Drop CAP_AUDIT_CONTROL after cleaning up the audit fixture.
> - Isolate cap_stacking and cap_audit in private UTS namespaces before
>   their successful sethostname() calls.
> - Add trace tests for successful and rejected rules, effective no-ops,
>   and normal, quiet, and CAP_OPT_NOAUDIT denials.
> - Extend audit coverage for normal-denial controls, same-member
>   allow/quiet overlap, and youngest-denier behavior.
> - Test target-user-namespace independence with an unsandboxed positive
>   control.
> 
> Changes since v2:
> https://patch.msgid.link/20260527181127.879771-8-mic@digikod.net
> - Rebased for ABI 11 and the renamed capability rule attribute (perm
>   plus allowed_capabilities/quiet_capabilities).
> - Add per-member quiet audit tests for the capability permission:
>   cap_audit.quieted, plus quiet-only and allow+quiet legs in
>   add_rule_bad_attr and the add_cap_rule_full helper.
> - add_rule_bad_attr: drop the dead quiet_capabilities reset after the
>   allow+quiet rule and reset it explicitly where the following rule
>   needs an allow-only attr, clarifying intent.
> - Strengthen the audit tests with positive controls: cap_audit.quieted
>   and cap_audit.noaudit_probe_not_logged now also assert that a normal
>   (non-quiet, non-noaudit) capability denial in the same domain IS
>   logged, proving suppression is not global.  cap_audit.quieted also
>   asserts the quieted capability is still denied (EPERM), not merely
>   unlogged.
> - Add cap_audit.quiet_unknown_bit_no_effect (an unknown quiet bit does
>   not suppress a known capability denial).
> 
> Changes since v1:
> https://patch.msgid.link/20260312100444.2609563-8-mic@digikod.net
> - Reflow comments after check-linux.sh comment fixes.
> - Rename LANDLOCK_PERM_NAMESPACE_ENTER references to
>   LANDLOCK_PERM_NAMESPACE_USE and bump the abi_version expectation
>   to 11 (companion changes to the introducing commit).
> - Add add_rule_unknown_no_runtime_effect: assert that a rule listing
>   only unknown capability bits is accepted at rule-add time but has
>   no runtime effect, so an actual CAP_* exercise (sethostname with
>   CAP_SYS_ADMIN) is still denied by deny-by-default once the domain
>   is enforced.
> - Add cap_stacking parent_denies variant covering the inverse
>   direction of stacking: layer 1 denies CAP_SYS_ADMIN, layer 2
>   allows, capability still denied.  Completes the per-layer walker
>   direction coverage.
> - Assert records.domain == 0 in cap_audit.allowed so the test also
>   checks that no domain-allocation record is emitted when nothing
>   is denied.
> ---
>  tools/testing/selftests/landlock/base_test.c |   19 +
>  tools/testing/selftests/landlock/cap_test.c  | 1370 ++++++++++++++++++
>  tools/testing/selftests/landlock/trace.h     |   24 +
>  3 files changed, 1413 insertions(+)
>  create mode 100644 tools/testing/selftests/landlock/cap_test.c
> 
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index 58fe322d8637..89c0d96607de 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -142,6 +142,25 @@ TEST(errata)
>  	ASSERT_EQ(EINVAL, errno);
>  }
>  
> +#define PERMISSION_LAST LANDLOCK_PERMISSION_CAPABILITY_USE
> +
> +TEST(ruleset_with_unknown_permission)
> +{
> +	__u64 permission_mask;
> +
> +	for (permission_mask = 1ULL << 63; permission_mask != PERMISSION_LAST;
> +	     permission_mask >>= 1) {
> +		struct landlock_ruleset_attr ruleset_attr = {
> +			.handled_permissions = permission_mask,
> +		};
> +
> +		/* Unknown handled_permissions values must be rejected. */
> +		ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
> +						      sizeof(ruleset_attr), 0));
> +		ASSERT_EQ(EINVAL, errno);
> +	}
> +}
> +
>  /* Tests ordering of syscall argument checks. */
>  TEST(create_ruleset_checks_ordering)
>  {
> diff --git a/tools/testing/selftests/landlock/cap_test.c b/tools/testing/selftests/landlock/cap_test.c
> new file mode 100644
> index 000000000000..3d7fd02e21ed
> --- /dev/null
> +++ b/tools/testing/selftests/landlock/cap_test.c
> @@ -0,0 +1,1370 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Landlock tests - Capability restriction
> + *
> + * Copyright © 2026 Cloudflare, Inc.
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <linux/capability.h>
> +#include <linux/landlock.h>
> +#include <sched.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/mount.h>
> +#include <sys/wait.h>
> +#include <sys/xattr.h>
> +#include <unistd.h>
> +
> +#include "audit.h"
> +#include "common.h"
> +#include "trace.h"
> +
> +#define TRACE_TASK "cap_test"
> +
> +static bool list_has_xattr(const char *list, ssize_t len, const char *name)
> +{
> +	const char *p;
> +
> +	for (p = list; p < list + len; p += strlen(p) + 1)
> +		if (strcmp(p, name) == 0)
> +			return true;
> +	return false;
> +}
> +
> +static int create_cap_ruleset(void)
> +{
> +	const struct landlock_ruleset_attr attr = {
> +		.handled_permissions = LANDLOCK_PERMISSION_CAPABILITY_USE,
> +	};
> +
> +	return landlock_create_ruleset(&attr, sizeof(attr), 0);
> +}
> +
> +static int add_cap_rule(int ruleset_fd, __u64 cap)
> +{
> +	const struct landlock_capability_attr attr = {
> +		.permissions = LANDLOCK_PERMISSION_CAPABILITY_USE,
> +		.allowed_capabilities = (1ULL << cap),
> +	};
> +
> +	return landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY, &attr,
> +				 0);
> +}
> +
> +static int add_cap_rule_full(int ruleset_fd, __u64 allowed, __u64 quiet)
> +{
> +	const struct landlock_capability_attr attr = {
> +		.permissions = LANDLOCK_PERMISSION_CAPABILITY_USE,
> +		.allowed_capabilities = allowed,
> +		.quiet_capabilities = quiet,
> +	};
> +
> +	return landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY, &attr,
> +				 0);
> +}
> +
> +TEST(add_rule_bad_attr)
> +{
> +	const struct landlock_ruleset_attr ns_only_attr = {
> +		.handled_permissions = LANDLOCK_PERMISSION_NAMESPACE_USE,
> +	};
> +	int ruleset_fd;
> +	struct landlock_capability_attr attr = {};
> +
> +	ruleset_fd = create_cap_ruleset();
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	/* Invalid rule pointer returns EFAULT. */
> +	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
> +					NULL, 0));
> +	ASSERT_EQ(EFAULT, errno);
> +
> +	/* Empty permissions selector returns ENOMSG. */
> +	attr.permissions = 0;
> +	attr.allowed_capabilities = (1ULL << CAP_NET_RAW);
> +	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
> +					&attr, 0));
> +	ASSERT_EQ(ENOMSG, errno);
> +
> +	/* Useless rule: neither allowed nor quiet capabilities set. */
> +	attr.permissions = LANDLOCK_PERMISSION_CAPABILITY_USE;
> +	attr.allowed_capabilities = 0;
> +	attr.quiet_capabilities = 0;
> +	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
> +					&attr, 0));
> +	ASSERT_EQ(ENOMSG, errno);
> +
> +	/* Quiet-only rule (empty allowed set) is legal. */
> +	attr.permissions = LANDLOCK_PERMISSION_CAPABILITY_USE;
> +	attr.allowed_capabilities = 0;
> +	attr.quiet_capabilities = (1ULL << CAP_NET_RAW);
> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
> +				       &attr, 0));
> +
> +	/* Allow and quiet different members in the same rule. */
> +	attr.permissions = LANDLOCK_PERMISSION_CAPABILITY_USE;
> +	attr.allowed_capabilities = (1ULL << CAP_SYS_ADMIN);
> +	attr.quiet_capabilities = (1ULL << CAP_NET_RAW);
> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
> +				       &attr, 0));
> +
> +	/* Valid capability selector plus an extra unhandled selector bit. */
> +	attr.permissions = LANDLOCK_PERMISSION_CAPABILITY_USE |
> +			   LANDLOCK_PERMISSION_NAMESPACE_USE;
> +	attr.allowed_capabilities = (1ULL << CAP_NET_RAW);
> +	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
> +					&attr, 0));
> +	ASSERT_EQ(EINVAL, errno);
> +
> +	/* permissions with wrong type. */
> +	attr.permissions = LANDLOCK_PERMISSION_NAMESPACE_USE;
> +	attr.allowed_capabilities = (1ULL << CAP_NET_RAW);
> +	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
> +					&attr, 0));
> +	ASSERT_EQ(EINVAL, errno);
> +
> +	/*
> +	 * Unknown capability bits (e.g. bit 63) are silently accepted for
> +	 * forward compatibility.  Only known bits are stored.
> +	 */
> +	attr.permissions = LANDLOCK_PERMISSION_CAPABILITY_USE;
> +	attr.allowed_capabilities = 1ULL << 63;
> +	attr.quiet_capabilities = 0;
> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
> +				       &attr, 0));
> +
> +	/*
> +	 * LANDLOCK_ADD_RULE_QUIET (and any other flag) is filesystem/network
> +	 * only and must be rejected for capability rules, even when every attr
> +	 * field is otherwise valid.
> +	 */
> +	attr.permissions = LANDLOCK_PERMISSION_CAPABILITY_USE;
> +	attr.allowed_capabilities = (1ULL << CAP_NET_RAW);
> +	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
> +					&attr, LANDLOCK_ADD_RULE_QUIET));
> +	ASSERT_EQ(EINVAL, errno);
> +
> +	EXPECT_EQ(0, close(ruleset_fd));
> +
> +	/*
> +	 * Ruleset handles LANDLOCK_PERMISSION_NAMESPACE_USE but not
> +	 * LANDLOCK_PERMISSION_CAPABILITY_USE: adding a capability rule must be
> +	 * rejected.
> +	 */
> +	ruleset_fd =
> +		landlock_create_ruleset(&ns_only_attr, sizeof(ns_only_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +	attr.permissions = LANDLOCK_PERMISSION_CAPABILITY_USE;
> +	attr.allowed_capabilities = (1ULL << CAP_NET_RAW);
> +	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
> +					&attr, 0));
> +	ASSERT_EQ(EINVAL, errno);
> +	EXPECT_EQ(0, close(ruleset_fd));
> +}
> +
> +/*
> + * Unknown capability values above CAP_LAST_CAP are silently accepted
> + * (allow-list: they have no effect since the kernel never checks them).
> + */
> +TEST(add_rule_unknown)
> +{
> +	int ruleset_fd;
> +	struct landlock_capability_attr attr = {
> +		.permissions = LANDLOCK_PERMISSION_CAPABILITY_USE,
> +	};
> +
> +	ruleset_fd = create_cap_ruleset();
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	/* Just above CAP_LAST_CAP should succeed. */
> +	attr.allowed_capabilities = (1ULL << (CAP_LAST_CAP + 1));
> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
> +				       &attr, 0));
> +
> +	/* High values (below bit 63) should succeed. */
> +	attr.allowed_capabilities = (1ULL << 62);
> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
> +				       &attr, 0));
> +
> +	EXPECT_EQ(0, close(ruleset_fd));
> +}
> +
> +/*
> + * A rule that lists only capability bits unknown to the running kernel is
> + * accepted by landlock_add_rule() but has no runtime effect: once the domain is
> + * enforced, any actual CAP_* capability is still denied by the per-category
> + * deny-by-default behaviour.  This documents the forward-compatibility
> + * contract: unknown bits are silently accepted so the same policy can be loaded
> + * across kernels, but they never grant a capability that the running kernel
> + * knows nothing about.
> + */
> +TEST(add_rule_unknown_no_runtime_effect)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.handled_permissions = LANDLOCK_PERMISSION_CAPABILITY_USE,
> +	};
> +	struct landlock_capability_attr attr = {
> +		.permissions = LANDLOCK_PERMISSION_CAPABILITY_USE,
> +		/* Only unknown bits above CAP_LAST_CAP. */
> +		.allowed_capabilities = (1ULL << (CAP_LAST_CAP + 1)) |
> +					(1ULL << 62),
> +	};
> +	int ruleset_fd;
> +
> +	disable_caps(_metadata);
> +
> +	ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
> +				       &attr, 0));
> +
> +	/*
> +	 * Isolate hostname changes and establish a baseline: with CAP_SYS_ADMIN
> +	 * and absent the domain, sethostname(2) succeeds.  This ensures the
> +	 * EPERM below is attributable to Landlock rather than to a missing
> +	 * capability, and fails if the hook always allows.
> +	 */
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	ASSERT_EQ(0, unshare(CLONE_NEWUTS));
> +	ASSERT_EQ(0, sethostname("baseline", 8));
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	EXPECT_EQ(0, close(ruleset_fd));
> +
> +	/*
> +	 * CAP_SYS_ADMIN is a real, known capability but was not authorised by
> +	 * the rule above; deny-by-default applies.  sethostname(2) requires
> +	 * CAP_SYS_ADMIN.
> +	 */
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	EXPECT_EQ(-1, sethostname("test", 4));
> +	EXPECT_EQ(EPERM, errno);
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +}
> +
> +/* clang-format off */
> +FIXTURE(cap_enforce) {};
> +/* clang-format on */
> +
> +FIXTURE_VARIANT(cap_enforce)
> +{
> +	const bool is_sandboxed;
> +	const bool handle_caps;
> +	const __u64 allowed_cap;
> +	const int expected_sysadmin;
> +	const int expected_chroot;
> +};
> +
> +/*
> + * Unsandboxed baseline: no Landlock domain is enforced.  Both capabilities
> + * should work normally.
> + */
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(cap_enforce, unsandboxed) {
> +	.is_sandboxed = false,
> +	.handle_caps = false,
> +	.allowed_cap = 0,
> +	.expected_sysadmin = 0,
> +	.expected_chroot = 0,
> +};
> +/* clang-format on */
> +
> +/*
> + * Denied: capabilities are handled but no rule allows them.  All capability
> + * checks must be denied by Landlock even if the capability is effective.
> + */
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(cap_enforce, denied) {
> +	.is_sandboxed = true,
> +	.handle_caps = true,
> +	.allowed_cap = 0,
> +	.expected_sysadmin = EPERM,
> +	.expected_chroot = EPERM,
> +};
> +/* clang-format on */
> +
> +/*
> + * Allowed: CAP_SYS_ADMIN is allowed by rule, CAP_SYS_CHROOT is not.  Only the
> + * explicitly allowed capability should succeed.
> + */
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(cap_enforce, allowed) {
> +	.is_sandboxed = true,
> +	.handle_caps = true,
> +	.allowed_cap = CAP_SYS_ADMIN,
> +	.expected_sysadmin = 0,
> +	.expected_chroot = EPERM,
> +};
> +/* clang-format on */
> +
> +/*
> + * Unhandled: the ruleset does not handle LANDLOCK_PERMISSION_CAPABILITY_USE at
> + * all (only handles FS access).  Both capabilities should work since the domain
> + * does not restrict them.
> + */
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(cap_enforce, unhandled) {
> +	.is_sandboxed = true,
> +	.handle_caps = false,
> +	.allowed_cap = 0,
> +	.expected_sysadmin = 0,
> +	.expected_chroot = 0,
> +};
> +/* clang-format on */
> +
> +FIXTURE_SETUP(cap_enforce)
> +{
> +	disable_caps(_metadata);
> +}
> +
> +FIXTURE_TEARDOWN(cap_enforce)
> +{
> +}
> +
> +/*
> + * Capability enforcement: tests the four fundamental enforcement scenarios
> + * (unsandboxed baseline, denied, allowed, unhandled) using two independent
> + * capability checks (sethostname for CAP_SYS_ADMIN, chroot for CAP_SYS_CHROOT).
> + */
> +TEST_F(cap_enforce, use)
> +{
> +	int ruleset_fd;
> +
> +	/* Isolate hostname changes from other tests. */
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	ASSERT_EQ(0, unshare(CLONE_NEWUTS));
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +
> +	if (variant->is_sandboxed) {
> +		if (variant->handle_caps) {
> +			ruleset_fd = create_cap_ruleset();
> +		} else {
> +			const struct landlock_ruleset_attr attr = {
> +				.handled_access_fs =
> +					LANDLOCK_ACCESS_FS_READ_FILE,
> +			};
> +
> +			ruleset_fd =
> +				landlock_create_ruleset(&attr, sizeof(attr), 0);
> +		}
> +		ASSERT_LE(0, ruleset_fd);
> +
> +		if (variant->allowed_cap)
> +			ASSERT_EQ(0, add_cap_rule(ruleset_fd,
> +						  variant->allowed_cap));
> +
> +		enforce_ruleset(_metadata, ruleset_fd);
> +		EXPECT_EQ(0, close(ruleset_fd));
> +	}
> +
> +	/* Test CAP_SYS_ADMIN via sethostname. */
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	if (variant->expected_sysadmin) {
> +		EXPECT_EQ(-1, sethostname("test", 4));
> +		EXPECT_EQ(variant->expected_sysadmin, errno);
> +	} else {
> +		EXPECT_EQ(0, sethostname("test", 4));
> +	}
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +
> +	/* Test CAP_SYS_CHROOT via chroot. */
> +	set_cap(_metadata, CAP_SYS_CHROOT);
> +	if (variant->expected_chroot) {
> +		EXPECT_EQ(-1, chroot("/"));
> +		EXPECT_EQ(variant->expected_chroot, errno);
> +	} else {
> +		EXPECT_EQ(0, chroot("/"));
> +	}
> +	clear_cap(_metadata, CAP_SYS_CHROOT);
> +}
> +
> +/*
> + * Layer stacking: both layers must allow CAP_SYS_ADMIN for the capability to be
> + * exercisable.  Variants cover the three per-layer combinations that exercise
> + * distinct walker paths (allow/deny, allow/allow, deny/allow), an unsandboxed
> + * baseline, and a mixed-layer case where one layer does not handle
> + * LANDLOCK_PERMISSION_CAPABILITY_USE at all.
> + */
> +/* clang-format off */
> +FIXTURE(cap_stacking) {};
> +/* clang-format on */
> +
> +FIXTURE_VARIANT(cap_stacking)
> +{
> +	const bool is_sandboxed;
> +	const bool first_layer_allows;
> +	const bool second_layer_allows;
> +	const bool second_layer_is_fs_only;
> +	const int expected_sysadmin;
> +	const int expected_chroot;
> +};
> +
> +/*
> + * Unsandboxed baseline: no Landlock layers are stacked.  Both capabilities
> + * should work normally.
> + */
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(cap_stacking, unsandboxed) {
> +	.is_sandboxed = false,
> +	.first_layer_allows = false,
> +	.second_layer_allows = false,
> +	.expected_sysadmin = 0,
> +	.expected_chroot = 0,
> +};
> +/* clang-format on */
> +
> +/* Layer 1 allows CAP_SYS_ADMIN, layer 2 denies -> denied. */
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(cap_stacking, deny) {
> +	.is_sandboxed = true,
> +	.first_layer_allows = true,
> +	.second_layer_allows = false,
> +	.expected_sysadmin = EPERM,
> +	.expected_chroot = EPERM,
> +};
> +/* clang-format on */
> +
> +/* Both layers allow CAP_SYS_ADMIN -> sysadmin succeeds, chroot still denied. */
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(cap_stacking, allow) {
> +	.is_sandboxed = true,
> +	.first_layer_allows = true,
> +	.second_layer_allows = true,
> +	.expected_sysadmin = 0,
> +	.expected_chroot = EPERM,
> +};
> +/* clang-format on */
> +
> +/*
> + * Layer 1 denies CAP_SYS_ADMIN, layer 2 allows -> still denied: a child layer
> + * cannot grant what an ancestor layer withheld.  Complements the
> + * parent-allows/child-denies variant; together they verify the walker checks
> + * both layers and accepts only the (allow, allow) cell.
> + */
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(cap_stacking, parent_denies) {
> +	.is_sandboxed = true,
> +	.first_layer_allows = false,
> +	.second_layer_allows = true,
> +	.expected_sysadmin = EPERM,
> +	.expected_chroot = EPERM,
> +};
> +/* clang-format on */
> +
> +/*
> + * Mixed layers: first layer handles LANDLOCK_PERMISSION_CAPABILITY_USE (denies
> + * all caps), second layer is FS-only (does not handle it).  The permission
> + * walker iterates from youngest (layer 1) to oldest (layer 0) and must skip the
> + * FS-only layer to find the denying layer beneath.
> + */
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(cap_stacking, mixed_layers) {
> +	/* clang-format on */
> +	.is_sandboxed = true,
> +	.first_layer_allows = false,
> +	.second_layer_is_fs_only = true,
> +	.expected_sysadmin = EPERM,
> +	.expected_chroot = EPERM,
> +};
> +
> +FIXTURE_SETUP(cap_stacking)
> +{
> +	disable_caps(_metadata);
> +
> +	/* Isolate every successful sethostname() from the other tests. */
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	ASSERT_EQ(0, unshare(CLONE_NEWUTS));
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +}
> +
> +FIXTURE_TEARDOWN(cap_stacking)
> +{
> +}
> +
> +TEST_F(cap_stacking, two_layers)
> +{
> +	int ruleset_fd;
> +
> +	if (variant->is_sandboxed) {
> +		/*
> +		 * First layer: handles LANDLOCK_PERMISSION_CAPABILITY_USE; rule
> +		 * added per variant.
> +		 */
> +		ruleset_fd = create_cap_ruleset();
> +		ASSERT_LE(0, ruleset_fd);
> +		if (variant->first_layer_allows)
> +			ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_SYS_ADMIN));
> +
> +		enforce_ruleset(_metadata, ruleset_fd);
> +		EXPECT_EQ(0, close(ruleset_fd));
> +
> +		if (variant->second_layer_is_fs_only) {
> +			/*
> +			 * Second layer: FS-only (does not handle
> +			 * LANDLOCK_PERMISSION_CAPABILITY_USE).  The permission
> +			 * walker must skip this layer.
> +			 */
> +			const struct landlock_ruleset_attr fs_attr = {
> +				.handled_access_fs =
> +					LANDLOCK_ACCESS_FS_READ_FILE,
> +			};
> +
> +			ruleset_fd = landlock_create_ruleset(
> +				&fs_attr, sizeof(fs_attr), 0);
> +		} else {
> +			/* Second layer: cap allow or deny. */
> +			ruleset_fd = create_cap_ruleset();
> +			if (variant->second_layer_allows)
> +				ASSERT_EQ(0, add_cap_rule(ruleset_fd,
> +							  CAP_SYS_ADMIN));
> +		}
> +		ASSERT_LE(0, ruleset_fd);
> +		enforce_ruleset(_metadata, ruleset_fd);
> +		EXPECT_EQ(0, close(ruleset_fd));
> +	}
> +
> +	/* Test CAP_SYS_ADMIN via sethostname. */
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	if (variant->expected_sysadmin) {
> +		EXPECT_EQ(-1, sethostname("test", 4));
> +		EXPECT_EQ(variant->expected_sysadmin, errno);
> +	} else {
> +		EXPECT_EQ(0, sethostname("test", 4));
> +	}
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +
> +	/* Test CAP_SYS_CHROOT via chroot. */
> +	set_cap(_metadata, CAP_SYS_CHROOT);
> +	if (variant->expected_chroot) {
> +		EXPECT_EQ(-1, chroot("/"));
> +		EXPECT_EQ(variant->expected_chroot, errno);
> +	} else {
> +		EXPECT_EQ(0, chroot("/"));
> +	}
> +	clear_cap(_metadata, CAP_SYS_CHROOT);
> +}
> +
> +/*
> + * Verify that LANDLOCK_PERMISSION_CAPABILITY_USE enforces when the domain is
> + * applied without no_new_privs, using CAP_SYS_ADMIN for
> + * landlock_restrict_self() authorization instead.  Privileged processes (e.g.
> + * container managers) can sandbox themselves this way.
> + */
> +TEST(cap_without_nnp)
> +{
> +	int ruleset_fd;
> +
> +	disable_caps(_metadata);
> +
> +	/* Isolate an unexpected successful sethostname(). */
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	ASSERT_EQ(0, unshare(CLONE_NEWUTS));
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +
> +	ruleset_fd = create_cap_ruleset();
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	/* Allow CAP_SYS_CHROOT but not CAP_SYS_ADMIN. */
> +	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_SYS_CHROOT));
> +
> +	/*
> +	 * Enforce WITHOUT NNP: landlock_restrict_self() succeeds when the
> +	 * caller has CAP_SYS_ADMIN (checked before the new domain takes
> +	 * effect).
> +	 */
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
> +	EXPECT_EQ(0, close(ruleset_fd));
> +
> +	/*
> +	 * CAP_SYS_ADMIN is still in effective set but Landlock denies it:
> +	 * cap_capable() returns 0, then hook_capable() returns -EPERM.
> +	 */
> +	EXPECT_EQ(-1, sethostname("test", 4));
> +	EXPECT_EQ(EPERM, errno);
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +
> +	/* CAP_SYS_CHROOT is allowed by the rule. */
> +	set_cap(_metadata, CAP_SYS_CHROOT);
> +	EXPECT_EQ(0, chroot("/"));
> +	clear_cap(_metadata, CAP_SYS_CHROOT);
> +}
> +
> +/*
> + * Verify that capabilities gained through user namespace ownership are still
> + * restricted by LANDLOCK_PERMISSION_CAPABILITY_USE.  When a process creates a
> + * user namespace, the kernel grants CAP_FULL_SET in the new namespace via
> + * cap_capable_helper()'s ownership bypass.  Landlock's hook_capable() must
> + * still deny capabilities not in the allowed set, ensuring that user namespace
> + * creation cannot be used to escape capability restrictions.
> + */
> +TEST(cap_userns_ownership_bypass)
> +{
> +	pid_t child;
> +	int status;
> +
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		int ruleset_fd;
> +
> +		disable_caps(_metadata);
> +
> +		ruleset_fd = create_cap_ruleset();
> +		ASSERT_LE(0, ruleset_fd);
> +
> +		/* Allow CAP_SYS_ADMIN only. */
> +		ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_SYS_ADMIN));
> +		enforce_ruleset(_metadata, ruleset_fd);
> +		EXPECT_EQ(0, close(ruleset_fd));
> +
> +		/*
> +		 * Create a user namespace.  This is unprivileged and does not
> +		 * require capabilities.  LANDLOCK_PERMISSION_NAMESPACE_USE is
> +		 * not handled so namespace creation is unrestricted.
> +		 */
> +		ASSERT_EQ(0, unshare(CLONE_NEWUSER));
> +
> +		/*
> +		 * After unshare(CLONE_NEWUSER), the kernel set cap_effective =
> +		 * CAP_FULL_SET in the new namespace.  Create a UTS namespace
> +		 * (requires CAP_SYS_ADMIN in the new user NS).  Landlock allows
> +		 * CAP_SYS_ADMIN.
> +		 */
> +		ASSERT_EQ(0, unshare(CLONE_NEWUTS))
> +		{
> +			TH_LOG("unshare(CLONE_NEWUTS): %s", strerror(errno));
> +		}
> +
> +		/*
> +		 * sethostname checks against uts_ns->user_ns, which is now the
> +		 * new user NS.  CAP_SYS_ADMIN is allowed.
> +		 */
> +		EXPECT_EQ(0, sethostname("test", 4));
> +
> +		/*
> +		 * chroot checks against current_user_ns(), which is the new
> +		 * user NS.  The process has CAP_SYS_CHROOT in cap_effective
> +		 * (from user NS creation), so cap_capable() returns 0.  But
> +		 * Landlock denies because no rule allows CAP_SYS_CHROOT.
> +		 */
> +		EXPECT_EQ(-1, chroot("/"));
> +		EXPECT_EQ(EPERM, errno);
> +
> +		_exit(_metadata->exit_code);
> +		return;
> +	}
> +
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
> +	    WEXITSTATUS(status) != EXIT_SUCCESS)
> +		_metadata->exit_code = KSFT_FAIL;
> +}
> +
> +/*
> + * Verify that capability restrictions do not depend on which user namespace the
> + * kernel checks.  An actor in the initial user namespace can enter a descendant
> + * user namespace with CAP_SYS_ADMIN.  With the same Linux capability state,
> + * handling capability use without an allow rule must deny that target-namespace
> + * check even though the target differs from current_user_ns().
> + */
> +TEST(cap_target_userns_independent)
> +{
> +	int sockets[2], status, target_userns_fd;
> +	pid_t actor, target;
> +
> +	disable_caps(_metadata);
> +	ASSERT_EQ(0,
> +		  socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, sockets));
> +
> +	target = fork();
> +	ASSERT_LE(0, target);
> +	if (target == 0) {
> +		int fd;
> +
> +		close(sockets[0]);
> +		if (unshare(CLONE_NEWUSER))
> +			_exit(255);
> +		fd = open("/proc/self/ns/user", O_RDONLY | O_CLOEXEC);
> +		if (fd < 0 || send_fd(sockets[1], fd))
> +			_exit(255);
> +		close(fd);
> +		close(sockets[1]);
> +		_exit(EXIT_SUCCESS);
> +	}
> +
> +	close(sockets[1]);
> +	target_userns_fd = recv_fd(sockets[0]);
> +	ASSERT_LE(0, target_userns_fd);
> +	EXPECT_EQ(0, close(sockets[0]));
> +	ASSERT_EQ(target, waitpid(target, &status, 0));
> +	ASSERT_TRUE(WIFEXITED(status));
> +	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
> +
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	for (int sandboxed = 0; sandboxed <= 1; sandboxed++) {
> +		actor = fork();
> +		ASSERT_LE(0, actor);
> +		if (actor == 0) {
> +			int ret, saved_errno;
> +
> +			if (sandboxed) {
> +				int ruleset_fd = create_cap_ruleset();
> +
> +				if (ruleset_fd < 0 ||
> +				    prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) ||
> +				    landlock_restrict_self(ruleset_fd, 0) ||
> +				    close(ruleset_fd))
> +					_exit(255);
> +			}
> +
> +			ret = setns(target_userns_fd, CLONE_NEWUSER);
> +			saved_errno = errno;
> +			_exit(ret ? saved_errno : EXIT_SUCCESS);
> +		}
> +
> +		ASSERT_EQ(actor, waitpid(actor, &status, 0));
> +		ASSERT_TRUE(WIFEXITED(status));
> +		EXPECT_EQ(sandboxed ? EPERM : EXIT_SUCCESS,
> +			  WEXITSTATUS(status));
> +	}
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +	EXPECT_EQ(0, close(target_userns_fd));
> +}
> +
> +/* Audit tests */
> +
> +static int matches_log_cap(int audit_fd, int cap_number)
> +{
> +	static const char log_template[] = REGEX_LANDLOCK_PREFIX
> +		" blockers=capability\\.use capability=%d $";
> +	char log_match[sizeof(log_template) + 10];
> +	int log_match_len;
> +
> +	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
> +				 cap_number);
> +	if (log_match_len >= sizeof(log_match))
> +		return -E2BIG;
> +
> +	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
> +				  NULL);
> +}
> +
> +FIXTURE(cap_audit)
> +{
> +	struct audit_filter audit_filter;
> +	int audit_fd;
> +};
> +
> +FIXTURE_SETUP(cap_audit)
> +{
> +	ASSERT_TRUE(is_in_init_user_ns());
> +
> +	disable_caps(_metadata);
> +
> +	/* Isolate successful sethostname() calls. */
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	ASSERT_EQ(0, unshare(CLONE_NEWUTS));
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +
> +	set_cap(_metadata, CAP_AUDIT_CONTROL);
> +	self->audit_fd = audit_init_with_exe_filter(&self->audit_filter);
> +	EXPECT_LE(0, self->audit_fd);
> +	clear_cap(_metadata, CAP_AUDIT_CONTROL);
> +}
> +
> +FIXTURE_TEARDOWN(cap_audit)
> +{
> +	set_cap(_metadata, CAP_AUDIT_CONTROL);
> +	EXPECT_EQ(0, audit_cleanup(self->audit_fd, &self->audit_filter));
> +	clear_cap(_metadata, CAP_AUDIT_CONTROL);
> +}
> +
> +/*
> + * Verifies that a denied capability produces the expected audit record with the
> + * correct capability number and blocker string.
> + */
> +TEST_F(cap_audit, denied)
> +{
> +	struct audit_records records = {};
> +	int ruleset_fd;
> +	__u64 domain_id;
> +
> +	/* Baseline: chroot works before Landlock. */
> +	set_cap(_metadata, CAP_SYS_CHROOT);
> +	ASSERT_EQ(0, chroot("/"));
> +	clear_cap(_metadata, CAP_SYS_CHROOT);
> +
> +	ruleset_fd = create_cap_ruleset();
> +	ASSERT_LE(0, ruleset_fd);
> +	/* Allow CAP_AUDIT_CONTROL for child-side audit cleanup. */
> +	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_AUDIT_CONTROL));
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	EXPECT_EQ(0, close(ruleset_fd));
> +
> +	/* Deny CAP_SYS_CHROOT (no allow rule). */
> +	set_cap(_metadata, CAP_SYS_CHROOT);
> +	EXPECT_EQ(-1, chroot("/"));
> +	EXPECT_EQ(EPERM, errno);
> +	clear_cap(_metadata, CAP_SYS_CHROOT);
> +
> +	EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_SYS_CHROOT));
> +
> +	/*
> +	 * The domain allocation record is emitted in the same event as the
> +	 * first denial; anchor its status=allocated and enforcing pid.  Both
> +	 * access and domain records are now consumed, so none remain.
> +	 */
> +	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, getpid(),
> +						  &domain_id));
> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +	EXPECT_EQ(0, records.access);
> +	EXPECT_EQ(0, records.domain);
> +}
> +
> +TEST_F(cap_audit, allowed)
> +{
> +	struct audit_records records = {};
> +	int ruleset_fd;
> +
> +	ruleset_fd = create_cap_ruleset();
> +	ASSERT_LE(0, ruleset_fd);
> +	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_SYS_ADMIN));
> +	/* Allow CAP_AUDIT_CONTROL for child-side audit cleanup. */
> +	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_AUDIT_CONTROL));
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	EXPECT_EQ(0, close(ruleset_fd));
> +
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	EXPECT_EQ(0, sethostname("test", 4));
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +
> +	/* No records: allowed operations never trigger audit logging. */
> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +	EXPECT_EQ(0, records.access);
> +}
> +
> +/* An allowed capability remains allowed when the same rule also quiets it. */
> +TEST_F(cap_audit, allow_and_quiet_same_member)
> +{
> +	struct audit_records records = {};
> +	int ruleset_fd;
> +
> +	ruleset_fd = create_cap_ruleset();
> +	ASSERT_LE(0, ruleset_fd);
> +	ASSERT_EQ(0, add_cap_rule_full(ruleset_fd,
> +				       (1ULL << CAP_SYS_ADMIN) |
> +					       (1ULL << CAP_AUDIT_CONTROL),
> +				       1ULL << CAP_SYS_ADMIN));
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	EXPECT_EQ(0, close(ruleset_fd));
> +
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	EXPECT_EQ(0, sethostname("test", 4));
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +
> +	/*
> +	 * Quiet is inert for the allowed member: nothing is denied or logged.
> +	 */
> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +	EXPECT_EQ(0, records.access);
> +}
> +
> +/*
> + * A quieted capability denial is still denied (EPERM); only its audit record is
> + * suppressed.  Quiet-only rule (empty allowed set).
> + */
> +TEST_F(cap_audit, quieted)
> +{
> +	struct audit_records records = {};
> +	int ruleset_fd;
> +	__u64 domain_id;
> +
> +	ruleset_fd = create_cap_ruleset();
> +	ASSERT_LE(0, ruleset_fd);
> +	/* Allow CAP_AUDIT_CONTROL for child-side audit cleanup. */
> +	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_AUDIT_CONTROL));
> +	ASSERT_EQ(0,
> +		  add_cap_rule_full(ruleset_fd, 0, (1ULL << CAP_SYS_CHROOT)));
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	EXPECT_EQ(0, close(ruleset_fd));
> +
> +	set_cap(_metadata, CAP_SYS_CHROOT);
> +	EXPECT_EQ(-1, chroot("/"));
> +	EXPECT_EQ(EPERM, errno);
> +	clear_cap(_metadata, CAP_SYS_CHROOT);
> +
> +	/*
> +	 * Positive control: CAP_SYS_ADMIN is denied but not quieted, so its
> +	 * denial IS logged.  This proves quieting is per-member, not global.
> +	 */
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	EXPECT_EQ(-1, sethostname("test", 4));
> +	EXPECT_EQ(EPERM, errno);
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +
> +	/*
> +	 * The quieted CAP_SYS_CHROOT denial is suppressed; the CAP_SYS_ADMIN
> +	 * denial is logged.
> +	 */
> +	EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_SYS_ADMIN));
> +	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, getpid(),
> +						  &domain_id));
> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +	EXPECT_EQ(0, records.access);
> +	EXPECT_EQ(0, records.domain);
> +}
> +
> +/*
> + * Only the youngest denying layer decides quieting: a parent cannot silence a
> + * denial by a deeper layer that handles but does not quiet the capability.
> + */
> +TEST_F(cap_audit, quiet_youngest_layer_wins)
> +{
> +	struct audit_records records = {};
> +	int ruleset_fd;
> +	__u64 domain_id;
> +
> +	/* Baseline: commoncap allows chroot before Landlock. */
> +	set_cap(_metadata, CAP_SYS_CHROOT);
> +	ASSERT_EQ(0, chroot("/"));
> +	clear_cap(_metadata, CAP_SYS_CHROOT);
> +
> +	/* Parent layer: denies and quiets CAP_SYS_CHROOT. */
> +	ruleset_fd = create_cap_ruleset();
> +	ASSERT_LE(0, ruleset_fd);
> +	ASSERT_EQ(0, add_cap_rule_full(ruleset_fd, 1ULL << CAP_AUDIT_CONTROL,
> +				       1ULL << CAP_SYS_CHROOT));
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	EXPECT_EQ(0, close(ruleset_fd));
> +
> +	/* Child layer: denies CAP_SYS_CHROOT without quieting it. */
> +	ruleset_fd = create_cap_ruleset();
> +	ASSERT_LE(0, ruleset_fd);
> +	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_AUDIT_CONTROL));
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	EXPECT_EQ(0, close(ruleset_fd));
> +
> +	set_cap(_metadata, CAP_SYS_CHROOT);
> +	EXPECT_EQ(-1, chroot("/"));
> +	EXPECT_EQ(EPERM, errno);
> +	clear_cap(_metadata, CAP_SYS_CHROOT);
> +
> +	/*
> +	 * The child is the youngest denier and does not quiet: log the denial.
> +	 */
> +	EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_SYS_CHROOT));
> +	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, getpid(),
> +						  &domain_id));
> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +	EXPECT_EQ(0, records.access);
> +	EXPECT_EQ(0, records.domain);
> +}
> +
> +/*
> + * Quieting an unknown capability bit has no effect: a rule that quiets only a
> + * bit above CAP_LAST_CAP still logs the denial of a known capability.
> + */
> +TEST_F(cap_audit, quiet_unknown_bit_no_effect)
> +{
> +	struct audit_records records = {};
> +	int ruleset_fd;
> +	__u64 domain_id;
> +
> +	ruleset_fd = create_cap_ruleset();
> +	ASSERT_LE(0, ruleset_fd);
> +	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_AUDIT_CONTROL));
> +	/* Quiet only an unknown bit (bit 63 is above CAP_LAST_CAP). */
> +	ASSERT_EQ(0, add_cap_rule_full(ruleset_fd, 0, (1ULL << 63)));
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	EXPECT_EQ(0, close(ruleset_fd));
> +
> +	set_cap(_metadata, CAP_SYS_CHROOT);
> +	EXPECT_EQ(-1, chroot("/"));
> +	EXPECT_EQ(EPERM, errno);
> +	clear_cap(_metadata, CAP_SYS_CHROOT);
> +
> +	/* The unknown quiet bit does not suppress the known denial. */
> +	EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_SYS_CHROOT));
> +	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, getpid(),
> +						  &domain_id));
> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +	EXPECT_EQ(0, records.access);
> +	EXPECT_EQ(0, records.domain);
> +}
> +
> +/*
> + * A capability check made with CAP_OPT_NOAUDIT is denied by Landlock but not
> + * logged: hook_capable() emits no Landlock audit record when the caller passes
> + * CAP_OPT_NOAUDIT, so the denial is silent here even though CAP_SYS_ADMIN is
> + * neither allowed nor quieted.  The probe is the
> + * ns_capable_noaudit(CAP_SYS_ADMIN) call in simple_xattr_list(), reached
> + * through tmpfs, which decides whether trusted.* xattrs are visible to
> + * listxattr(2).
> + */
> +TEST_F(cap_audit, noaudit_probe_not_logged)
> +{
> +	struct audit_records records = {};
> +	int ruleset_fd, fd;
> +	__u64 domain_id;
> +	char list[256];
> +	ssize_t len;
> +
> +	/*
> +	 * Private tmpfs holding a trusted.* xattr so its listxattr(2)
> +	 * visibility depends only on the CAP_SYS_ADMIN noaudit probe.
> +	 */
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	ASSERT_EQ(0, unshare(CLONE_NEWNS));
> +	ASSERT_EQ(0, mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL));
> +	ASSERT_EQ(0, mount("test", "/tmp", "tmpfs", 0, NULL));
> +	fd = open("/tmp/f", O_CREAT | O_RDWR | O_CLOEXEC, 0600);
> +	ASSERT_LE(0, fd);
> +	ASSERT_EQ(0, fsetxattr(fd, "trusted.landlock_test", "x", 1, 0));
> +
> +	/* Baseline: with CAP_SYS_ADMIN, the trusted xattr is listed. */
> +	len = flistxattr(fd, list, sizeof(list));
> +	ASSERT_LE(0, len);
> +	ASSERT_TRUE(list_has_xattr(list, len, "trusted.landlock_test"));
> +
> +	ruleset_fd = create_cap_ruleset();
> +	ASSERT_LE(0, ruleset_fd);
> +	/* Allow CAP_AUDIT_CONTROL for child-side audit cleanup. */
> +	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_AUDIT_CONTROL));
> +	/* CAP_SYS_ADMIN is neither allowed nor quieted. */
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	EXPECT_EQ(0, close(ruleset_fd));
> +
> +	/*
> +	 * CAP_SYS_ADMIN is still effective, but Landlock denies the noaudit
> +	 * probe, so the trusted.* xattr is filtered out of the listing.
> +	 */
> +	len = flistxattr(fd, list, sizeof(list));
> +	ASSERT_LE(0, len);
> +	EXPECT_FALSE(list_has_xattr(list, len, "trusted.landlock_test"));
> +	EXPECT_EQ(0, close(fd));
> +
> +	/* The denied noaudit probe leaves no audit record nor denial. */
> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +	EXPECT_EQ(0, records.access);
> +
> +	/*
> +	 * Positive control: a normal (audited) CAP_SYS_ADMIN denial in the same
> +	 * domain IS logged.  This proves the empty record set above is caused
> +	 * by CAP_OPT_NOAUDIT, not by an always-allow or always-silent bug.
> +	 */
> +	EXPECT_EQ(-1, sethostname("test", 4));
> +	EXPECT_EQ(EPERM, errno);
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +
> +	EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_SYS_ADMIN));
> +	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, getpid(),
> +						  &domain_id));
> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +	EXPECT_EQ(0, records.access);
> +	EXPECT_EQ(0, records.domain);
> +}
> +
> +/* Trace tests */
> +
> +/* clang-format off */
> +FIXTURE(cap_trace) {
> +	/* clang-format on */
> +	int tracefs_ok;
> +};
> +
> +FIXTURE_SETUP(cap_trace)
> +{
> +	int ret;
> +
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	ASSERT_EQ(0, unshare(CLONE_NEWNS));
> +	ASSERT_EQ(0, mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL));
> +
> +	ret = tracefs_fixture_setup();
> +	if (ret) {
> +		clear_cap(_metadata, CAP_SYS_ADMIN);
> +		self->tracefs_ok = 0;
> +		SKIP(return, "tracefs not available");
> +	}
> +	self->tracefs_ok = 1;
> +
> +	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_CREATE_RULESET_ENABLE, true));
> +	ASSERT_EQ(0, tracefs_enable_event(TRACEFS_ADD_RULE_CAPABILITY_ENABLE,
> +					  true));
> +	ASSERT_EQ(0, tracefs_enable_event(
> +			     TRACEFS_DENY_PERMISSION_CAPABILITY_ENABLE, true));
> +	ASSERT_EQ(0, tracefs_clear());
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +}
> +
> +FIXTURE_TEARDOWN(cap_trace)
> +{
> +	if (!self->tracefs_ok)
> +		return;
> +
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	tracefs_enable_event(TRACEFS_CREATE_RULESET_ENABLE, false);
> +	tracefs_enable_event(TRACEFS_ADD_RULE_CAPABILITY_ENABLE, false);
> +	tracefs_enable_event(TRACEFS_DENY_PERMISSION_CAPABILITY_ENABLE, false);
> +	tracefs_fixture_teardown();
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +}
> +
> +/*
> + * Check the permission fields and version history, including two rejected calls
> + * and two successful calls that do not extend the effective policy: a repeated
> + * rule and an unknown-only rule.
> + */
> +TEST_F(cap_trace, rule_events)
> +{
> +	const char *const version_1 =
> +		REGEX_ADD_RULE_CAPABILITY_VERSION(TRACE_TASK, "1");
> +	const char *const version_2 =
> +		REGEX_ADD_RULE_CAPABILITY_VERSION(TRACE_TASK, "2");
> +	const char *const version_3 =
> +		REGEX_ADD_RULE_CAPABILITY_VERSION(TRACE_TASK, "3");
> +	const struct landlock_capability_attr valid_attr = {
> +		.permissions = LANDLOCK_PERMISSION_CAPABILITY_USE,
> +		.allowed_capabilities = 1ULL << CAP_SYS_ADMIN,
> +		.quiet_capabilities = 1ULL << CAP_SYS_CHROOT,
> +	};
> +	const struct landlock_capability_attr invalid_attr = {
> +		.permissions = LANDLOCK_PERMISSION_NAMESPACE_USE,
> +		.allowed_capabilities = 1ULL << CAP_SYS_ADMIN,
> +	};
> +	char expected[32], field[64];
> +	char *buf;
> +	int ruleset_fd;
> +
> +	if (!self->tracefs_ok)
> +		SKIP(return, "tracefs not available");
> +
> +	ASSERT_EQ(0, tracefs_clear_buf());
> +
> +	ruleset_fd = create_cap_ruleset();
> +	ASSERT_LE(0, ruleset_fd);
> +	ASSERT_EQ(0, add_cap_rule_full(ruleset_fd, 1ULL << CAP_SYS_ADMIN,
> +				       1ULL << CAP_SYS_CHROOT));
> +	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
> +					&invalid_attr, 0));
> +	ASSERT_EQ(EINVAL, errno);
> +	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
> +					&valid_attr, LANDLOCK_ADD_RULE_QUIET));
> +	ASSERT_EQ(EINVAL, errno);
> +	ASSERT_EQ(0, add_cap_rule_full(ruleset_fd, 1ULL << CAP_SYS_ADMIN,
> +				       1ULL << CAP_SYS_CHROOT));
> +	ASSERT_EQ(0, add_cap_rule(ruleset_fd, 63));
> +	EXPECT_EQ(0, close(ruleset_fd));
> +
> +	buf = tracefs_read_buf();
> +	ASSERT_NE(NULL, buf);
> +
> +	ASSERT_EQ(1,
> +		  tracefs_count_matches(buf, REGEX_CREATE_RULESET(TRACE_TASK)));
> +	ASSERT_EQ(0, tracefs_extract_field(
> +			     buf, REGEX_CREATE_RULESET(TRACE_TASK),
> +			     "handled_permissions", field, sizeof(field)));
> +	EXPECT_STREQ("capability.use", field);
> +
> +	ASSERT_EQ(3,
> +		  tracefs_count_matches(buf, "landlock_add_rule_capability: "));
> +	ASSERT_EQ(3, tracefs_count_matches(
> +			     buf, REGEX_ADD_RULE_CAPABILITY(TRACE_TASK)));
> +	EXPECT_EQ(1, tracefs_count_matches(buf, version_1));
> +	EXPECT_EQ(1, tracefs_count_matches(buf, version_2));
> +	EXPECT_EQ(1, tracefs_count_matches(buf, version_3));
> +
> +	ASSERT_EQ(0, tracefs_extract_field(buf, version_1, "permissions", field,
> +					   sizeof(field)));
> +	EXPECT_STREQ("capability.use", field);
> +	ASSERT_EQ(0,
> +		  tracefs_extract_field(buf, version_1, "allowed_capabilities",
> +					field, sizeof(field)));
> +	snprintf(expected, sizeof(expected), "0x%llx", 1ULL << CAP_SYS_ADMIN);
> +	EXPECT_STREQ(expected, field);
> +	ASSERT_EQ(0, tracefs_extract_field(buf, version_1, "quiet_capabilities",
> +					   field, sizeof(field)));
> +	snprintf(expected, sizeof(expected), "0x%llx", 1ULL << CAP_SYS_CHROOT);
> +	EXPECT_STREQ(expected, field);
> +
> +	/* The rejected calls emit no event and do not consume version 2. */
> +	ASSERT_EQ(0, tracefs_extract_field(buf, version_2, "permissions", field,
> +					   sizeof(field)));
> +	EXPECT_STREQ("capability.use", field);
> +	ASSERT_EQ(0,
> +		  tracefs_extract_field(buf, version_2, "allowed_capabilities",
> +					field, sizeof(field)));
> +	snprintf(expected, sizeof(expected), "0x%llx", 1ULL << CAP_SYS_ADMIN);
> +	EXPECT_STREQ(expected, field);
> +	ASSERT_EQ(0, tracefs_extract_field(buf, version_2, "quiet_capabilities",
> +					   field, sizeof(field)));
> +	snprintf(expected, sizeof(expected), "0x%llx", 1ULL << CAP_SYS_CHROOT);
> +	EXPECT_STREQ(expected, field);
> +
> +	/* The unknown-only call succeeds but contributes no effective bits. */
> +	ASSERT_EQ(0, tracefs_extract_field(buf, version_3, "permissions", field,
> +					   sizeof(field)));
> +	EXPECT_STREQ("capability.use", field);
> +	ASSERT_EQ(0,
> +		  tracefs_extract_field(buf, version_3, "allowed_capabilities",
> +					field, sizeof(field)));
> +	EXPECT_STREQ("0x0", field);
> +	ASSERT_EQ(0, tracefs_extract_field(buf, version_3, "quiet_capabilities",
> +					   field, sizeof(field)));
> +	EXPECT_STREQ("0x0", field);
> +
> +	free(buf);
> +}
> +
> +enum cap_trace_denial_kind {
> +	CAP_TRACE_DENY,
> +	CAP_TRACE_DENY_QUIET,
> +	CAP_TRACE_DENY_NOAUDIT,
> +};
> +
> +static void exercise_cap_trace_denial(struct __test_metadata *const _metadata,
> +				      const enum cap_trace_denial_kind kind)
> +{
> +	int ruleset_fd, fd = -1;
> +	char list[256];
> +	ssize_t len;
> +
> +	disable_caps(_metadata);
> +
> +	if (kind == CAP_TRACE_DENY_NOAUDIT) {
> +		set_cap(_metadata, CAP_SYS_ADMIN);
> +		set_cap(_metadata, CAP_SYS_CHROOT);
> +		ASSERT_EQ(0, mount("test", "/tmp", "tmpfs", 0, NULL));
> +		fd = open("/tmp/f", O_CREAT | O_RDWR | O_CLOEXEC, 0600);
> +		ASSERT_LE(0, fd);
> +		ASSERT_EQ(0, fsetxattr(fd, "trusted.landlock_test", "x", 1, 0));
> +
> +		/* Baseline: CAP_SYS_ADMIN exposes the trusted xattr. */
> +		len = flistxattr(fd, list, sizeof(list));
> +		ASSERT_LE(0, len);
> +		ASSERT_TRUE(list_has_xattr(list, len, "trusted.landlock_test"));
> +	} else {
> +		set_cap(_metadata, CAP_SYS_CHROOT);
> +	}
> +
> +	ruleset_fd = create_cap_ruleset();
> +	ASSERT_LE(0, ruleset_fd);
> +	if (kind == CAP_TRACE_DENY_QUIET)
> +		ASSERT_EQ(0, add_cap_rule_full(ruleset_fd, 0,
> +					       1ULL << CAP_SYS_CHROOT));
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	EXPECT_EQ(0, close(ruleset_fd));
> +
> +	if (kind == CAP_TRACE_DENY_NOAUDIT) {
> +		/* Probe CAP_SYS_ADMIN with CAP_OPT_NOAUDIT. */
> +		len = flistxattr(fd, list, sizeof(list));
> +		ASSERT_LE(0, len);
> +		EXPECT_FALSE(
> +			list_has_xattr(list, len, "trusted.landlock_test"));
> +		EXPECT_EQ(0, close(fd));
> +
> +		/* Control: an ordinary denial in the same domain is traced. */
> +		EXPECT_EQ(-1, chroot("/"));
> +		EXPECT_EQ(EPERM, errno);
> +		clear_cap(_metadata, CAP_SYS_ADMIN);
> +		clear_cap(_metadata, CAP_SYS_CHROOT);
> +	} else {
> +		EXPECT_EQ(-1, chroot("/"));
> +		EXPECT_EQ(EPERM, errno);
> +		clear_cap(_metadata, CAP_SYS_CHROOT);
> +	}
> +}
> +
> +static void test_cap_trace_denial(struct __test_metadata *const _metadata,
> +				  const enum cap_trace_denial_kind kind,
> +				  const int expected_capability,
> +				  const char *const expected_logged)
> +{
> +	char expected[16], field[64];
> +	int status;
> +	char *buf;
> +	pid_t child;
> +
> +	ASSERT_EQ(0, tracefs_clear_buf());
> +
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		exercise_cap_trace_denial(_metadata, kind);
> +		_exit(_metadata->exit_code);
> +	}
> +
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +	ASSERT_TRUE(WIFEXITED(status));
> +	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
> +
> +	buf = tracefs_read_buf();
> +	ASSERT_NE(NULL, buf);
> +	ASSERT_EQ(1, tracefs_count_matches(
> +			     buf, REGEX_DENY_PERMISSION_CAPABILITY(TRACE_TASK)))
> +	{
> +		TH_LOG("Expected one capability denial event\n%s", buf);
> +	}
> +
> +	ASSERT_EQ(0, tracefs_extract_field(
> +			     buf, REGEX_DENY_PERMISSION_CAPABILITY(TRACE_TASK),
> +			     "domain", field, sizeof(field)));
> +	EXPECT_STRNE("0", field);
> +	ASSERT_EQ(0, tracefs_extract_field(
> +			     buf, REGEX_DENY_PERMISSION_CAPABILITY(TRACE_TASK),
> +			     "same_exec", field, sizeof(field)));
> +	EXPECT_STREQ("1", field);
> +	ASSERT_EQ(0, tracefs_extract_field(
> +			     buf, REGEX_DENY_PERMISSION_CAPABILITY(TRACE_TASK),
> +			     "logged", field, sizeof(field)));
> +	EXPECT_STREQ(expected_logged, field);
> +	ASSERT_EQ(0, tracefs_extract_field(
> +			     buf, REGEX_DENY_PERMISSION_CAPABILITY(TRACE_TASK),
> +			     "blockers", field, sizeof(field)));
> +	EXPECT_STREQ("use", field);
> +	ASSERT_EQ(0, tracefs_extract_field(
> +			     buf, REGEX_DENY_PERMISSION_CAPABILITY(TRACE_TASK),
> +			     "capability", field, sizeof(field)));
> +	snprintf(expected, sizeof(expected), "%d", expected_capability);
> +	EXPECT_STREQ(expected, field);
> +
> +	free(buf);
> +}
> +
> +TEST_F(cap_trace, deny)
> +{
> +	if (!self->tracefs_ok)
> +		SKIP(return, "tracefs not available");
> +	test_cap_trace_denial(_metadata, CAP_TRACE_DENY, CAP_SYS_CHROOT, "1");
> +}
> +
> +TEST_F(cap_trace, deny_quiet)
> +{
> +	if (!self->tracefs_ok)
> +		SKIP(return, "tracefs not available");
> +	test_cap_trace_denial(_metadata, CAP_TRACE_DENY_QUIET, CAP_SYS_CHROOT,
> +			      "0");
> +}
> +
> +/*
> + * A CAP_OPT_NOAUDIT probe is denied without any record.  The audit counterpart
> + * checks the missing audit record; this one checks that the CAP_SYS_ADMIN probe
> + * emits no trace event, while the CAP_SYS_CHROOT denial that follows it in the
> + * same domain still does.
> + */
> +TEST_F(cap_trace, noaudit_probe_not_traced)
> +{
> +	if (!self->tracefs_ok)
> +		SKIP(return, "tracefs not available");
> +	test_cap_trace_denial(_metadata, CAP_TRACE_DENY_NOAUDIT, CAP_SYS_CHROOT,
> +			      "1");
> +}
> +
> +TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/landlock/trace.h b/tools/testing/selftests/landlock/trace.h
> index 568c13d8eee4..36e8f16171b0 100644
> --- a/tools/testing/selftests/landlock/trace.h
> +++ b/tools/testing/selftests/landlock/trace.h
> @@ -33,6 +33,8 @@
>  	TRACEFS_LANDLOCK_DIR "/landlock_add_rule_net_port/enable"
>  #define TRACEFS_ADD_RULE_NAMESPACE_ENABLE \
>  	TRACEFS_LANDLOCK_DIR "/landlock_add_rule_namespace/enable"
> +#define TRACEFS_ADD_RULE_CAPABILITY_ENABLE \
> +	TRACEFS_LANDLOCK_DIR "/landlock_add_rule_capability/enable"
>  #define TRACEFS_CHECK_RULE_FS_ENABLE \
>  	TRACEFS_LANDLOCK_DIR "/landlock_check_rule_inode/enable"
>  #define TRACEFS_CHECK_RULE_NET_ENABLE \
> @@ -43,6 +45,8 @@
>  	TRACEFS_LANDLOCK_DIR "/landlock_deny_access_net/enable"
>  #define TRACEFS_DENY_PERMISSION_NAMESPACE_ENABLE \
>  	TRACEFS_LANDLOCK_DIR "/landlock_deny_permission_namespace/enable"
> +#define TRACEFS_DENY_PERMISSION_CAPABILITY_ENABLE \
> +	TRACEFS_LANDLOCK_DIR "/landlock_deny_permission_capability/enable"
>  #define TRACEFS_DENY_PTRACE_ENABLE \
>  	TRACEFS_LANDLOCK_DIR "/landlock_deny_ptrace/enable"
>  #define TRACEFS_DENY_SCOPE_SIGNAL_ENABLE \
> @@ -110,6 +114,17 @@
>  #define REGEX_ADD_RULE_NAMESPACE(task) \
>  	REGEX_ADD_RULE_NAMESPACE_VERSION(task, "[0-9]\\+")
>  
> +#define REGEX_ADD_RULE_CAPABILITY_VERSION(task, version) \
> +	TRACE_PREFIX(task)                               \
> +	"landlock_add_rule_capability: "                 \
> +	"ruleset=[0-9a-f]\\+\\." version " "             \
> +	"permissions=[a-z._|]* "                         \
> +	"allowed_capabilities=0x[0-9a-f]\\+ "            \
> +	"quiet_capabilities=0x[0-9a-f]\\+$"
> +
> +#define REGEX_ADD_RULE_CAPABILITY(task) \
> +	REGEX_ADD_RULE_CAPABILITY_VERSION(task, "[0-9]\\+")
> +
>  #define REGEX_CREATE_RULESET(task)        \
>  	TRACE_PREFIX(task)                \
>  	"landlock_create_ruleset: "       \
> @@ -173,6 +188,15 @@
>  	"namespace_type=0x[0-9a-f]\\+ "        \
>  	"namespace_id=[0-9]\\+$"
>  
> +#define REGEX_DENY_PERMISSION_CAPABILITY(task)  \
> +	TRACE_PREFIX(task)                      \
> +	"landlock_deny_permission_capability: " \
> +	"domain=[0-9a-f]\\+ "                   \
> +	"same_exec=[01] "                       \
> +	"logged=[01] "                          \
> +	"blockers=[a-z_|]* "                    \
> +	"capability=[0-9]\\+$"
> +
>  #define REGEX_DENY_PTRACE(task)      \
>  	TRACE_PREFIX(task)           \
>  	"landlock_deny_ptrace: "     \
> -- 
> 2.55.0
> 

Same comments as in the preceding commit as well;
specifically,
* some helper functions could call ASSERT directly
* EXPECT instead of ASSERT in various places

–Günther
