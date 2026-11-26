Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665956;
	b=JM9xtOubwNjHRz6l7LAVHuBAW0yvRnVAylL33CBcC5UxAflPNKzWD+VBg89gLG2bRSAq
	 tTrfWzHVaDkXjFeFi3H0G6QnpTLtEi6mrHsOKqOnNsiMroPHhsyYqA3R7gw7AnXOBAFnH
	 nRBwzTnm9TwGvs7M2bnLPzZrMSmIxOxCLUC3Y+48uUHesQ18ufGj4xKOaehVhs4sAXlRh
	 Zy922ek9gi5Py1UjyZTzP2hJZ9MNZxFszU/pJHtvIWwhfxMTdmGjAisUzsNs8rbejoRSK
	 a3TDmv41VwCrcUcdttfyTZp3W0pc3BlXBU8CPT0SSP8AQZO1UqEvPMVGd2pknOY9xVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665956;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S8lq1DpO7GOTvoSd8fPLdjoxUAMwonfdHnRtXIYtk28=;
	b=M8ilZmi7DonLbKKxs9rZ6dn0t+L2MMqmP/g8Ma0RqH5/SCdamtfDpc+8vHFeIWtd4kit
	 ZZESNf4bOEpfsSFte7FxS+90DjgwDaP9fZjR1By2/RBBDwiaiHtryag1n6QbGBo7ti9Pl
	 gLOLE3csXd/jBAALxDDDTdE8Duv0Rt6wqPpMDCO+2SJxKIh+PQJrpfPJoL5C81Xc3GvS7
	 /4ONPb5HczZYoUzvHFP/F4inSDZ+1QuFnnjwMuDb5RLiTUJR+So+0jD7mviQ9JSU1aWKA
	 FRzy3AVCjlp7hZ8txovqyfSfCr2FDZR+L5hBnLEq6b4DXrMp4MPqZpQXCXSfsaKG19Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G9Q0sb57;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEEF606A31E;
	Thu, 26 Nov 2026 04:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G9Q0sb57
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDF51F000C0;
	Thu, 26 Nov 2026 04:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795665955;
	bh=S8lq1DpO7GOTvoSd8fPLdjoxUAMwonfdHnRtXIYtk28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G9Q0sb57wR41ypPr4skt8kFz4g3B63s+XyJ3mECHik5CnfPXjj4/kxZMB0+gqiCYS
	 92OSpwIWxv7ICtUa9P+xfuBQhzqxTkp2SOcehnEmaEwbRYOHIR4mtYsML8DJ2lvwVj
	 bczRmh0/ltsFABgw2GhS5xdGBilb3XG/YNzdUAGlGGCE30Id/ZejPu9cAq9w4/y8z2
	 w5vVKNOVuRnZfWR8Ltlw2GeXeHAOkfJyn1Fz26GzWK+FHxc/cpj9SxTH4vR4t3T21b
	 brrL06zeslVJzjtVj+rjVQmTCfEjy9PglkYRwV5x738yQCZsx2s79rSY5wUeSeVFSd
	 cEKq7kjcz3alA==
Message-ID: <sashiko-outbox-234719@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] landlock: restrict opening namespace file descriptors
Reply-To: sashiko-reviews@lists.linux.dev
To: shaos <shawnq1@163.com>
Cc: linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <179566442733.1993761.8053687674090289362@163.com>
References: <179566442733.1993761.8053687674090289362@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 04:05:55 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] landlock: check_ns_type() current-ns check bypasses setns()
  enforcement
- [Medium] landlock: hook_file_open() checks nsfs permission before fs
  path access
- [Low] landlock: missing doc, UAPI comment, and test regex updates for
  acquire op
- [Low] landlock: commit message has bug-report boilerplate and wrong
  setns() claim
--

commit 54561b92150f0ba42829d19391fa02878f218068
Author: shaos <shawnq1@163.com>

> landlock: restrict opening namespace file descriptors
>
> Hello,
>
> Landlock checks NAMESPACE_USE when a task creates a namespace or
> installs one with setns(), but does not check acquisition of a file
> descriptor for an existing namespace. A sandboxed task can use
> SIOCGSKNS on a retained socket to obtain a descriptor for a network
> namespace denied by its Landlock rules, then pass that descriptor to
> RTM_SETLINK to move an interface into that namespace.
>
> The reproducer uses a task with CAP_NET_ADMIN in its own user namespace
> and a retained socket reference to the target namespace. It demonstrates
> a Landlock namespace-use policy bypass; it does not demonstrate
> privilege escalation beyond that capability.
>
> This change checks nsfs file opens from Landlock's file_open hook. It
> covers proc namespace links and namespace ioctls that create an nsfs
> file. It keeps the current namespace implicitly accessible, consistent
> with the documented behavior, and records fd acquisition distinctly in
> audit and trace events.
>
> HEAD commit:    8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
> Git tree:       fe970b05333fb8e41da21e9e289f652abcc7cba7
> Source version: Linux 7.4.0-rc4
> Compiler:       gcc 11.4.0, GNU ld 2.38
> Test runtime:   QEMU 6.2.0, x86-64 TCG
>
> The PoC, complete configuration, console logs, and initramfs helpers
> are in this unlisted Gist:
>
> https://gist.github.com/shaos26/b2c0b1e1951692b79d2bc2f9421abfbc
>
> Console output:
> https://gist.githubusercontent.com/shaos26/b2c0b1e1951692b79d2bc2f9421abf=
bc/raw/d2278bbd001f2c62b611fc0a5325cc4c8f7451b0/console-output.txt
> Kernel config:
> https://gist.githubusercontent.com/shaos26/b2c0b1e1951692b79d2bc2f9421abf=
bc/raw/d2278bbd001f2c62b611fc0a5325cc4c8f7451b0/kernel-config.txt
> PoC source:
> https://gist.githubusercontent.com/shaos26/b2c0b1e1951692b79d2bc2f9421abf=
bc/raw/d2278bbd001f2c62b611fc0a5325cc4c8f7451b0/poc.c
>
> The reproduction script builds the specified kernel, builds the PoC and
> initramfs, and runs the baseline, deny, allow, and invalid-fd cases:
>
>     git clone https://gist.github.com/b2c0b1e1951692b79d2bc2f9421abfbc.gi=
t repro
>     git -C repro checkout d2278bbd001f2c62b611fc0a5325cc4c8f7451b0
>     chmod +x repro/*.sh
>     ./repro/reproduce.sh
>
> Two vulnerable boots allowed SIOCGSKNS and RTM_SETLINK despite the deny
> rule: the move request was acknowledged and the interface appeared in
> the denied namespace. With this patch, opening the current namespace
> still succeeds, setns() and unshare() remain denied, SIOCGSKNS returns
> EPERM, and the interface remains in its original namespace. Baseline,
> explicit allow-rule, and invalid-fd controls pass.
>
> Fixes: 15dd86021b57 ("landlock: Enforce namespace use restrictions")
> Cc: stable@vger.kernel.org
> Signed-off-by: shaos <shawnq1@163.com>

[Severity: Low]
This isn't a code bug, but the greeting, test environment table, external
gist URLs, and git clone instructions belong below the "---" tearline rather
than in the permanent commit changelog.  Also, the claim that setns() on the
current namespace remains denied does not match the check_ns_type() change
below.

[ ... ]

> diff --git a/include/trace/events/landlock.h b/include/trace/events/landl=
ock.h
> index 09e90e4a9cd7b..ae385ffb3a360 100644
> --- a/include/trace/events/landlock.h
> +++ b/include/trace/events/landlock.h
> @@ -40,6 +40,7 @@ TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_FS_ACCESS);
>  TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_NET_ACCESS);
>  TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_NAMESPACE_CREATE);
>  TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_NAMESPACE_ENTER);
> +TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_NAMESPACE_ACQUIRE);
>  TRACE_DEFINE_ENUM(LANDLOCK_REQUEST_CAPABILITY);
> =20
>  #ifdef CREATE_TRACE_POINTS
> @@ -993,8 +994,8 @@ TRACE_EVENT(landlock_deny_access_net,
>   * @namespace_id: Namespace ID, not directly visible from user space when
>   *                creation was denied.
>   *
> - * Emitted when a Landlock domain denies namespace creation or entry.  T=
he
> - * namespace_op field distinguishes these operations.
> + * Emitted when a Landlock domain denies namespace creation, entry, or fd
> + * acquisition. The namespace_op field distinguishes these operations.
>   */
>  TRACE_EVENT(landlock_deny_permission_namespace,
> =20
> @@ -1028,14 +1029,17 @@ TRACE_EVENT(landlock_deny_permission_namespace,
>  	TP_printk("domain=3D%llx same_exec=3D%d logged=3D%d blockers=3D%s names=
pace_op=3D%s namespace_type=3D0x%x namespace_id=3D%llu",
>  		  __entry->domain_id, __entry->same_exec, __entry->logged,
>  		  (__entry->blockers_type =3D=3D LANDLOCK_REQUEST_NAMESPACE_CREATE ||
> -		   __entry->blockers_type =3D=3D LANDLOCK_REQUEST_NAMESPACE_ENTER) ?
> +		   __entry->blockers_type =3D=3D LANDLOCK_REQUEST_NAMESPACE_ENTER ||
> +		   __entry->blockers_type =3D=3D LANDLOCK_REQUEST_NAMESPACE_ACQUIRE) ?
>  			  __print_flags(__entry->blockers_access, "|",
>  					_LANDLOCK_PERMISSION_BLOCKER_NAMES) :
>  			  "unknown",
>  		  __entry->blockers_type =3D=3D LANDLOCK_REQUEST_NAMESPACE_CREATE ?
>  			  "create" :
>  		  __entry->blockers_type =3D=3D LANDLOCK_REQUEST_NAMESPACE_ENTER ?
> -			  "enter" : "unknown",
> +			  "enter" :
> +		  __entry->blockers_type =3D=3D LANDLOCK_REQUEST_NAMESPACE_ACQUIRE ?
> +			  "acquire" : "unknown",
>  		  __entry->namespace_type, __entry->namespace_id)
>  );

[Severity: Low]
Should REGEX_DENY_PERMISSION_NAMESPACE in
tools/testing/selftests/landlock/trace.h, along with
Documentation/admin-guide/LSM/landlock.rst,
Documentation/trace/events-landlock.rst, and the
LANDLOCK_PERMISSION_NAMESPACE_USE comment in include/uapi/linux/landlock.h,
also be updated for the new namespace_op=3Dacquire value?  As is,
REGEX_DENY_PERMISSION_NAMESPACE only matches "create" or "enter" and will
fail to match acquire denial trace events.

[ ... ]

> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 2ab67bcad1983..97b30fbffa48e 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c

[ ... ]

> @@ -1861,6 +1864,14 @@ static int hook_file_open(struct file *const file)
>  	const struct landlock_cred_security *const subject =3D
>  		landlock_get_applicable_subject(file->f_cred, any_fs, NULL);
>  	struct landlock_request request =3D {};
> +	int err;
> +
> +	if (proc_ns_file(file)) {
> +		err =3D landlock_check_namespace_fd(file->f_cred,
> +						  get_proc_ns(file_inode(file)));
> +		if (err)
> +			return err;
> +	}
> =20
>  	if (!subject)
>  		return 0;

[Severity: Medium]
Should hook_file_open() run landlock_check_namespace_fd() only after the
filesystem path access check succeeds?

When an nsfs file is bind-mounted into the filesystem (for example under
/run/netns/<name>) at a path where the domain denies
LANDLOCK_ACCESS_FS_READ_FILE, running landlock_check_namespace_fd() first
causes open() to fail with -EPERM instead of -EACCES and emits a
namespace_op=3Dacquire audit and trace denial exposing the target namespace=
's
ns_type and ns_id from a path the task was not allowed to access.

[ ... ]

> diff --git a/security/landlock/ns.c b/security/landlock/ns.c
> index 3d443599b16f4..1ef41ac4f977b 100644
> --- a/security/landlock/ns.c
> +++ b/security/landlock/ns.c
> @@ -89,25 +89,28 @@ static const struct access_masks ns_permission =3D {
>  /**
>   * check_ns_type - Check namespace use permission
>   *
> - * @ns: The namespace being allocated or installed.
> + * @ns: The namespace being created, installed, or opened.
> + * @cred: Credentials whose Landlock domain is checked.
>   * @request_type: Namespace operation reported on denial.
>   *
> - * Shared check for namespace_init (creation via clone(2), unshare(2),
> - * open_tree(2), or fsmount(2)) and namespace_install (use via setns(2))=
: denies
> - * when the namespace type is not in the domain's allowed set.  At alloc=
ation
> - * time @ns->ns_id is already set even though the namespace is not reach=
able
> - * from user space yet.
> + * Shared check for namespace creation, installation, and nsfs file open=
ing.
> + * Namespaces in which the current task is already a member remain acces=
sible.
> + * At allocation time @ns->ns_id is already set even though the namespac=
e is
> + * not reachable from user space yet.
>   *
>   * Return: 0 if allowed, -EPERM if denied.
>   */
>  static int check_ns_type(struct ns_common *const ns,
> +			 const struct cred *const cred,
>  			 const enum landlock_request_type request_type)
>  {
>  	const struct landlock_cred_security *subject;
>  	size_t denied_layer;
> =20
> -	subject =3D landlock_get_applicable_subject(current_cred(), ns_permissi=
on,
> -						  NULL);
> +	if (is_current_namespace(ns))
> +		return 0;
> +
> +	subject =3D landlock_get_applicable_subject(cred, ns_permission, NULL);
>  	if (!subject)
>  		return 0;
> =20
> @@ -132,13 +135,20 @@ static int check_ns_type(struct ns_common *const ns,
> =20
>  static int hook_namespace_init(struct ns_common *const ns)
>  {
> -	return check_ns_type(ns, current_cred(),
> -			     LANDLOCK_REQUEST_NAMESPACE_CREATE);
>  }
> =20
>  static int hook_namespace_install(const struct nsset *const nsset,
>  				  struct ns_common *const ns)
>  {
> -	return check_ns_type(ns, current_cred(),
> -			     LANDLOCK_REQUEST_NAMESPACE_ENTER);
>  }
> =20
> +int landlock_check_namespace_fd(const struct cred *cred, struct ns_commo=
n *ns)
> +{
> +	return check_ns_type(ns, cred, LANDLOCK_REQUEST_NAMESPACE_ACQUIRE);
> +}

[Severity: High]
Doesn't placing the is_current_namespace(ns) check inside check_ns_type()
also exempt hook_namespace_install() when setns(2) targets a namespace the
task is already in?

Re-entering the current namespace via setns(2) is not a no-op (for example,
mntns_install() resets fs->pwd and fs->root to the mount namespace root),
and the setns denial and audit/trace tests in
tools/testing/selftests/landlock/ns_test.c open /proc/self/ns/<type> and
expect setns(2) to fail with EPERM.  Scoping is_current_namespace(ns) to
landlock_check_namespace_fd() (after checking
landlock_get_applicable_subject() so unsandboxed tasks avoid the check)
would preserve setns(2) enforcement.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179566442733.199376=
1.8053687674090289362@163.com?part=3D1
