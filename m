Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5565330DD2F
	for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 01:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790732276; cv=pass; b=pkEAzOQaCthIyHV+EtgjVA8Ue/Hx0O0LCs2isBfYnmgQcJGNUUcJyCSY41hGegjpZECZH2qr0wLhf1U2OqR4OZrlYWjEQo1/KvyQdOQATJvoywT9cR3TUjzXqMnFde7RlgQ8MueP8QbNutJ1iTguVcBiiMPyZYhxyCjmKy+bkwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790732276; c=relaxed/simple;
	bh=bhJUcLjKo02bLvE25E0PNpH+ye50aBQvEKX0dR+Ok7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFzjyngsy4Ljs7O39lwpElAQuQiNBup1EZBK9kKFvoN55VQLqnWxvouDForyHcehb2fHi+GGkCI9QqCr2grDiNh9/Dyb4WZtGG1j80OSkCCkg/b9KNEiBP//6CFrToUmCX3crhrjghMj+7guGN0OHABlWQQoU4hIOB4JpFcNpD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I97lxwgR; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I97lxwgR"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d91ede8035so40650245ad.3
        for <linux-security-module@vger.kernel.org>; Tue, 29 Sep 2026 18:37:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790732271; cv=none;
        d=google.com; s=arc-20260327;
        b=cyZnXovXr0PbEqp4a3nZX+SgVQL49hLaAGO9r3TM62Pj4EFBPN4CDkfOWoTabKJNb6
         PUbbg3VqaOOPfoswcz3005mACvk/FVJhPL81X979cg/YpoujIg/hOwjBN3jni+Qw4IDt
         N0W+qq6w9B/Uk7LN7ieUCVAk0Mc5m7GcZbtgy8lO7stadpnBVTG1I5EkorDwm+F35A3w
         Pw/beQk8VTStY2L2WG0YnyKZ8x1wZF/9uB0tvX9NwPwRnlfYP9qhX00gWIZVo9FZWTWc
         k7buYHiHJsCEL8ZH+c2g/S9UeaAVcKL8q0QQPMDur/WFfWdjiVYEkw5Nn9GDJqfCvn67
         pjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OaTWYjGa88IT1G2tVr2iEi35Jf6xhHPNQWrE7gJBkU0=;
        fh=0vUip5oIZOXGu/H2pbjitYYElIlYRjnVswedhVzJeTc=;
        b=hBfqYYE4XZy3o29+iEKa1DPuYYj2jWZbT5xqkwuqUr/TDI5QA6c7F6k4ZrHdVfaxqR
         0ELMeIQDu52NHtka09aMS+FCNXg0EKBUBC3WSKuJcmalrd9UVzfpPBZBF9+b3PsxTP76
         24FJ0xkiDyoJt+CuRRXlMTvd7Nfjwo74ntgOBkXRi7vTutF8OHmF5xPeMtrVUHt3a/tg
         lMaJSUth1RacBGumSEe8lWPVjz19WwpuOzCIQd377y/fHV344rHBokuoklerJJcPK+5H
         Xk1wdfVNftyx1u+hBvMf93qSZ2eziCNzCYHNCp2DJ1DLgs3mxy7lwSX2JBpeh1LaDNSr
         lR3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790732271; x=1791337071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OaTWYjGa88IT1G2tVr2iEi35Jf6xhHPNQWrE7gJBkU0=;
        b=I97lxwgRrLCGRi4ZUv+8vwPeqQpl3+D0y8LybsOltepQ637INvdy1Ox7aLFn2sldow
         s/wC776XNpEi9D3ReZqHy0oLGcxKsetJGRr4ZoDB6tjcbmnPuIHVeuy3YpSX/42I8G48
         e0f3yGgT1c2S93o++DAMMd31Et045nCdiIJ5iKwxZ/DUAbJoD4ctSDFu9D13NQpBDTJm
         Jt/Lm0CPMaFMcFhdNFxBUEYA7N36DdBJmT9lvVMrfFMNJw6h3quptOGJ9LqYdDEkn3lu
         q2UZxpC4RsF3kMvSus5s7kdGHVBXo8B14QkTPRBJIJZodipeaR2c1x5jLZU0b6VBztyP
         BzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790732271; x=1791337071;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OaTWYjGa88IT1G2tVr2iEi35Jf6xhHPNQWrE7gJBkU0=;
        b=2Pnas/n6hhsLKANsMmUUs9fOAnw2D3qRN/9InCLTqQ365h8Ui5TA1Q/F6ObOmAwNky
         v4wmMy256ZfaDlGFmzHM9OxrvI6GPgPtqLCLdChjsBGi+6+ORdW/q2/zSymeF0C3kZA0
         5h7htfnbY10V87PX2uFzFl6pr/9CHQg8CKWHIrA5RzdNI+/HfNrLyPMM3MsJW7YADPbX
         4z3DjtaE1gDp6+KXTYDxTIUvzvAN19JGE1ZnAUzwW9rn3H1dVm+njkAuexYCVK7mHaP6
         x3o7jHf/8784JRkScToEThS16D7pZJ0Izx71jS76aNXalWEe58AgATQ497rHHFgKP9AZ
         NcCA==
X-Forwarded-Encrypted: i=1; AKwUvBx+RolX4XR+7TjI25UpadxrFFlmkJVxoWVHUpCqDnHHdDd1o8SQ5qqtk0ZLqWxQ1aU4zxFfixOn1NfEqE3StjofMvcwFaI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZaqVmilq4jR2kKrLu0NIaELVmhTE7Eof5T6+w31FA+t6Dpa0q
	IGYsDSbl/Vri4G5/jA15BGEMTRhvbRrF/NJbXVggQc5FAyLTMpDEK1EH3HXQaX57p2bT4rZgdR/
	MiMaX0asaFtkheAGXOE4A6egXjkhSEZZw53RBjb/h
X-Gm-Gg: AYBFou1wOzHn6r1AxoDNBn1wFJmZoXoeiniX8uzda67ppSxhUWZ32+Wr2Rv9HqWgUhJ
	cNDGBYRZzc+X1SWT0PIlH5bRiazAY/fEHQUa6vvaGhUF/ZWS67GyhLBX6157SLehXoA+u/YmL58
	o7xB4VdPZzF9JNJjmxJMQH3cyiAd35s8RW24JyeYubGuJ2RpUULLBCWvoL+Acu/PtfaR13wBIck
	snqZVf3CgVGDcuj2P80Ll1ehdR6Oa2JtvlzJzjOpYimm0WKQQwb/CexhYFd6vv6QIuWnwtxoLef
	jmSIqwUwlr8GLQF0M0kh8ODIi9gJsgICpZjB31wORDd2bkHnOyKrbfdn9zrijWm1IFgyKkOp4RM
	yyyv3X08i89M=
X-Received: by 2002:a17:90b:5826:b0:3a4:b418:94ce with SMTP id
 98e67ed59e1d1-3a4bfad5481mr925945a91.1.1790732270586; Tue, 29 Sep 2026
 18:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928193046.6698-1-fmancera@suse.de> <20260928193046.6698-16-fmancera@suse.de>
In-Reply-To: <20260928193046.6698-16-fmancera@suse.de>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 Sep 2026 21:37:37 -0400
X-Gm-Features: AclHuK9OxXVVrbvz3Zo4XSmKnOU38tEex0LOM5rHmx7snd46dBYW9kvi1MOOmgw
Message-ID: <CAHC9VhSQe27X+YVp4crJYhH_OxeVt=G6HCyrOqJgDii=MiCXsQ@mail.gmail.com>
Subject: Re: [PATCH 15/16 net-next v2] netlabel: cipso: introduce CONFIG_CIPSO
 to decouple IPv4 dependency
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Biggers <ebiggers@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Florian Westphal <fw@strlen.de>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, 
	Wyatt Feng <bronzed_45_vested@icloud.com>, Joel Granados <joel.granados@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Yung Chih Su <yuuchihsu@gmail.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 3:32=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> Currently, the Commercial IP Security Option (CIPSO) is unconditionally
> tied to CONFIG_NETLABEL. Because CIPSO is inherently an IPv4 protocol
> feature, this creates a transitive dependency where subsystems relying
> on NetLabel (such as Smack) are forced to depend on CONFIG_IPV4, even if
> the user only wants to utilize IPv6/CALIPSO.
>
> This patch introduces a new CONFIG_CIPSO boolean that is automatically
> enabled only when both NETLABEL and IPV4 are selected. It abstracts the
> CIPSO-specific Makefile targets, sysctls, and kernel APIs behind this
> new config.
>
> By safely stubbing out the CIPSO netlabel_kapi functions to return
> -ENOSYS when disabled, this allows NetLabel and Smack to be successfully
> built and used on IPv6-only kernels.
>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  include/net/cipso_ipv4.h         | 18 +++++++++++-------
>  net/Kconfig                      |  3 ---
>  net/ipv4/Makefile                |  2 +-
>  net/ipv4/sysctl_net_ipv4.c       |  4 ++--
>  net/netlabel/Kconfig             |  4 ++++
>  net/netlabel/Makefile            |  2 +-
>  net/netlabel/netlabel_cipso_v4.h |  7 +++++++
>  net/netlabel/netlabel_kapi.c     |  3 +++
>  security/smack/Kconfig           |  1 -
>  9 files changed, 29 insertions(+), 15 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
