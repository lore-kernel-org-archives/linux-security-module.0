Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A78E422523
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jul 2026 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507268; cv=none; b=SVThYAG9n7feIWVIQKi2is3Rm/JjyASG1nNZZa7Lcp0QBUKnYR9olsWrRJDIb32f5xxcqn5lEcIn0/LzqXXaCnFyGcO3V32+XGxJ3GHZmOOgjczu7Hy6vPTfZe5XX1ZzdfiDgwbjwSEklSfIsMYe49vmRICDImXoPu8Fqwc/LwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507268; c=relaxed/simple;
	bh=KIPKS9qTYssUK1Pdf4rnW1pNs1gOm+YQLMiuu14W4mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Epf/a/mL8xLVfwLi6cOg4oenMiWGkj+s06//j1Vq9EQhbfVWeqyCONniJKiPiI6jcbfDeF2o/B/UdH8CeXaDbW2FkWCnYEme5RqFlzscYX3dbCubDLDsXhBLixN+ZPBioARitLHqZcxCD3riv9HxDUWp9nvtAexN0xW83kumqBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=KfPXKnUC; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="KfPXKnUC"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gwF4D66lNzN21;
	Wed,  8 Jul 2026 12:40:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1783507244;
	bh=h+szCH3qJjavBjzWpe3u9PkHYRvYTjkN/5nGy0sOvZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KfPXKnUCFCNh8ENlkTCjQEhAnkBFiBDQSMY7TF6N4sDRhNsBXyjkWvIXRj41n4poQ
	 AzCyThAcp1BgNH7R6+wbN63bPcK2PKFnEEBpViokSZHxwhOFnJcvdLXTsO4svLkbjr
	 eH6HoCoHLvLCe6lQwj1qs7tSblD/SG2J6cEHVBkY=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gwF4D1NTkzNTQ;
	Wed,  8 Jul 2026 12:40:44 +0200 (CEST)
Date: Wed, 8 Jul 2026 12:40:42 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Alejandro Colomar <alx.manpages@gmail.com>, Alejandro Colomar <alx@kernel.org>
Subject: Re: [PATCH] landlock: Documentation wording cleanups
Message-ID: <20260708.EimaePheb3ji@digikod.net>
References: <20260516190112.4924-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260516190112.4924-1-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

Thanks, applied!

On Sat, May 16, 2026 at 09:01:12PM +0200, Günther Noack wrote:
> Documentation cleanups suggested by Alejandro Colomar,
> which we have also applied in the man pages.
> 
> Link: https://lore.kernel.org/all/agW4yMK6CinJGqXt@devuan/
> Suggested-by: Alejandro Colomar <alx@kernel.org>
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  include/uapi/linux/landlock.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 10a346e55e95..48c12ddf1108 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -255,16 +255,16 @@ struct landlock_net_port_attr {
>   *   :manpage:`connect(2)` as well as calls to :manpage:`sendmsg(2)` with an
>   *   explicit recipient address.
>   *
> - *   This access right only applies to connections to UNIX server sockets which
> + *   This access right applies only to connections to UNIX server sockets which
>   *   were created outside of the newly created Landlock domain (e.g. from within
>   *   a parent domain or from an unrestricted process).  Newly created UNIX
>   *   servers within the same Landlock domain continue to be accessible.  In this
>   *   regard, %LANDLOCK_ACCESS_FS_RESOLVE_UNIX has the same semantics as the
>   *   ``LANDLOCK_SCOPE_*`` flags.
>   *
> - *   If a resolve attempt is denied, the operation returns an ``EACCES`` error,
> - *   in line with other filesystem access rights (but different to denials for
> - *   abstract UNIX domain sockets).
> + *   If a resolution attempt is denied, the operation returns an ``EACCES``
> + *   error, in line with other filesystem access rights (but different to
> + *   denials for abstract UNIX domain sockets).
>   *
>   *   This access right is available since the ninth version of the Landlock ABI.
>   *
> -- 
> 2.54.0
> 
> 
