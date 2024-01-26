Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916DE10A24
	for <linux-security-module@vger.kernel.org>; Fri, 26 Jan 2024 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279572; cv=none; b=UiNMkcZnCURYCLhGzOhpcP2Ta4iI7b4qXoyGBA5zKf1s/SFa1yLD1w3Sxju2deo4tbFrdkdDBtFJ9mnejBaZAU6LDg60NbMtxK6ePQKpZ+J7a31Rt7MX89D3EYivNLoOJS0BU+O3MtPkUtkM8Dsx/9+5WZJAMuJY1WPVtw5Ui3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279572; c=relaxed/simple;
	bh=6PPRZrNsmHDjZrpEUeko1khDonxHnwNEvcTO2stQCJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqnSpg4NJNxic/2c3JEdWvhTpLzeP43MIBTMW/PzDiEccKvOGgp/vhyy9perADoMbdza5bnUBzPZXIQvrtxPva+JqY/8h/gsHVeY7QcjXDsdGCsh6vWez12kEYRjk/9SH+O54KYB5qj5Mb4jiVKjjKh5dsMo1I7jxfm3dhpZACg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYzv4koy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYzv4koy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706279569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNabKwrVREWMEeA3kDjfDhpYf/5K6ftzVIbV9xAafXU=;
	b=LYzv4koyV+zSSIGz2qmCI7Yblu9CeGfEiVJoBvzJgLIvLfF0vNfzkS055RaTMTRJf1RzPM
	xMDFlcjne+DRngJxrxOQXMHudYimwvUK+MMYZwkQco9zPX3YVoQrql0P6+dTBa0MHOyMlB
	B4LePzwa/hN5gZCRulyjxAszYU2nyg4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-_H0fgQUqMpqNC-mdHqnhLQ-1; Fri, 26 Jan 2024 09:32:48 -0500
X-MC-Unique: _H0fgQUqMpqNC-mdHqnhLQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d741d9e527so1905995ad.1
        for <linux-security-module@vger.kernel.org>; Fri, 26 Jan 2024 06:32:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706279567; x=1706884367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNabKwrVREWMEeA3kDjfDhpYf/5K6ftzVIbV9xAafXU=;
        b=nUxf/ba3by8IQQfWntoAVd9svIkXEPJiAgeXHvWt750eOZp5KFkzcX5X/H6ClzdTsC
         w5ifY0u5IgBtBTrGLccsaOsqP6xiyrJPNL4NUxVrkh6SMDSLWUnoPkcE2vYYUTV4Ijyl
         s8mKxd+3b2eHIp/iz8CFHFuGGtq5A3ApwZ8eHYVuH9SpeHNgG/edaFp09qyG1/uwO9dm
         j/iFt7oai2TMjrikYVLNCSJOj1F1Q8eOutj4o+I5pkWo4DL7HDAIZq1VFVNGAtLE9SSl
         G5P8gn23/prL2BRz/MzWS+YetD8K5EiIpH6TK6yxi3wXGVYpf+s6tbdinFpb+bs3UiMd
         pY2A==
X-Gm-Message-State: AOJu0YxaALzwj3XEvPj21gLoQ52Wxs2Dr184yo9GKV98dr0NAat1GLE0
	ivQ4Tm1/HglfNrW50G16t/GvuU0OKDXU+U9mXDH8fzrXdUSf5UHCjGEDlFfMEJ7pVGOTRZ5wlxQ
	VFYV9xJoDiZlcpDhs2Mb3H4Sg3jntH1xOTVER8Bu1kAyGVyk9ljv5eHFpnPr3Lvx451D9bPfOaP
	iv39EyQq0/nWX1U5Vuw1lCyA63WGQoYylaMXPw8BZqheMCjBQA
X-Received: by 2002:a17:903:41ce:b0:1d7:443a:477 with SMTP id u14-20020a17090341ce00b001d7443a0477mr1214936ple.110.1706279567033;
        Fri, 26 Jan 2024 06:32:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7f4Ddg+xn8XLYOyK7hDipS3kgJ/vif8kdaOufGf3LfaAtLCgK7hIa5S+lsNU0lxppHuMQSJhQE5DupGukguE=
X-Received: by 2002:a17:903:41ce:b0:1d7:443a:477 with SMTP id
 u14-20020a17090341ce00b001d7443a0477mr1214925ple.110.1706279566705; Fri, 26
 Jan 2024 06:32:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126104403.1040692-1-omosnace@redhat.com>
In-Reply-To: <20240126104403.1040692-1-omosnace@redhat.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 26 Jan 2024 15:32:35 +0100
Message-ID: <CAFqZXNuK4m+CQFejWx6nWkoMFmDDzhDw7FZhFMbKZUQVQ3JeZA@mail.gmail.com>
Subject: Re: [PATCH] security: fix the logic in security_inode_getsecctx()
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 11:44=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
>
> The inode_getsecctx LSM hook has previously been corrected to have
> -EOPNOTSUPP instead of 0 as the default return value to fix BPF LSM
> behavior. However, the call_int_hook()-generated loop in
> security_inode_getsecctx() was left treating 0 as the neutral value, so
> after an LSM returns 0, the loop continues to try other LSMs, and if one
> of them returns a non-zero value, the function immediately returns with
> said value. So in a situation where SELinux and the BPF LSMs registered
> this hook, -EOPNOTSUPP would be incorrectly returned whenever SELinux
> returned 0.
>
> Fix this by open-coding the call_int_hook() loop and making it use the
> correct LSM_RET_DEFAULT() value as the neutral one, similar to what
> other hooks do.
>
> Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Link: https://lore.kernel.org/selinux/CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90j=
YPwRQRAqXxmOKD4Q@mail.gmail.com/

Actually, I should have also added:

Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2257983

Hopefully it can be added when applying if there isn't going to be a respin=
.

> Fixes: b36995b8609a ("lsm: fix default return value for inode_getsecctx")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> I ran 'tools/nfs.sh' on the patch and even though it fixes the most
> serious issue that Stephen reported, some of the tests are still
> failing under NFS (but I will presume that these are pre-existing issues
> not caused by the patch).
>
> I can also see an opportunity to clean up the hook implementations in
> security/security.c - I plan to have a go at it and send it as a
> separate patch later.
>
>  security/security.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/security/security.c b/security/security.c
> index 0144a98d3712..6196ccaba433 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4255,7 +4255,19 @@ EXPORT_SYMBOL(security_inode_setsecctx);
>   */
>  int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxle=
n)
>  {
> -       return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ct=
xlen);
> +       struct security_hook_list *hp;
> +       int rc;
> +
> +       /*
> +        * Only one module will provide a security context.
> +        */
> +       hlist_for_each_entry(hp, &security_hook_heads.inode_getsecctx, li=
st) {
> +               rc =3D hp->hook.inode_getsecctx(inode, ctx, ctxlen);
> +               if (rc !=3D LSM_RET_DEFAULT(inode_getsecctx))
> +                       return rc;
> +       }
> +
> +       return LSM_RET_DEFAULT(inode_getsecctx);
>  }
>  EXPORT_SYMBOL(security_inode_getsecctx);
>
> --
> 2.43.0
>


--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

