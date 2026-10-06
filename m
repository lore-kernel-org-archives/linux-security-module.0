Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D4E236453;
	Tue,  6 Oct 2026 00:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791247038; cv=none; b=Gycz63rhqkgAuUdByvNd1P36cj0gRS4lZtz16Qv4h0v9HOAJ3ceZjJ+y4S7OaNfwb3VQD8AbhCZlb77Ow0P5sEmP6nAKjyPJ2JezZ1zpGBEFQQg0SSQMj6sf9/8GTW5mbxdgvLPLpej5VNmG72DdAEKgAZ4JSJriqMtXkiBo4sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791247038; c=relaxed/simple;
	bh=uUw1JIOppDaRCS0HTG7cIMFESo5yo54VA9C9QqVDt1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z4IOH3SBGrfBJMuybKyOcuUf/oZMRkhdAPIAH0orGk08lpwu3K0cANm35laMobI9UVE06L7s6T/MKMq1tuvHjd8Dig2tnZsKTn2vzmKc9VShNDw8azIphfiVHqo5QG/HGdoijByX82w2zvbx4znjTXk7trhFcjZ+H9Dfu6MzJFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2twnbAs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2twnbAs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7791F000FF;
	Tue,  6 Oct 2026 00:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791247037;
	bh=H4E3FCgcFyhEWXYNjkD9YwD+FHxrKaa045jiweF5Vd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f2twnbAsM+wPIMYSs/z7M2YwEB6UPJ5SpeP4Ds7jN9NOqa6gtwM3JDhhS+tRuu9aK
	 CVM8YVYzTqSb7Sx25R9xMHJIThVWShccXx5fTTloXRWS+QB/tk8xoaMwwyTn5CovNN
	 YChjJPvId+alXLcMZ7XgBcAqiV7SrxLuD5G8aG+qX2K2bVw31ZjpI3QXc/N5w3fRb9
	 8YrE2huzejWaY+tQhCBRYZau9fxIUkRJTHZCecf+KQGAlByvBiiOE1iKFh4GDCMFUs
	 eYJzJHL5L9ND6fMjyKkp7JM+X+Agw8TuOmDednoZIz40M5q1YqJGE2haNtkrvuZBRm
	 rp62Lcir9pcAQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 10/12] bpf: support "__uninit" iterator
 arguments in generic kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261006002020.2890858-11-utilityemal77@gmail.com>
References: <20261006002020.2890858-1-utilityemal77@gmail.com>
 <20261006002020.2890858-11-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 00:37:16 +0000
Message-Id: <20261006003716.CC7791F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: aliased __uninit and __iter arguments bypass verifier initi=
alization checks
--

commit e08b0892f34d46a76c048cb46111b4956bcddfe8
Author: Justin Suess <utilityemal77@gmail.com>

bpf: support "__uninit" iterator arguments in generic kfuncs

This commit allows generic kfuncs to initialize iterator arguments by
recognizing the __uninit suffix. It updates process_iter_arg() to treat
these marked arguments similarly to how bpf_iter_<type>_new() operates on
uninitialized iterator state.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 066c4b838b858..3294b2a431674 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -8363,8 +8386,16 @@ static int process_iter_arg(struct bpf_verifier_en=
v *env, struct bpf_reg_state *
>  	t =3D btf_type_by_id(meta->btf, btf_id);
>  	nr_slots =3D t->size / BPF_REG_SIZE;
> =20
> -	if (is_iter_new_kfunc(meta)) {
> -		/* bpf_iter_<type>_new() expects pointer to uninit iter state */
> +	/*
> +	 * Whether this argument is the iterator the call initializes, rather
> +	 * than an initialized one it operates on.
> +	 */
> +	init =3D is_iter_new_kfunc(meta) ||
> +	       is_kfunc_arg_iter_init(meta, arg,
> +				      &btf_params(meta->func_proto)[arg]);
> +
> +	if (init) {
> +		/* expects a pointer to uninit iter state */

[Severity: Medium]
Is there a risk of bypassing verifier initialization checks if a BPF program
passes aliased registers for these arguments?

When check_func_args() evaluates kfunc arguments sequentially, an __uninit
argument will set init to true here, and process_iter_arg() will immediately
mark the stack slots as initialized via mark_stack_slots_iter().

If a subsequent __iter argument to the same kfunc aliases those exact same
stack slots, its is_iter_reg_valid_init() check will incorrectly pass becau=
se
the previous argument just marked them as initialized. This could allow
uninitialized stack memory to be passed where an initialized iterator is
expected.

While this is mitigated in this patch series because the newly introduced
kfunc uses different BTF types for its iterators (causing the bypass to fail
strict BTF ID checks), does this structure need to be fixed to prevent futu=
re
issues when kfuncs use matching iterator types?

Should state modifications like mark_stack_slots_iter() be deferred until
all arguments are successfully validated, similar to how
ARG_PTR_TO_UNINIT_MEM is handled?

>  		if (!is_iter_reg_valid_uninit(env, reg, nr_slots)) {
>  			verbose(env, "expected uninitialized iter_%s as %s\n",
>  				iter_type_str(meta->btf, btf_id), reg_arg_name(env, argno));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006002020.2890=
858-1-utilityemal77@gmail.com?part=3D10
