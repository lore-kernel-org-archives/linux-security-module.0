Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9B53B6359
	for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2026 23:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034928; cv=none; b=KAXFLX5xLp1xI11qQGytadUnXQ+JbsmvN+TL/CctF9CnxuGgBblLPOMgCPwb4PHtPuNX0rytGt/9K1IKIxas8uN9s2hE6fMuAewsrm1GspjJJoX4rZsiGJmLhDOBJ4F37tWQN5FSDSf2ju1eKj+SdT5JnGTJkH221CA0B2FFXeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034928; c=relaxed/simple;
	bh=uE6cvJCeUUt46qVoBXyfE9zMT/Jn6/GTUI1B1OkYTUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnfJsX+JdO/AjhCKfnpUk1Y4xPA8NgfUbom6YgsTJi6XXhT2oojQcqJQDdtqJfo51kFBhdP8y2rATTQeOIfXHbAduExIgb9pg9VNhWaFg5OhBflId0uwjcMXIcX7PGX8MP+58YbllKdFqyCqeID5lHBIy3onrCkZ4Uhg9Lqt6cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrY5lfUp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrY5lfUp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15A21F000FF
	for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2026 23:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790034927;
	bh=odcasyXpajK/bRBL1pCgrDLz+d+eBunFQXffgqZmUDg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KrY5lfUpEXXGumquRUYzC4qZ7kSmL1FqTcR82dt7LWYXdROX4/2GyuDkxL7DMCWJj
	 deIRrswoyIthZGJ1+YxwOtqRSzMe+vQR2WDuID1pC5DRgEJCquupMahfcckfLCdsBh
	 k12dMSnzWikvmBoz9ydjYSPvN3L61uh6l4+jnh0X1FVu4iSaiT+YoBJ9zLbWUU7GU9
	 DdzGt3rPAfVSNy+UCC0MdZkDczzPpBsWfKnUKcY4i25/FcuDEC8xlblZSp4H453gMm
	 Ws8CVqox1WuTItNqkWerddHiBojE3sm050OZ9WBwJ/GsGz1bNbS36JVjgAZ3LnUAk6
	 SbMH5FENZtFUg==
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd5cf03so3456396a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2026 16:55:26 -0700 (PDT)
X-Gm-Message-State: AFuF++mqqSdunnSt4rCjgDeLAe2+GQwmqSHmoBx+0BnLdWYbYyYBVpLQ
	IIZ2/nNotT7M6IHoJ6ZcFn9Nz3I5zdqYHynYsghcfNb/uRb1Uh6M/XtlKXtY8OLxgiaJEhmC7eM
	cDGEpVEniXFtyIWK8R+J3qVN7TymFaxA=
X-Received: by 2002:a17:90b:5287:b0:38e:7168:281 with SMTP id
 98e67ed59e1d1-39e54ce361emr18546713a91.10.1790034926666; Mon, 21 Sep 2026
 16:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921220516.121589-1-wufan@kernel.org> <20260921221626.D2EAE1F000FF@smtp.kernel.org>
In-Reply-To: <20260921221626.D2EAE1F000FF@smtp.kernel.org>
From: Fan Wu <wufan@kernel.org>
Date: Mon, 21 Sep 2026 16:55:14 -0700
X-Gmail-Original-Message-ID: <CAKtyLkGDT=T-EORXb-RXXQVX2C9=vNncqcEXUz8D7uCXn0M_Uw@mail.gmail.com>
X-Gm-Features: AcwNN1UNOrxQK0gNEAq3kAMoLMBWbD549LDDGl0pRIS2_NMuLG8sk-JPXtEJvhU
Message-ID: <CAKtyLkGDT=T-EORXb-RXXQVX2C9=vNncqcEXUz8D7uCXn0M_Uw@mail.gmail.com>
Subject: Re: [PATCH] dm-verity: clear LSM integrity state on suspend
To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 3:18=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] dm-verity: clearing LSM state on suspend breaks IPE for cached f=
iles
> - [High] ipe: Use-After-Free in evaluate_dmv_roothash() due to missing RC=
U
> --
>
> commit 0a1a0f42158da1707e32f8b9739a8420e73985d1
> Author: Fan Wu <wufan@kernel.org>
>
> dm-verity: clear LSM integrity state on suspend
>
> This commit updates dm-verity to clear the published root hash and signat=
ure
> state from the LSM security blob during verity_postsuspend(). This preven=
ts
> the block device from retaining stale attributes if the verity target is
> replaced with a different target type.
>
> > diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-targe=
t.c
> > index cb105ccc47ecb..6d589867623c0 100644
> > --- a/drivers/md/dm-verity-target.c
> > +++ b/drivers/md/dm-verity-target.c
>
> [ ... ]
>
> > @@ -1779,8 +1781,31 @@ static int verity_preresume(struct dm_target *ti=
)
> >       return r;
> >  }
> >
> > +static void verity_security_clear_integrity(struct dm_target *ti)
> > +{
> > +     struct block_device *bdev =3D dm_disk(dm_table_get_md(ti->table))=
->part0;
> > +
> > +     security_bdev_setintegrity(bdev, LSM_INT_DMVERITY_ROOTHASH, NULL,=
 0);
>
> [Severity: High]
> Does passing NULL to security_bdev_setintegrity() trigger a use-after-fre=
e
> in IPE?
>
> When this is called, ipe_bdev_setintegrity() appears to free the root has=
h
> without RCU synchronization:
>
> security/ipe/hooks.c:ipe_bdev_setintegrity() {
>         if (!value) {
>                 ipe_digest_free(blob->root_hash);
>                 blob->root_hash =3D NULL;
> ...
>
> If a concurrent thread is evaluating an mprotect or execve call, could it
> dereference this freed memory in evaluate_dmv_roothash()?
>
> security/ipe/eval.c:evaluate_dmv_roothash() {
>         ...
>         ipe_digest_eval(p->value, ctx->ipe_bdev->root_hash);
> ...
>

I will post an UAF fix for this, however this is an ipe issue so not
blocking this patch.

> > +     verity_security_clear_signature(bdev);
> > +}
> > +
> > +#else
> > +
> > +static inline void verity_security_clear_integrity(struct dm_target *t=
i)
> > +{
> > +}
> > +
> >  #endif /* CONFIG_SECURITY */
> >
> > +static void verity_postsuspend(struct dm_target *ti)
> > +{
> > +     struct dm_verity *v =3D ti->private;
> > +
> > +     flush_workqueue(v->verify_wq);
> > +     dm_bufio_client_reset(v->bufio);
> > +     verity_security_clear_integrity(ti);
>
> [Severity: High]
> Does unconditionally clearing the integrity state on every table suspend =
break
> IPE evaluation for already cached files?
>
> During a temporary freeze or table reload, clearing the LSM integrity sta=
te
> will cause concurrent VFS operations on already-cached files to see a cle=
ared
> state. Will this result in spurious -EACCES failures since IPE will deny
> access despite the files being valid?
>

This is the expected behavior. Tracking the verification status of
cached data is impractical.

The deny issue can also be avoided by creating a new dm device instead
of swapping tables.

-Fan
