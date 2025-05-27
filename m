Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A9F3C30
	for <linux-security-module@vger.kernel.org>; Tue, 27 May 2025 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748343634; cv=none; b=AbSV7dO1jyrhEsFqSVOP5FWSFMCxGL4P468cl90Sf3DA9b5MZKuf+oVUmlQoeIKpT7+xewxOtb3wb9uoRKHsSmXMvJudXWIO+uEXecarqOTxCiHolZRRuHCIBaZ5ge3OxfjRGKA9Q6yBK2R0/K+0btSGgOpAp783GSMt3kWheLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748343634; c=relaxed/simple;
	bh=1ymit/SHBDSAciuBYn1YUSFveYAGSEEyUuvDQrliTv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEMOJc0OaWV0/2iEvr1i5fHDChcRM2L4q/rrmDmabh3ZuZejBjKiA0SR1dzsgSbhQZ9ashq+jg+h7Llhhnx3KHRXtIq+qPXtSPQGSbCM/HA/LJjRwPcMBVeoyuP1rfaxPnOYUifM1+1t7PLO6MxpppcDbKDLjsDJknXV7bqqyCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=A7M/qDtA; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="A7M/qDtA"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b68mr3tHbzFNl;
	Tue, 27 May 2025 13:00:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748343628;
	bh=nhEUzTuXRhlNN4MCC35fG/R3HnRRAbg8INxYzqSNfiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A7M/qDtA4fSTCpuK3w06sZoKAYpWFClef0eQElNRUOPMTEDWLoayzZRPj7F5JpFnp
	 NlgYR+ygwvl6kpnOIreLUOK/qYKgzVcvfA/rqxAT7fvT0Rhq5HIcR+NDov71plyQIR
	 aSUiVe89xEo9BmMJCiFBUmMSZK4iteWfnOHiIvHY=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4b68mr0k05zM3h;
	Tue, 27 May 2025 13:00:28 +0200 (CEST)
Date: Tue, 27 May 2025 13:00:27 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 08/10] landlock: Construct the inode hashtable in the
 new landlock_domain
Message-ID: <20250527.paeShie1ofoo@digikod.net>
References: <cover.1747836146.git.m@maowtm.org>
 <e0fcfb45accc387fb0c6a4deca2724fc531b7bd0.1747836146.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0fcfb45accc387fb0c6a4deca2724fc531b7bd0.1747836146.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Wed, May 21, 2025 at 08:32:04PM +0100, Tingmao Wang wrote:
> Since we can't get rid of the old landlock_merge_ruleset yet, we call our
> new thing landlock_merge_ruleset2.
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
>  security/landlock/domain.c   |  87 +++++++++++++++++++++++++++++
>  security/landlock/domain.h   |   4 ++
>  security/landlock/hash.h     | 105 +++++++++++++++++++++++++++++++++++
>  security/landlock/ruleset.h  |   2 +-
>  security/landlock/syscalls.c |   9 +++
>  5 files changed, 206 insertions(+), 1 deletion(-)


> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 07823771b402..ac91d4a865b9 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -27,7 +27,7 @@ struct landlock_hierarchy;
>   */
>  struct landlock_layer {
>  	/**
> -	 * @level: Position of this layer in the layer stack.
> +	 * @level: Position of this layer in the layer stack. Starts from 1.

Feel free to send a standalone patch with improved doc, I'll merge it
directly.

>  	 */
>  	u16 level;
>  	/**
