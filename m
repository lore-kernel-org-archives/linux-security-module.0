Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F97383AE
	for <linux-security-module@vger.kernel.org>; Sat, 29 Jun 2024 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719648822; cv=none; b=X2OF8TvT/p/NjdQrN7u8zlgeGmCyxZvz1HCN/oj4Z/2uY7EhyTI9usLOflPKyN035EWYB0DX8h86+2KsWYL1OLiU0dkjv6BwSRTHqRoOjQkstm0zjZcCaC+2WGNwNTNQOcxU5Rutq+5UgFaTRmSGNNNzIE0qD3FWXoHLvJhjDCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719648822; c=relaxed/simple;
	bh=1jCxBGpGU81pgWUcqGkfoa7KPlglGQP+hudgOhGyxMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWr5UNV/7vUIYtMa3wEcTNEWclqEI02SmONU2KCCLJrhjAW+2HDLGr41DHfkC9HsI0b3kSVsccHnL7vvezBapwcph7pA1RyQg82p9nxNDIQHRhBiWGVq4WMpaaHbEPfbIr+rkpb3wShIGokjmhdVYrKq8q8NeCVfTh9yzoN3OUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrnnakOo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrnnakOo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D08C4AF10
	for <linux-security-module@vger.kernel.org>; Sat, 29 Jun 2024 08:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719648822;
	bh=1jCxBGpGU81pgWUcqGkfoa7KPlglGQP+hudgOhGyxMU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BrnnakOog8cY2pUp3eI5/C1xpcnPRqoKInlAoI1mSfyxVc2vjeC0Pmt+lsiFra6qh
	 zh0pmas3Nx0gWvyXOahBJvkgUCj2TIzzj0vrA+XIomgD9f81NOaK6WSyqLispTcTYT
	 wSxEr5d1ZgMgqRp7vT68A82SviQuw0zrAuW8xfe5xe8KcseJ2inzbaKK/yT/a2EZS6
	 mkeIKb0D9VCq8nybmLNeWnf9A4WTUYmjOYvO8YyK6eqpRIBRViAvAzP5dejmuH/rYf
	 IRztt6Ke7ZsKy7WFIQdXizbha+IAZ+FqLUl5P3py9/UiAlE7ndx+h1SS820yfDb5Rj
	 acgdo6saT0pxQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ec3f875e68so14221931fa.0
        for <linux-security-module@vger.kernel.org>; Sat, 29 Jun 2024 01:13:41 -0700 (PDT)
X-Gm-Message-State: AOJu0YzrPKYCX/lqbdvIyDivM6NLe7QFPrD0Co6O/XHu9Ks//RvoCyob
	ietH9DNwIZYAu3+ULxiGB/SghPnbW7buK1c4PjUJ/VPs/Nrkvdvb5HEMP/fFz+eKEF+0ouRYpF1
	JJfTsjSj5xYl8djG3HA1JWH/Phk4ABTA7bYV/
X-Google-Smtp-Source: AGHT+IHguEG8pekqrd8aD21X4p8y8aI6Zbl7rkO8tvm6/5jukDtiKlDeUF4IjB+Y2FdE+SAmd4DYms5X9scCYyo99MU=
X-Received: by 2002:a2e:300e:0:b0:2ec:92ad:19ad with SMTP id
 38308e7fff4ca-2ee5e34575fmr3271671fa.7.1719648820189; Sat, 29 Jun 2024
 01:13:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516003524.143243-6-kpsingh@kernel.org> <03c6f35485d622d8121fa0d7a7e3d0b2@paul-moore.com>
In-Reply-To: <03c6f35485d622d8121fa0d7a7e3d0b2@paul-moore.com>
From: KP Singh <kpsingh@kernel.org>
Date: Sat, 29 Jun 2024 13:43:28 +0530
X-Gmail-Original-Message-ID: <CACYkzJ6hBdk0MEW+4-U3zprEY4a_JcOLYj0wFEz1KW2gBDDE_Q@mail.gmail.com>
Message-ID: <CACYkzJ6hBdk0MEW+4-U3zprEY4a_JcOLYj0wFEz1KW2gBDDE_Q@mail.gmail.com>
Subject: Re: [PATCH v12 5/5] bpf: Only enable BPF LSM hooks when an LSM
 program is attached
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 6:35=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On May 15, 2024 KP Singh <kpsingh@kernel.org> wrote:
> >
> >

[...]

> > +/**
> > + * security_toggle_hook - Toggle the state of the LSM hook.
> > + * @hook_addr: The address of the hook to be toggled.
> > + * @state: Whether to enable for disable the hook.
> > + *
> > + * Returns 0 on success, -EINVAL if the address is not found.
> > + */
> > +int security_toggle_hook(void *hook_addr, bool state)
> > +{
> > +     struct lsm_static_call *scalls =3D ((void *)&static_calls_table);
>
> GCC (v14.1.1 if that matters) is complaining about casting randomized
> structs.  Looking quickly at the two structs, lsm_static_call and
> lsm_static_calls_table, I suspect the cast is harmless even if the
> randstruct case, but I would like to see some sort of fix for this so
> I don't get spammed by GCC every time I do a build.  On the other hand,
> if this cast really is a problem in the randstruct case we obviously
> need to fix that.
>

The cast is not a problem with rand struct, we are iterating through a
2 dimensional array and it does not matter in which order we iterate
the first dimension.

diff --git a/security/security.c b/security/security.c
index 2ee880b3a39a..4cc0e368d07f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -899,23 +899,24 @@ int lsm_fill_user_ctx(struct lsm_ctx __user
*uctx, u32 *uctx_len,
  */
 int security_toggle_hook(void *hook_addr, bool state)
 {
-       struct lsm_static_call *scalls =3D ((void *)&static_calls_table);
+       struct lsm_static_call *scall;
+       void *scalls_table =3D ((void *)&static_calls_table);
        unsigned long num_entries =3D
                (sizeof(static_calls_table) / sizeof(struct lsm_static_call=
));
        int i;

        for (i =3D 0; i < num_entries; i++) {
-
-               if (!scalls[i].hl || !scalls[i].hl->runtime)
+               scall =3D scalls_table + (i * sizeof(struct lsm_static_call=
));
+               if (!scall->hl || !scall->hl->runtime)
                        continue;

-               if (scalls[i].hl->hook.lsm_func_addr !=3D hook_addr)
+               if (scall->hl->hook.lsm_func_addr !=3D hook_addr)
                        continue;

                if (state)
-                       static_branch_enable(scalls[i].active);
+                       static_branch_enable(scall->active);
                else
-                       static_branch_disable(scalls[i].active);
+                       static_branch_disable(scall->active);
                return 0;
        }
        return -EINVAL;

fixes the error. I will respin.




> Either way, resolve this and make sure you test with GCC/randstruct
> enabled.
>
> > +     unsigned long num_entries =3D
> > +             (sizeof(static_calls_table) / sizeof(struct lsm_static_ca=
ll));
> > +     int i;
> > +
> > +     for (i =3D 0; i < num_entries; i++) {
> > +
> > +             if (!scalls[i].hl || !scalls[i].hl->runtime)
> > +                     continue;
> > +
> > +             if (scalls[i].hl->hook.lsm_func_addr !=3D hook_addr)
> > +                     continue;
> > +
> > +             if (state)
> > +                     static_branch_enable(scalls[i].active);
> > +             else
> > +                     static_branch_disable(scalls[i].active);
> > +             return 0;
> > +     }
> > +     return -EINVAL;
> > +}
> > +
> >  /*
> >   * The default value of the LSM hook is defined in linux/lsm_hook_defs=
.h and
> >   * can be accessed with:
> > --
> > 2.45.0.rc1.225.g2a3ae87e7f-goog
>
> --
> paul-moore.com
