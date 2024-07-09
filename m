Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FBE15B57D
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jul 2024 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536695; cv=none; b=KlprOKXr5K1tALgDa2VCPWJC82YG95grJv9Ai/W8ViCWt8ZnD0lZE0Nj5tca8mbZtRVbfhPL4FgYtw6u4S+jyQsXgqJIOc1mV57nnnj9rIJIlgvCUAPmeg/ufbniWQA802BgBfyRuRSf/PZX+WXSnP1JjVY15yCSdrC7EetZt80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536695; c=relaxed/simple;
	bh=UVpvvv5hcYG8IH0FzAYJgDALiwcVm6EMz7HdnduQllU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sad+nDKEE3f8cIz6167sOxQKfF2jaiZO6gC9baKUflB7wGlXPRksOmtBbJNI6jy8lLNIpjl2FTFQD0V34LHlqC/O3jUROsElbJKxYfiIrRbuCZVj9jD68JpYpKUJKTDY/gF/pWYlP0TGh5rh5qAJpXmZNG3h98OJem0ze1/3fRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bE80LEc0; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bE80LEc0"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e0361c767ddso5008918276.1
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jul 2024 07:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720536693; x=1721141493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2cIr3JLhxqqtsJCxEtam/aozkG3wv5prUSPsfUfDOk=;
        b=bE80LEc0qkt4DIuq0C0YoqXTkc4K0kk9sm/dxaOTKaR8d/j78WLTyP6QAOPT6YS8pd
         GFjU6NSit7ZHKRRrr1lX/nSDNjEqnjy3RiOvmSxEIaIFtZLSJ+mcUNbt2EHby6LTVaEq
         43hIEToLjAgAMV/qFdDDZ3SpQ2K2I6W3+pgwYAc3vSPKFbjVrSF4AMtCM6fEaUuQyjM/
         p5hu/5hFsgJmTlHrfco3EFSjCGodC87gkZ2d7NTzECynCw4SvpO7Kf175a6jnTBikAep
         nFp4ux1TI3NQLau0cSK0usx0r+stLh5Wp7YedO6hZ1M3XM5veRCOWcfHRham1uiB0+yu
         n+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720536693; x=1721141493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2cIr3JLhxqqtsJCxEtam/aozkG3wv5prUSPsfUfDOk=;
        b=Hz9bv6CTd6kyKLaC9+7FepSB1xEs/sKj0UFSKG0DT0EDTRtGQIPdib+mgVxx8xgUpC
         vqsDReZ1BWN6L4yX3HDui544szyDti2qwPBWj7Tmzw1vNapaSTrPZy8yJXhIsWL/DPU0
         eGtO2xL2ju0nU8bjn9TK6sSZ46bTlCskj8TsnDHzP/owELV8JoukoA4XLeMbQjgOLgh7
         q0blj/rLmhccvRSpAMWyJ8pqozBt6LVFEdzmiymwrOJvT/xsycf+hfGjjovi7MlLOc9Q
         jVKh41ng1GgLj4zroewwjSEHwfMQSWB11xNBdYQ2PXVQgc5rv4nxH2sFnP5xVY2WaiIk
         NA1w==
X-Gm-Message-State: AOJu0YyNN7YxLGyBtO+1ucKHN6ilNHfqWoxGrjxdrME5E6STEV7v8sW1
	uIcMoCP3NBPplrrdLynf/F0Ew5HobtblIWClmteDiP8Q/zXE7pZzekq9aFOOE4QowDvHWe6Wi+c
	InFuuAeHXleFkXqj1azVtJ8Inxt+luSrQleNq
X-Google-Smtp-Source: AGHT+IG2FdoxZPzV+YqmBDtPFwV2kV8zsMsNY2H/39Lmek9L5lLQSS6rMDUZt6mnCu3uhTMZi25NRsoJXHcx1P6zDPQ=
X-Received: by 2002:a81:b663:0:b0:61d:fcf7:b79a with SMTP id
 00721157ae682-658ee79043emr30907067b3.11.1720536692759; Tue, 09 Jul 2024
 07:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629084331.3807368-5-kpsingh@kernel.org> <f40a3d1bc1cd69442f4524118c3e2956@paul-moore.com>
 <CACYkzJ4R-zG8=Xet4v-mf-Dmi_V9cHL7f0EiOEKhnPDxwsqx1Q@mail.gmail.com>
In-Reply-To: <CACYkzJ4R-zG8=Xet4v-mf-Dmi_V9cHL7f0EiOEKhnPDxwsqx1Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Jul 2024 10:51:21 -0400
Message-ID: <CAHC9VhSH+JkgxHccKBb-11o0QRjOHjB2T0q8tSGw7M7CxQyWhQ@mail.gmail.com>
Subject: Re: [PATCH v13 4/5] security: Update non standard hooks to use static calls
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 8:36=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote:
> > > --- a/security/security.c
> > > +++ b/security/security.c

...

> > > -#define lsm_for_each_hook(scall, NAME)                              =
         \
> > > -     for (scall =3D static_calls_table.NAME;                        =
   \
> > > -          scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++) =
 \
> > > -             if (static_key_enabled(&scall->active->key))
> > > +/*
> > > + * Can be used in the context passed to lsm_for_each_hook to get the=
 lsmid of the
> > > + * current hook
> > > + */
> > > +#define current_lsmid() _hook_lsmid
> >
> > See my comments below about security_getselfattr(), I think we can drop
> > the current_lsmid() macro.  If we really must keep it, we need to renam=
e
> > it to something else as it clashes too much with the other current_XXX(=
)
> > macros/functions which are useful outside of our wacky macros.
>
> call_hook_with_lsmid is a pattern used by quite a few hooks, happy to
> update the name.
>
> What do you think about __security_hook_lsm_id().

I guess we can't get rid of it due to the crazy macro stuff with loop
unrolling, BEFORE/AFTER blocks, etc.  Ooof.  If you were looking for
another example of why I don't really like these patches, this would
be a good candidate.

More below ...

> > I know I was the one who asked to implement the static_calls for *all*
> > of the LSM functions - thank you for doing that - but I think we can
> > all agree that some of the resulting code is pretty awful.  I'm probabl=
y
> > missing something important, but would an apporach similar to the pseud=
o
> > code below work?
>
> This does not work.
>
> The special macro you are defining does not have the static_call
> invocation and if you add that bit it's basically the __CALL_HOOK
> macro or __CALL_STATIC_INT, __CALL_STATIC_VOID macro inlined
> everywhere, I tried implementing it but it gets very dirty.

Thanks for testing it out.  Perhaps trying to move all of these hooks
to use the static_call approach was a mistake.  I realize you're doing
your best adapting the static_call API to support multiple LSMs, but
it just doesn't look like a good fit to me for the "unconventional"
hooks here in this patch.

> > I think we may need to admit defeat with security_getselfattr() and
> > leave it as-is, the above is just too ugly to live.  I'd suggest
> > adding a comment explaining that it wasn't converted due to complexity
> > and the resulting awfulness.
>
> I think your position on fixing everything is actually a valid one for
> security, which is why I did not contest it.
>
> The security_getselfattr is called very close to the syscall boundary
> and the closer to the boundary the call is, the greater control the
> attacker has over arguments and the easier it is to mount the attack.
> This is why LSM indirect calls are a lucrative target because they
> happen fairly early in the transition from user to kernel.
> security_getselfattr is literally just in a SYSCALL_DEFINE

I recognize that your comments are in reference to that last flaw
rooted in the hardware that used indirect calls at an attack vector,
but wasn't that resolved through other means?  I never saw the PoC or
had time to follow up on whatever mitigation was ultimately merged (if
any).  However, my understanding is that the move to static_calls is
not strictly necessary to patch over that particular hardware flaw, it
is just a we-really-want-this for either a performance or a
non-specific security reason; pick your favorite  of the two based on
your audience.

Regardless, since none of the previous suggestions/options proved to
be workable, I'm going to suggest we just kill this patch too and move
forward with the others.  I had hoped we could get the changes in this
patch cleaned up, but it doesn't look like that is going to be the
case, or at least not within a week or two, so let's drop it and we
can always reconsider this in the future if a cleaner implementation
is presented.

--=20
paul-moore.com
