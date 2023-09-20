Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049D7C04AA9
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Sep 2023 15:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbjITPyd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbjITPyc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Sep 2023 11:54:32 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C2FC6
        for <linux-security-module@vger.kernel.org>; Wed, 20 Sep 2023 08:54:26 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-27666e94ad7so771806a91.0
        for <linux-security-module@vger.kernel.org>; Wed, 20 Sep 2023 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695225266; x=1695830066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cvzJPQO/bADTYnKAw8CDtr04xbcONw8HjKLsAZQM774=;
        b=QdmQFYlf8kJ5ERGCY6MN5OwJC8rcuoNumDIOpHBk3/gUr+DyHaHgWJndKqmLmZZvim
         WdbLzHs44mTFFRFsj/4FfJihZy9IEIZSqWQRbdgfWVN5GZUCnRxRsfmZ9dv9GvKd5A2U
         Bs2klVY2CFvLt4TwP+0KaTL1Yth83rPyA0IdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695225266; x=1695830066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvzJPQO/bADTYnKAw8CDtr04xbcONw8HjKLsAZQM774=;
        b=rxi5Y4m2fSSFG6n2DFXRBDQ406yQPlnD4yVog1uryq4LfPTvOBgPxa1252pkn/2O/E
         VA3NHl5vO7PXwenaZH1i6RqMcRH4CFsfsjIA/cKNHsOHlWGdHVPKyIQPdixGMSpZoerP
         GHee+uWn9UKvqGoRssimcpi6SOTgCNqL3FQxZEPHoKnuW1DRc/svFd0EDGnXSGkj/xtE
         DhIYWT2gIsoqL39FKrQ4JEnuIE9BUke8qG3m3B29gUNdRMMheI9gTPVG9D6VCH5Lf2UN
         HI8IkwSSGZWLZKR1x6tktggD3gprgTE+RQg9fbdo2gKEG5At/KITcT6he5MMbABSQPnv
         3FHQ==
X-Gm-Message-State: AOJu0YwDvPR2FZSPBtK/tOm97tHEMfuZ6APikPbqtOo+CQAI7HErwIsF
        C92LycwynV3kb1IdYJbpRrOfgQ==
X-Google-Smtp-Source: AGHT+IG4/LCvBOh0cOC4pD2Z/5P+TJilImO7/jqJyK2O5LkDYpzfajqXXpz5jfN2q0iv2SzN27CkkA==
X-Received: by 2002:a17:90a:db82:b0:26b:513a:30b0 with SMTP id h2-20020a17090adb8200b0026b513a30b0mr4468518pjv.10.1695225257588;
        Wed, 20 Sep 2023 08:54:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s62-20020a17090a69c400b002682523653asm1599254pjj.49.2023.09.20.08.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:54:16 -0700 (PDT)
Date:   Wed, 20 Sep 2023 08:54:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org
Subject: Re: [PATCH v3 3/5] security: Replace indirect LSM hook calls with
 static calls
Message-ID: <202309200848.7099DFF1B@keescook>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-4-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918212459.1937798-4-kpsingh@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 18, 2023 at 11:24:57PM +0200, KP Singh wrote:
> LSM hooks are currently invoked from a linked list as indirect calls
> which are invoked using retpolines as a mitigation for speculative
> attacks (Branch History / Target injection) and add extra overhead which
> is especially bad in kernel hot paths:

I feel like the performance details in the cover letter should be
repeated in this patch, since it's the one doing the heavy lifting.

> [...]
> 
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Regardless, this is a nice improvement on execution time and one of the
more complex cases for static calls.

> -struct security_hook_heads {
> -	#define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
> -	#include "lsm_hook_defs.h"
> +/*
> + * @key: static call key as defined by STATIC_CALL_KEY
> + * @trampoline: static call trampoline as defined by STATIC_CALL_TRAMP
> + * @hl: The security_hook_list as initialized by the owning LSM.
> + * @active: Enabled when the static call has an LSM hook associated.
> + */
> +struct lsm_static_call {
> +	struct static_call_key *key;
> +	void *trampoline;
> +	struct security_hook_list *hl;
> +	/* this needs to be true or false based on what the key defaults to */
> +	struct static_key_false *active;
> +};

Can this be marked __randomize_layout too?

Everything else looks good to me. I actually find the result more
readable that before. But then I do love a good macro. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
