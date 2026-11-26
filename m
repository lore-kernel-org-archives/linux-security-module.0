Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691453;
	b=3Ou3rE6it77h12vTNyGKOnaq86Qxe1aHW/INUY6J/rRHQHrbOUjhNpzgEyZzaKT2wFoE
	 FhEYLHieyuFJVT2DaO2m3qjKAdL8l6RPtYShTqdyx07yWFHUar4ag13AImda/o6g9VJxH
	 V1iyW41ieFUJz5qQS49rzADIfcbyCU81fNsolfZHBOdJqdaHSMw++iA4ehi7OO2fuysI1
	 Srm9kOxWHwc52Z6g8RmWi8fxifDi145Bvf053BUwj72uvE3hxIBg18jd9hqXjsgt/NRAt
	 scnwqWX7zHPqBY4PwEHwy9ZvA/SMxWullhNMQix79rnxlJhZeEC19D7QjZtuYJ3O3hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691453;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mzhfHYOTAiWX4/4QQvlE4sNDOxtXiB/zhUzzBPto7Gg=;
	b=ZT/LGV0rqYwv7RH40yysjiOGofOTosbcYJe6yKDC9r6HfD0Sx3bGS1laU0mvuJnbfRgr
	 N0PCwNBOoO1H101sNUWEbWjJiV+NErQGp/Q+AwGnRxGhVRLknsEyLwAVmocWschSqErAV
	 lT/6Pe7rl4FWHf6ujwyaAX07cISgtlnJM1BCZ1me8FkPwG+6grlnaf8muZIPtnAgViyEH
	 Aod/AIyE+qb2yUBj47PGPvyV2WaAqddDqC5Pz2veC/7RUfdI6cEDZaFjDMQFBR6qQPkka
	 wnn+vGwWENgpfALlwC0VOYmoTg4VTmwhlctG5D6G6SVaUiOf+LApnzUq9p5gkYYDvvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A+nXzGi6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC5A606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 26 Nov 2026 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A+nXzGi6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5161F000C0;
	Thu, 26 Nov 2026 11:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691453;
	bh=mzhfHYOTAiWX4/4QQvlE4sNDOxtXiB/zhUzzBPto7Gg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A+nXzGi6hA1waDmMchthGQIFQF53hls5vuEY0MNWl8ro9oCLwWl1SiqufjiNXVqyA
	 KlZtB/DTEanOQ9KDlavO2hm+TxpBobgPkG5aecpDsqcXjDGn0xJFFghvOMZhQMRE4s
	 MpZmDd2noaNyR23VJVt5hIQdE96YwmPNeOEj9jUZojYIM+GlSv3zI4ZTxCwlraux2R
	 bZPSQATVGWzO2K2FAvf6zXqNmKAs9WIKiMhICBCwMRIpfEmEgfNdwzrGvQrpHsDqaH
	 v7Lkug97REhA8Gqaa7sjCAy0Cf6na6PQqzu2a2lgjSD8xz8t3VXexLak/FXubRTfHG
	 tX4ad4XqZ1deg==
Message-ID: <sashiko-outbox-235347@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH slab/for-next v2 14/14] mm/slab: do not set
 SLAB_MAY_ACCOUNT for all caches
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFycnkgWW9vIChNZXRhKQ==?= <harry@kernel.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Johannes Weiner" <hannes@cmpxchg.org>, "Michal
 Hocko" <mhocko@kernel.org>, "Shakeel Butt" <shakeel.butt@linux.dev>, "Roman
 Gushchin" <roman.gushchin@linux.dev>
Cc: "Hao Li" <hao.li@linux.dev>, "Christoph Lameter" <cl@gentwo.org>, "David
 Rientjes" <rientjes@google.com>, "Muchun Song" <muchun.song@linux.dev>, "Hao
 Ge" <hao.ge@linux.dev>, "Pedro Falcato" <pfalcato@suse.de>, linux-mm@kvack.org, kernel-team@meta.com, "Liam
 R. Howlett" <liam@infradead.org>, "Alice Ryhl" <aliceryhl@google.com>, "Andrew
 Ballance" <andrewjballance@gmail.com>, "Matthew Wilcox" <willy@infradead.org>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Jiayuan
 Chen" <jiayuan.chen@linux.dev>, "Kees Cook" <kees@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "Nicholas Piggin" <npiggin@gmail.com>, "Robin
 Murphy" <robin.murphy@arm.com>, =?utf-8?b?Sm9lcmcgUm9lZGVsIChBTUQp?= <joro@8bytes.org>, "Amir
 Goldstein" <amir73il@gmail.com>, "Casey Schaufler" <casey@schaufler-ca.com>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, "Richard
 Weinberger" <richard@nod.at>, "Anton Ivanov" <anton.ivanov@cambridgegreys.com>, "Johannes
 Berg" <johannes@sipsolutions.net>, "Eric Dumazet" <edumazet@kernel.org>
In-Reply-To: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-14-7c680f02a734@kernel.org>
References: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
 <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-14-7c680f02a734@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:10:51 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] mm/slab: missing short description in SLAB_MAY_ACCOUNT
  kernel-doc comment
--

commit b34eae19fad88ae1a8ba755676d1139c330f19f8
Author: Harry Yoo (Meta) <harry@kernel.org>

mm/slab: do not set SLAB_MAY_ACCOUNT for all caches

This commit stops unconditionally setting SLAB_MAY_ACCOUNT on all slab
caches and updates the kernel-doc comments for SLAB_ACCOUNT and
SLAB_MAY_ACCOUNT.

> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index ad645967a3eea..8525e70eaa76b 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -201,14 +201,24 @@ enum _slab_flag_bits {
>  /**
>   * define SLAB_ACCOUNT - Account allocations to memcg.
>   *
> - * All object allocations from this cache will be memcg accounted, regar=
dless of
> - * __GFP_ACCOUNT being or not being passed to individual allocations.
> + * All object allocations from this cache will be memcg accounted.
> + * SLAB_ACCOUNT implies SLAB_MAY_ACCOUNT.
>   */
>  #ifdef CONFIG_MEMCG
>  # define SLAB_ACCOUNT		__SLAB_FLAG_BIT(_SLAB_ACCOUNT)
> -# define SLAB_MAY_ACCOUNT	__SLAB_FLAG_BIT(_SLAB_MAY_ACCOUNT)
>  #else
>  # define SLAB_ACCOUNT		__SLAB_FLAG_UNUSED
> +#endif
> +
> +/**
> + * define SLAB_MAY_ACCOUNT
> + *
> + * Objects will be memcg accounted when __GFP_ACCOUNT flag is specified.
> + * Requesting __GFP_ACCOUNT allocations without SLAB_MAY_ACCOUNT is not =
allowed.
> + */

[Severity: Low]
Should the identifier line for SLAB_MAY_ACCOUNT include a "- <short
description>" suffix, like SLAB_ACCOUNT above?  Without it, running
kernel-doc with -Wall or -Wshort-desc warns about a missing initial short
description.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-memalloc-p=
rof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org?part=3D14
