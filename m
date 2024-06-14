Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035852837A
	for <linux-security-module@vger.kernel.org>; Fri, 14 Jun 2024 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377736; cv=none; b=FUYCIgkNbEU5ZJPilm0SlzxfUG9LeLYGsFMfx3du0WbWGG0G42sBVWYDI+hrnGDzh9K4wdaSmaP5FWduzkUP5A4sWE6l11pQzR9QkjN2H8+OAeC6AbPTILIFmtDmnnx/m4/cWTf+vxTB40/Yja7h9wHH34XjQ6NW2y1YFJNBVGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377736; c=relaxed/simple;
	bh=HrDFMm3wKTp0UO86+kI8aHZ3XDSGQ+2b7UCsc2lJ5RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hz69UymWTDk1sgPYDn0Hf1+8f2O5EOYcYM3iIN+vsu7WCz4OcIB1JeNKY7iaLO6Gxe4m6ttEpwJNmKridpEOoy1WFcZtusNcR75vsm4jJNDxYjO5csoH7kiuO1w6zDafbSSTruda/rojBg0CDE6oCb5A3V7CBgdwP4d8lVe7zoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ElG3alYV; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ElG3alYV"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6fa11ac8695so1231772a34.3
        for <linux-security-module@vger.kernel.org>; Fri, 14 Jun 2024 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718377733; x=1718982533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=so5U+szNbhr5bnxSQqrZZ3bBxHi8XinDGxihgq18GlU=;
        b=ElG3alYVenfyC60oeKAQUBdtwT+VkJo6fF/6P1CcBLrjWqFpF7ibdC/RPMGWxRype4
         wBY4AWisfWXxbN/jWxq2CSeia32mKcOOSRY/gGz2XdzYNsmfnh9z4Rb6xpOeTnsNicg8
         ODgsdBUGXuYYBXwVz6ccg0CG63X6AuRuW9OvR1dpErtmYJB0IF4qFhCKzRcsqKRsbXsb
         vTDBBCur+7jOH+/gel7Ochi3Hw7OXPMcFTO6zZc8Css8AvgLmTYadppy++y4AcUCxskE
         SnSF8tu6h7JFwQcF/Hn+rhLR2gMrbtzEfTLTH7HXg7Knh7FAKModOc/hfmjYFPRbpnOv
         W0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718377733; x=1718982533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=so5U+szNbhr5bnxSQqrZZ3bBxHi8XinDGxihgq18GlU=;
        b=lM4laYMstsAOLkpoToL7NGnjBbJawCHjfGX21r5AUrmMwpigvom6KBU0Jx13j7F3W0
         Yi9O+1VxCeBxwQe3kSvdtHaNnRnwfyWLAlP1SCvF2WeRYdLAL6T5ZbpJaqbUiM7d9hz8
         KKmZjqGeMUxKRZSxh80yAJTyiShLj6DkbbdaM18ZJxtPXB2nU3TDs0Dc98v+SUcmANGI
         V3CqILHLmkC0f85iurngvRGPXBkZ7ghND0sLMptFwASxuJoY3Mt1rKgPNtd6b/co+6c8
         R0/4CEddOi5QMBlJztoILk/wcIwA+D9leOs8si2Nvge5ObwcxVNp0U1rxsqlewexAo4d
         3r9g==
X-Forwarded-Encrypted: i=1; AJvYcCUOq1URf+jrbwPwEiIK4WY5cvgbM/RWek04lWuvNtzCq5ATvSq3mAfJ0ebEgR+ol6nfhE/S0Zv5yrq/+XScDPQ02s6FelLK/+xMN8zVPg3phjNbblay
X-Gm-Message-State: AOJu0YxrSvTNTWsduGC4jaAGZy+cnemBk4Keda6U/gvqZR6bDpyoNIYe
	uY64yWy0F4AU6AaRSFZaUfPVV08P2x5Eq6AkufXPVKDmw7Gazi4JRIJeGL51MFFtg08hmCB+EC5
	PBYfFaNwguxhVHd/NgpsJ1HuHMLot6u1Rc9Kc
X-Google-Smtp-Source: AGHT+IFwLI89Z0cObJU/BB4y3EADZgT0NPGQP8yPvcIcc70tnoYEV1Wzk2snZ+CT8t98W5JCjs0/zjJ2FHkRh1NIJcU=
X-Received: by 2002:a05:6808:170b:b0:3d2:2b43:1804 with SMTP id
 5614622812f47-3d24e8e108bmr3360579b6e.19.1718377732934; Fri, 14 Jun 2024
 08:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607160753.1787105-1-omosnace@redhat.com> <171834962895.31068.8051988032320283876.git-patchwork-notify@kernel.org>
In-Reply-To: <171834962895.31068.8051988032320283876.git-patchwork-notify@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 14 Jun 2024 11:08:41 -0400
Message-ID: <CAHC9VhSRUW5hQNmXUGt2zd8hQUFB0wuXh=yZqAzH7t+erzqRKQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] cipso: make cipso_v4_skbuff_delattr() fully remove
 the CIPSO options
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	patchwork-bot+netdevbpf@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 3:20=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This series was applied to netdev/net.git (main)
> by David S. Miller <davem@davemloft.net>:

Welp, that was premature based on the testing requests in the other
thread, but what's done is done.

Ondrej, please accelerate the testing if possible as this patchset now
in the netdev tree and it would be good to know if it need a fix or
reverting before the next merge window.

> On Fri,  7 Jun 2024 18:07:51 +0200 you wrote:
> > This series aims to improve cipso_v4_skbuff_delattr() to fully
> > remove the CIPSO options instead of just clearing them with NOPs.
> > That is implemented in the second patch, while the first patch is
> > a bugfix for cipso_v4_delopt() that the second patch depends on.
> >
> > Tested using selinux-testsuite a TMT/Beakerlib test from this PR:
> > https://src.fedoraproject.org/tests/selinux/pull-request/488
> >
> > [...]
>
> Here is the summary with links:
>   - [v2,1/2] cipso: fix total option length computation
>     https://git.kernel.org/netdev/net/c/9f3616991233
>   - [v2,2/2] cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO=
 options
>     (no matching commit)
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

--=20
paul-moore.com
