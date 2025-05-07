Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3061DE2DE;
	Wed,  7 May 2025 03:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746587784; cv=none; b=fVDuuoYcSyrV0ycmbubiGkaz/rES4u4faDXxcb89MsV/AvAqWTdYEqJwKhr2uYInZUvmFWx3i+/vBxIrbyHlYGdHYX2UjgxmvcLTEGDXxMW6yNAV3gI5C/R5xvFVH4cUsL6iB/r5l8XSgSnCbXT+8PhSzYvhLAX4aavWU4PTtz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746587784; c=relaxed/simple;
	bh=32WlCO71OjiYT2aoyhlntKR9ovKyf9vnH96JdQigswI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dsf25ugwTspw74u8aiVEbPRT5FLtX6ixhenFTPTMwRNgSqdQF3VcX8bSmHZICoAXBDmvTX2/ymqHESmLg9czFFI4DOY2Kjm9hwN1G31Vg99U/9O9S+hqgQsf8CM105dqnMtgRJEhbfLSL+VViWxzlQWhljEuKcdeRSUbz+h+DIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1c4o8RZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1c4o8RZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB29C4CEF8;
	Wed,  7 May 2025 03:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746587783;
	bh=32WlCO71OjiYT2aoyhlntKR9ovKyf9vnH96JdQigswI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o1c4o8RZdJlLclWm5TxXkFl/BRqAbrNpGURmvXPllf0vZcQUGCX0LY5fxyALR7IDs
	 YER9d2Fb3NUDtZxWwQzNbnrlHLXdpULL79qSC1B2mIIQQv6xABU+cDOncIQZaOBifb
	 nMG2jeKOJAo2YHCCNlzhVhjvQowqW1nIi5mMuBve4ips9xg7tzy9+e0nNUM0MobN9d
	 6Vs9UkTTjfqJUQO/nmfma8Bno+xKLy3Tw66Iu9pMp0jcliiDl6K8psYmQUJ60HWtla
	 GxziLenaLcc/51dVL7imu2cPX7jgFsZ0JWHhZrPEL9TzDXKAfRDx8rbBTiYbgwuXTo
	 mO+9Nk9FOmAEQ==
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-af548cb1f83so6132264a12.3;
        Tue, 06 May 2025 20:16:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWTV+HTlOfWnZ0E+jGcpdJo8A9G9BRCW3Qr77+8tK2bFMEBhtfQjoprX4RP5zhXwj587OfyvnW+kec14roP42KYZnu3OaJB@vger.kernel.org, AJvYcCXgBpJ/VkQUJu6nr1jDyrJFYTscKw7EAI8995foa79BzzkuivQnXFH+YSfnVsVzG9f35zh9H3G00APwaAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcHeDxvtu3rNkd0vCPjx03FKvBmgBMtmdaF0so+vEOt0B5/7Z9
	jdjP8jrPbjnODg8zRZ3Gvi6m2vnPVcUf0V5w7XZy6YLrWfqlohpOz4trbpi6xrrl5mrgp62Fjsd
	Ek7jpS9llZUFPJz1Un1yI0GQMVqI=
X-Google-Smtp-Source: AGHT+IEXC3Vsr2Rgr65O8kyUpKpYF3B44exSqyI1j/ooaXaFLZkr4cb5MPWzkviMbzeR3GEzlF8cg3G6JIm6ZI+Fz0U=
X-Received: by 2002:a17:90a:ec8c:b0:2ee:f687:6acb with SMTP id
 98e67ed59e1d1-30aac1947a5mr3125622a91.13.1746587783328; Tue, 06 May 2025
 20:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <20250309151907.GA178120@mail.hallyn.com> <CAKPOu+_vTuZqsBLfRH+kyphiWAtRfWq=nKAcAYu=Wn2JBAkkYg@mail.gmail.com>
 <20250506132158.GA682102@mail.hallyn.com> <CAKPOu+9JCLVpJ-g_0WwLm5oy=9sq=c9rmoAJD6kNatpMZbbw9w@mail.gmail.com>
In-Reply-To: <CAKPOu+9JCLVpJ-g_0WwLm5oy=9sq=c9rmoAJD6kNatpMZbbw9w@mail.gmail.com>
From: "Andrew G. Morgan" <morgan@kernel.org>
Date: Tue, 6 May 2025 20:16:12 -0700
X-Gmail-Original-Message-ID: <CACmP8U+aLY7wmEqdb=a_tpDCY5LaPGb46DU+jSD3bCXX=JUAuA@mail.gmail.com>
X-Gm-Features: ATxdqUFmZ2s_ZlLLimKgjcARTYd5C_qFYoCyepjYfWpeDu4uUNFd_ukk0NjhmpY
Message-ID: <CACmP8U+aLY7wmEqdb=a_tpDCY5LaPGb46DU+jSD3bCXX=JUAuA@mail.gmail.com>
Subject: Re: [PATCH] security/commoncap: don't assume "setid" if all ids are identical
To: Max Kellermann <max.kellermann@ionos.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Andy Lutomirski <luto@kernel.org>, paul@paul-moore.com, 
	jmorris@namei.org, kees@kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 7:51=E2=80=AFAM Max Kellermann <max.kellermann@ionos=
.com> wrote:
> To me, the current implementation looks weird and buggy (but that's
> just my opinion). The code figures that that it's a set-id exec when
> effective!=3Dreal, which is indeed how set-id execution looks like, but
> still that check is slightly off:
>
> 1. it's really only set-id when new!=3Dold; checking real!=3Deffective is
> conceptually the wrong angle
> 2. there may be other reasons why real!=3Deffective
>
> My patch is an attempt to fix this in an unintrusive way, by not
> rewriting it but adding another check to rule out some special case.
> If I were to rewrite this from scratch, I'd do it differently (only
> compare new!=3Dold), but I don't want to mess too much with security
> code that I'm not very familiar with. I believe the guy who initially
> wrote it made wrong assumptions, but maybe I'm just wrong, I'm not the
> expert here.
>
> > Note also that so far I'm only asking about the intent of the patch.
>
> In a shared webhosting environment, we want to run an Apache (or
> nginx) in each website's container. If the website owner does "chmod
> 600", the Apache should not be able to read the file; but PHP
> processes spawned by the Apache should have full access. Therefore, we
> run Apache with a different fsuid; when Apache executes PHP, the fsuid
> is reverted.

[...]

> > Apart from that, I do think the implementation is wrong, because you
> > are impacting non-NO_NEW_PRIVS behavior as well, such as calculation
> > of cap_permitted and the clearing of ambient capabilities.
>
> You are right, it affects all three code blocks that are checking
> "is_setid", but why do you believe it's wrong?
> I can move the new check to the bottom, covering only the
> "secureexec=3D1" line, if that worries you.

If a setuid program execs itself, does the presence of this code undo
any protection the kernel afforded it on its first invocation? It
feels like changing that could easily turn out to be exploitable in
some context. Programs re-exec themselves all the time.

> > And, I'm not sure the has_identical_uids_gids() is quite right, as I'm
> > not sure what the bprm->cred->fsuid and suid make sense, though the
> > process's fsuid and suid of course need to be checked.
>
> Sorry, I don't get that. What do you mean?

I suspect Serge is noting that s*id and f*uid are forced to be the
corresponding e*id later in the code (indeed you mention this feature
above where I've put [...]), so comparing the values before that takes
effect isn't really comparing the right values in your added code.

FWIW I ran the libcap quicktest.sh script against your change and it
doesn't break any capability thing I test for when making libcap
releases. That being said, in general this whole zoo of *[ug]id values
and their subtle behavior is not casually obvious. I'd recommend using
a userspace workaround for your use case, and not changing the legacy
behavior of the kernel.

Cheers

Andrew
