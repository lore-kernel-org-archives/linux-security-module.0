Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2107D2DEA70
	for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765534408; cv=none; b=X6zV6RNoZ+kkqn4oReyqKAbPjoaL8RHCVuYGJvmMPQdWV69UxkMDHQhkzp0K+TPeCX53cWBdGdsvzMNoev8UKoBcpBkwNb5S4apoQ5Sx+OdzUn+6r39PtDmRWSbjDsUwoiCxaxvpioGnAoywEzLxS2c+jFsCOgP1N83apPVlrdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765534408; c=relaxed/simple;
	bh=E/bM3a7NnykmLL6sM3vzkiU/MfvHgspoqGqRhWtm660=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB6ZcFH8DZvl2c8Pfoclqqgfi0Ay6CqDc465BQ8dr4spP4g0FT+wUEi/0VGXmB6WFiba+0ebN2ldZstyx6uKoyyN7E0IxlsxCwMh2JEbg+wnHrSiPcBg2sUt/Mwi2r2qoIyhx6Gt90146TyVsPfB8tvGnWr6C0qmSqLZgt1EU9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Khcvwfc1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Khcvwfc1"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so11337105e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 12 Dec 2025 02:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765534405; x=1766139205; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RCQ5S2exRgoL7ke7NbItl7r3b4v/Y2q17UzGJFaPYjg=;
        b=Khcvwfc130uWwl9fRUKeMOvu90ZDzWn7VCMUaCWNXZe2Ot7qt+l7Et4hdCSSfUBrMq
         r+UKe7lrsR7jIaHQ2BDf7ymx8iQZOz4ZaA1k37g3zrsj1pWKJRwE6ZxtTrbk5qjKb+L9
         NN9PsZue5wnXc7Q7/ruL+NOSFzPO95EZOB3dEnwx6MPFq07FJsopz0CkxgVL4pOw05G1
         c+/U19nXXKTMKJO29GZ0OsirWXyveXP0HyCnbrQwQN7Ix+gN26JK9qVKxlY2QekbsROj
         m1TEmdl8hV7pmIFHWxTvA1jWXQfIMV8gFZxBN+2bMfVymsaPFs7LLHutOQndnSSj7Wz7
         CQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765534405; x=1766139205;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCQ5S2exRgoL7ke7NbItl7r3b4v/Y2q17UzGJFaPYjg=;
        b=FknhJHPvcDePs8eWxyh6iiOxwsOoOXXrQhuh81MjqvNk4GWE6+STwTznSxn4OuNA28
         BXgMZGlIBWls0xkHHeycuWNuTDal4ISsV3146DrJReyojE+9LOk8iCyEvH58/L8MNvWd
         kiC+xyZacOSpsplUaIAiYUpq/dbtIwu0HRSZOEiU+S5lpH+uS/oAuGmkGQHITR5vpzJF
         74ePND9ZhmRj3XkaTjLSPoVX3Lo8Anz0fZdcwz09BT3zjiX9xrDxcfDcwncDy4lLWuaT
         5V7CzZKCsaUziIAewlbMI2PiGjFN3B3LPz5MvC2IG/nzlnChM3VZ2wkdFdHtTy8r70i2
         RqEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDY+njei4+Vg7hIyLVsPEdtbnt2vBaj0HDfNCQGkWOPWGOzRr37c/6khceHY54pjNkEcaeS5x6CQto37eVdhYzBDs33j4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUYMogC+cavsVc/0VOl17U/9/tZl2mkLw0AH/NhnhmwGN3E2ob
	uJC9xvjV9rehufTw8/cLOmCn+D0Jz4sJHXjPWoG0w/MZ6DtNZjSwyDN+fVwn/Ej92g==
X-Gm-Gg: AY/fxX4q/X/2WoZOvRgHVcEiBsfdvlZBVChBrVx/e0+4/p7f+B4CLOeRDHVyyCmPFVp
	zs0FO+pOl5irvmYa1mFEJP+pZYcuJNjZrsAxU+czK4VzOw0SUme65JqZugRrznoX7tvvA6TTcxS
	vQ/juWXd3ViluNAOYbjRJJKNS476XICYdpDoWmSekNGkMsemn+DWTZlO7j0cporALwd+G6rD9Ad
	5XDwMA2TTpMk64/kPe6gGYIyfFmx4+qRA0puPea1clO4lDxrADaoabtA5sgpDm47T+T0hhsLU/y
	gb6aeISzf9BzCw9mfAGfCTiZDSdgKH8fw/DTv+NdZmVTFIn7vU8Aflj5xjznyA30w0tWBdf7i0t
	dMEvUmfqsdU23n96X75eqFFCHW7qvel8CMWMjKiAMZ/62Hj2krfs9PWCmyGspBB/kJPiRE9pUBb
	o3/30qT2c+pTODe3IMcrt51G6tivfUkObOIOoS817jiA==
X-Google-Smtp-Source: AGHT+IEUAZhdVwwjMYzGWMPq0rSdb+cLoKKIVFsEhA+d1p+EqMtEKAcCfqS1epvf1i5jeJQn0PX/HQ==
X-Received: by 2002:a05:600c:154a:b0:477:af74:ed64 with SMTP id 5b1f17b1804b1-47a8f90d15amr14131405e9.27.1765534405274;
        Fri, 12 Dec 2025 02:13:25 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:4718:75d0:7a77:77d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a665e3sm11334118f8f.6.2025.12.12.02.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 02:13:24 -0800 (PST)
Date: Fri, 12 Dec 2025 11:13:19 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>, Jan Kara <jack@suse.cz>,
	Abhinav Saxena <xandfury@gmail.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 04/10] landlock: Fix wrong type usage
Message-ID: <aTvqrOomA3v52sIg@google.com>
References: <cover.1765040503.git.m@maowtm.org>
 <7339ad7b47f998affd84ca629a334a71f913616d.1765040503.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7339ad7b47f998affd84ca629a334a71f913616d.1765040503.git.m@maowtm.org>

On Sat, Dec 06, 2025 at 05:11:06PM +0000, Tingmao Wang wrote:
> I think, based on my best understanding, that this type is likely a typo
> (even though in the end both are u16)
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> Fixes: 2fc80c69df82 ("landlock: Log file-related denials")
> ---
> 
> Changes in v2:
> - Added Fixes tag
> 
>  security/landlock/audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index 1a9d3f4e3369..d51563712325 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -191,7 +191,7 @@ static size_t get_denied_layer(const struct landlock_ruleset *const domain,
>  	long youngest_layer = -1;
>  
>  	for_each_set_bit(access_bit, &access_req, layer_masks_size) {
> -		const access_mask_t mask = (*layer_masks)[access_bit];
> +		const layer_mask_t mask = (*layer_masks)[access_bit];
>  		long layer;
>  
>  		if (!mask)
> -- 
> 2.52.0

Agreed, thanks!

Reviewed-by: Günther Noack <gnoack@google.com>

—Günther
