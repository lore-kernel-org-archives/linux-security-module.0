Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF51713EFE5
	for <linux-security-module@vger.kernel.org>; Wed, 15 May 2024 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789323; cv=none; b=kgxKBO32HAtdV9n+2vnbgOZjRN1uD51u/OfZMmlqO5LV6BYDYkOSZBR5fcnSFrRGvAYnAxS29citJaRuusH88rQuwEFlzh7Mnw/AZMkkMI/WXX0ZDS63MrIrP2zcmvooTr55b5NDutfgpfhnxvgI/RlN+TCSoj76OFtezvX73UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789323; c=relaxed/simple;
	bh=zJgJiGahL8zQGBhnP/5IiZOVI2hcpOYN49/eIsUk3Io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4UEbnCfmumpHV9nYJScrmCGntbaZr79mpOJxPrsLhEaCvTD3yY/TEet34WjHZFw0NbEKRQYuWswmYAism1Quk8UEWM5EFbJK9i5yK0IMlWcMW9FkF0UHCyIL/fQwOj2w9CzekfTY5OebMaKJ5prUBlrKD3hOz1SRwlzvQDI6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNo5z3Sa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNo5z3Sa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B88C4AF0C
	for <linux-security-module@vger.kernel.org>; Wed, 15 May 2024 16:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715789322;
	bh=zJgJiGahL8zQGBhnP/5IiZOVI2hcpOYN49/eIsUk3Io=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aNo5z3SaW/yzrHEUJ7mjLu/PbUCaYxOYHlnpC5jWuKrPhRBAR+TUqeIVPWL/y0Aok
	 Au7SErcKsJccGaNLKh2I+owXhrVgS2w8/PF9A9udzzRj159Cn5IpKhfSt6BmwXcw1c
	 +dF7fUBijd3wa1qdv5WNSxFUjLJlTssjvoGmsDUjn9vRPgUNuB9odWTC8iW1ewuc2b
	 bmE2W77Eo01Ilh196DKA9e/XuuvSDqMalyicLt7EFG6N8isErK4mdEgXKY+RDnBtQH
	 EEDF7J5q5e+Y4tf4+u0+HzAsN/2DLjpyjgrH8t+HoS9TBKaGLsX6QLpCb5YhG7Grvb
	 2L+Ml1Lz9sG6Q==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-572b37afd73so2402980a12.2
        for <linux-security-module@vger.kernel.org>; Wed, 15 May 2024 09:08:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyBfW1HNVsMnHGe+ZD7oQ42WiZ1PRwkyksLzzD7sgZs4gKg4u5wffWhxYg7AgwRFetbHXvNrn/Q22RSr462z8Js04df8UwU1W02rmedSmY12WuHl98
X-Gm-Message-State: AOJu0Yy8syVQSkxJlqYu7xAI1q3Hgc2Qhv3JvsVFDOS2Q87bzYBYzwGX
	YJy1kV/+DgN5yNx1wwo6Uc5VRJnvYZ6/3V8/sVG2X25y+swGpQqEYpguZalWw+wqM1+OAgvF0BX
	yfWNXGF+tqDMGuPOxQNeM79JtJLFeT++xxjQY
X-Google-Smtp-Source: AGHT+IGGvBZ5pt+6vWRPm/MoTKbes3Vgd9t6nMAtJhNhhHJ8oi7IBEiyq+wVoQtHqeDTIFsEBYjRIYb5g49LwNJ/g3A=
X-Received: by 2002:a50:a45e:0:b0:56e:99e:1fac with SMTP id
 4fb4d7f45d1cf-5734d6b0dffmr10240656a12.39.1715789320995; Wed, 15 May 2024
 09:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507221045.551537-1-kpsingh@kernel.org> <20240507221045.551537-6-kpsingh@kernel.org>
 <202405071653.2C761D80@keescook> <CAHC9VhTWB+zL-cqNGFOfW_LsPHp3=ddoHkjUTq+NoSj7BdRvmw@mail.gmail.com>
 <0E524496-74E4-4419-8FE5-7675BD1834C0@kernel.org> <CAHC9VhS6hckf+xzhPn9gNQfFDiQhiGyJuzGVNXB=ZAr=8Af37w@mail.gmail.com>
 <D58AC87E-E5AC-435D-8A06-F0FFB328FF35@kernel.org>
In-Reply-To: <D58AC87E-E5AC-435D-8A06-F0FFB328FF35@kernel.org>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 15 May 2024 10:08:30 -0600
X-Gmail-Original-Message-ID: <CACYkzJ4wH258JZMN4gqSs-BxU1QgeHMJ2U=bouYf+xLUW8+ttw@mail.gmail.com>
Message-ID: <CACYkzJ4wH258JZMN4gqSs-BxU1QgeHMJ2U=bouYf+xLUW8+ttw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 5/5] bpf: Only enable BPF LSM hooks when an
 LSM program is attached
To: Paul Moore <paul@paul-moore.com>
Cc: Kees Cook <keescook@chromium.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, jackmanb@google.com, renauld@google.com, 
	casey@schaufler-ca.com, song@kernel.org, revest@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 7:23=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote=
:
>
>
>
> > On 9 May 2024, at 16:24, Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Wed, May 8, 2024 at 3:00=E2=80=AFAM KP Singh <kpsingh@kernel.org> wr=
ote:
> >> One idea here is that only LSM hooks with default_state =3D false can =
be toggled.
> >>
> >> This would also any ROPs that try to abuse this function. Maybe we can=
 call "default_disabled" .toggleable (or dynamic)
> >>
> >> and change the corresponding LSM_INIT_TOGGLEABLE. Kees, Paul, this may=
 be a fair middle ground?
> >
> > Seems reasonable to me, although I think it's worth respinning to get
> > a proper look at it in context.  Some naming bikeshedding below ...
> >
> >> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> >> index 4bd1d47bb9dc..5c0918ed6b80 100644
> >> --- a/include/linux/lsm_hooks.h
> >> +++ b/include/linux/lsm_hooks.h
> >> @@ -117,7 +117,7 @@ struct security_hook_list {
> >>        struct lsm_static_call  *scalls;
> >>        union security_list_options     hook;
> >>        const struct lsm_id             *lsmid;
> >> -       bool                            default_enabled;
> >> +       bool                            toggleable;
> >> } __randomize_layout;
> >
> > How about inverting the boolean and using something like 'fixed'
> > instead of 'toggleable'?
> >
>
> I would prefer not changing the all the other LSM_HOOK_INIT calls as we c=
hange the default behaviour then. How about calling it "dynamic"
>
> LSM_HOOK_INIT_DYNAMIC and call the boolean dynamic
>

Paul, others, any preferences here?

- KP

> - KP
>
> > --
> > paul-moore.com
>
