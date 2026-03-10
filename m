Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D74389470
	for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148743; cv=none; b=pH+Mgom/iTcJy9UKXV6gwmwarqnuw/g0i2bXlnMi14DqlHkQNeIXcaSo4OOUrjmG6xkYHHG4eKDN0Et14bRwfbd1MnkpUMEMicYZeA8bjfDhdLLZFSMrmWfb/1Qb1OgeR1hZ3AgCeL1+4lhINHTm4yklHjdPjk4aPp2wwTFxrRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148743; c=relaxed/simple;
	bh=qGFmsEiAojZh7ZtbQT6yUccuh3z2mY7MiLKkEe6upJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhvqbew2o5OOI8XXbMyYOvpcW7adkvJoYAJNAuLm8d9XAOCSloSJUP31I3pDHXTlkPJMZ/PWlZiEQg7PQGh4KG1WPa0/zrO6UlhOHAOS/+GoD+BYqc8Zb3sHaRg0g0DCxFh12acj8mQU+M2lMXmXryUIAL6qO5GhQcheiQ/7TLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nnhNhhVL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nnhNhhVL"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48534237460so28906625e9.3
        for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 06:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773148740; x=1773753540; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bxGye1DdlQ/BmAK0V7cQ3Fzy+RkQYUSRF1aa9nYTl80=;
        b=nnhNhhVLdhbTiqJezepBbwRvrgFPuJIwI1a9GSw2cCVG1S/ciHD3m3XlCWfivEQ9lu
         60+B+uzvg/NK7ypO7VTUG8awYpsn+Rw+AS9VuhBHpuqHljVv89AmjvAW1ouZUedcrNX0
         4ckzJHx3S786QRlGEw8IrgxXCauw+JIpBpBkgMkpTnQvd4UdE2IXNUzXLItJSh4KOjLc
         cyLa+tT5MdWOftF9MoZ8SQjtmacq70e5oQ0mvlnxC4eLx55oUSBpv7D4KsHorNfdW3+P
         lceMcYglj9CfI2p95+UwLFMxkDRt/Olbv0NmQHFu/ts2Lgdwe3JS/tUp6zBrD0XiX6Zs
         3Qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773148740; x=1773753540;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bxGye1DdlQ/BmAK0V7cQ3Fzy+RkQYUSRF1aa9nYTl80=;
        b=rfE28xkGP/fq6xaxiMj4aNNYfpkBYK6Zb6ppqlSEkDy/6Bw96kJ/W4TYxTTGo4neOH
         g71cUJrFOWAIweeN1EeJHUcowbjfwfOqBX+j96bzvurB7g+89AVBF4Nrtp8sq9Q8h+wu
         vWdzKC6m2NmXU5PTd0hkFEIzDDFW72wVnyzHlsY8FMyQOCSPN8sTSjzcATNJv3UlQGlg
         YSuwmMzah2b+AmEyqyXWolII1b4B87yz064vdV2b9Iy7i3gDipgXUwaIPY0tD7uyAibr
         JRX1HM/6ZpsT1PHiMY3WhXCtTKphDZdkYR3pOU/cpJ66y6EaVwgaPJRRR9VyiEtWuWsT
         6Q/g==
X-Gm-Message-State: AOJu0YwqZ5si/sPe3+cJ91itPA7FEcvUakFpEiX4pvsRVGUXlga0gNNV
	87lrk2LLabWlGnKgZFI1/x4Vzmfnl4JZNvR7OQYzlm8+zimeRQO08DRPngKB3f7Oku9PqIKj1Kd
	U2gL2zVyf
X-Gm-Gg: ATEYQzyOTA2tsXANWH6C94JsQUL4tKSoV0Wi78FMVm0MY33CBYQ/N60i00jbjcWmYhN
	0/RsatVH5pximd1Es90hV1CgdMjVeQxO1iCZRnnyH2qDfslmAeAsY0ObIQ7YURx03on2LIOpqLR
	sdjv0qhtCnFrjQqs48cuq5OF1tdaU/iPP52Ig4mk3ornvx/T9ngMi+bv5vbt0/iiyS7rOM0Trh4
	LNhqFdieFwrlYebuI7TaYnp3gTDl75w+tXjIKT/hOWaR+ut/ML5nY2Q6S7PUg2F5FaILk27K131
	GprBDOayxuN5Chh52qdx0NAzmNmNeIzL/InXJTwvLrSJMzQFZy8ZAPGpsTdDtn7z9sCNmzgPqQ/
	QSdmk5uF6yoIZ/IItJsGjtsbogY78CpD52tfMNCO+cjSq5cGWj4Zqz4Fx2qFkfGcbnJL2EGVcXb
	WVQmPObHRRxqzjtQLpNTs2XxwszafNSZ4dm21n4yW4YMNxCA1BMLSR2Q==
X-Received: by 2002:a05:600c:1d25:b0:485:4388:348b with SMTP id 5b1f17b1804b1-485438835c1mr45378785e9.0.1773148739899;
        Tue, 10 Mar 2026 06:18:59 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:43dd:a0ed:65ba:bc74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541a8d4desm73621535e9.8.2026.03.10.06.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:18:58 -0700 (PDT)
Date: Tue, 10 Mar 2026 14:18:54 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 1/4] landlock: Fix kernel-doc warning for
 pointer-to-array parameters
Message-ID: <abAaPmuYskAkubF9@google.com>
References: <20260304193134.250495-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260304193134.250495-1-mic@digikod.net>

On Wed, Mar 04, 2026 at 08:31:24PM +0100, Mickaël Salaün wrote:
> The insert_rule() and create_rule() functions take a
> pointer-to-flexible-array parameter declared as:
> 
>   const struct landlock_layer (*const layers)[]
> 
> The kernel-doc parser cannot handle a qualifier between * and the
> parameter name in this syntax, producing spurious "Invalid param" and
> "not described" warnings.
> 
> Introduce landlock_layer_array_t as a typedef for the flexible array
> type so the parameter can be written as:
> 
>   const landlock_layer_array_t *const layers
> 
> This is the same type but kernel-doc parses it correctly, while
> preserving the pointer-to-array type safety that prevents callers from
> accidentally passing a pointer to a single element.
> 
> Cc: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/landlock/ruleset.c | 4 ++--
>  security/landlock/ruleset.h | 8 ++++++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index 419b237de635..a61ced492f41 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -108,7 +108,7 @@ static bool is_object_pointer(const enum landlock_key_type key_type)
>  
>  static struct landlock_rule *
>  create_rule(const struct landlock_id id,
> -	    const struct landlock_layer (*const layers)[], const u32 num_layers,
> +	    const landlock_layer_array_t *const layers, const u32 num_layers,
>  	    const struct landlock_layer *const new_layer)
>  {
>  	struct landlock_rule *new_rule;
> @@ -205,7 +205,7 @@ static void build_check_ruleset(void)
>   */
>  static int insert_rule(struct landlock_ruleset *const ruleset,
>  		       const struct landlock_id id,
> -		       const struct landlock_layer (*const layers)[],
> +		       const landlock_layer_array_t *const layers,
>  		       const size_t num_layers)
>  {
>  	struct rb_node **walker_node;
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 9d6dc632684c..87d52031fb5a 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -37,6 +37,14 @@ struct landlock_layer {
>  	access_mask_t access;
>  };
>  
> +/*
> + * Flexible array of Landlock layers, used for pointer-to-array function
> + * parameters that reference either a stack-allocated layer array or a rule's
> + * flexible array member (struct landlock_rule.layers).  This typedef avoids
> + * the complex (*const name)[] syntax that the kernel-doc parser cannot handle.
> + */
> +typedef struct landlock_layer landlock_layer_array_t[];
> +
>  /**
>   * union landlock_key - Key of a ruleset's red-black tree
>   */
> -- 
> 2.53.0
> 

Thanks for the reminder on the other thread; I skipped over this one
indeed. I am hesitant about this patch because it seems to be at odds
with the Linux kernel coding style on the use of typedef:

https://www.kernel.org/doc/html/v4.17/process/coding-style.html#typedefs

It says:

    the rule should basically be to NEVER EVER use a typedef unless
    you can clearly match one of those rules.

The rules being:

    (a) totally opaque object whose contents we want to hide
        (I don't think that is the purpose here; the example in
	the style guide is to keep generic code from playing with
	hardware-specific page table entry structures)
    (b) integer types (not applicable)
    (c) when using sparse (not applicable)
    (d) some types identical to C99 types (not applicable)
    (e) types safe for use in userspace (not applicable)

It seems that the easier option might be to drop the "const" between
the pointer and the type, if apparently we are the only ones doing
this?

FWIW, I have put these consts as well to be consistent with Landlock
style, but I am also not convinced that they buy us much;

* In a type like "const u8 *buf", when the type is part of a function
  signature, that is a guarantee to the caller that the function won't
  modify the buffer contents through the pointer.

* However, in a type like "u8 *const buf", the const is not a
  guarantee to the caller, but only a constraint on the function
  implementation that the pointer is not rewired to point elsewhere.
  It is not clear to me that this adds much in implementation safety.

WDYT?

—Günther
