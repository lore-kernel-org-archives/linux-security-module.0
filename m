Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A059C04AA7
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Sep 2023 15:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbjITPsU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbjITPsT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Sep 2023 11:48:19 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E302BA3
        for <linux-security-module@vger.kernel.org>; Wed, 20 Sep 2023 08:48:13 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-565e54cb93aso4110351a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 20 Sep 2023 08:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695224892; x=1695829692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JG6AMx69HAwK3LvGawCCvsiysMo16gJkJBfu4krPdX4=;
        b=L6cQHymBGBbw4mCcBEECSQ1ouVljdF71w1E83JxX+tX0t4RKg2Dx0h9lKTLEQKeMwK
         xoyJXaZ9Ac3MrjuKyjF1j6gnEHDDyTU9sArG4I2ZY7ZgnO01OCdvCBXBrWwBRTXW3mWV
         Qht773L/wU/Bc41ikWoMHTA/CB539WL0JO310=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695224892; x=1695829692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JG6AMx69HAwK3LvGawCCvsiysMo16gJkJBfu4krPdX4=;
        b=jnqyLfsABV3jvOBRazXBeSJ9GX2w+mgWquEZ8UQI9OC59f5ZMdu1qctre4KDrqxEMp
         UnFuzaPUYioZfkjZ/lE5+S5arI0JsbhxCtKsDqsvHr8Rr71fYnTJsDycdijzCavXLFnb
         DJ4YoLPxMuCY6IqdWXLq0qHyHS4efnaFos15eicsdrQtyhAj6G8XmrMltlmqJ8D5f1XK
         hUR2/AKehHms69jR5JghlEL/5jRV7XAfEgEMGNxGy9NGU1hPYec3pMAMOXybXl1ZFf/e
         6ogMuKkhxUFy0qtD3X3gNY3m3PP+vGAvF4zy7lvaPNTVE54M22FxRSUOjmftfAk8Wihm
         ZN1g==
X-Gm-Message-State: AOJu0Yyn8o1fXx2r0ulJEGWDyxVbTz84ce9uUluJsa6XomyQlbbubMzX
        HvW/N340GgJeA3/fzdd1M2ogcw==
X-Google-Smtp-Source: AGHT+IF3jUYC3V9O4e6ev1/IQ/oataOazO91sNIhbn8jC3dux8A4pM5zLj/0IGha9pWLZSSePT1FLA==
X-Received: by 2002:a17:90b:60f:b0:271:9237:a07f with SMTP id gb15-20020a17090b060f00b002719237a07fmr3157518pjb.32.1695224892075;
        Wed, 20 Sep 2023 08:48:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bb18-20020a17090b009200b0026fb228fafasm1489400pjb.18.2023.09.20.08.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:48:11 -0700 (PDT)
Date:   Wed, 20 Sep 2023 08:48:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org,
        Kui-Feng Lee <sinquersw@gmail.com>
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
Message-ID: <202309200847.975DE8B704@keescook>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-3-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918212459.1937798-3-kpsingh@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 18, 2023 at 11:24:56PM +0200, KP Singh wrote:
> These macros are a clever trick to determine a count of the number of
> LSMs that are enabled in the config to ascertain the maximum number of
> static calls that need to be configured per LSM hook.
> 
> Without this one would need to generate static calls for (number of
> possible LSMs * number of LSM hooks) which ends up being quite wasteful
> especially when some LSMs are not compiled into the kernel.
> 
> Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org
> Signed-off-by: KP Singh <kpsingh@kernel.org>

I may extract this into a separate header in the future -- I have plans
to make strscpy() take a variable number of arguments. ;) Regardless,
for the LSM usage:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
