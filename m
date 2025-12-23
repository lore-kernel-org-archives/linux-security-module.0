Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484F32DCBF4
	for <linux-security-module@vger.kernel.org>; Tue, 23 Dec 2025 23:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766531517; cv=none; b=i4PmuIIK7pfFfcUArmVDbUqa0oF/vhDccpKAghLSbYED6DnfrfSJ7j9GKlbcUpyJk8RiUESOC/l7xlnGhX6EDfe0fPaDTwHdbyN+gKpDEc6TMBr4QiMWYYnlSxOKESWvUK+ZIeI4jPEQRkH5PnqZsGVoJLwjY8u8VlHxy9PqDrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766531517; c=relaxed/simple;
	bh=pS0BuCZASQQcUSQGZmQONDhdqjK/gTLvS9Bm83K6x/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dv5lVyikZgWyzRMBa4x1GMjhzvPqBbcJu7Qiczp80UtqKsAOunlc5i3/4/e0BnEF1VJYMOWUoKftGvyXYWm4k/6qGAbXOJJ7JJrcyjaFRoqgNJ18g5lV9G6jeb3UdLlvq0rqDQUl+9jE3A2T8XOK1obLd1T6ZvxBrAIcMrmQdrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czmEgOFp; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czmEgOFp"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso7786481a12.0
        for <linux-security-module@vger.kernel.org>; Tue, 23 Dec 2025 15:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766531513; x=1767136313; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cRBHow4H5Rq09HC3GLl0qz6af56ZPXFKGlPGjJ40LF0=;
        b=czmEgOFpOva35Dam9G0QTP1YkEesq7qjZ6/dpN+n5CylWaBNyI4ruBXIvfR54OUon9
         NhpnmSvTki+/fLUsFIofWaj04A6znshbQRfRYaft7uvVH1IocAAFjTgakuZJ12gcYYYN
         OI5buuCMqMF4vnqAkmId4LndYUHQSpcZOmDADXHV7nf6HVZTQEXCpMsKt1vIG07s5wQp
         bKAcgXMUOAhoj7U/A8tEv99QvxwPXFV74pKgpJADxpvsdOPvOEJx2ZK4S9FZVe3Pp4Kw
         rp2pPV2KYyh7pkHoPm4wA5Xit9EVl1638tZsE+Bnom1MF2yy/wmLSBLQo40YFTXSefHf
         mbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766531513; x=1767136313;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRBHow4H5Rq09HC3GLl0qz6af56ZPXFKGlPGjJ40LF0=;
        b=TKohVGWPyhZ0cMaUEYZKpzKAg/awwwf7dr4z1revRpJq83y6doudEnjAhUWk4J/g4E
         zbGiKSzmiS2FW9lDZJ7WAPL1/dU9QmjsujHpy8ZOVycPS229QdO36VpE1TOCTRdNvjmE
         6Ru5pJKQVFDM+MIef1YdqxmVRxC91dQHQJhF+7detExnQCpJDesP+RBpj0MTbCmMcuIw
         kVrQLpBVCofkVVgU+rD6pDOSQSkSeNvpRhLWbO1ViebruqZ32qU41unP5nwcM+lXlYO4
         57fzvqrJ6GUPUJ+RnnyT5nAK3AoAg9+ZxmxZ3vO+JiCHOE3riWNuSlmCdEii0U9ZRmoh
         rzQg==
X-Gm-Message-State: AOJu0YyO4FA86umPK4zJri/sf+mv2uVNYkrW0zovEl8chsyqnFfktXRx
	+QuVKOsRZIZ5aUgykKJHz0OxLoG5kQDYbUyhPj3nTaSR6X2ewmd73CGz5NXzhQ==
X-Gm-Gg: AY/fxX7QLnvayGVM5D7Pc0xgoWnHoeScfF+g+EtHd/uaJbP5ha9r1hGkSSREFbGne68
	QFWXEfeQP/RZxeHV2IMlKnKXcunB90PGJCJE/dFBRfU/Txi7E4QvHEPmMbRZRzBc4VtN4prQsag
	+kfbciVfWpUSVZaetpqlRotTFGNq/ioL8aKHIRXD8UPTnOmKhEk1aMUfbTwq7Cl4WwDos6ypxlr
	xSExUpcCMVHmUI94udivI9rLbBdMrVKtKnikMb39toFXCgQEImwDpNbY0s5Yxtz1M35YP8S/sq6
	8G6+f4nbcU0mW7E+bhpU8ZD00gKKrAzx19v92z57UOqPL5rPD0NYc/yh2vdHjnbJiaP4trd5O6c
	U8pDta3up9pr++bn9P7jewL6+qeosxOrbz0QjVhGx7oLXTeEB91JsRxqIZ41qmImMn1H5WZnds+
	l9of1ZnB/+CUrZNFSDT6zxolxHgzPssRHeehFN
X-Google-Smtp-Source: AGHT+IFy/lBrNqQaYecxqdlO4iL/cqG9DjkUwYewekRI4pI8dHHAguk38xmASW3mJBfxgc7E3EcAJQ==
X-Received: by 2002:a05:6402:1ec9:b0:64b:3225:b771 with SMTP id 4fb4d7f45d1cf-64b8e82b70bmr15760058a12.6.1766531513295;
        Tue, 23 Dec 2025 15:11:53 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b912534f2sm14963839a12.15.2025.12.23.15.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 15:11:52 -0800 (PST)
Date: Wed, 24 Dec 2025 00:11:51 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1] landlock: Optimize stack usage when !CONFIG_AUDIT
Message-ID: <20251223.7ae881d64b8f@gnoack.org>
References: <20251219142302.744917-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251219142302.744917-2-mic@digikod.net>

On Fri, Dec 19, 2025 at 03:22:59PM +0100, Mickaël Salaün wrote:
> Until now, each landlock_request struct were allocated on the stack, even
> if not really used, because is_access_to_paths_allowed() unconditionally
> modified the passed references.  Even if the changed landlock_request
> variables are not used, the compiler is not smart enough to detect this
> case.
> 
> To avoid this issue, explicitly disable the related code when
> CONFIG_AUDIT is not set, which enables elision of log_request_parent*
> and associated caller's stack variables thanks to dead code elimination.
> This makes it possible to reduce the stack frame by 192 bytes for the
> path_link and path_rename hooks, and by 96 bytes for most other
> filesystem hooks.
> 
> Here is a summary of scripts/checkstack.pl before and after this change
> when CONFIG_AUDIT is disabled:
> 
>   Function                       Old size   New size   Diff
>   ----------------------------------------------------------
>   current_check_refer_path       384        208        -176
>   current_check_access_path      192        112        -80
>   hook_file_open                 208        128        -80
>   is_access_to_paths_allowed     240        224        -16
> 
> Also, add extra pointer checks to be more future-proof.
> 
> Fixes: 2fc80c69df82 ("landlock: Log file-related denials")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/landlock/fs.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index fe794875ad46..722f950307f6 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -939,7 +939,12 @@ static bool is_access_to_paths_allowed(
>  	}
>  	path_put(&walker_path);
>  
> -	if (!allowed_parent1) {
> +	/*
> +	 * Check CONFIG_AUDIT to enable elision of log_request_parent* and
> +	 * associated caller's stack variables thanks to dead code elimination.
> +	 */
> +#ifdef CONFIG_AUDIT
> +	if (!allowed_parent1 && log_request_parent1) {
>  		log_request_parent1->type = LANDLOCK_REQUEST_FS_ACCESS;
>  		log_request_parent1->audit.type = LSM_AUDIT_DATA_PATH;
>  		log_request_parent1->audit.u.path = *path;
> @@ -949,7 +954,7 @@ static bool is_access_to_paths_allowed(
>  			ARRAY_SIZE(*layer_masks_parent1);
>  	}
>  
> -	if (!allowed_parent2) {
> +	if (!allowed_parent2 && log_request_parent2) {
>  		log_request_parent2->type = LANDLOCK_REQUEST_FS_ACCESS;
>  		log_request_parent2->audit.type = LSM_AUDIT_DATA_PATH;
>  		log_request_parent2->audit.u.path = *path;
> @@ -958,6 +963,8 @@ static bool is_access_to_paths_allowed(
>  		log_request_parent2->layer_masks_size =
>  			ARRAY_SIZE(*layer_masks_parent2);
>  	}
> +#endif /* CONFIG_AUDIT */
> +
>  	return allowed_parent1 && allowed_parent2;
>  }
>  
> -- 
> 2.52.0
> 

Thanks, this looks good to me!

Reviewed-by: Günther Noack <gnoack3000@gmail.com>
