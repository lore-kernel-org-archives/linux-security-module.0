Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5487C1422D8;
	Tue, 12 Nov 2024 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418863; cv=none; b=oXv8cjLqsIa+uGNEzedSLk9Rx+d15dlNBoe4TfLP3Kv2iQTPZgGfB8MWcRETtmBF6IwFggyb/dtMr3CAweV4Os2adr8wBF4mgP6yifWG98HJI0I1cFcAgFjtdDhjyLEtdxphNHdDKnujILOVF7WBUmPhk35Bbxdnu60jimz1TvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418863; c=relaxed/simple;
	bh=tuSYjFrlqFcCAlMH/fjcjS0cRxcltUMgQgwqktk4694=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzfKyR3Kmz3lMyIDPtqjaMRG++lNDXqdVJUvOmxycGXxGTujJvAC50iS3BlSUQRf4nHgL15oofcoroBf69sacFKnHIzBB/wQ777riorcb0rcSwwpvmnPUl4AjHXjkoh9Vzy54Td+wZsSGdV29obkdlfHvXowJaZehBAuqZ7Zf68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 3F1F0668; Tue, 12 Nov 2024 07:32:24 -0600 (CST)
Date: Tue, 12 Nov 2024 07:32:24 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] security: remove redundant assignment to variable
 rc
Message-ID: <20241112133224.GA340871@mail.hallyn.com>
References: <20241112124532.468198-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112124532.468198-1-colin.i.king@gmail.com>

On Tue, Nov 12, 2024 at 12:45:32PM +0000, Colin Ian King wrote:
> In the case where rc is equal to EOPNOTSUPP it is being reassigned a
> new value of zero that is never read. The following continue statement
> loops back to the next iteration of the lsm_for_each_hook loop and
> rc is being re-assigned a new value from the call to getselfattr.
> The assignment is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

(long as it doesn't go to stable :)

> ---
>  security/security.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/security/security.c b/security/security.c
> index 09664e09fec9..6147f27ea92a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4139,10 +4139,8 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
>  		if (base)
>  			uctx = (struct lsm_ctx __user *)(base + total);
>  		rc = scall->hl->hook.getselfattr(attr, uctx, &entrysize, flags);
> -		if (rc == -EOPNOTSUPP) {
> -			rc = 0;
> +		if (rc == -EOPNOTSUPP)
>  			continue;
> -		}
>  		if (rc == -E2BIG) {
>  			rc = 0;
>  			left = 0;
> -- 
> 2.39.5
