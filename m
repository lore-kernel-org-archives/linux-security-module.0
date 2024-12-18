Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657A11F63EB
	for <linux-security-module@vger.kernel.org>; Wed, 18 Dec 2024 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734557515; cv=none; b=M5b9ZE1aozgW284H9uq+Hx1nFTtklxr5861k5VsYBJ7kbwJYT4ZcVRwRQJ8Oti2kQxoEXSt543fTj5GfTWOpd9tfgPfjbdvOJACMaV8mN8tzsmvqodm8nktnhjvcbfSdxBQSM8IjIEmBt8HBLzZDcEXxt/otkj8FshuNtd8foo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734557515; c=relaxed/simple;
	bh=SaoKEUZWkdHnHaD1cXDQ7o58skgw8VAikNl6ksvw504=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2153/6eJUHvrLOcSRdP1vueTSP0V609aSbiXt9W2bNtY9FCRuPUfvD0xhGawtWHMkNrzdnFMPOwwB6KRjQkF1V0QkVGAeTgARalFDGgGZkaqXQFFIPUrC4ktXC0Vh+c/p2NKNWxyu9EjmiPdt1d8m387PU8pGrryis3B7fIHVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bD0BCwgh; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bD0BCwgh"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e4419a47887so117582276.0
        for <linux-security-module@vger.kernel.org>; Wed, 18 Dec 2024 13:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734557512; x=1735162312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbb5HxOosSv4xHBBVCidgzEivDXQn/dRx15F72hAHmM=;
        b=bD0BCwghQfusC7fkrAGznbKEog9hh2a4DnROMaptszIujlar6w8zOXbm7untQxIMwD
         LJLleHonw0x3HREViO6ubsAu04SDPSQSPtZKaZvgeXmocshXiz6N6L0bi5S4xOexNCEp
         s9fTN/FH05rDvln6KRdWd3OyUrPfWRvnGHjKFT3A3J8/nWJtt3D+gRdn6u4m3wa52YTz
         46IrJM8xZ6cAyA+qfYM3qcFKjG1H29ZPpmATfOAbqgC34FjZo98zVa3QwobkwFA1ZjUy
         njkFo9M0OyVwdTNMPJKIWEV149QUF3bIyNScu/4ChI5/szl8R3YSSxg/gUbUifErGyEZ
         ohZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734557512; x=1735162312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbb5HxOosSv4xHBBVCidgzEivDXQn/dRx15F72hAHmM=;
        b=tZygxBKVl4abjB3H1l1GZ5EpNtT/LA4b5FxhVtv4hGeHEjM2oW2p2Tbk3cGtz4H10Q
         s+do3VDyJvsKVXZO9g1wQ7ra3v+/jTVVlVH15FaMyK7ISr17j58YzkDMhVAgoHLg4wWt
         3Q+Y58+mLFG3g075tjauUZztdROods+FQo0kqEJxnBO2y58D32gYpuRLEr3Ov3wqLldX
         MHGRiAFmYMNX9ONNPCQZZgqAAUMP8Gyf+ZdkMSXM21ZrWtY1G4+t9C95wff9gGITYW/e
         u5OCn3DSB/fCliwWMPjxkPwlipDSPLFGdV1vcRP2OUetFaIh/l4UJW3n9aklV3PB6FEc
         fB1g==
X-Forwarded-Encrypted: i=1; AJvYcCXH37go2NqRBrk/oVpNKEEkO29+gySRxhTgNk92rC7Ygl1fARTUYv5TIaBQCfGX58bhdPM2AUD++hb+w34dEfaeG6TDOCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGSXheroCyCpbRmN52/drZzTqJoezKucBqOdLBUrPxk8CjXqLc
	rlYQoF123QYftMf/SvsoheKQ4Jo6R7XjHR7iiR3yz3IZz6acEnVVbY1cirEooczkQ6e/WyhfqN0
	+C6EtxoMsjxCdfPSTM2zhXvy3KpwqhZDna96v
X-Gm-Gg: ASbGnct5/IMwLpq56k+mUzvAZqndPMGP3Lr8S0XFMaANKl7TYwE6H9Fh2sppGBuFFUM
	dwh5lXOSsz+KZKEuwZNAk7mpNdNXW/ufw9KuT
X-Google-Smtp-Source: AGHT+IEjrEr9+v70o2geP95qlt0cRv1yOG9LXlkZULe3tUc67P40O378dVss/NWybbKjWzlLMOEhvIQZI5vAW9me90E=
X-Received: by 2002:a05:6902:1a43:b0:e2b:dbe5:851d with SMTP id
 3f1490d57ef6-e53621e7653mr4266621276.28.1734557512447; Wed, 18 Dec 2024
 13:31:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215165352.186692-1-linux@treblig.org>
In-Reply-To: <20241215165352.186692-1-linux@treblig.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Dec 2024 16:31:41 -0500
Message-ID: <CAHC9VhRyf8Jo54gnz2Nu17eHFOEqeXd3B5_HoXbz9uLYDba=HA@mail.gmail.com>
Subject: Re: [PATCH] capability: Remove unused has_capability
To: linux@treblig.org
Cc: serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 11:54=E2=80=AFAM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> The vanilla has_capability() function has been unused since 2018's
> commit dcb569cf6ac9 ("Smack: ptrace capability use fixes")
>
> Remove it.
>
> (There is still mention in a comment in security/commoncap.c
> but I suspect rather than removing the entry it might be better
> to expand the comment to talk about the other
> has_[ns_]capability[_noaudit] variants).

I would suggest that this patch would be an excellent place to change
that comment.  Without historical knowledge, the comment will be hard
to understand after this patch is merged as inspecting
has_capability() will be much more difficult, and including the
comment change with the function removal will bind the two changes
nicely in the git log.

Otherwise, this seems fine to me.

Reviewed-by: Paul Moore <paul@paul-moore.com>

> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  include/linux/capability.h |  5 -----
>  kernel/capability.c        | 16 ----------------
>  2 files changed, 21 deletions(-)
>
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index 0c356a517991..1fb08922552c 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -139,7 +139,6 @@ static inline kernel_cap_t cap_raise_nfsd_set(const k=
ernel_cap_t a,
>  }
>
>  #ifdef CONFIG_MULTIUSER
> -extern bool has_capability(struct task_struct *t, int cap);
>  extern bool has_ns_capability(struct task_struct *t,
>                               struct user_namespace *ns, int cap);
>  extern bool has_capability_noaudit(struct task_struct *t, int cap);
> @@ -150,10 +149,6 @@ extern bool ns_capable(struct user_namespace *ns, in=
t cap);
>  extern bool ns_capable_noaudit(struct user_namespace *ns, int cap);
>  extern bool ns_capable_setid(struct user_namespace *ns, int cap);
>  #else
> -static inline bool has_capability(struct task_struct *t, int cap)
> -{
> -       return true;
> -}
>  static inline bool has_ns_capability(struct task_struct *t,
>                               struct user_namespace *ns, int cap)
>  {
> diff --git a/kernel/capability.c b/kernel/capability.c
> index dac4df77e376..67094b628ea9 100644
> --- a/kernel/capability.c
> +++ b/kernel/capability.c
> @@ -289,22 +289,6 @@ bool has_ns_capability(struct task_struct *t,
>         return (ret =3D=3D 0);
>  }
>
> -/**
> - * has_capability - Does a task have a capability in init_user_ns
> - * @t: The task in question
> - * @cap: The capability to be tested for
> - *
> - * Return true if the specified task has the given superior capability
> - * currently in effect to the initial user namespace, false if not.
> - *
> - * Note that this does not set PF_SUPERPRIV on the task.
> - */
> -bool has_capability(struct task_struct *t, int cap)
> -{
> -       return has_ns_capability(t, &init_user_ns, cap);
> -}
> -EXPORT_SYMBOL(has_capability);
> -
>  /**
>   * has_ns_capability_noaudit - Does a task have a capability (unaudited)
>   * in a specific user ns.
> --
> 2.47.1

--=20
paul-moore.com
