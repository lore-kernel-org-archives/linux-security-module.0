Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF579DF76
	for <linux-security-module@vger.kernel.org>; Sun, 28 Dec 2025 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766946316; cv=none; b=cgNz9FEuJ8kZhX1UakWoBwJJtI4z5nRH7o2EPrAidJIZPfa+F0+f3JkQCKSIEIckoFoF37ycfNppnMZhCHhXEkzbfa48g78NGACGQyAMmYNfKn4OkXFDaftZE0tAL/tDw0zvHsvxU02wg7GyT9JfjfXvX/k2SaA0WHcOxmH+vW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766946316; c=relaxed/simple;
	bh=C2EfN41oEQoDV3fy7Um9qQ5D1j4hhtXPZR8L4qzL2zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPioynr08XMI/HhCiJLj6846D/zboyxaSttYFmZ9rLvu3WPDOnPf2xTz6REP5gZpvZEerhSIy/iZqGrQ5Wrn236aB59dHKXK082RSjLaYT/iFd8R2aujOIcTRAqaiHxbzByXIM6AALQIz6yE/ZgebMZJuKNguJD6bIaQ3S8X9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=oU+CEFHf; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="oU+CEFHf"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dfSGt1j33zNKv;
	Sun, 28 Dec 2025 19:16:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1766945798;
	bh=pKxn6mXhEciO/Q16BwoGTgLhe6/Pw0iVKg48CDYkcng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oU+CEFHfk7zH22zFS2JZoURvr8DvyppAVHw4XJSMWloT4EgXMCs3GA2xNTbHXAYV1
	 VrAmgiUVX7Eg8uIw/KdzFhDA2dELOw455Ba77MbOUFFb8fUIvEKT4juxPEDkKaBnGG
	 Hl+CSGugEyJQkiGs+WJVapHYbQeSbVWnQstXffNU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dfSGs4vM4zN6b;
	Sun, 28 Dec 2025 19:16:37 +0100 (CET)
Date: Sun, 28 Dec 2025 19:16:36 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 3/5] Documentation/landlock: Fix missing case for ABI 6
 in downgrade example
Message-ID: <20251228.Ohvaelo1AePi@digikod.net>
References: <cover.1766885035.git.m@maowtm.org>
 <1175b37d065b49520cbc335a9a2d501513a6c6ef.1766885035.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1175b37d065b49520cbc335a9a2d501513a6c6ef.1766885035.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

The subject for documentation should just start with "landlock: "

On Sun, Dec 28, 2025 at 01:27:33AM +0000, Tingmao Wang wrote:
> Note that this code is different from the one in sandboxer.c since
> sandboxer won't ever add LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF and
> LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF.

A more complet patch was sent a few days ago:
https://lore.kernel.org/r/3e21551d-24c3-459f-8cee-4d85c97c0120@oracle.com

> 
> Fixes: 12bfcda73ac2 ("landlock: Add LANDLOCK_RESTRICT_SELF_LOG_*_EXEC_* flags")

Unless required by other parts of the patch, there is no need to
backport documentation changes, so there should not be any Fixes tag.

> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
>  Documentation/userspace-api/landlock.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 1d0c2c15c22e..903d2ad11852 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -127,6 +127,12 @@ version, and only use the available subset of access rights:
>          /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
>          ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
>                                   LANDLOCK_SCOPE_SIGNAL);
> +        __attribute__((fallthrough));
> +    case 6:
> +        /* Removes LANDLOCK_RESTRICT_SELF_LOG_* for ABI < 7 */
> +        supported_restrict_flags &= ~(LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
> +                                      LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
> +                                      LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF);

As Günther pointed out, this switch/case might not be needed for this
part of the documentation.

>      }
>  
>  This enables the creation of an inclusive ruleset that will contain our rules.
> -- 
> 2.52.0
> 
> 
