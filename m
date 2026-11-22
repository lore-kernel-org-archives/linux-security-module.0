Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795306254;
	b=I/1zmgoYgB/Yp1FcZ0XkM4W9K75hzBhxM7HhBPOE9hsC6X0Ecqwx+6tJ5lvwdM/ooNSK
	 tKSkgKjERuyBpsIaN6hiMmbK9eWOkKenmldyAujKDAo13XVyCKQvy6oFdp1Ich5cSuwfp
	 cSxZkr8ltsOCBSjOkeSLQEFgdprbvGk9j2g91kvx/x3uNfFXb1HMfQdVf6GwWNxj7BOBi
	 ZWQs65cyUwgI6lm7x5ctfbiNgtqLdvT3EMy55zp6cQHty2z95R4TSCrWpuNSyrW30xJ0I
	 zovYReGqKq0NZAqh9JpoKi1KvM5mwVhdNMcjurpCAHdMQKYdmOkRegSv1UJ9+rORQuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795306254;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Iqb1sxGXVs+ZBL2YO1Gxpd58VvwV2+dlg9RG8sovwRk=;
	b=rflNS8CBi1VZLeiMwI3aq8f93keH6QEogu/kNO3wbrbLXfVSdU/M1As40ufgYHakjVQ+
	 HuJzNOPlLw0DZBlVmGGDckiv15+bEk7L+yfyGG3Och9CSHjQoqcCwqmrs8kT9e6sOuM6Y
	 hUv55lvftWKY/d6XmR+Vm9WyJiElm4QIOYaJC2B5y+JMVvl7QNm6nnstohklvmvEuBd12
	 aJ5m7oVqjPS39kegGK4rEoZClBbTnRdGjHDul3ZENxKtdryx2LLYKqhsjjtcWBRD5p11a
	 MwozckAsAJ2coLOFC189dK3cvWTT4mi0JmDm8gOb5ut+VhIqhKJ3Sr5WGhYt6oWCHvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jdzme6jD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8691F606A320
	for <linux-security-module@vger.kernel.org>; Sun, 22 Nov 2026 00:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jdzme6jD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6A91F000C0;
	Sun, 22 Nov 2026 00:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795306254;
	bh=Iqb1sxGXVs+ZBL2YO1Gxpd58VvwV2+dlg9RG8sovwRk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jdzme6jDlPEH9sXHNBaFkNO/jgmbvC1G2RSo97+cJNY67STD7lrt2j1TZm/bun4Qv
	 sCVAI5JtJ9kPPD2C4c6IOFkgIOSrQplvNb7vhkTwXldlDssVbaY4UImqvq8ysBamCH
	 oHxbnqxB49eL8sokvPPJlRl9qX2nk38biae/yynw9WPyOM+nBS2ii/J4RQqZjxVzji
	 wjPHBlUdt46uLlvpf+ruGWd0e8/3iXMuv6dXr6ENWr+PmA+QBPtZ96Z5r7pkdnj93s
	 ovP0x7nnHWgP+LSUqxzr+iej73HAjJEpro00U2O1yyU+LaV052sRgZrW9CBbC99t59
	 QqfW2Jv5S1/4g==
Message-ID: <sashiko-outbox-227537@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 02/25] userns: Add userns_set_idmap() system call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Alexander
 Mikhalitsyn" <alex@amutable.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Andy
 Lutomirski" <luto@amacapital.net>, "Christian Brauner" <brauner@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Jan Kara" <jack@suse.cz>, "Jonathan Corbet" <corbet@lwn.net>, "Josef
 Bacik" <josef@toxicpanda.com>, "Kees Cook" <kees@kernel.org>, "Neal Gompa" <neal@gompa.dev>, "Paul
 Moore" <paul@paul-moore.com>, "Serge Hallyn" <sergeh@kernel.org>, "Zygmunt
 Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261121000844.1863324-3-jarkko@kernel.org>
References: <20261121000844.1863324-1-jarkko@kernel.org>
 <20261121000844.1863324-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 00:10:52 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] userns: missing target CAP_SYS_ADMIN and caller checks in
  sys_userns_set_idmap()
- [Medium] userns: unbounded size passed to copy_struct_from_user() in
  sys_userns_set_idmap()
- [Medium] userns: transient ns->flags mutation in
  sys_userns_set_idmap() before validation
--

commit cd58304550496b7580b53ae3de9d67b848eccae2
Author: Jarkko Sakkinen <jarkko@kernel.org>

userns: Add userns_set_idmap() system call

This commit introduces the userns_set_idmap() system call to atomically
configure setgroups policy and UID, GID, and project ID mappings directly
on a user namespace file descriptor.

> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 6b9673dcdc670..d7f2cad388c8c 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c

[ ... ]

> +static bool caller_idmap_permitted(struct user_namespace *ns, int cap_se=
tid,
> +				   const struct uid_gid_map *new_map)
> +{
> +	const struct cred *cred =3D current_cred();
> +
> +	if (cap_setid =3D=3D CAP_SETUID && idmap_maps_root(new_map)) {
> +		if (cred->user_ns =3D=3D ns) {
> +			if (!ns->parent_could_setfcap)
> +				return false;
> +		} else {
> +			if (!ns_capable(ns->parent, CAP_SETFCAP))
> +				return false;
> +		}
> +	}
> +
> +	if (new_map->nr_extents =3D=3D 1 && new_map->extent[0].count =3D=3D 1 &&
> +	    uid_eq(ns->owner, cred->euid)) {
> +		u32 id =3D new_map->extent[0].lower_first;
> +
> +		if (cap_setid =3D=3D CAP_SETUID) {
> +			kuid_t uid =3D make_kuid(ns->parent, id);
> +
> +			if (uid_eq(uid, cred->euid))
> +				return true;
> +		} else if (cap_setid =3D=3D CAP_SETGID) {
> +			kgid_t gid =3D make_kgid(ns->parent, id);
> +
> +			if (!(ns->flags & USERNS_SETGROUPS_ALLOWED) &&
> +			    gid_eq(gid, cred->egid))
> +				return true;
> +		}
> +	}
> +
> +	if (!cap_valid(cap_setid))
> +		return true;
> +
> +	return ns_capable(ns->parent, cap_setid);
> +}

[ ... ]

> +SYSCALL_DEFINE4(userns_set_idmap, int, fd,
> +		const struct userns_idmap __user *, map,
> +		size_t, size, unsigned int, flags)
> +{

[ ... ]

> +	if (!map || size < USERNS_IDMAP_SIZE_VER0)
> +		return -EINVAL;
> +
> +	ret =3D copy_struct_from_user(&req, sizeof(req), map, size);
> +	if (ret)
> +		return ret;

[Severity: Medium]
Should sys_userns_set_idmap() reject size > PAGE_SIZE with -E2BIG before
calling copy_struct_from_user()?  When size exceeds sizeof(req),
copy_struct_from_user() calls check_zeroed_user() on the trailing bytes,
which scans the user range word-by-word inside user_read_access_begin()
without rescheduling or checking for pending signals.  An unprivileged
caller can pass a multi-gigabyte zero-filled mapping and stall a CPU in
the kernel.

> +
> +	if (!req.flags || (req.flags & ~USERNS_IDMAP_ALL_FLAGS))
> +		return -EINVAL;
> +	if (!(req.flags & USERNS_IDMAP_UID) &&
> +	    (req.nr_uid_extents || req.uid_extents))
> +		return -EINVAL;
> +	if (!(req.flags & USERNS_IDMAP_GID) &&
> +	    (req.nr_gid_extents || req.gid_extents))
> +		return -EINVAL;
> +	if (!(req.flags & USERNS_IDMAP_PROJID) &&
> +	    (req.nr_projid_extents || req.projid_extents))
> +		return -EINVAL;
> +
> +	if (!ns->parent)
> +		return -EPERM;
> +	if (current_user_ns() !=3D ns && current_user_ns() !=3D ns->parent)
> +		return -EPERM;
> +
> +	if (req.flags & (USERNS_IDMAP_UID | USERNS_IDMAP_GID |
> +			 USERNS_SETGROUPS_DENY)) {
> +		bool file_ok =3D (filp->f_cred->user_ns =3D=3D ns ||
> +				filp->f_cred->user_ns =3D=3D ns->parent) &&
> +			       file_ns_capable(filp, ns, CAP_SYS_ADMIN);
> +
> +		if (!ns_capable(ns, CAP_SYS_ADMIN) && !file_ok)
> +			return -EPERM;
> +	}

[Severity: High]
Does omitting USERNS_IDMAP_PROJID from this CAP_SYS_ADMIN check allow any
unprivileged process holding a read-only userns fd to write ns->projid_map?

For /proc/<pid>/projid_map, writing requires opening the procfs file
(mode 0644, owned by the target task) for write, so VFS permission checks
block unrelated users in ns->parent and unprivileged non-owner tasks inside
ns.  By contrast, nsfs files have mode 0444 and are always opened O_RDONLY,
and caller_idmap_permitted() returns true unconditionally when cap_setid is
-1.  As a result, an unprivileged task inside ns that dropped capabilities,
or an unrelated user in ns->parent that obtained an nsfs fd (for example via
NS_GET_USERNS), can call userns_set_idmap() with USERNS_IDMAP_PROJID and
lock in the write-once projid_map.

In addition, when file_ok is true on a delegated nsfs fd and the caller
lacks ns_capable(ns, CAP_SYS_ADMIN), neither USERNS_SETGROUPS_DENY nor
USERNS_IDMAP_PROJID verifies any privilege on current_cred() in ns->parent,
allowing an unprivileged recipient of a read-only userns fd to disable
setgroups(2) or configure projid_map on ns.

[ ... ]

> +	if (req.flags & USERNS_SETGROUPS_DENY)
> +		ns->flags &=3D ~USERNS_SETGROUPS_ALLOWED;
> +
> +	if (req.flags & USERNS_IDMAP_UID) {
> +		ret =3D prepare_caller_idmap(ns, CAP_SETUID, &new_uid,
> +					   &ns->parent->uid_map);
> +		if (ret < 0)
> +			goto out_restore;
> +	}
> +	if (req.flags & USERNS_IDMAP_GID) {
> +		ret =3D prepare_caller_idmap(ns, CAP_SETGID, &new_gid,
> +					   &ns->parent->gid_map);
> +		if (ret < 0)
> +			goto out_restore;
> +	}
> +	if (req.flags & USERNS_IDMAP_PROJID) {
> +		ret =3D prepare_caller_idmap(ns, -1, &new_projid,
> +					   &ns->parent->projid_map);
> +		if (ret < 0)
> +			goto out_restore;
> +	}
> +
> +	if (req.flags & USERNS_IDMAP_UID)
> +		commit_new_idmap(&ns->uid_map, &new_uid);
> +	if (req.flags & USERNS_IDMAP_GID)
> +		commit_new_idmap(&ns->gid_map, &new_gid);
> +	if (req.flags & USERNS_IDMAP_PROJID)
> +		commit_new_idmap(&ns->projid_map, &new_projid);
> +
> +	mutex_unlock(&userns_state_mutex);
> +	return 0;
> +
> +out_restore:
> +	ns->flags =3D old_flags;

[Severity: Medium]
Can clearing USERNS_SETGROUPS_ALLOWED in ns->flags before
prepare_caller_idmap() expose a transient "deny" state to concurrent
readers if preparation fails?

proc_setgroups_show() reads READ_ONCE(ns->flags) without holding
userns_state_mutex:

kernel/user_namespace.c:proc_setgroups_show() {
	struct user_namespace *ns =3D seq->private;
	unsigned long userns_flags =3D READ_ONCE(ns->flags);

	seq_printf(seq, "%s\n",
		   (userns_flags & USERNS_SETGROUPS_ALLOWED) ?
		   "allow" : "deny");
	return 0;
}

While prepare_caller_idmap() needs USERNS_SETGROUPS_ALLOWED cleared when
checking an unprivileged caller's GID mapping, mutating ns->flags in place
and restoring old_flags on failure lets a concurrent reader of
/proc/<pid>/setgroups observe "deny" before it reverts to "allow". Could
caller_idmap_permitted() check the effective flags value and leave the
update to ns->flags until the commit phase after all prepare_caller_idmap()
calls succeed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121000844.1863=
324-1-jarkko@kernel.org?part=3D2
