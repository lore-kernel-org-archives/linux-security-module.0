Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5B3E743D3
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Sep 2023 00:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjI2AlF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Sep 2023 20:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjI2AlE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Sep 2023 20:41:04 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A2111F
        for <linux-security-module@vger.kernel.org>; Thu, 28 Sep 2023 17:41:03 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3ae1916ba69so7206969b6e.2
        for <linux-security-module@vger.kernel.org>; Thu, 28 Sep 2023 17:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695948062; x=1696552862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XwfbFz7AC9k7AWBKDX0z2oZGXpJwVkw+x4UEe/Bp1hE=;
        b=XvTt8bAU4kO9540SuOhAJrnaQE8l8KyzNCkenBxMjk/XNXqospAG+TGmfUo+pWqx41
         9P1afxOfApN7hInDYvMF7bWdthHvc677sHidiq8RG7ziscsLglisfjsHm5L/bYGGzEjq
         uxYTW19bh+rj23G63iIsgDVRtn2BWc+IESN0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695948062; x=1696552862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwfbFz7AC9k7AWBKDX0z2oZGXpJwVkw+x4UEe/Bp1hE=;
        b=JUpYP3YhuKka6u6qIHhOTaBIHDFc4+6B2cA+eSBc7uddiGCpIl9cuWfin3aC6MjTOS
         alPcGwRMJ0XOKvl5giBgRUS6UN+7LG2KqiMHnIdYYbeWt4ZSzVCjigIYNdS7qDMNZYSZ
         PH0C29RYnAnohDtrLcy3/ZfGQ9xMZwgOLlI8DyRFCSa6CFRanuB7BnO1fWDvdrwqNnfd
         uKveQf67H2DVugG4Ke/tXrs5xJOFpQilQoJC3XzG57tg9QTt1pHQYEGhLTAlySF+UeBm
         MVQHHLJxO0tr0227QultSQwQlPUDdjxnI5IBoUrBHriezw8+2eXFtjmIFlaDi7Ric7Uk
         57Fg==
X-Gm-Message-State: AOJu0YyJ6XZlWdrG9Nv/fbBnFczH8xythL96RNmSl50C1bN6SBKqDbox
        jlMiN35Vi/HE/sEWXyLt1bOSnmZuJUbnzYp3p+U=
X-Google-Smtp-Source: AGHT+IGStMPCGiqWjdMWha4VKtzOWCbr0+OekdeT6elVf8RwYnXoPEb+KM1RB+dk/XjWJH2hc3gpbA==
X-Received: by 2002:a05:6808:148:b0:3a7:7988:9916 with SMTP id h8-20020a056808014800b003a779889916mr2649682oie.59.1695948062337;
        Thu, 28 Sep 2023 17:41:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i4-20020a63e444000000b0056428865aadsm13512890pgk.82.2023.09.28.17.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 17:41:01 -0700 (PDT)
Date:   Thu, 28 Sep 2023 17:41:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>, paul@paul-moore.com
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        casey@schaufler-ca.com, song@kernel.org, daniel@iogearbox.net,
        ast@kernel.org, renauld@google.com
Subject: Re: [PATCH v5 0/5] Reduce overhead of LSMs with static calls
Message-ID: <202309281739.7C2963BC7@keescook>
References: <20230928202410.3765062-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928202410.3765062-1-kpsingh@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 28, 2023 at 10:24:05PM +0200, KP Singh wrote:
> # Performance improvement
> 
> With this patch-set some syscalls with lots of LSM hooks in their path
> benefitted at an average of ~3% and I/O and Pipe based system calls benefitting
> the most.

Paul, FWIW, I think this series is ready to land in -next. I'd like it
to get some bake time there just to see if anything unexpected shows up.
It's quite happy in all my local testing, though.

-Kees

-- 
Kees Cook
