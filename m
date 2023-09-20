Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2700AC04FF1
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Sep 2023 19:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjITTYf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 Sep 2023 15:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjITTYe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Sep 2023 15:24:34 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9957594
        for <linux-security-module@vger.kernel.org>; Wed, 20 Sep 2023 12:24:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68fac16ee5fso135756b3a.1
        for <linux-security-module@vger.kernel.org>; Wed, 20 Sep 2023 12:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695237868; x=1695842668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sbkk6hz3XsIl+HyZho/PKECXy7y/OprsUmNHvfxO5Ic=;
        b=PuyaXsLW8bmQg9pl9NLPku49J91+nxRDXvRxSDP1C/o5ZSWSW3Iyv1PXnpHLtSizL7
         zeeZg/JcK94oZCWBimd4GvXDvNPqFmpmZtFEK18GQkQcUWAf1RMi8xo5H2q9Idfq/WeU
         o5HW6yWOXooVH3Sc6plnKtoFrrI7rwWZlLqy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237868; x=1695842668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbkk6hz3XsIl+HyZho/PKECXy7y/OprsUmNHvfxO5Ic=;
        b=RDJnTS1MCJ7X96poYj8LxGwM+7gJ/aMhAxhAHqXap7MtZECsKKo2sNSwUYVNnBtqJN
         NICOtWlNSFco7QYB+y8eSvyPR8lMS8S/Em2FrygVK6N77v3XsnFWaQRlerNVE+Q8dFzJ
         yqb6aD7Pnt0HU8qDkE1RFnnUfMukk1mQxoV8GM6pn/vKAOjZMjXDEauGma4m+QvM1s9N
         2g1hTAiNdhMv/C4FrKhEryLdbW265kKNgfRNSUYesU4ku0aE91ugdPBHRBXKOSkTIwGk
         Thjf5lfdJGUXmYZJ6Mgs5yV99KljkC7TuB94Rvdy6cQeGxtVtxrCwwyoph+t1ZpYInZT
         KqeA==
X-Gm-Message-State: AOJu0YxTSav+LqBO0LmbgcaBOEvvAgCHK6WYwk+0GBVCAbobl6ddJB7m
        mRlX60k4LQXVoNBywNnzVF10Qg==
X-Google-Smtp-Source: AGHT+IHRSye8QE+aWI++EX2U6GXV5VK/MwMR/Sxvbydxbkc0t16NEDXtfQUuSkg2yfOlJI1h0KfKsg==
X-Received: by 2002:a05:6a20:5485:b0:153:8754:8a7f with SMTP id i5-20020a056a20548500b0015387548a7fmr3943631pzk.4.1695237868064;
        Wed, 20 Sep 2023 12:24:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id dh2-20020a056a00478200b00690bd3c0723sm3366388pfb.99.2023.09.20.12.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:24:27 -0700 (PDT)
Date:   Wed, 20 Sep 2023 12:24:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, song@kernel.org, daniel@iogearbox.net,
        ast@kernel.org, Kui-Feng Lee <sinquersw@gmail.com>
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
Message-ID: <202309201221.205BA18@keescook>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-3-kpsingh@kernel.org>
 <98b02c73-295d-baad-5c77-0c8b74826ca9@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98b02c73-295d-baad-5c77-0c8b74826ca9@schaufler-ca.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/18/2023 2:24 PM, KP Singh wrote:
> [...]
> +#define __COUNT_COMMAS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _n, X...) _n
> +#define COUNT_COMMAS(a, X...) __COUNT_COMMAS(, ##X, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
> +#define ___COUNT_COMMAS(args...) COUNT_COMMAS(args)

Oh! Oops, I missed that this _DOES_ already exist in Linux:

cf14f27f82af ("macro: introduce COUNT_ARGS() macro")

now in include/linux/args.h as COUNT_ARGS():

#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _n, X...) _n
#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)

I think this can be refactored to use that?

-Kees

-- 
Kees Cook
