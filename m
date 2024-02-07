Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBFB80050
	for <linux-security-module@vger.kernel.org>; Wed,  7 Feb 2024 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321678; cv=none; b=Kj9RO8ktfFOpZByURm7qQXKdV0YqYY+DK/rqWIaa0dvXyjYtmrj6kfVb3E8ap1z5OfRVQQmOPu+IEDKf7HmKQHlU27HgHxme9MoCADXKr/OvHSWTq/WQDysmQ1mSRj1SLnc4cIjvqZU8hTKR0ZzGRGrK5hG8rCQ+k9BQEzT+yGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321678; c=relaxed/simple;
	bh=tRFljhwMB4MgO3yaAsgqXOkez35UfRXvUgw0a7Rtm44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JkG84uYzk8yKJ4g5aJ5EEY1BwnIEJMq8smz7Ym7JET1p4prdDkC59EEikzgsOQp4j4NZJezESyaf4WsXWgwK86iU8Md2rrSfINvxhixcZH83QwwPzTT2tXkjBA6hQCOhhR6yPSOCkfz0vvhwvSf0y6+RuCYJ7HeV7EtCoay0v70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YeF10JYz; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YeF10JYz"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6e0fe3195so802744276.0
        for <linux-security-module@vger.kernel.org>; Wed, 07 Feb 2024 08:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707321675; x=1707926475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxtNW82JBl+/qv1Lfklex243MjNUyJXmyfgEwoYAhcA=;
        b=YeF10JYzzfnJq2ooJA/bx8bvFQbVVM4MFXMpTjUIhZxRdaDxN1XcfX3QXfc1turHFz
         4OAmaRelm0ulI65ayKuXfYa1vP/Y032a7DvaicaHjZumNNDzmqF5lFBSqhFpVOZKr7xz
         KspEwrTBJeiY370aIm2OLCdok74xosyrvDqkKE2dKmmy9/+VDT6XHpBAvDpJW3oOBJF9
         8c2k8Ba5IQZ2gbTmoeac76gFIKf5SNu1IQmDZycobLYzKSwrz9XdeS6T7c6Gq071qXtS
         A5KcQz4uuLx2f+m3k/PaGvIbijYgIneL0gYHxz87bNQYrJUIiR2bRZgn0zd/kLh+JpDO
         Pqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707321675; x=1707926475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxtNW82JBl+/qv1Lfklex243MjNUyJXmyfgEwoYAhcA=;
        b=l8Po2d05KjSHt9Bu4iOOtfZdbzpH3mVcqqTRTFmyNE6rsn5TJP4OnVwvvjPhQHi2af
         F8jwdup06F9pFOdUvW464CB8tqVK+rZzjlTFvau3nxgQ1+E4GR8TcE61UwueHbpZ2mSt
         4Ab6z6RZMEZjeX5ndBI32+54rc+z7b8HY21dgHw/eOhdRG34jNRDJuJ15rHoTfJQjukh
         5xkmpvFcL9Qm95wQs2RQkGnKa7dJWqgPVpp/SDY5ksMbgNdkvL8TpHirNPPhLf2Vr8LJ
         Z/uqkj2OCve32sr62RAE3wyeXBiDC9kfnyhUzV7+1k0sQHnxcT+az7bwbaQMJBFQlzw6
         kZ3w==
X-Gm-Message-State: AOJu0YyRtxpR2aOwk/UA71Jthgr6fy2/vTZPKSHFayxy7bBSgTDz7d1G
	kCYwzOFwxu/BBfDgeiaHkTKfgW6WQ0LMpytR0cUv81CVjBrvPB9LhjnawjxhmDGLZD62WaQWamH
	hnX+9moQaJidUVe5Qv2ukIIlf4Wt3Uk60CSy+
X-Google-Smtp-Source: AGHT+IGLRof03AeG7moUMh3bNmzc2buHmfvITsFlKH2vkSeVCiedBCdAJ9+91kZrNNYraEEDXJYoLrCGtWdtB8t3AEQ=
X-Received: by 2002:a25:ae93:0:b0:dc6:ff66:87a8 with SMTP id
 b19-20020a25ae93000000b00dc6ff6687a8mr5182541ybj.51.1707321674769; Wed, 07
 Feb 2024 08:01:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <894cc57c-d298-4b60-a67d-42c1a92d0b92@I-love.SAKURA.ne.jp>
 <ab82c3ffce9195b4ebc1a2de874fdfc1@paul-moore.com> <1138640a-162b-4ba0-ac40-69e039884034@I-love.SAKURA.ne.jp>
 <202402070631.7B39C4E8@keescook>
In-Reply-To: <202402070631.7B39C4E8@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Feb 2024 11:01:03 -0500
Message-ID: <CAHC9VhS1yHyzA-JuDLBQjyyZyh=sG3LxsQxB9T7janZH6sqwqw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] LSM: add security_execve_abort() hook
To: Kees Cook <keescook@chromium.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 9:34=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
> On Wed, Feb 07, 2024 at 08:10:55PM +0900, Tetsuo Handa wrote:
> > On 2024/02/07 9:00, Paul Moore wrote:
> > >> @@ -1223,6 +1223,17 @@ void security_bprm_committed_creds(const stru=
ct linux_binprm *bprm)
> > >>    call_void_hook(bprm_committed_creds, bprm);
> > >>  }
> > >>
> > >> +/**
> > >> + * security_execve_abort() - Notify that exec() has failed
> > >> + *
> > >> + * This hook is for undoing changes which cannot be discarded by
> > >> + * abort_creds().
> > >> + */
> > >> +void security_execve_abort(void)
> > >> +{
> > >> +  call_void_hook(execve_abort);
> > >> +}
> > >
> > > I don't have a problem with reinstating something like
> > > security_bprm_free(), but I don't like the name security_execve_abort=
(),
> > > especially given that it is being called from alloc_bprm() as well as
> > > all of the execve code.  At the risk of bikeshedding this, I'd be muc=
h
> > > happier if this hook were renamed to security_bprm_free() and the
> > > hook's description explained that this hook is called when a linux_bp=
rm
> > > instance is being destroyed, after the bprm creds have been released,
> > > and is intended to cleanup any internal LSM state associated with the
> > > linux_bprm instance.
> > >
> > > Are you okay with that?
> >
> > Hmm, that will bring us back to v1 of this series.
> >
> > v3 was based on Eric W. Biederman's suggestion
> >
> >   If you aren't going to change your design your new hook should be:
> >           security_execve_revert(current);
> >   Or maybe:
> >           security_execve_abort(current);
> >
> >   At least then it is based upon the reality that you plan to revert
> >   changes to current->security.  Saying anything about creds or bprm wh=
en
> >   you don't touch them, makes no sense at all.  Causing people to
> >   completely misunderstand what is going on, and making it more likely
> >   they will change the code in ways that will break TOMOYO.
> >
> > at https://lkml.kernel.org/r/8734ug9fbt.fsf@email.froward.int.ebiederm.=
org .
>
> Yeah, I'd agree with Eric on this: it's not about bprm freeing, it's
> catching the execve failure. I think the name is accurate -- it mirrors
> the abort_creds() call.

I'm sorry, but I would still much rather prefer security_bprm_free()
both to reflect the nature of the caller as well as to abstract away a
particular use case; this is also why I suggested a different hook
description for the function header block.

If you really want this to be focused on reverting the execvc changes
(I do agree with Eric about "revert" over "abort") then please move
this hook out of free_bprm() and into do_execveat_common() and
kernel_execve().

To quickly summarize, there are two paths forward that I believe are
acceptable from a LSM perspective, pick either one and send me an
updated patchset.

1. Rename the hook to security_bprm_free() and update the LSM hook
description as I mentioned earlier in this thread.

2. Rename the hook to security_execve_revert(), move it into the
execve related functions, and update the LSM hook description to
reflect that this hook is for reverting execve related changes to the
current task's internal LSM state beyond what is possible via the
credential hooks.

--=20
paul-moore.com
