Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068881A01BE;
	Mon, 25 Nov 2024 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732535320; cv=none; b=kJ0HuTVhdAB86eZNNzIXc/10upnHG4fdREnke76IIR4i/fsfIveCc6Dl6JfDcxJg3Z/FMQMRkmHR9eQciFZlvSQWMa0WWcLFPfYqzHa8C1SHu4sphnHobvOzkClEXlFYiYlLIpPVKIqp0qsEUJPknFCEoySb0pyTk63hrricbU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732535320; c=relaxed/simple;
	bh=AhyJjQBTjioYzgxJDPHVAqiDUJIeso9JI8kilmR9JSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amWXoDLnQNg/GvY0Q0UJZFOwZJsJLKH2/1ZB4IfgQtl8qasiIjAVkgIWy7kZcJ1h22l4IQ0k4g2h8ID66AEkCAvZ2378xFfCLm+2/J7+B4+bh4mdfWC14552SsPcDxKBST8GgV0PEqRu4M0g9p6A+p0oKGZUfVub8jnCkvft4v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=jTojhiyu; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jTojhiyu"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e3882273bc8so3926848276.1;
        Mon, 25 Nov 2024 03:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1732535318; x=1733140118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=476juWLLXH68WdEd6CCvoohOL74hVP8YdxJenm7T9uk=;
        b=jTojhiyu7vegKl28NqlUtELG8uB4Tn6YJdFWtWTt+kSfthukjF4QNGkpqlPpHqcUmn
         pWxu3/Ab6egj7GdI/cXysfF0Rm2//6nPLZO/o4/T+nl2ahj78p8Q+YOF5Bv6wjv9ifZj
         3IBU+aPukGrX6Z0aG1CG7itgYVISPr1rsifu13pSy7zcKLpbFWV6QeSFb1zZdxvWCWkW
         A4676UapBIZY7WN9ofhXKvQJRhujfIQgntEhGCrkq5kpvaSTnEpCslZrCjXrBoTgvfs+
         Hrh7+DcmFurle8cg4hybr0tyy5QNREG2FBYY9v6QsIQllHAUWj/jxk5jxKGv0sPZ9Rth
         LTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732535318; x=1733140118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=476juWLLXH68WdEd6CCvoohOL74hVP8YdxJenm7T9uk=;
        b=g9XMkdc9du1bdUfXoCQ8CFsjQ1GPV4lwYxzyVipsyxiNsK6TsqAZ5dbhuKw+PcySu/
         aQ68LXQTe6RnrvhfieffeaQCI8K9pseUumiotjsJ86F/vrh3RYBQgpP7FFsSwfXUbVbl
         EYvU0Zt+nxI23SvCgXnF/eW8UGCWJvToLX8J9Nq7h987y7SfudMzIHioq2zdSPy06NTo
         SGtMUaGedN0/glBx86RxOLMLu6EfAEP6eNfkv4he9OAj71h1zFOfkkARVLVkUR+mbGBS
         zk1DTuP81TGFOQX3e+p9ubxFb+jPnq/YzleJ7HgE9cpEBmSrb4ShcBiAgMSBwHKAtVdl
         4Jfw==
X-Forwarded-Encrypted: i=1; AJvYcCWBVnUctIsHsyQ3CD3+KLEZw8AZ0xicqNyrPRPoCHPse6vdIbiNnVIoEZyMtyTiLNk0NE+xU+O2VgW2zAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyROU7rlX4U8hJMCExULV0OfUF41jt8yz4hfywE+O81h5NLaonB
	CjqnJ3XfDRoltPXSOaal71T3OENVVCMUTdJHkCoJkO3C8cvu+2hPAqJRawch1vxtipR1N+T/mfw
	buPzeRgr1c7Rh7wDyxKQbnbU8mCs=
X-Gm-Gg: ASbGncus+HnKKncqbctxHVMT7vHQTTZXPWUTNqglcF00KmBIvEuFY8//gU/0ekZNZD6
	yVWFrGyhJ3085ipmqHb5w5b20K1z+yVku
X-Google-Smtp-Source: AGHT+IGYP2SKdODKsnDK/PfBnKLbQWqO3MML2UPkyylWYXOgHgp7Wt8KYifNK0fRtunrvJy8VyVVbVwzaUlM3QnofG0=
X-Received: by 2002:a05:6902:2084:b0:e38:ea81:d01e with SMTP id
 3f1490d57ef6-e38f8aca119mr9503432276.8.1732535317875; Mon, 25 Nov 2024
 03:48:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
 <20241125104011.36552-5-cgoettsche@seltendoof.de> <1045101183.70157813.1732534258584.JavaMail.zimbra@nod.at>
In-Reply-To: <1045101183.70157813.1732534258584.JavaMail.zimbra@nod.at>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 25 Nov 2024 12:48:27 +0100
Message-ID: <CAJ2a_Dd_sz2LYEEJJhiJE=JP81V4AvET=jgSyRe73eF-YjeXhg@mail.gmail.com>
Subject: Re: [PATCH 06/11] ubifs: reorder capability check last
To: Richard Weinberger <richard@nod.at>
Cc: LSM <linux-security-module@vger.kernel.org>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	chengzhihao1 <chengzhihao1@huawei.com>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	DRI mailing list <dri-devel@lists.freedesktop.org>, linux-mtd <linux-mtd@lists.infradead.org>, 
	cocci <cocci@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Nov 2024 at 12:31, Richard Weinberger <richard@nod.at> wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Christian G=C3=B6ttsche" <cgoettsche@seltendoof.de>
> > capable() calls refer to enabled LSMs whether to permit or deny the
> > request.  This is relevant in connection with SELinux, where a
> > capability check results in a policy decision and by default a denial
> > message on insufficient permission is issued.
> > It can lead to three undesired cases:
> >  1. A denial message is generated, even in case the operation was an
> >     unprivileged one and thus the syscall succeeded, creating noise.
> >  2. To avoid the noise from 1. the policy writer adds a rule to ignore
> >     those denial messages, hiding future syscalls, where the task
> >     performs an actual privileged operation, leading to hidden limited
> >     functionality of that task.
> >  3. To avoid the noise from 1. the policy writer adds a rule to permit
> >     the task the requested capability, while it does not need it,
> >     violating the principle of least privilege.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > drivers/gpu/drm/panthor/panthor_drv.c | 2 +-
>
> This change is unrelated, please remove it.

Sorry, somehow these two changes got erroneously combined in a single patch=
.
I'll send a v2 with them split into separate ones.

>
> > fs/ubifs/budget.c                     | 5 +++--
> > 2 files changed, 4 insertions(+), 3 deletions(-)
>
> [...]
>
> > diff --git a/fs/ubifs/budget.c b/fs/ubifs/budget.c
> > index d76eb7b39f56..6137aeadec3f 100644
> > --- a/fs/ubifs/budget.c
> > +++ b/fs/ubifs/budget.c
> > @@ -256,8 +256,9 @@ long long ubifs_calc_available(const struct ubifs_i=
nfo *c,
> > int min_idx_lebs)
> >  */
> > static int can_use_rp(struct ubifs_info *c)
> > {
> > -     if (uid_eq(current_fsuid(), c->rp_uid) || capable(CAP_SYS_RESOURC=
E) ||
> > -         (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)=
))
> > +     if (uid_eq(current_fsuid(), c->rp_uid) ||
> > +         (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)=
) ||
> > +         capable(CAP_SYS_RESOURCE))
> >               return 1;
> >       return 0;
> > }
>
> The UBIFS part looks ok:
>
> Acked-by: Richard Weinberger <richard@nod.at>
>
> Since I was not CC'ed to the whole series, I miss a lot of context.

The series consists of similar patches to other subsystems and a
coccinelle script addition.
See https://lore.kernel.org/linux-security-module/20241125104011.36552-11-c=
goettsche@seltendoof.de/#t

> Will this series merged as a whole? By whom?
>
> Thanks,
> //richard
