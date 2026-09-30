Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0F24EB845
	for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776556; cv=none; b=KpM9PrRSPYohO0Lf3rONjrVHuvE0563gzoWoUah7enlxgcZqcfOlThMA58gwI0mTE9OnLkV66/Rznp9XYQi3Gn3OglTafsQoGQ4BrNZcq4VAd4PpTZFs2tJjeDDcIW7uuFIgMegoFdqROwCOWhlIvD7lqTC6QrR9dDsLRbC5hCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776556; c=relaxed/simple;
	bh=o3vO+ROmAxUnv04mUEERF5aEsfgLpY8zBqHkHZYljM4=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bAHN/ptSXQrYK1VFEJnZyHmgUKi+9Cr6WNWEWLHH5rPBK5YRXksB94q1vbo24auYtVBvj984QJN4tIpq5mP3VoAuP1HnNEmXnxkPjNYHjNJ0h7+y5Prg5K925cfmg8lo81Ps2pip9gQWEcO7yjuEHS7SXMGatK2sCXrw8nOj3es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIqEUjjq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIqEUjjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B9A1F00893
	for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 13:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790776546;
	bh=8IUm4y/UqVertwcKbHpn5s+bbF7TcOrMA6JEK/crw/c=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=PIqEUjjqNu8V2DUMTnUCO3M39e5DOpQwJnRSUoQWNks9zr0wWCrA8dhTkyF+Ueac5
	 waSEVRvYBcx/c44oxitBTTs0StM4gyq6Krd19qNStDjPgB9nhtmB6sTPt6TpR3wn/2
	 P7IVKORyAzdNqxowXFi00ZiRELmuTopyyDdl7OIXStyVE2nb1uVepw1jX0z6Vqcdo7
	 jo69mrQFU1QwRQOrH7UHFAnVd5IrkvX3OxmSbj3zpncBx6hX1wAmMmP3Hhnv3qKOPL
	 XqoErKmzdK/5FCUt95Eyyrl5iYMWjgn82hmQg00hPs/6/QfpgLP3dqbLgw+4eNYvCL
	 hw+ACHkZrwjAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/3] virt: coco: introduce tsm_default_tm() and
 tsm_mr_read()/write()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260930-ima_tgx_integration_v2-v1-1-722c35370548@arm.com>
References: <20260930-ima_tgx_integration_v2-v1-0-722c35370548@arm.com>
 <20260930-ima_tgx_integration_v2-v1-1-722c35370548@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 13:55:46 +0000
Message-Id: <20260930135546.99B9A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] virt: coco: UAF in tsm_mr_read/write due to premature lock release
- [High] virt: coco: mutating const parameter causes page fault on rodata
--

commit 9580da40a9c2580df1ab20f035b99adff1efdc0d
Author: Yeoreum Yun <yeoreum.yun@arm.com>

virt: coco: introduce tsm_default_tm() and tsm_mr_read()/write()

This patch introduces new APIs to allow reading and extending TSM measureme=
nt
registers from IMA. It adds an IDR mechanism to track measurement contexts
so that IMA can retrieve and manipulate them using the new exported symbols.

> diff --git a/drivers/virt/coco/guest/tsm-mr.c b/drivers/virt/coco/guest/t=
sm-mr.c
> index 657b9c5739d0d..9e721348be8d3 100644
> --- a/drivers/virt/coco/guest/tsm-mr.c
> +++ b/drivers/virt/coco/guest/tsm-mr.c

[ ... ]

> @@ -230,6 +251,15 @@ tsm_mr_create_attribute_group(const struct tsm_measu=
rements *tm)
>  	ctx->agrp.name =3D "measurements";
>  	ctx->agrp.bin_attrs =3D no_free_ptr(attrs);
>  	ctx->tm =3D tm;
> +
> +	guard(mutex)(&idr_lock);
> +	((struct tsm_measurements *)tm)->ctx_id =3D idr_alloc(&tm_ctx_idr, ctx,=
 0,
> +							    TM_NUM_CTX, GFP_KERNEL);

[Severity: High]
Does casting away the const qualifier here cause a write protection violati=
on?

If a provider driver passes a struct tsm_measurements template that is
statically allocated in read-only memory (.rodata), this write to ctx_id
will trigger a kernel oops page fault.

> +	if (tm->ctx_id < 0) {
> +		kfree(ctx->agrp.bin_attrs);
> +		return ERR_PTR(tm->ctx_id);
> +	}
> +
>  	return &no_free_ptr(ctx)->agrp;
>  }

[ ... ]

> @@ -243,9 +273,90 @@ EXPORT_SYMBOL_GPL(tsm_mr_create_attribute_group);
>   */
>  void tsm_mr_free_attribute_group(const struct attribute_group *attr_grp)
>  {
> +	struct tm_context *ctx;
> +
>  	if (!IS_ERR_OR_NULL(attr_grp)) {
> +		ctx =3D container_of(attr_grp, struct tm_context, agrp);
> +		scoped_guard(mutex, &idr_lock)
> +			idr_remove(&tm_ctx_idr, ctx->tm->ctx_id);
>  		kfree(attr_grp->bin_attrs);
> -		kfree(container_of(attr_grp, struct tm_context, agrp));
> +		kfree(ctx);
>  	}
>  }

[ ... ]

> +int tsm_mr_read(const struct tsm_measurements *tm, int idx,
> +		u8 *digest, u32 digest_size)
> +{
> +	struct tm_context *ctx;
> +	const struct tsm_measurement_register *mr;
> +	int rc;
> +
> +	scoped_guard(mutex, &idr_lock)
> +		ctx =3D idr_find(&tm_ctx_idr, tm->ctx_id);
> +
> +	if (IS_ERR_OR_NULL(ctx))
> +		return -ENODEV;
> +
> +	if (!digest || (idx >=3D ctx->tm->nr_mrs) ||
> +	    (ctx->tm->mrs[idx].mr_size > digest_size) ||
> +	    !(ctx->tm->mrs[idx].mr_flags & TSM_MR_F_READABLE))
> +		return -EINVAL;
> +
> +	mr =3D &ctx->tm->mrs[idx];
> +
> +	rc =3D __tsm_mr_read(ctx, mr, (char *)digest, 0, mr->mr_size);

[Severity: High]
Can this result in a use-after-free if tsm_mr_free_attribute_group() runs
concurrently?

Since scoped_guard only applies to the single statement block (the idr_find
call), the idr_lock is released immediately afterward. If a concurrent devi=
ce
unbind triggers tsm_mr_free_attribute_group() before __tsm_mr_read()
completes, the context could be removed from the IDR and freed via kfree(ct=
x)
while this function is still dereferencing it for bounds checks and the read
operation.

> +	if (rc < 0)
> +		return rc;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tsm_mr_read);
> +
> +int tsm_mr_write(const struct tsm_measurements *tm, int idx,
> +		 u8 *digest, u32 digest_size)
> +{
> +	struct tm_context *ctx;
> +	const struct tsm_measurement_register *mr;
> +	int rc;
> +
> +	scoped_guard(mutex, &idr_lock)
> +		ctx =3D idr_find(&tm_ctx_idr, tm->ctx_id);
> +
> +	if (IS_ERR_OR_NULL(ctx))
> +		return -ENODEV;
> +
> +	if (!digest || (idx >=3D ctx->tm->nr_mrs) ||
> +	    !(ctx->tm->mrs[idx].mr_flags & TSM_MR_F_WRITABLE))
> +		return -EINVAL;
> +
> +	/* partial writes are not supported */
> +	if (ctx->tm->mrs[idx].mr_size !=3D digest_size)
> +		return -EINVAL;
> +
> +	mr =3D &ctx->tm->mrs[idx];
> +
> +	rc =3D __tsm_mr_write(ctx, mr, (char *)digest, mr->mr_size);

[Severity: High]
Does this suffer from the same concurrent use-after-free issue as
tsm_mr_read()?

The scoped_guard releases idr_lock right after idr_find(), leaving ctx
vulnerable to being freed by tsm_mr_free_attribute_group() before the write
completes.

> +	if (rc < 0)
> +		return rc;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-ima_tgx_in=
tegration_v2-v1-0-722c35370548@arm.com?part=3D1
