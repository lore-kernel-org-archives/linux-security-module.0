Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01AF21D581
	for <linux-security-module@vger.kernel.org>; Tue,  8 Apr 2025 01:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744076111; cv=none; b=GyzLLY1rfoxzR4yJCx/6NZ0dEYDrhDRQIlPpF0JaQrR6iQrqtjAZlJrlObscQ69YyhAPlzyoNLzIJQ1I7lYtIlhEH88Pb66Gl5oHQpCxfs3M+RTrw3t7Mye+YsTm8CAdRFUhuR4PM3ah3SOcngTsnbMiS/VrP0zEKjnSSAVhN5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744076111; c=relaxed/simple;
	bh=UzJzuG6mawXDt2lg66B7/EZDQHiqmaU6CjBKqdUBOTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4Gon6VEGkOoPVk8hCHg8AmosrsA+fLqR1T7Pj5x30nqW9xm7SfVrNCxLnSCFdx9tSZ3gSZ9o5MvSNn6yJoxYa8HOgLIaWgosnKt+YQkepbXQLmUDX2YebY4ZnMBUQB+nYD1sD2hZ77t1A/7WHagOb0NM7QN9w28wDpCAR/jBpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KmNpvg9Q; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KmNpvg9Q"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ff4faf858cso38016527b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 07 Apr 2025 18:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744076109; x=1744680909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqYTSM1FJCMjPZR8TM1fd1KRA6QF3QSY/HArlDQ7k74=;
        b=KmNpvg9QQg7BJIuyLYnliYgTUgkMAC/Bu+lgqmMEHSXen7KvKmMzFELZxU4BSyo8L8
         xhQJgL/O2RKMlrAFBVc4l3GMVAofsgqKcnYVUncLbmRR22TgyQea8lf39hAhD04gnASj
         5wftt4wj55s+z24XNVQTqnhbBodJ+DEg5/sbuD3BzdKRCVZN6VRWqXhvCpNE3BdMZFbu
         FzR5YxhWAda+NrqmE0sg9ikcBNRlKjgniDCmlHmd+hDfcADsSJ2iBNrSNnJwCEEZ0yBR
         1jY3ZQxdmeShrPNXdWZsXi2+V+uwbKNFbwUlWB99actm5Y2MUyNdjnsnsTcfztjN2+KR
         2szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744076109; x=1744680909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqYTSM1FJCMjPZR8TM1fd1KRA6QF3QSY/HArlDQ7k74=;
        b=dfjwxyOrVvt5XQtkmUiPzlVdX4mgwb9VuX+C60wBsuPwf52+uKbsFQat2JbNWtWa6W
         1CGVsMtErP0Jr+r2ykRFWOYWG76nwexxAw8jyEL3FUmg/YPtdIJJuyf7LdevvNijld9e
         eJMyv8PuJfWfwBZbdQo3b76Cdc89f/shgBPsN+rUlWEUkurioh0g7i1+G7jiCEu/0KGk
         rMwd4BxlI6n4BgVbJRB3W3e2EXMGJYhBxR+w69A1wV8r0KtjnVRCgmHb0z2SIchF/6iS
         /mHKDX0xy8woHpCoqvi/5RJ57e4vqNKpQz92/HbaBK+OIk4eBLVFWpdVmLZ/jS9ExP3a
         LaFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEkrC7/KLP5tuWVcb6RKAJDHi/klKkXpvbu4xgvlWm9L0wCTNHxplTmWaML1E+59mBZSGI8G5VdHNPNQ+wnMEW/UlAs64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw/QGi34BEqTyNtgBQMtQrQADw59XjGqUYzS/WgZHXXWe8uyND
	zlIk8sP19uPhVj9v7vJlIT93qSEn5fxmCYkl+FEC1BdhaIttMzk34RRA37QVxH9k9H35ZDEmlnX
	CxIHCpYyioJ2cH4TACDoDUF9+OmxRPic2gy0i
X-Gm-Gg: ASbGncsTDfLKDCEGuJmGfz2xZSTiCrZxOR/G3dyWDGJDOyJv+0GS9VJiyk4ovn9141F
	sBBsdJPFJkAtOPUYsxJ/aSkXgWm7vogblsZETMp6j/cNEsANLSg7J3dvkza4oUgV6usgVYHqk75
	AG18Dv+CF35/SGHSRq6SkOEdAaezRpimkZzrTd
X-Google-Smtp-Source: AGHT+IGoUzeM8HMuTr1NGJvPb8jIlKfrqtqlOQ2FpYfKI0PmIIhhs/TRzx73rkt7iCRa1VGrIOSWdhBV02vnAqQGDHc=
X-Received: by 2002:a05:690c:4d8a:b0:703:b278:db30 with SMTP id
 00721157ae682-703e310896emr240899877b3.4.1744076108806; Mon, 07 Apr 2025
 18:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407231823.95927-1-kuniyu@amazon.com> <20250407231823.95927-3-kuniyu@amazon.com>
In-Reply-To: <20250407231823.95927-3-kuniyu@amazon.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 7 Apr 2025 21:34:57 -0400
X-Gm-Features: ATxdqUGY33CqhAhJH11kZ7E-OTlreVGoamoyxPdGrvFZsT_Af-mUeIimwX5FK90
Message-ID: <CAHC9VhQCS-TfSL4cMfBu2GszHS8DVE05Z6FH-zPXV=EiH4ZHdg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 2/4] net: Retire DCCP.
To: Kuniyuki Iwashima <kuniyu@amazon.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Casey Schaufler <casey@schaufler-ca.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 7:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> DCCP was orphaned in 2021 by commit 054c4610bd05 ("MAINTAINERS: dccp:
> move Gerrit Renker to CREDITS"), which noted that the last maintainer
> had been inactive for five years.
>
> In recent years, it has become a playground for syzbot, and most changes
> to DCCP have been odd bug fixes triggered by syzbot.  Apart from that,
> the only changes have been driven by treewide or networking API updates
> or adjustments related to TCP.
>
> Thus, in 2023, we announced we would remove DCCP in 2025 via commit
> b144fcaf46d4 ("dccp: Print deprecation notice.").
>
> Since then, only one individual has contacted the netdev mailing list. [0=
]
>
> There is ongoing research for Multipath DCCP.  The repository is hosted
> on GitHub [1], and development is not taking place through the upstream
> community.  While the repository is published under the GPLv2 license,
> the scheduling part remains proprietary, with a LICENSE file [2] stating:
>
>   "This is not Open Source software."
>
> The researcher mentioned a plan to address the licensing issue, upstream
> the patches, and step up as a maintainer, but there has been no further
> communication since then.
>
> Maintaining DCCP for a decade without any real users has become a burden.
>
> Therefore, it's time to remove it.
>
> Removing DCCP will also provide significant benefits to TCP.  It allows
> us to freely reorganize the layout of struct inet_connection_sock, which
> is currently shared with DCCP, and optimize it to reduce the number of
> cachelines accessed in the TCP fast path.
>
> Note that we leave uAPI headers alone for userspace programs.
>
> Link: https://lore.kernel.org/netdev/20230710182253.81446-1-kuniyu@amazon=
.com/T/#u #[0]
> Link: https://github.com/telekom/mp-dccp #[1]
> Link: https://github.com/telekom/mp-dccp/blob/mpdccp_v03_k5.10/net/dccp/n=
on_gpl_scheduler/LICENSE #[2]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Adding the LSM and SELinux lists for obvious reasons, as well as Casey
directly since he maintains Smack and I don't see him on the To/CC
line.

For those that weren't on the original posting, the lore link is below:
https://lore.kernel.org/all/20250407231823.95927-1-kuniyu@amazon.com

> diff --git a/security/selinux/include/classmap.h b/security/selinux/inclu=
de/classmap.h
> index 04a9b480885e..5665aa5e7853 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -127,8 +127,6 @@ const struct security_class_mapping secclass_map[] =
=3D {
>         { "key",
>           { "view", "read", "write", "search", "link", "setattr", "create=
",
>             NULL } },
> -       { "dccp_socket",
> -         { COMMON_SOCK_PERMS, "node_bind", "name_connect", NULL } },
>         { "memprotect", { "mmap_zero", NULL } },
>         { "peer", { "recv", NULL } },
>         { "capability2", { COMMON_CAP2_PERMS, NULL } },

A quick question for the rest of the SELinux folks: the DCCP code is
going away, so we won't be performing any of the access checks listed
above, and there will be no way to get a "dccp_socket" object, but do
we want to preserve the class/perms simply to quiet the warning when
loading existing policies?

Personally I'm not too bothered by those warnings, I see them fairly
regularly for a few classes/perms on my test systems, but thought it
was worth having a quick discussion on this one since it is a bit
different.

--=20
paul-moore.com
