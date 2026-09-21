Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D6C51B199
	for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2026 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028988; cv=none; b=l2LZlCJFN90WrMBUSy13tGFui3R9iTcT2VhCs3+AvWefnIeiFYPDjgdJO+Dwa5qx49QTp/1Ub5EI7Zu2axpkNvT0Gv2LGN+eulN87Fc5nzUJ9zkuFfISe5+YVk36QIJRLluPcU0Gp5ClUjQdP05bMOSg6nr9m6N/N/HGy77Jyzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028988; c=relaxed/simple;
	bh=/gSyyWwrZOQWCwMOMHVdDspza+0pmK+D/tKjm+seXps=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oDARk9rB0X7XuLpFNKJbpOGZ1ktv3ZGJTgJs5T5RZHtRtQnIebgdmnwlcsth2lKvPPcrKOqbcWPrOW67r7l7da9g/Nr/i+Yp3Kqogd7a03eI6UlmhxQDCKPjtcJrlu6J5zeaU08k6JD1RbYeBn+1pLSBazn7Gmt1DvXrfmZDW9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSbbrF9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSbbrF9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EAE1F000FF
	for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2026 22:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790028987;
	bh=pQ8fc35ktjlxRKNjMwkpUD5oQUQftAUYJhaaCJsgtvI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=XSbbrF9x1Dc6asa9mSYKODaSeqDscM2TNdTkWw2grJm36ZHbC3sN5ARbbcBCnuvXJ
	 PB/whty2mVTMdhqVD1eCxpdk/lazUFwGX5LEVMU4b7s1I5/O+wP1OT39dbl0kYC70v
	 4H9AU9L07HX1vWyvrFbhQbU2J0VN2HcyLZJUuzADypQ929kZaEaZaxgfos1RHrZvgW
	 5TYl9SSuIEMiuodkN5kFyKgAYuVk/nw9W8AeBPYI6bEJQxLoWwwT08l1QfZEOWuFoi
	 msnkJGD1ZK9/+nQMP/fTB8RytMyqf3SgAJ5RLG4o/8LrJeAOAcp1L2lwLT+AjkjllK
	 d9ZwziyPy9ZHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dm-verity: clear LSM integrity state on suspend
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260921220516.121589-1-wufan@kernel.org>
References: <20260921220516.121589-1-wufan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 22:16:26 +0000
Message-Id: <20260921221626.D2EAE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] dm-verity: clearing LSM state on suspend breaks IPE for cached fil=
es
- [High] ipe: Use-After-Free in evaluate_dmv_roothash() due to missing RCU
--

commit 0a1a0f42158da1707e32f8b9739a8420e73985d1
Author: Fan Wu <wufan@kernel.org>

dm-verity: clear LSM integrity state on suspend

This commit updates dm-verity to clear the published root hash and signature
state from the LSM security blob during verity_postsuspend(). This prevents
the block device from retaining stale attributes if the verity target is
replaced with a different target type.

> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index cb105ccc47ecb..6d589867623c0 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c

[ ... ]

> @@ -1779,8 +1781,31 @@ static int verity_preresume(struct dm_target *ti)
>  	return r;
>  }
> =20
> +static void verity_security_clear_integrity(struct dm_target *ti)
> +{
> +	struct block_device *bdev =3D dm_disk(dm_table_get_md(ti->table))->part=
0;
> +
> +	security_bdev_setintegrity(bdev, LSM_INT_DMVERITY_ROOTHASH, NULL, 0);

[Severity: High]
Does passing NULL to security_bdev_setintegrity() trigger a use-after-free
in IPE?

When this is called, ipe_bdev_setintegrity() appears to free the root hash
without RCU synchronization:

security/ipe/hooks.c:ipe_bdev_setintegrity() {
	if (!value) {
		ipe_digest_free(blob->root_hash);
		blob->root_hash =3D NULL;
...

If a concurrent thread is evaluating an mprotect or execve call, could it
dereference this freed memory in evaluate_dmv_roothash()?

security/ipe/eval.c:evaluate_dmv_roothash() {
	...
	ipe_digest_eval(p->value, ctx->ipe_bdev->root_hash);
...

> +	verity_security_clear_signature(bdev);
> +}
> +
> +#else
> +
> +static inline void verity_security_clear_integrity(struct dm_target *ti)
> +{
> +}
> +
>  #endif /* CONFIG_SECURITY */
> =20
> +static void verity_postsuspend(struct dm_target *ti)
> +{
> +	struct dm_verity *v =3D ti->private;
> +
> +	flush_workqueue(v->verify_wq);
> +	dm_bufio_client_reset(v->bufio);
> +	verity_security_clear_integrity(ti);

[Severity: High]
Does unconditionally clearing the integrity state on every table suspend br=
eak
IPE evaluation for already cached files?

During a temporary freeze or table reload, clearing the LSM integrity state
will cause concurrent VFS operations on already-cached files to see a clear=
ed
state. Will this result in spurious -EACCES failures since IPE will deny
access despite the files being valid?

> +}
> +
>  static struct target_type verity_target =3D {
>  	.name		=3D "verity",
>  /* Note: the LSMs depend on the singleton and immutable features */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921220516.1215=
89-1-wufan@kernel.org?part=3D1
