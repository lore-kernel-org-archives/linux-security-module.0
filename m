Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195877;
	b=Oo1oak47GMP1bRdbKHOWAwYBpf+Qp95RS/8UGvCnUn06rCoEBDIKFyEE+NluSev/gkX0
	 /vFQFA+cL7gpde7Nk3ZALji4q8GSCqc21V6JumAEqLBj6hb+rC+/E4rVxMnxT3PeKJJfw
	 ZdcloW1Dj2cHwUx0QwGa926QleWQdHlkWufrLny1rxE9L3ypmNFGh1orpm2CzSQh8dSax
	 aqNWPm9yzSIEFetzGu+gM/i7D13dhA6sHS8lN1o+bRwYY9/gLDkKIXykBgKQ5gSSu3uFN
	 uUF7EO3anaQ1qWJ8ewAmcRyh8qKDrUXtlJIsnAXuvTdnbkkkh2qdLx395KCgHCM/Odg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195877;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jF61DnAnp/Jp3Z54ckfGeGv59ZDI/5spgfPWp4G/sWM=;
	b=wf48ZGn287P14TKl61CwVoOvls9MjQeIVodkmK84XfBsQdBT/rgRAHOh5MqnWPeIooot
	 41DQsdKOeRe25w8jVUbLZ0uRid53KCjyzjCmQRtaFCB+m9PA53jhptv0rLYoMuNl7BQ3J
	 br7cr1rSNv8N8pdWpRib3bnCB0hz6FmjRe7iy9MUwnNMj1bQPhEjPIja4M6/JD5tpHPnX
	 WR5eyKFzh1dLSXe8OVpdNEY23kYL9tcN6CaiSOExeMDApdMaPdkJdbxNhzZ2iVxKKaI8/
	 rbiHEc2wsYoVmah9LZpJ60A/6Nh+1/U7FslHAdWIBim9Pj8HZxKmmNSwixf1faU7WSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qq0QOa5u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD3D606A327
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qq0QOa5u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FD91F031E2
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 13:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793195876;
	bh=jF61DnAnp/Jp3Z54ckfGeGv59ZDI/5spgfPWp4G/sWM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Qq0QOa5uO3JlzBiv2MVtipN0q9wlXNxq5Dc7PsGbU+N1VJpNJWb6n87LtowS43etk
	 kVjWdK8WxcZ3sRBsmeLIaSIv8wQLqeKvuZthgXOQyQuNV+W3XrEgnrrwozP+siqH1Y
	 Y7sZZ6R68C/UMMGo3+mIpq7k+VDfjfcZiuMQOlD6SHw/D+BX7lvJsuqhMAPImV0Zqh
	 LtJwldjVioznZlUQ8DPUY8Da1N6gVNjUceu776lsuPXYztNcq1CgH6h/lSJ4UMpzYC
	 Jxhrw18EZQ9+KXVd0wAYqqIST1+xszWD9HQJT4AersFr2H27XMYMV3XzLN/krUAOFK
	 WISAQtfSQhpdw==
Message-ID: <sashiko-outbox-187951@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/6] security: add the Kernel Assurance Plane LSM
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261028133335.75899-4-ketan@armoriq.io>
References: <20261028133335.75899-1-ketan@armoriq.io>
 <20261028133335.75899-4-ketan@armoriq.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 13:57:55 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 15 potential issue=
(s) to consider:
- [Critical] security: kap: missing addrlen check in kap_socket_connect() l=
eaks stack
- [High] security: kap: wrong PID namespace and TID in kap_normalize_procfs=
_self()
- [High] security: kap: execmem and memfd misclassification in mmap and exe=
c hooks
- [High] security: kap: data race on kap_task_state in kap_ptrace_target()
- [High] security: kap: fork race between kap_task_alloc() and kap_bind_pid=
_locked()
- [High] security: kap: predicate boundary misparse in kap_compile_kind_arr=
ay()
- [High] security: kap: mount hooks truncate paths and fail open on path er=
rors
- [High] security: kap: deleted suffix bypasses exact deny in kap_file_pref=
ix_match()
- [High] security: kap: unpinned old_dentry->d_parent race in kap_path_link=
()
- [High] security: kap: kap_file_permission() skips revocation for anon cha=
nnels
- [Medium] security: kap: decision helpers fail open when bound igroup is m=
issing
- [Medium] security: kap: missing kap in default CONFIG_LSM strings in Kcon=
fig
- [Medium] security: kap: unconditional kap_lock acquisition in kap_task_al=
loc()
- [Medium] security: kap: u64 overflow in kap_parse_transition_sequence()
- [Medium] security: kap: leaked kap_bound_pid entries on task exit and reb=
ind
--

commit d9df2395eaa207ea017067bab85ba4a25d760030
Author: Ketan Bhardwaj <ketan@armoriq.io>

security: add the Kernel Assurance Plane LSM

This commit adds the Kernel Assurance Plane (KAP) LSM, implementing Intent
Lineage Groups (igroups), authority predicate compilation and evaluation, a=
nd
the LSM hook callbacks that enforce igroup authority on bound tasks.

> diff --git a/security/Kconfig b/security/Kconfig
> index f7bf6cdc6229e..c2e6249fb8abb 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -228,6 +228,7 @@ source "security/safesetid/Kconfig"
>  source "security/lockdown/Kconfig"
>  source "security/landlock/Kconfig"
>  source "security/ipe/Kconfig"
> +source "security/kap/Kconfig"
> =20
>  source "security/integrity/Kconfig"

[Severity: Medium]
In security/kap/kap_lsm.c, DEFINE_LSM(kap) omits .order and therefore defau=
lts
to LSM_ORDER_MUTABLE, which means security/lsm_init.c only initializes kap =
if
it is listed in CONFIG_LSM or on the lsm=3D kernel command line.

Since security/Kconfig does not add kap to any of the default strings for
config LSM, won't enabling CONFIG_SECURITY_KAP=3Dy leave KAP inactive at bo=
ot on
default configurations unless the user manually overrides CONFIG_LSM or pas=
ses
lsm=3D on the command line?

> diff --git a/security/kap/igroup.c b/security/kap/igroup.c
> new file mode 100644
> index 0000000000000..069905a32e8ea
> --- /dev/null
> +++ b/security/kap/igroup.c

[ ... ]

> +static int kap_object_target(enum kap_hook_kind kind, const void *object,
> +			     char *target, size_t target_len)
> +{
> +	if (!object)
> +		return -EINVAL;
> +
> +	switch (kind) {

[ ... ]

> +	case KAP_HOOK_SOCKET_CONNECT: {
> +		const struct sockaddr *addr =3D object;
> +
> +		if (addr->sa_family =3D=3D AF_INET) {
> +			const struct sockaddr_in *in =3D object;
> +
> +			scnprintf(target, target_len, "%pI4:%u",
> +				  &in->sin_addr, ntohs(in->sin_port));
> +			return 0;
> +		}
> +		if (addr->sa_family =3D=3D AF_INET6) {
> +			const struct sockaddr_in6 *in6 =3D object;
> +
> +			scnprintf(target, target_len, "%pI6c:%u",
> +				  &in6->sin6_addr, ntohs(in6->sin6_port));
> +			return 0;
> +		}
> +		/* Other families, vsock among them, are named so a grant can allow th=
em. */
> +		scnprintf(target, target_len, "family:%u", addr->sa_family);
> +		return 0;
> +	}

[Severity: Critical]
Can this read uninitialized kernel memory and leak it into kap.events and
dmesg?

In security/kap/kap_lsm.c, kap_socket_connect() only checks that addrlen is=
 at
least offsetofend(struct sockaddr, sa_family) (2 bytes) and drops addrlen w=
hen
calling kap_check_current_emit(KAP_HOOK_SOCKET_CONNECT, address, ...):

	if (addrlen < offsetofend(struct sockaddr, sa_family) ||
	    address->sa_family =3D=3D AF_UNSPEC || address->sa_family =3D=3D AF_UN=
IX)
		return 0;
	return kap_check_current_emit(KAP_HOOK_SOCKET_CONNECT, address,
				      "net_predicate_denied", "net_allowed");

When a bound task calls connect() (via __sys_connect(), which allocates an
uninitialized struct sockaddr_storage on the kernel stack, or via io_uring
io_connect_prep()) with addrlen =3D 2 and sa_family =3D AF_INET or AF_INET6,
move_addr_to_kernel() copies only 2 bytes before invoking
security_socket_connect().

Here in kap_object_target(), casting object to struct sockaddr_in * or
struct sockaddr_in6 * and formatting sin_addr/sin_port or sin6_addr/sin6_po=
rt
without verifying addrlen >=3D sizeof(struct sockaddr_in) or
addrlen >=3D sizeof(struct sockaddr_in6) reads up to 22 bytes of uninitiali=
zed
kernel stack or heap memory, evaluates the policy against it, and writes the
formatted result to kap.events and the kernel log.

[ ... ]

> +static bool kap_file_prefix_match(const char *target, const char *candid=
ate)
> +{
> +	size_t len =3D strlen(candidate);
> +	size_t target_len =3D strlen(target);
> +
> +	if (!strcmp(target, candidate))
> +		return true;
> +	if (!len || target_len <=3D len)
> +		return false;
> +	if (candidate[len - 1] =3D=3D '/')
> +		return !strncmp(target, candidate, len);
> +	return target[len] =3D=3D '/' && !strncmp(target, candidate, len);
> +}

[Severity: High]
What happens in kap_file_prefix_match() and kap_exec_decision_locked() when=
 a
file or binary is unlinked while open?

Both kap_file_target() and kap_lsm_file_path_alloc() resolve paths with
d_path(&file->f_path, ...), which appends " (deleted)" when
d_unlinked(path->dentry) is true.

If a denied file "/srv/work/keys" inside an allowed directory "/srv/work" is
unlinked while open (and later checked in kap_file_permission(), received in
kap_file_receive(), or opened via /proc/pid/fd/N), target becomes
"/srv/work/keys (deleted)". Because target[len] is a space rather than '/' =
or
'\0', the exact deny pattern "/srv/work/keys" fails to match in
kap_file_prefix_match(), while the parent directory allow pattern "/srv/wor=
k"
still matches.

Similarly, in kap_exec_decision_locked(), executing an unlinked binary with
execveat(fd, "", ..., AT_EMPTY_PATH) produces resolved =3D
"/usr/bin/prog (deleted)" and bprm->filename =3D "/dev/fd/N", which misses =
an
exact deny rule "/usr/bin/prog" while still matching an allow rule
"/usr/bin/*".

Should unlinked files be handled before matching against path predicates?

[ ... ]

> +/* Collect one array across every predicate of a kind, keeping the set c=
ontiguous. */
> +static int kap_compile_kind_array(struct kap_compiled_authority *compile=
d,
> +				  struct kap_pattern_set *set,
> +				  const char *auth, const char *end,
> +				  const char *kind_name, const char *array_name)
> +{
> +	const char *predicate =3D auth;
> +
> +	set->offset =3D compiled->pool_used;
> +	set->count =3D 0;
> +	while ((predicate =3D kap_next_predicate(predicate, end, kind_name))) {
> +		const char *next =3D strstr(predicate + 1, "\"kind\":");
> +		const char *predicate_start =3D predicate;
> +		const char *predicate_end =3D next && next < end ? next : end;
> +		int rc;
> +
> +		while (predicate_start > auth && *predicate_start !=3D '{')
> +			predicate_start--;
> +		rc =3D kap_compile_array(compiled, set, predicate_start,
> +				       predicate_end, array_name);
> +		if (rc)
> +			return rc;
> +		predicate =3D predicate_end;
> +	}
> +	return 0;
> +}

[ ... ]

> +static int kap_validate_authority_payload(const char *payload)
> +{
> +	const char *cursor =3D payload;
> +	const char *end =3D payload + strlen(payload);
> +	bool saw_kind =3D false;
> +
> +	if (payload[0] !=3D '{' || !strstr(payload, "\"predicates\":["))
> +		return -EINVAL;
> +
> +	while ((cursor =3D strstr(cursor, "\"kind\":\""))) {
> +		const char *kind_start =3D cursor + strlen("\"kind\":\"");
> +		const char *kind_end =3D strchr(kind_start, '"');
> +		const char *next_kind =3D strstr(kind_start, "\"kind\":\"");
> +		const char *predicate_start =3D cursor;
> +		const char *predicate_end =3D next_kind ? next_kind : end;
> +
> +		if (!kind_end)
> +			return -EINVAL;
> +		if (!kap_is_known_kind_name(kind_start, kind_end - kind_start))
> +			return -EINVAL;
> +		while (predicate_start > payload && *predicate_start !=3D '{')
> +			predicate_start--;
> +		if (!kap_range_contains(predicate_start, predicate_end, "\"allow\":["))
> +			return -EINVAL;
> +		if (!kap_range_contains(predicate_start, predicate_end, "\"deny\":["))
> +			return -EINVAL;
> +		saw_kind =3D true;
> +		cursor =3D kind_end + 1;
> +	}
> +	return saw_kind ? 0 : -EINVAL;
> +}

[Severity: High]
Can kap_compile_kind_array() and kap_validate_authority_payload() misparse
predicate boundaries and compile allow/deny arrays into the wrong kind?

Both functions determine a predicate's span [predicate_start, predicate_end)
by scanning backward from "\"kind\":\"" to the first '{' and forward to the
next "\"kind\":".

First, if predicate N+1 places its "\"allow\":[...]" or "\"deny\":[...]" ar=
ray
before its "\"kind\":\"...\"" key, predicate N's predicate_end extends past
predicate N's closing '}' into predicate N+1. As a result, kap_compile_arra=
y()
matches and compiles predicate N+1's allow/deny arrays into predicate N's
kind.

Second, if a pattern string placed before "\"kind\"" contains a '{' charact=
er
(for example, "/safe/{secret}"), scanning backward from "\"kind\"" for '{'
stops inside the string literal rather than at the predicate object's openi=
ng
'{', causing the arrays preceding it to be skipped.

[ ... ]

> +static struct kap_igroup *kap_find_current_igroup_locked(void)
> +{
> +	struct kap_task_state *state =3D kap_task_state(current);
> +
> +	if (!state || !state->active)
> +		return NULL;
> +	return kap_find_igroup_locked(state->igroup_name);
> +}

[ ... ]

> +int kap_check_current_target_why(enum kap_hook_kind kind, const char *ta=
rget,
> +				 const char **why)
> +{
> +	const char *gate =3D NULL;
> +	struct kap_igroup *igroup;
> +	int rc =3D 0;
> +
> +	if (why)
> +		*why =3D NULL;
> +	if (kap_skip_current(kind))
> +		return 0;
> +
> +	spin_lock(&kap_lock);
> +	igroup =3D kap_find_current_igroup_locked();
> +	if (!igroup) {
> +		if (kap_unbound_refused(kind))
> +			rc =3D kap_refuse_unbound(kind, target);
> +		goto out;
> +	}
> +	rc =3D kap_authority_decision_locked(igroup, kind, target, &gate);
> +	if (why)
> +		*why =3D gate;
> +out:
> +	spin_unlock(&kap_lock);
> +	return rc;
> +}
> +
> +int kap_check_current_emit(enum kap_hook_kind kind, const void *object,
> +			   const char *deny_reason, const char *allow_reason)
> +{
> +	char *target;
> +	struct kap_igroup *igroup;
> +	const char *why =3D NULL;
> +	int rc =3D 0;
> +
> +	if (kap_skip_current(kind))
> +		return 0;
> +
> +	target =3D kmalloc(PATH_MAX, GFP_KERNEL);
> +	if (!target)
> +		return -ENOMEM;
> +	if (kap_object_target(kind, object, target, PATH_MAX)) {
> +		kfree(target);
> +		return -EACCES;
> +	}
> +
> +	spin_lock(&kap_lock);
> +	igroup =3D kap_find_current_igroup_locked();
> +	if (!igroup) {
> +		if (kap_unbound_refused(kind))
> +			rc =3D kap_refuse_unbound(kind, target);
> +		goto out;
> +	}
> +	rc =3D kap_decide_locked(igroup, kind, object, target, &why);
> +	kap_append_event_locked(igroup, kind, rc =3D=3D 0,
> +				rc ? (why ? why : deny_reason) : allow_reason, target);
> +out:
> +	spin_unlock(&kap_lock);
> +	kfree(target);
> +	return rc;
> +}
> +
> +int kap_check_current_target_emit(enum kap_hook_kind kind, const char *t=
arget,
> +				  const char *deny_reason, const char *allow_reason)
> +{
> +	struct kap_igroup *igroup;
> +	const char *why =3D NULL;
> +	int rc =3D 0;
> +
> +	if (kap_skip_current(kind))
> +		return 0;
> +
> +	spin_lock(&kap_lock);
> +	igroup =3D kap_find_current_igroup_locked();
> +	if (!igroup) {
> +		if (kap_unbound_refused(kind))
> +			rc =3D kap_refuse_unbound(kind, target);
> +		goto out;
> +	}

[Severity: Medium]
Doesn't this fail open if a task is marked active (state->active =3D=3D tru=
e),
but kap_find_igroup_locked(state->igroup_name) returns NULL?

Because kap_find_current_igroup_locked() returns NULL both when current is
unbound and when current is bound to an igroup_name that cannot be found in
kap_igroups, kap_check_current_target_why(), kap_check_current_emit(), and
kap_check_current_target_emit() only refuse when kap_unbound_refused(kind) =
is
true and otherwise jump to out with rc =3D 0.

Should a bound task whose igroup is missing fail closed with -EACCES?

[ ... ]

> +int kap_parse_transition_sequence(const char *payload, u64 *sequence)
> +{
> +	const char *cursor =3D strstr(payload, "\"sequence\"");
> +	u64 value =3D 0;
> +	bool seen_digit =3D false;
> +
> +	if (!cursor)
> +		cursor =3D strstr(payload, "sequence");
> +	if (!cursor)
> +		return -EINVAL;
> +	cursor =3D strchr(cursor, ':');
> +	if (!cursor)
> +		return -EINVAL;
> +	cursor++;
> +	while (*cursor =3D=3D ' ' || *cursor =3D=3D '\t')
> +		cursor++;
> +	while (*cursor >=3D '0' && *cursor <=3D '9') {
> +		seen_digit =3D true;
> +		value =3D value * 10 + (*cursor - '0');
> +		cursor++;
> +	}
> +	if (!seen_digit)
> +		return -EINVAL;
> +	*sequence =3D value;
> +	return 0;
> +}

[Severity: Medium]
Can value overflow u64 in kap_parse_transition_sequence()?

Unlike authority_epoch and expires_at in kap_install_parse(), which use
kstrtou64(), this loop accumulates decimal digits into value without checki=
ng
for 64-bit multiplication or addition overflow, allowing sequence numbers
larger than U64_MAX to wrap modulo 2^64 and bypass the monotonic sequence
check in kap_install_locked().

[ ... ]

> +int kap_bind_pid_locked(struct kap_igroup *igroup, pid_t pid,
> +			struct kap_bound_pid **entry)
> +{
> +	struct task_struct *task, *t;
> +
> +	if (pid <=3D 0)
> +		return -EINVAL;
> +	rcu_read_lock();
> +	task =3D pid_task(find_vpid(pid), PIDTYPE_PID);
> +	if (!task) {
> +		rcu_read_unlock();
> +		return -ESRCH;
> +	}
> +	for_each_thread(task, t) {
> +		struct kap_task_state *state =3D kap_task_state(t);
> +
> +		if (!state)
> +			continue;
> +		state->active =3D true;
> +		state->epoch =3D igroup->epoch;
> +		strscpy(state->igroup_name, igroup->name, sizeof(state->igroup_name));
> +	}
> +	rcu_read_unlock();
> +
> +	if (kap_pid_in_igroup_locked(igroup, pid))
> +		return 0;
> +	(*entry)->pid =3D pid;
> +	list_add_tail(&(*entry)->node, &igroup->pids);
> +	*entry =3D NULL;
> +	return 0;
> +}

[Severity: Medium]
Does igroup->pids leak struct kap_bound_pid entries when bound tasks exit or
are rebound to another igroup?

Here in kap_bind_pid_locked(), *entry is added to igroup->pids via
list_add_tail(). However, when a task exits, kap_task_free() in
security/kap/kap_lsm.c only zeroes the task's struct kap_task_state without
removing or freeing any entry from igroup->pids, and rebinding a task to a
different igroup overwrites state->igroup_name without removing its pid from
the previous igroup's pids list.

> diff --git a/security/kap/kap_lsm.c b/security/kap/kap_lsm.c
> new file mode 100644
> index 0000000000000..b148b3437d900
> --- /dev/null
> +++ b/security/kap/kap_lsm.c

[ ... ]

> +static int kap_task_alloc(struct task_struct *task, u64 clone_flags)
> +{
> +	struct kap_task_state *old =3D kap_task_state(current);
> +	struct kap_task_state *new =3D kap_task_state(task);
> +	int rc;
> +
> +	if (!new)
> +		return 0;
> +
> +	rc =3D kap_check_namespace_flags(clone_flags, "clone");
> +	if (rc)
> +		return rc;
> +
> +	memset(new, 0, sizeof(*new));
> +	/* Under kap_lock, so a bind running now is copied whole or not at all.=
 */
> +	spin_lock(&kap_lock);
> +	if (old && old->active)
> +		*new =3D *old;
> +	spin_unlock(&kap_lock);
> +	return 0;
> +}

[Severity: High]
Can a newly cloned child or thread miss a concurrent bind in
kap_bind_pid_locked()?

In copy_process(), security_task_alloc() calls kap_task_alloc() early=E2=80=
=94before
copy_files(), copy_mm(), and alloc_pid(), and before tasklist_lock and sigl=
ock
are acquired to link the new task onto signal->thread_head.

If kap_bind_pid_locked() runs on another CPU after kap_task_alloc() drops
kap_lock, but before copy_process() links the new task onto
task->signal->thread_head, for_each_thread(task, t) in kap_bind_pid_locked()
will not see the in-flight task, leaving the new thread or child process
unbound (or running with the pre-bind igroup and epoch).

[Severity: Medium]
Also in kap_task_alloc(), is it intentional that spin_lock(&kap_lock) is
acquired unconditionally on every fork() and clone() across the system?

The commit message notes that an unbound task returns before taking any loc=
k,
but kap_task_alloc() takes the global kap_lock even when kap_ready is false=
 or
current is unbound.

[ ... ]

> +static int kap_bprm_check_security(struct linux_binprm *bprm)
> +{
> +	char *target;
> +
> +	/*
> +	 * An unbound task is skipped everywhere else, but under
> +	 * kap.default =3D closed an unbound exec is the one thing that must not
> +	 * proceed.
> +	 */
> +	if (!kap_lsm_current_active() && !kap_fail_closed_kind(KAP_HOOK_EXEC))
> +		return 0;
> +	if (bprm->file) {
> +		target =3D kap_lsm_file_path_alloc(bprm->file);
> +		if (!IS_ERR(target)) {
> +			if (kap_path_is_memfd(target)) {
> +				int rc =3D kap_check_current_target_emit(KAP_HOOK_EXECMEM, target,
> +								       "memfd_exec_predicate_denied",
> +								       "memfd_exec_allowed");
> +				kfree(target);
> +				return rc;
> +			}
> +			kfree(target);
> +		}
> +	}
> +	return kap_check_current_emit(KAP_HOOK_EXEC, bprm,
> +				      "exec_predicate_denied", "exec_allowed");
> +}

[ ... ]

> +static void kap_normalize_procfs_self(char *target)
> +{
> +	static const char self[] =3D "/proc/self";
> +	const size_t self_len =3D sizeof(self) - 1;
> +	char prefix[32];
> +	size_t prefix_len;
> +	size_t tail_len;
> +
> +	prefix_len =3D scnprintf(prefix, sizeof(prefix), "/proc/%d", task_pid_n=
r(current));
> +	if (strncmp(target, prefix, prefix_len))
> +		return;
> +	if (target[prefix_len] !=3D '\0' && target[prefix_len] !=3D '/')
> +		return;
> +	tail_len =3D strlen(target + prefix_len);
> +	if (self_len + tail_len >=3D PATH_MAX)
> +		return;
> +	memmove(target + self_len, target + prefix_len, tail_len + 1);
> +	memcpy(target, self, self_len);
> +}

[Severity: High]
Doesn't kap_normalize_procfs_self() use the wrong PID and PID namespace when
matching "/proc/%d"?

procfs resolves /proc/self (in fs/proc/self.c) using
task_tgid_nr_ns(current, proc_pid_ns(inode->i_sb)), which is the thread-gro=
up
leader's TGID in the PID namespace of that procfs mount. Here,
kap_normalize_procfs_self() formats "/proc/%d" using task_pid_nr(current),
which is the calling thread's TID in init_pid_ns.

Because of this mismatch:
1. For any non-leader thread (current->pid !=3D current->tgid) or any task =
in a
   child PID namespace with its own /proc mount, d_path() produces
   /proc/<ns_tgid>/..., which does not match /proc/<init_tid> and is not
   normalized to /proc/self/....
2. In a child PID namespace, if another process in the container happens to
   have a container-local PID equal to current's init_pid_ns TID,
   kap_normalize_procfs_self() rewrites that other process's /proc/<pid>/...
   path to /proc/self/..., allowing current to access another process's pro=
cfs
   files under a /proc/self grant.

Should this use task_tgid_nr_ns(current, proc_pid_ns(file_inode(file)->i_sb=
))
instead of task_pid_nr(current)?

> +
> +static bool kap_path_is_memfd(const char *path)
> +{
> +	return strstr(path, "/memfd:") || strstr(path, "memfd:");
> +}

[ ... ]

> +static int kap_file_permission(struct file *file, int mask)
> +{
> +	const char *why =3D NULL;
> +	char *target;
> +	int rc;
> +
> +	if (!kap_lsm_current_active())
> +		return 0;
> +	if (!(mask & (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)))
> +		return 0;
> +	target =3D kap_lsm_file_path_alloc(file);
> +	if (IS_ERR(target))
> +		return kap_check_current_emit(KAP_HOOK_FILE, file,
> +					      "file_use_predicate_denied",
> +					      "file_use_allowed");
> +	if (kap_path_is_anonymous_channel(target)) {
> +		kfree(target);
> +		return 0;
> +	}

[Severity: High]
When kap_path_is_anonymous_channel(target) is true ("pipe:", "socket:", or
"anon_inode:"), kap_file_permission() returns 0 before calling
kap_check_current_target_why().

Since the authority-state checks (kap_current_epoch_stale_locked(),
igroup->expires_at, igroup->revoked, and !igroup->authority_len) only run
inside kap_authority_decision_locked(), won't returning 0 early here allow a
bound task whose authority has expired, been revoked, or become epoch-stale=
 to
continue reading and writing already-open sockets, pipes, and anon_inodes?

[ ... ]

> +static int kap_mmap_file(struct file *file, unsigned long reqprot,
> +			 unsigned long prot, unsigned long flags)
> +{
> +	char *target;
> +	int rc =3D 0;
> +
> +	if (!kap_lsm_current_active())
> +		return 0;
> +	if (!(reqprot & PROT_EXEC) && !(prot & PROT_EXEC))
> +		return 0;
> +	if (!file)
> +		return kap_check_current_target_emit(KAP_HOOK_EXECMEM, "anonymous",
> +						     "execmem_predicate_denied",
> +						     "execmem_allowed");
> +	target =3D kap_lsm_file_path_alloc(file);
> +	if (IS_ERR(target))
> +		return 0;
> +	if (kap_path_is_memfd(target))
> +		rc =3D kap_check_current_target_emit(KAP_HOOK_EXECMEM, target,
> +						   "execmem_predicate_denied",
> +						   "execmem_allowed");
> +	kfree(target);
> +	return rc;
> +}
> +
> +static int kap_file_mprotect(struct vm_area_struct *vma,
> +			     unsigned long reqprot, unsigned long prot)
> +{
> +	char *target;
> +	struct file *file;
> +	int rc =3D 0;
> +
> +	if (!kap_lsm_current_active())
> +		return 0;
> +	if (!(reqprot & PROT_EXEC) && !(prot & PROT_EXEC))
> +		return 0;
> +	file =3D vma ? vma->vm_file : NULL;
> +	if (!file)
> +		return kap_check_current_target_emit(KAP_HOOK_EXECMEM, "anonymous",
> +						     "execmem_predicate_denied",
> +						     "execmem_allowed");
> +	target =3D kap_lsm_file_path_alloc(file);
> +	if (IS_ERR(target))
> +		return 0;
> +	if (kap_path_is_memfd(target))
> +		rc =3D kap_check_current_target_emit(KAP_HOOK_EXECMEM, target,
> +						   "execmem_predicate_denied",
> +						   "execmem_allowed");
> +	kfree(target);
> +	return rc;
> +}

[Severity: High]
Are there several ways to bypass KAP_HOOK_EXECMEM and KAP_HOOK_EXEC through
kap_mmap_file(), kap_file_mprotect(), kap_bprm_check_security(), and
kap_path_is_memfd()?

1. In kap_file_mprotect(), checking vma->vm_file =3D=3D NULL instead of
   vma_is_anonymous(vma) misses private mappings of /dev/zero (where
   vma_is_anonymous(vma) is true but vma->vm_file points to /dev/zero) as w=
ell
   as MAP_ANONYMOUS | MAP_SHARED mappings (where shmem_zero_setup() attache=
s an
   internal "/dev/zero (deleted)" file to vma->vm_file).
2. In both kap_mmap_file() and kap_file_mprotect(), when file is non-NULL:
   - if kap_lsm_file_path_alloc(file) returns an ERR_PTR (such as -ENOMEM or
     -ENAMETOOLONG), returning 0 fails open; and
   - if !kap_path_is_memfd(target), both hooks return 0 without consulting
     KAP_HOOK_EXECMEM at all (which also leaves case KAP_HOOK_EXECMEM in
     kap_object_target() unused), allowing executable mappings of /dev/zero,
     MAP_ANONYMOUS | MAP_SHARED, O_TMPFILE, or any regular file.
3. kap_path_is_memfd() checks strstr(path, "/memfd:") || strstr(path, "memf=
d:"),
   which matches any filesystem path containing the substring "memfd:". In
   kap_bprm_check_security(), executing an on-disk file whose path contains
   "memfd:" (e.g. /tmp/memfd:bin) is routed to KAP_HOOK_EXECMEM instead of
   KAP_HOOK_EXEC (and skips kap_exec_decision_locked()'s check on
   bprm->filename).

[ ... ]

> +static int kap_lsm_check_dir_entry(const struct path *dir, struct dentry=
 *dentry)
> +{
> +	char *buf;
> +	char *rendered;
> +	char *target;
> +	int rc;
> +	int len;
> +
> +	/* kap_path_link builds old_path by hand, so either field can be NULL.
> +	 * d_path would dereference them.
> +	 */
> +	if (!dir || !dir->mnt || !dir->dentry || !dentry)
> +		return kap_lsm_refuse_unresolved("file_path_unresolved");
> +	buf =3D kmalloc(PATH_MAX, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +	target =3D kmalloc(PATH_MAX, GFP_KERNEL);
> +	if (!target) {
> +		kfree(buf);
> +		return -ENOMEM;
> +	}
> +	rendered =3D d_path(dir, buf, PATH_MAX);

[ ... ]

> +static int kap_path_link(struct dentry *old_dentry, const struct path *n=
ew_dir,
> +			 struct dentry *new_dentry)
> +{
> +	struct path old_path;
> +	int rc;
> +
> +	if (!kap_lsm_current_active())
> +		return 0;
> +	/* Checking only the destination would let a denied file be linked into
> +	 * an allowed directory and then read through the alias, since the later
> +	 * open sees the allowed name. A hard link cannot cross a mount, so the
> +	 * source shares new_dir's vfsmount.
> +	 */
> +	old_path.mnt =3D new_dir ? new_dir->mnt : NULL;
> +	old_path.dentry =3D old_dentry ? old_dentry->d_parent : NULL;
> +	rc =3D kap_lsm_check_dir_entry(&old_path, old_dentry);
> +	if (rc)
> +		return rc;
> +	return kap_lsm_check_dir_entry(new_dir, new_dentry);
> +}

[Severity: High]
Is reading old_dentry->d_parent without dget_parent() in kap_path_link() sa=
fe
against a concurrent rename()?

When do_linkat() calls security_path_link(old_path.dentry, &new_path,
new_dentry), the VFS holds a reference on old_dentry and holds i_rwsem only=
 on
new_dir->dentry->d_inode; old_dentry's parent directory is not locked and
old_dentry->d_parent is not separately pinned.

kap_path_link() copies old_dentry->d_parent into old_path.dentry without
taking a reference, and kap_lsm_check_dir_entry() then performs two sleeping
kmalloc(PATH_MAX, GFP_KERNEL) allocations before passing old_path to d_path=
().
If a concurrent rename moves old_dentry to another directory and the former
parent dentry is removed, old_path.dentry can be freed before d_path()
dereferences it. Why not construct old_path as
{ .mnt =3D new_dir->mnt, .dentry =3D old_dentry } and resolve it directly w=
ith
d_path()?

[ ... ]

> +static int kap_sb_mount(const char *dev_name, const struct path *path,
> +			const char *type, unsigned long flags, void *data)
> +{
> +	char path_target[KAP_LSM_TARGET_LEN];
> +	char target[KAP_LSM_TARGET_LEN];
> +
> +	if (!kap_lsm_current_active())
> +		return 0;
> +
> +	if (kap_lsm_path_target(path, path_target, sizeof(path_target)))
> +		strscpy(path_target, "unknown", sizeof(path_target));
> +	scnprintf(target, sizeof(target), "mount:mount:%s:%s",
> +		  type ?: "unknown", path_target);
> +	return kap_check_static_target(KAP_HOOK_NAMESPACE, target,
> +				       "mount_predicate_denied", "mount_allowed");
> +}
> +
> +static int kap_sb_umount(struct vfsmount *mnt, int flags)
> +{
> +	struct path path =3D { .mnt =3D mnt, .dentry =3D mnt ? mnt->mnt_root : =
NULL };
> +	char path_target[KAP_LSM_TARGET_LEN];
> +	char target[KAP_LSM_TARGET_LEN];
> +
> +	if (!kap_lsm_current_active())
> +		return 0;
> +
> +	if (!mnt || kap_lsm_path_target(&path, path_target, sizeof(path_target)=
))
> +		strscpy(path_target, "unknown", sizeof(path_target));
> +	scnprintf(target, sizeof(target), "mount:umount:%s", path_target);
> +	return kap_check_static_target(KAP_HOOK_NAMESPACE, target,
> +				       "mount_predicate_denied", "mount_allowed");
> +}
> +
> +static int kap_sb_pivotroot(const struct path *old_path, const struct pa=
th *new_path)
> +{
> +	char old_target[KAP_LSM_TARGET_LEN];
> +	char new_target[KAP_LSM_TARGET_LEN];
> +	char target[KAP_LSM_TARGET_LEN];
> +
> +	if (!kap_lsm_current_active())
> +		return 0;
> +
> +	if (kap_lsm_path_target(old_path, old_target, sizeof(old_target)))
> +		strscpy(old_target, "unknown", sizeof(old_target));
> +	if (kap_lsm_path_target(new_path, new_target, sizeof(new_target)))
> +		strscpy(new_target, "unknown", sizeof(new_target));
> +	scnprintf(target, sizeof(target), "mount:pivotroot:%s:%s",
> +		  old_target, new_target);
> +	return kap_check_static_target(KAP_HOOK_NAMESPACE, target,
> +				       "mount_predicate_denied", "mount_allowed");
> +}
> +
> +static int kap_move_mount(const struct path *from_path, const struct pat=
h *to_path)
> +{
> +	char from_target[KAP_LSM_TARGET_LEN];
> +	char to_target[KAP_LSM_TARGET_LEN];
> +	char target[KAP_LSM_TARGET_LEN];
> +
> +	if (!kap_lsm_current_active())
> +		return 0;
> +
> +	if (kap_lsm_path_target(from_path, from_target, sizeof(from_target)))
> +		strscpy(from_target, "unknown", sizeof(from_target));
> +	if (kap_lsm_path_target(to_path, to_target, sizeof(to_target)))
> +		strscpy(to_target, "unknown", sizeof(to_target));
> +	scnprintf(target, sizeof(target), "mount:move:%s:%s",
> +		  from_target, to_target);
> +	return kap_check_static_target(KAP_HOOK_NAMESPACE, target,
> +				       "mount_predicate_denied", "mount_allowed");
> +}

[Severity: High]
In kap_sb_mount(), kap_sb_umount(), kap_sb_pivotroot(), and kap_move_mount(=
),
what happens when a mount path is longer than KAP_LSM_TARGET_LEN (256 bytes)
or when kap_lsm_path_target() fails?

kap_lsm_path_target() copies the PATH_MAX result of d_path() into target us=
ing
strscpy(target, rendered, target_len) and ignores the -E2BIG truncation err=
or,
and the mount hooks then format one or two 256-byte path buffers into a sin=
gle
256-byte target buffer via scnprintf(). Furthermore, if kap_lsm_path_target=
()
returns an error, the mount hooks substitute "unknown" instead of refusing =
the
operation.

As noted in the comment above kap_lsm_check_dir_entry(), truncating a path =
or
substituting a placeholder like "unknown" lets a broad allow pattern (such =
as
"mount:*" or "*") pass while preventing a specific deny rule on the actual
path from matching. Shouldn't these hooks allocate full-length buffers and
refuse on path resolution failure or truncation?

[ ... ]

> +static void kap_ptrace_target(struct task_struct *child, char *target, s=
ize_t target_len)
> +{
> +	struct kap_task_state *current_state =3D kap_task_state(current);
> +	struct kap_task_state *child_state =3D kap_task_state(child);
> +
> +	if (current_state && current_state->active &&
> +	    child_state && child_state->active &&
> +	    !strcmp(current_state->igroup_name, child_state->igroup_name) &&
> +	    current_state->epoch =3D=3D child_state->epoch) {
> +		strscpy(target, "same-igroup", target_len);
> +		return;
> +	}
> +	if (child_state && child_state->active) {
> +		scnprintf(target, target_len, "igroup=3D%s", child_state->igroup_name);
> +		return;
> +	}
> +	strscpy(target, "unconfined", target_len);
> +}

[Severity: High]
Can kap_ptrace_target() race with kap_bind_pid_locked() when reading
current_state and child_state?

In security/kap/igroup.c, kap_bind_pid_locked() updates each thread's
struct kap_task_state in place under kap_lock by setting state->active =3D =
true
before writing state->epoch and strscpy(state->igroup_name, ...):

		state->active =3D true;
		state->epoch =3D igroup->epoch;
		strscpy(state->igroup_name, igroup->name, sizeof(state->igroup_name));

However, kap_ptrace_target() (called by kap_ptrace_access_check() and
kap_ptrace_traceme() before kap_check_current_target_emit() acquires kap_lo=
ck)
reads active, igroup_name, and epoch of both current and child without hold=
ing
kap_lock. If a bind or rebind runs concurrently on another CPU,
kap_ptrace_target() can observe state->active =3D=3D true while state->igro=
up_name
is still empty or partially written, or paired with an inconsistent epoch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028133335.7589=
9-1-ketan@armoriq.io?part=3D3
