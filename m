Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BB9368970
	for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177235; cv=none; b=L+Le6dYkYif98ArTciVkFHiZrsscV22XlKkpyc4E0IryIofMbWWoTxTo7nDGtBaTYA48xS0GTiy5zPxN4IJP21+hdroDfIpVAdiroYTM3jYwB2heC6wsLetOOGGYw8dzaPYK8Pi2EVYcs8OX0o+ffej10CVWgBrp1ONX6wldnDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177235; c=relaxed/simple;
	bh=BiS4wbOk3SQA3Tb/QtAYZWqbiIdtp77ohrLarWdhn74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCMZG2hGSDWX3ChXeSrZjKPTdgH5D88qq3hwxC/E648jLvpVm8Tpl+6OyPmvxAVnKKY79lsqvkS7TtLdvPxzNIcX7zPOzLpCezjvWw+ofTsEeLWmpwI63ropBj79ntTkxmaeWoOR0oHi5wT5QBEX5RFVDCFNpQ+DPr49Dcw7e1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUmUv8tR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUmUv8tR"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso3874840f8f.3
        for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 14:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773177233; x=1773782033; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nc7bLMm7TtIkR8qh6zQOn/d7uDE/pwkDUTc+mlre2R8=;
        b=XUmUv8tRLr2GHPb9eGnJiwstbEdzR60kcWkcN8kSEy+n0SRnRXn3u0r4zedWpvjjxT
         52sOkSmYFiPLGdL+AY60NErohnOJ7aGIR0HQjvu50OcCC/4tiAqmP/YS9Zs+HCc3yvpX
         z1swGDlM8wTATqv4Rgnrnb5vp1Sd/0pHJHSrwgPkkfFDhAe4QoYEl/CL4by0FAGoQScT
         Fzkn4arHk5WkW16ZRhuGGj7rXbOFAliWslkZHYyZTWZ5bZLVHlLjPh86CdgQDX4zcS+R
         gTJVyWA2m8tEebAVLP2/PmbgZAQZJDCvw8vQRLWGbfA/Xfs4jbQtdUpucxjz5iMpv6us
         1XPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773177233; x=1773782033;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nc7bLMm7TtIkR8qh6zQOn/d7uDE/pwkDUTc+mlre2R8=;
        b=NPnUhL5Mw0UQK6oth8miIJLtUF3iwqsLxrVBrCsz7hj8kMyVndpeT16rRFALjr1Ta3
         SHd0T0fjQd9lCVvw1b/o+D0oDSTQIxmqb6Bs18B296PYr8b1nNFpdgnUPx0xHdZtVVYI
         qyK6JlXgkJPNSakZ66zdmCrQCm/3nu5ej7g3X1GDbuJ2L81/kCWJDM48dIsScE3SFAMr
         HD3lFdO/xwt5gW7L/Nm1BB783sF5f/mzo0eA4afvCWS/tnz4PdoEmX56lBVEZ5F8SR6J
         2aXyatrSuTpufYoqTktGE9aNZyWOW9/s34TWETsKut3BjmBRvAmSiSgvOvJUcGmRaWMf
         7xCA==
X-Forwarded-Encrypted: i=1; AJvYcCUzVVA2isIsd+rTLH7a6b/yliT2FE1KLt14o2vtUnUNNaxvXZMU0+WpR3Ts3JzFhaVZf45K8OVFhRv0Ae5CsrevjTPdPxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN8aIQHyav4PwlTv/X1oOtkmzjmtn+YPv5Po70pS8jddQwrCRA
	sDkscGZg/e8BZRUiQdka1816k6rpV/mBN2kZNAGvcbg3cH5tKqjGB9DX
X-Gm-Gg: ATEYQzxxJqMeh/mYTvDLqJjd1qDGDvxwM+8f8ybUiYFMHOA8DsPwrPX0rrBDwPX4OcQ
	4UuimT6jQvahcUXr3t2tl0u70hhftDSZd6eQfE4zEdJCmm1PspMqXe1vQllSuHRlz0JNpoz9qR8
	D1+5OoL5ZYman5wEci3Fm/YDw4d8MDb8/uUsl01X7WnHudse2ZULbdP/zBwBZrC325BBtPBwSRM
	NLpWoj/8kgLHyeEIuOThv3CDN/mhr6pquP3A6PrK0DtzeTKfphozOf5saWOo68A7RambD3n0Vco
	gaQX7Jr3dFq2TMyRLRSZt2FHopeIDaoBGYrxQRmbCWvmSl7NomcEGz2bZbtjtgkXRC+jiLp6JFG
	m1CAKlpPOpByizt6pZe7gOUeLiMEcg2ppeBXubfq9r9vqWfSd9tkMqMQ/iZhRpiXKGyz9Sqe94e
	S/eVt2agMPVEseaOsQ0m7xwd1GcqNf0sMwFtwuMXbt0nw5KtVr
X-Received: by 2002:a05:6000:2302:b0:439:c9dd:cd5f with SMTP id ffacd0b85a97d-439f8201374mr696520f8f.19.1773177232720;
        Tue, 10 Mar 2026 14:13:52 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a3b91sm842777f8f.13.2026.03.10.14.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:13:52 -0700 (PDT)
Date: Tue, 10 Mar 2026 22:13:43 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] landlock: Fix kernel-doc warning for pointer-to-array
 parameters
Message-ID: <20260310.92671a11287f@gnoack.org>
References: <20260310172004.1839864-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310172004.1839864-1-mic@digikod.net>

On Tue, Mar 10, 2026 at 06:20:03PM +0100, Mickaël Salaün wrote:
> The insert_rule() and create_rule() functions take a
> pointer-to-flexible-array parameter declared as:
> 
>   const struct landlock_layer (*const layers)[]
> 
> The kernel-doc parser cannot handle a qualifier between * and the
> parameter name in this syntax, producing spurious "Invalid param" and
> "not described" warnings.
> 
> Remove the const qualifier of the "layers" argument to avoid this
> parsing issue.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v1:
> https://lore.kernel.org/r/20260304193134.250495-1-mic@digikod.net
> - Remove const instead of using a typedef (suggested by Günther).
> ---
>  security/landlock/ruleset.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index 3234a5bc11ff..181df7736bb9 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -107,7 +107,7 @@ static bool is_object_pointer(const enum landlock_key_type key_type)
>  
>  static struct landlock_rule *
>  create_rule(const struct landlock_id id,
> -	    const struct landlock_layer (*const layers)[], const u32 num_layers,
> +	    const struct landlock_layer (*layers)[], const u32 num_layers,
>  	    const struct landlock_layer *const new_layer)
>  {
>  	struct landlock_rule *new_rule;
> @@ -206,7 +206,7 @@ static void build_check_ruleset(void)
>   */
>  static int insert_rule(struct landlock_ruleset *const ruleset,
>  		       const struct landlock_id id,
> -		       const struct landlock_layer (*const layers)[],
> +		       const struct landlock_layer (*layers)[],
>  		       const size_t num_layers)
>  {
>  	struct rb_node **walker_node;
> -- 
> 2.53.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>
