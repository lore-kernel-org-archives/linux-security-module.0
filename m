Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84362BAE2
	for <linux-security-module@vger.kernel.org>; Sat, 29 Jun 2024 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719649711; cv=none; b=EqqrBmduteXKnyBOc+dBrZriVt9rpqGS372OM/29ZW/WK9fwF0EXHtCVmctuIIR3p2VESGN0SVp0nJWCVLeP/83KALsnW5IJkcCUpQxSg8NOkrUFlCS0IJULf9F8LFeg5ppyICgrwcVbFz4GHvc/WrrAYXhxrTmXpGSze3sky6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719649711; c=relaxed/simple;
	bh=3BV09iRNsBIppNhQ1jz5ggeS/OiqFDNg3CudkJ0hswA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJ9meW5mS+he9qDZ+u7yzMiyLs1SNiEeXipnYzD9fp1XS9l9x01AN0DjqdKdDNLC53gXOWdIfWUC3B2cWscuw7X6TSlt+GpFkxS0Cl5F4UddfiOeQomtoEDoXHMq6+rZjluL2oCODyrugZw/DU2UIIBQA/CNuiXdm4Ej7bEyNKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goZN4ePF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goZN4ePF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59837C2BBFC
	for <linux-security-module@vger.kernel.org>; Sat, 29 Jun 2024 08:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719649711;
	bh=3BV09iRNsBIppNhQ1jz5ggeS/OiqFDNg3CudkJ0hswA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=goZN4ePF2mq7JLdUG+SaW5+MkyEzVVzoP08C5OjnkGfvM89WPXo8EVo8Rp0uxIkst
	 ys1z9OaKpo2mwoW09Lx2xQnCy+zOJQ8IPt05OmwAgYnedlfr2sWyPSerQEnpz9pBnR
	 KsoO+JN4CyU8Nkqjy7ESoIC9BNWMvjx+KsT69dtNzBs+gPMDcvZ9HjwlJNvHTwfHgv
	 znHG//pe1j3PJYiff9KquMFInG1f7uiZjLu92GMWcVNb3qSCGvpCvbdbvEV6VlimD4
	 715mGl+70p6kLXtvrQ1BC1WnTZactICJE9F4cyb/9BNMQIyZQ2o9PVz7TVQhKOBVCk
	 txZV3fLiO2Bfg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d07f07a27so1576728a12.3
        for <linux-security-module@vger.kernel.org>; Sat, 29 Jun 2024 01:28:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YySyTdHYmN2LBlV4FPSH0lPUZ59xdsLTAJNU5JZWrYrkcSEpEzG
	Gh8NuZ0xKmIvsHcdLX7EP1GoK9i+wZ6V/w5VP2K/MhmGPsfgiu1eOh991hL0dktcr2PmG8AjVAv
	jNFFBUj1ObhJcMuxvz5QSGiUJh79qTByIoAWy
X-Google-Smtp-Source: AGHT+IHuf9ASwxi/zJ6LSb5A5ELU3+VWQc+BvmG1mtZyq6FRFRz5aSPj/EFpd+yYzF0z+dos+8LBv+05hYM9I4W+g/w=
X-Received: by 2002:a05:6402:2554:b0:578:67db:7529 with SMTP id
 4fb4d7f45d1cf-5879eaff6e9mr334848a12.4.1719649709928; Sat, 29 Jun 2024
 01:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516003524.143243-1-kpsingh@kernel.org> <20240516003524.143243-4-kpsingh@kernel.org>
 <87ikxuuo4s.fsf@trenco.lwn.net>
In-Reply-To: <87ikxuuo4s.fsf@trenco.lwn.net>
From: KP Singh <kpsingh@kernel.org>
Date: Sat, 29 Jun 2024 13:58:18 +0530
X-Gmail-Original-Message-ID: <CACYkzJ7W2_zQuLQB_PTH8cbrt0xpm9X1if-+=EKRSVwhs2TnpA@mail.gmail.com>
Message-ID: <CACYkzJ7W2_zQuLQB_PTH8cbrt0xpm9X1if-+=EKRSVwhs2TnpA@mail.gmail.com>
Subject: Re: [PATCH v12 3/5] security: Replace indirect LSM hook calls with
 static calls
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, andrii@kernel.org, 
	keescook@chromium.org, daniel@iogearbox.net, renauld@google.com, 
	revest@chromium.org, song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 1:58=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> KP Singh <kpsingh@kernel.org> writes:
>
> > LSM hooks are currently invoked from a linked list as indirect calls
> > which are invoked using retpolines as a mitigation for speculative
> > attacks (Branch History / Target injection) and add extra overhead whic=
h
> > is especially bad in kernel hot paths:
>
> I hate to bug you with a changelog nit, but this is the sort of thing
> that might save others some work..
>
> [...]
>
> > A static key guards whether an LSM static call is enabled or not,
> > without this static key, for LSM hooks that return an int, the presence
> > of the hook that returns a default value can create side-effects which
> > has resulted in bugs [1].
>
> I looked in vain for [1] to see what these bugs were.  After sufficient
> digging, I found that the relevant URL:
>
>   https://lore.kernel.org/linux-security-module/20220609234601.2026362-1-=
kpsingh@kernel.org/
>

Thank you so much Jon, appreciate the attention to detail, I have
fixed it in v13.

- KP

> was evidently dropped in v4 of the patch set last September, and nobody
> evidently noticed.  If there's a v13, I might humbly suggest putting it
> back :)
>
> Thanks,
>
> jon
