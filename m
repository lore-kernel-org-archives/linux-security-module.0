Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03481A2C2C
	for <linux-security-module@vger.kernel.org>; Wed,  8 May 2024 01:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715132722; cv=none; b=IgQdhIiHhzCd8ordaxYA/KiPRvef6Ov9TqTASWhxbSbG9ZJloZjjpTBJMdewdgXWqVda/U6G+wNTv8zl9ywCcbHJ8/wwK1LB9kBcB2G1Gb54+TRVcmJlLCd26cRZQ3niBBmuu/9KIOfVdgKzba+InBIaRSAclRpRbESq0lj8PYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715132722; c=relaxed/simple;
	bh=R5J5D9ZKuWmZzGFNECx87GIRuqKlti4xOZdHT8yGlp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1HAsSMGqTBTU5nku4gaCfbWyxzJRG499r1AX0+O+APQsISkrOjt4y7XH6COkCpHTtwVOXypbHciSkv6Oz04XKTKYTh0UmoepcRWLIUB9xv4c7sQ1gQNZN7+3pTv6p6b7hOWYSC9JiVV7XWsGQrS2qwnL/eL1pMCuufNrYTGW+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fHcDMvKZ; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fHcDMvKZ"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de5a7b18acdso3712122276.3
        for <linux-security-module@vger.kernel.org>; Tue, 07 May 2024 18:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715132720; x=1715737520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrJsMoaRhbasokCymMtA8+yZNAppY6Qm/M+dgYp8KUs=;
        b=fHcDMvKZc3mm7/WVCyXEhUJIJE5pW8muV1yyC7SZjJStCSSi8w71nl+sn+EgJdl+a2
         qVjhrsK9iTpr74cAPfXRANc3KZ1H2SbJ/JgoC66ldCq4Ww03DOMkZPZ3pLphz5uDKTEL
         WjRHEo2uV+2CigBN7Z9GubPkvQ+lXfMGVYy9adhimVltQmbCg7SrYyK+h/gkC6YaKDsx
         NkNKTkx80gdx0sgMXiOURoBs4C7kPxMr6U7mk52A0uu9kvvcss/YfqR4hrxANrOzqnyK
         kwnhppm/gj69M217XJmRG9Jb6TjEmmqyiSzm0bMD3zgzRmoANJ8T+CeLZAazbeNZmbeK
         OC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715132720; x=1715737520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrJsMoaRhbasokCymMtA8+yZNAppY6Qm/M+dgYp8KUs=;
        b=fAWc99YJv4ymrlYCrsu+DOm3iQMZPKy5ffTIIFjWRzPf08C1kYOI27jSQN2uGo26uS
         IKn3wqQedy8tzASKLZ9aWnR19DRpGsRUjXUDI3bFZ1TG39m4L0BS6jWPhwjIHn8Zac1B
         tOiWIU5jTEC33nTNFYWBsmjpyTLMfFGMZSAmYGqgPtbqLxjrfgWFiVfHESU+4X7XZWwR
         0URCpuSWd6imxcF9as9LYBvPaKz56J5scrL6U4IBk6gs1SbMoDZLdto4HRX3Ucz4YlxI
         tTlPh6IBiGg50xtKaytVXPPHXe3gVF3ECZagtHqiCB/k8CK5vwaaWSPlMrSI++KVxDAf
         1jHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ4SdGP6mrilX14NiBrCIqIJbvXuoEo7jE8xr6qaLmqvqxZclBd5yF9XK+GVCjRH0OZSNRygdPGi3JL3PNJthz2tiTuzR0V3LB2R/SYgdCROHsRyYz
X-Gm-Message-State: AOJu0Yzd6C1Dxw09BOja7QYJY7m807+KW3Ofj4I8VolUKf94pLSYTWDB
	hSeyGa/axTX/0t+o6Wp+IIGvUdiKXLzMZ03OkPro1LBOhDEp7CC92p8UkgXcYyi2ZlsypUHo9/z
	vX0SdqyQE5h4kPXCBzX9c3im550RZXHZyb+ouq32MHE2TKxM=
X-Google-Smtp-Source: AGHT+IGjKeonlGN7lLPWOVHFC+5P9EL3SvbUl7WN4dyHUsZy0cawxGPRfPyPsIJFsTkfddSbIY4cRnWTJC4/C30kbkw=
X-Received: by 2002:a0d:ea92:0:b0:61b:2b7:27d8 with SMTP id
 00721157ae682-62085aa1ee8mr15117897b3.23.1715132719776; Tue, 07 May 2024
 18:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507221045.551537-1-kpsingh@kernel.org> <20240507221045.551537-6-kpsingh@kernel.org>
 <202405071653.2C761D80@keescook>
In-Reply-To: <202405071653.2C761D80@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 May 2024 21:45:09 -0400
Message-ID: <CAHC9VhTWB+zL-cqNGFOfW_LsPHp3=ddoHkjUTq+NoSj7BdRvmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 5/5] bpf: Only enable BPF LSM hooks when an
 LSM program is attached
To: Kees Cook <keescook@chromium.org>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	jackmanb@google.com, renauld@google.com, casey@schaufler-ca.com, 
	song@kernel.org, revest@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 8:01=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Wed, May 08, 2024 at 12:10:45AM +0200, KP Singh wrote:
> > [...]
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
> > +     unsigned long num_entries =3D
> > +             (sizeof(static_calls_table) / sizeof(struct lsm_static_ca=
ll));
> > +     int i;
> > +
> > +     for (i =3D 0; i < num_entries; i++) {
> > +             if (!scalls[i].hl)
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
>
> First of all: patches 1-4 are great. They have a measurable performance
> benefit; let's get those in.
>
> But here I come to patch 5 where I will suggest the exact opposite of
> what Paul said in v9 for patch 5. :P

For those looking up v9 of the patchset, you'll be looking for patch
*4*, not patch 5, as there were only four patches in the v9 series.
Patch 4/5 in the v10 series is a new addition to the stack.

Beyond that, I'm guessing you are referring to my comment regarding
bpf_lsm_toggle_hook() Kees?  The one that starts with "More ugh.  If
we are going to solve things this way ..."?

> I don't want to have a global function that can be used to disable LSMs.
> We got an entire distro (RedHat) to change their SELinux configurations
> to get rid of CONFIG_SECURITY_SELINUX_DISABLE (and therefore
> CONFIG_SECURITY_WRITABLE_HOOKS), via commit f22f9aaf6c3d ("selinux:
> remove the runtime disable functionality"). We cannot reintroduce that,
> and I'm hoping Paul will agree, given this reminder of LSM history. :)
>
> Run-time hook changing should be BPF_LSM specific, if it exists at all.

I don't want individual LSMs manipulating the LSM hook state directly;
they go through the LSM layer to register their hooks, they should go
through the LSM layer to unregister or enable/disable their hooks.
I'm going to be pretty inflexible on this point.

Honestly, I see this more as a problem in the BPF LSM design (although
one might argue it's an implementation issue?), just as I saw the
SELinux runtime disable as a problem.  If you're upset with the
runtime hook disable, and you should be, fix the BPF LSM, don't force
more bad architecture on the LSM layer.

--=20
paul-moore.com
