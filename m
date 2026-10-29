Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312308;
	b=sEeT8zKigpWc8Lz/hrbVTG5mL5Lh4zsTIcLoLhJZCIpL3bNreLwAlxCRV2NSZ8/9rRPY
	 b6KoU04LSLTxOXqQo+9zff63IH77RCrJ4imX1hrUQGUBUX5dTPnES5w0B1OvFG0ay00Of
	 47PH/Csqryz2nxzAeZqjNfs2/OgAd5vpBUAZzXjJL+X3j15BUm4u7+gOhFFtbe0jCCeM/
	 BAAyfKjhjnRxoee7VeDVdpqo9TmdGeXMutmpZE6o6p2EEy5sPdp/hfRk3xMPDMETNVjxZ
	 17BWbGcucCG5bpHkyxphs8iCU7l4rxrmPdkslPIizGCL+zFemmM7NaOU28SC3dw7LDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312308;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HznpeWcXZGzquW9bOHw8Gll7fCKr4Vnh0PYtn7eevAQ=;
	b=I7m/3rcgBgKPdhcF60PcSybstfHxSj8qVQPqGnUlAF3THRdhIFuXXnIaNLU1DhYRFsgI
	 KA8W//Vd1JQkW+fKyoUTcXo1XMBY+ICLbnQr/IJTDLArduLbqtL4fV3BnDnxAST9/qNTO
	 PMoBHHiUGqHIxsTz8Oxfll5ZCrg5lzRQT6KRMnvIHknO0baw+Xnm9Dn64AHQehreal5vR
	 u7zejjQOZlirhpJOvI+kG1/+UwwQ1d6FHIbJXy9Wk9osuJmRpcoN5bs1DaLrn5bS5PVQ4
	 onag30odmUTd06IJcI51LAEyV445vGHHibXbbdN9wqb+mCeuzRqEnFk4SIszoJdaanw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZ8242SF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C58C606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 22:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZ8242SF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CB61F01816
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 22:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793312307;
	bh=HznpeWcXZGzquW9bOHw8Gll7fCKr4Vnh0PYtn7eevAQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hZ8242SF3g3n6wQz2aJApM8ZVFp3BhR3ACnsQLhj0EgrLq1M1ftHS59aZ/udt4kZo
	 oTSbEyHit6jGNBcomBtvP0uxZxXn6Bw3on7nUeUmk2DQon8XfjxODCsUiqLtFrnCOA
	 /VJBjxkKq/N9UYsUTHKgaHhkalaoMHZuorFb+cmu53po02Xz7MAoO8MNTCmgUlW7Cn
	 +pPOPEQsqNQNxRhBtwPFuyWz/wCEORvAevaTQvsBNhvW8frG88yBIj7HaliSj7mdGp
	 FsPIvhbPdEz60YNASSzSBv5St8MiXqKetIvTw2MWRwIpLQJb8uIox8ayjpwSwENDih
	 lMD08h2kUWoiQ==
Message-ID: <sashiko-outbox-190064@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] userns: allow restricting capability bounding set
 via clone3()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261028221705.3915340-4-halg@google.com>
References: <20261028221705.3915340-1-halg@google.com>
 <20261028221705.3915340-4-halg@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 22:18:26 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] fork: copy_clone_args_from_user() validates cap_bset outside fla=
g gate
--

commit ad8aaabe65c03fa30d8b9e523721be228b373956
Author: Hallgrimur H. Gunnarsson <halg@google.com>

userns: allow restricting capability bounding set via clone3()

This commit introduces the CLONE_NEWUSER_BSET flag and adds a cap_bset
field to struct clone_args (CLONE_ARGS_SIZE_VER3). When specified with
CLONE_NEWUSER during clone3(), the new user namespace's capability bounding
set is intersected with cap_bset.

> diff --git a/kernel/fork.c b/kernel/fork.c
> index c0f7520e754ab..a09f62cadeac1 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
[ ... ]
> @@ -2962,6 +2964,11 @@ static noinline int copy_clone_args_from_user(stru=
ct kernel_clone_args *kargs,
>  	    (args.cgroup > INT_MAX || usize < CLONE_ARGS_SIZE_VER2))
>  		return -EINVAL;
> =20
> +	if ((args.flags & CLONE_NEWUSER_BSET) && usize < CLONE_ARGS_SIZE_VER3)
> +		return -EINVAL;
> +	if (!(args.flags & CLONE_NEWUSER_BSET) && args.cap_bset)
> +		return -EINVAL;

[Severity: Medium]
Should copy_clone_args_from_user() in kernel/fork.c really reject a non-zero
args.cap_bset when CLONE_NEWUSER_BSET is not set in args.flags?

In include/uapi/linux/sched.h, cap_bset in struct clone_args is documented
as a flag-gated field:

 * @cap_bset:     If CLONE_NEWUSER_BSET is specified, this
 *                specifies the capability bounding set mask to
 *                apply to the new user namespace. Unknown
 *                capability bits (> CAP_LAST_CAP) are ignored.

Other flag-gated fields in struct clone_args (such as cgroup gated by
CLONE_INTO_CGROUP right above, or pidfd, child_tid, parent_tid, and tls) are
only validated and consumed when their corresponding flag is set, and
copy_creds() in kernel/cred.c only reads kargs->cap_bset when
CLONE_NEWUSER_BSET is present:

	if (clone_flags & CLONE_NEWUSER) {
		kernel_cap_t cap_bset =3D CAP_FULL_SET;

		if (clone_flags & CLONE_NEWUSER_BSET)
			cap_bset =3D (kernel_cap_t){ .val =3D kargs->cap_bset };

If userspace invokes sys_clone3() -> copy_clone_args_from_user() with
usize >=3D CLONE_ARGS_SIZE_VER3 and without CLONE_NEWUSER_BSET set, while
args.cap_bset is non-zero (for instance, when reusing a struct clone_args
buffer after clearing CLONE_NEWUSER_BSET or only initializing fields for the
flags being passed), won't this check cause the syscall to fail spuriously
with -EINVAL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028221705.3915=
340-1-halg@google.com?part=3D3
