Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EA7C4332F
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Nov 2022 02:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiKPCf6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 15 Nov 2022 21:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiKPCf5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Nov 2022 21:35:57 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDE627935
        for <linux-security-module@vger.kernel.org>; Tue, 15 Nov 2022 18:35:56 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id y203so16182008pfb.4
        for <linux-security-module@vger.kernel.org>; Tue, 15 Nov 2022 18:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LsUkQ9mUTtmbZUYtAJD3DaSoBhry/tgp9n6xBguz4lI=;
        b=BCeqLLVGH2R8cvfyP4TzIQJp8FsuwwIaDb5fGlWXYWyEVoWZ4CecVwo/6hlZ0wvZMN
         8lB+4IedPpag9pnDwUu3fp+CJiiyRKyRfgLgWZBq6lj5OYXr/GMQ/6PmrLoOHQfF5F2F
         8JPKsCFZ2mp6UveVHoxNpH1BZrdNrYCH5iHsdmqHFkvPqarKWe3Q7LLEuojD5USAVfMj
         yyBjNbC6D65G4sTN7czLTqdLrM4Ikx6MbVH8WtwwBi+3ICbpjQWQG9mmMD2Ji468yFPK
         DL8QrJaSyUJEgplPEa2/dcuu4sVbqCCLEbNJDN0nLWJD+h+eIvwqsVlKbCuZAL7FP47K
         IxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsUkQ9mUTtmbZUYtAJD3DaSoBhry/tgp9n6xBguz4lI=;
        b=GotLMcXrprMEmOnVux8hwABnkRndHxU6YWaz1V/X9tyay49tHpKCePpGJ/Ud1xtbF3
         S/YAv278/DTlKokfadzJ2J4P8GmwIZZHS8SBmMX9y5jSdXVeG3AGhS64ywJefWaFq6da
         IQRAbhQgQmjbSXBYJxwP8HQzaz5FIO06O+8HgKeVVIh9452imGWVAriFX2/0VmcGREGp
         ZqN4tXqhPWW3T+y86d8GBb4lPoqRYcoCRYg9Nw74fa8Q7WRGHBojL/5iuqP3Q0D/wLOI
         XqpZjBmnQXL4e8x8IBeDmkvPD2OUnbx6+rOUjTmnUpVspJLO4yOYKwPlE2IF5PcMtJyt
         DxVw==
X-Gm-Message-State: ANoB5plZ5vs/VVK+VyJuZVdIXs8AYQ/W2d+ooQhdMO74hVdzumJIZvir
        wgguamiTIPW+iBqFal/hEbgyA1iKEuNKfe3na70M
X-Google-Smtp-Source: AA0mqf5CJnhn5qnkSOJep/sQV/5oppCSnD92JqMIf6aCUDEsrMG3l9LTpaW0nNXIgzolcSBlOiuoKMQ31Wut3i9jIHY=
X-Received: by 2002:a63:4087:0:b0:44e:46f9:7eeb with SMTP id
 n129-20020a634087000000b0044e46f97eebmr18693190pga.3.1668566155982; Tue, 15
 Nov 2022 18:35:55 -0800 (PST)
MIME-Version: 1.0
References: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com> <20221115175652.3836811-5-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221115175652.3836811-5-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Nov 2022 21:35:44 -0500
Message-ID: <CAHC9VhQ+fUZfJwJ=oJ9ieszKeicnS7Z-QcJuJVL9HF5F0tcA7Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 4/4] security: Enforce limitations on return values
 from LSMs
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, revest@chromium.org,
        jackmanb@chromium.org, jmorris@namei.org, serge@hallyn.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 15, 2022 at 12:58 PM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> LSMs should not be able to return arbitrary return values, as the callers
> of the LSM infrastructure might not be ready to handle unexpected values
> (e.g. positive values that are first converted to a pointer with ERR_PTR,
> and then evaluated with IS_ERR()).
>
> Modify call_int_hook() to call is_ret_value_allowed(), so that the return
> value from each LSM for a given hook is checked. If for the interval the
> return value falls into the corresponding flag is not set, change the
> return value to the default value, just for the current LSM.
>
> A misbehaving LSM would not have impact on the decision of other LSMs, as
> the loop terminates whenever the return value is not zero.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/security.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

Casey touched on some of this in his reply to patch 0/4, but basically
I see this as a BPF LSM specific problem and not a generalized LSM
issue that should be addressed at the LSM layer.  Especially if the
solution involves incurring additional processing for every LSM hook
instantiation, regardless if a BPF LSM is present.  Reading your
overall patchset description I believe that you understand this too.

If you want to somehow instrument the LSM hook definitions (what I
believe to be the motivation behind patch 3/4) to indicate valid
return values for use by the BPF verifier, I think we could entertain
that, or at least discuss it further, but I'm not inclined to support
any runtime overhead at the LSM layer for a specific LSM.

-- 
paul-moore.com
