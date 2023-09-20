Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6EDC04AA9
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Sep 2023 16:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbjITQAU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 Sep 2023 12:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbjITQAT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Sep 2023 12:00:19 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9862CD3
        for <linux-security-module@vger.kernel.org>; Wed, 20 Sep 2023 09:00:11 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6c0a42a469dso4369642a34.2
        for <linux-security-module@vger.kernel.org>; Wed, 20 Sep 2023 09:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695225611; x=1695830411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GARuZLjax5ZehW3tqP+adtXUOBpLk790EcyUIQ2WXt8=;
        b=eqYAJPTGONkRqh84dgtBN/q1aMrTpM20SENuFj1qmntW+R+40utMbeKL+9Y7VxRR9k
         zEjJBgTbSbW8DXWxk9xsPy5YFvLTreWkyITxocrGu9avn+hUGBjs7JoEMOP1busYz+na
         a4jjE+R0D01BMEWiJn270M94MwdyIf6JRF6D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695225611; x=1695830411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GARuZLjax5ZehW3tqP+adtXUOBpLk790EcyUIQ2WXt8=;
        b=NsNaAf3iV0EsQerrrH0yNRdcGqkXf8arRgJvDSJFBV4zllaZI6nDIITQ2Xa2dfXCfW
         IZ8daZYY+UaXLDWjtUGNWSKjw2iXnkbbSbW7DL/P4aCTPzHxawXBNy5K5N/ebj96od/i
         J/kydBx8NEcN3Slpd8r39LAGrGmdiUUxeZSjQifNJ4gyGc4uCtjvZgeXrehGdAx2yfzU
         UBpF87B5zmChxk2VeVZLWpxhDuVx3s1FAmwxhCnBIdrVVS+9iOYetwhFXNsYgjDgu68p
         sRaPEm2adWN9p9A2KwgVK/GwsHoLOjUUvTc7BcY/+C3MfST8yTSwFNCm7M6xWCCykske
         L8kQ==
X-Gm-Message-State: AOJu0Yy6XFUxHLFHlnPjNdR6VMSvrlY3w9awlzYr6vUXqI9NZAffoUzx
        GrjivoKeQdazqTPN5576S/5wMA==
X-Google-Smtp-Source: AGHT+IG+VqDNgI7sB2xdy/PCcSuPtd/kb07w3J4N/Vw2FSOKK2lG5rBkUWZUgWkl2Y2PTEjT0/xe5g==
X-Received: by 2002:a05:6358:50cc:b0:133:a55:7e26 with SMTP id m12-20020a05635850cc00b001330a557e26mr4173746rwm.7.1695225610811;
        Wed, 20 Sep 2023 09:00:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e9-20020a63ae49000000b00578f1a71a91sm546785pgp.79.2023.09.20.09.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 09:00:10 -0700 (PDT)
Date:   Wed, 20 Sep 2023 09:00:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org
Subject: Re: [PATCH v3 4/5] bpf: Only enable BPF LSM hooks when an LSM
 program is attached
Message-ID: <202309200859.D8E31893F4@keescook>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-5-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918212459.1937798-5-kpsingh@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 18, 2023 at 11:24:58PM +0200, KP Singh wrote:
> [...]
> +void bpf_lsm_toggle_hook(void *addr, bool value)
> +{
> +	struct lsm_static_call *scalls;
> +	struct security_hook_list *h;
> +	int i, j;
> +
> +	for (i = 0; i < ARRAY_SIZE(bpf_lsm_hooks); i++) {
> +		h = &bpf_lsm_hooks[i];
> +		scalls = h->scalls;
> +		if (h->hook.lsm_callback == addr)
> +			continue;
> +
> +		for (j = 0; j < MAX_LSM_COUNT; j++) {
> +			if (scalls[j].hl != h)
> +				continue;
> +			if (value)
> +				static_branch_enable(scalls[j].active);
> +			else
> +				static_branch_disable(scalls[j].active);
> +		}
> +	}
> +}

And this happily works with everything being read-only? I double-checked
these structures, and it seems like the answer is "yes". :)

So, to that end:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
