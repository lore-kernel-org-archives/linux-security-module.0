Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.16.66.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794525946;
	b=rfscejnreK08br4BRKDP4YSqvntOi/5aUSrUnX/x9//R5/hbZkS2AaGhI1BeYk7ajIKp
	 NbG2F7Wwor1H6gUZirdkc9LpEGz79Yjk3YtOkWSt1F7nNo90DWBdW6ZFKeBAPJ1IlKY9c
	 qHdl8jW1U+1qL3fzA36O0vFE9Uk1uHW+qnUBM5OGZAEpbegwvlUjjuoG+OEtUOxJzfIj6
	 05fZK+B1qyr676mC/ls6Ro+vUolGRGwyNHrvpwexWOSUaYZ6wXRgZkQGU+dNvfQ9yqqiR
	 LUC5Pw3iq+Ce7T8SPVDk4PH/m2Z+8rkqQgtDGlo3g+fECy8l2O7bwTFrzeb3uv8lvxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794525946;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Infomaniak-Routing;
	bh=T76uH9psnvSA8tO0kynH0zC7r5rVBFkGZPHF2OjedBI=;
	b=MLZX0PyAYXBZb3TwKsEie07v72QWylLj1S05+Gi/Ma+Ktn5uZjK5SoaQoFEoggB9Apxz
	 PUiDmw2B3Al6khNhC/Eiv32F4oRBuAcw5i9SCdgZ6alaJyHPAxGWTMLF6CPyA1SucJe6L
	 UOjLy24djvsXCY++gbOhBtOYb0O08lrnS50XJk7vNkvzPxWURb6sXeeYd73oH6vDNURlK
	 6jpBRhBjK4tG7bY4qsPEbgZmYHiv0LdhBxRRM/H1lwcMYI/RLTq1+/CWOlIjQl9BPgROI
	 /PvtnfGfmDPiCyRazmhafm4ewVbCdL3rC5IAqnw8YlBRw7I31U6blM/puP24ZxOv3UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=hEx1FvkR;
	arc=none smtp.remote-ip=84.16.66.174
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B0E606A31C;
	Thu, 12 Nov 2026 23:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0B0E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=hEx1FvkR
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jQc295Rklz84;
	Fri, 13 Nov 2026 00:25:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794525937;
	bh=T76uH9psnvSA8tO0kynH0zC7r5rVBFkGZPHF2OjedBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hEx1FvkRwD99totD/HdQ0Et1+kpn16dVcqrdWj61iv4rgSMkwTBCoZpVFt39JMgRN
	 OHp76Z26d3/GlWObC6E+G856bHToN0RGny1JXVoRqdvH5z4mMExNBB+rkmX+KCFS9A
	 4RJKuGKKcQQf5E8Ku2Kjqe4iweEdpDhl9ArpsRgc=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jQc284b6Jzfc3;
	Fri, 13 Nov 2026 00:25:36 +0100 (CET)
Date: Fri, 13 Nov 2026 00:25:36 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/4] landlock: Simplify landlock_get_fs_access_mask()
Message-ID: <20261113.ojir0eich9Ja@digikod.net>
References: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
 <20261108-b4-landlock-refer-nonfs-layer-v2-3-2b405fc1b3aa@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261108-b4-landlock-refer-nonfs-layer-v2-3-2b405fc1b3aa@gmail.com>
X-Infomaniak-Routing: alpha

On Sun, Nov 08, 2026 at 09:23:50PM +0100, Günther Noack wrote:
> Return the handled FS access mask as it is, instead of artificially
> adding LANDLOCK_ACCESS_FS_REFER to it.
> 
> Since commit d6c7cf84a24f ("landlock: Simplify initially denied access
> rights"), the merge operation already bakes the initially denied
> access rights (LANDLOCK_ACCESS_FS_REFER) into the a layer's handled FS
> access rights. -- They don't need to be added explicitly any more.
> 
> No functional change.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  security/landlock/domain.h | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/security/landlock/domain.h b/security/landlock/domain.h
> index d9ebf4857fce..812c324cb6ef 100644
> --- a/security/landlock/domain.h
> +++ b/security/landlock/domain.h
> @@ -262,16 +262,12 @@ static inline access_mask_t
>  landlock_get_fs_access_mask(const struct landlock_domain *const domain,
>  			    const u16 layer_level)
>  {
> -	access_mask_t handled = domain->layers[layer_level].handled.fs;
> -
>  	/*
> -	 * Handles all initially denied by default access rights, but only for
> -	 * layers handling filesystem accesses.
> +	 * Initially denied by default access rights are already included for
> +	 * layers handling filesystem accesses, see
> +	 * landlock_upgrade_handled_layer_config().
>  	 */
> -	if (handled)
> -		handled |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
> -
> -	return handled;
> +	return domain->layers[layer_level].handled.fs;

Could we add a small companion KUnit test to make sure the semantic
doesn't change?

>  }
>  
>  static inline access_mask_t
> 
> -- 
> 2.56.0
> 
> 
