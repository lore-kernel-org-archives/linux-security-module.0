Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A145C83F17
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Aug 2023 18:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbjH3Sqk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343609AbjH3QO2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Aug 2023 12:14:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26251A3
        for <linux-security-module@vger.kernel.org>; Wed, 30 Aug 2023 09:14:23 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c3c8adb27so728230166b.1
        for <linux-security-module@vger.kernel.org>; Wed, 30 Aug 2023 09:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693412062; x=1694016862; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J+IbjS4hQ1xrZMoTCi3gEShIbmawdzOCZjpHyuEsjwE=;
        b=Gnl7aNzYPtrmKPd2soG+AnuedyHsV2D6aANBFj+BUNr8B2CVnLSa/KzP4KnFrXWXbf
         Z+EvRqCVV8h5nV0fAfnHXwovd3gIxFK5nzgV8k4/DTh+HBtLMR7xYpbO1MsjfoqYT4EX
         ooJGRfidtAMiAXmB9L5UaRJBhTFbI7ttviMCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693412062; x=1694016862;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+IbjS4hQ1xrZMoTCi3gEShIbmawdzOCZjpHyuEsjwE=;
        b=aax2KiUYw1Cc+Hjrs5rFubAGopxhI6t5q/AXYaEC9WfVSNz7BLQeaqLsLPGD5WlhyQ
         aeuENvzHPhAx0X+Hwj9gcthHjNxgBVBjdoLAsZgVmcO+l8sjX+7ayN+NueECnLHxWKbp
         r6TPVp7BXTdXb2fb0zEjKdV6p1xFa455D8+Qmo0Bj0fEAgF/eYUD9epfRi2q5PEL/AQg
         T5UwquZ41gosQ+Qf/uGvBNL05gaAGbJHl50gXIAWhgqFXGLF9ljoVBl48nIi3hV373YP
         N26QkehazHojfuD5qMMEZcD3ezV1zcu7461r+lxB4NCYSvcY5JbRPtekMm+7wGGfzrO+
         6WLg==
X-Gm-Message-State: AOJu0YwatrXW/6eHA0f6152x44GVcB6oYbUWOB7lFeXlZAXaSRA6dVeI
        gAJ5q0fE710hLgTPQEjHmvyvuzPAipbVZKhu96kQmZr1
X-Google-Smtp-Source: AGHT+IFAxqHiNTODZT7nWjgq4UF+3/RzJbMMCzXx6gC6zmuQnyxmnNXrw9vcluVCBE9BzWqFAEDg/A==
X-Received: by 2002:a17:906:2d9:b0:9a1:d79a:4193 with SMTP id 25-20020a17090602d900b009a1d79a4193mr2086317ejk.23.1693412061941;
        Wed, 30 Aug 2023 09:14:21 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id w26-20020a1709064a1a00b009786c8249d6sm7457464eju.175.2023.08.30.09.14.21
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 09:14:21 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-52a49a42353so7889449a12.2
        for <linux-security-module@vger.kernel.org>; Wed, 30 Aug 2023 09:14:21 -0700 (PDT)
X-Received: by 2002:a17:906:518e:b0:99e:1201:48bc with SMTP id
 y14-20020a170906518e00b0099e120148bcmr2002148ejk.64.1693412060814; Wed, 30
 Aug 2023 09:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQQqQCdcSdb7G8v1ZHU8zn0XJZ6hS0rbGufAuZyPSCDCA@mail.gmail.com>
In-Reply-To: <CAHC9VhQQqQCdcSdb7G8v1ZHU8zn0XJZ6hS0rbGufAuZyPSCDCA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Aug 2023 09:14:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgvT9yJT+QwWHArnO7c64_g3kXzMi5xr7j-a55kZAdGhg@mail.gmail.com>
Message-ID: <CAHk-=wgvT9yJT+QwWHArnO7c64_g3kXzMi5xr7j-a55kZAdGhg@mail.gmail.com>
Subject: Re: [GIT PULL] LSM patches for v6.6
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 29 Aug 2023 at 16:37, Paul Moore <paul@paul-moore.com> wrote:
>
> Ten LSM patches for the Linux v6.6 merge window, and while most of
> them are fairly minor, there is at least one merge conflict involving
> security_sk_classify_flow() in security/security.c; it looks like a
> netdev constification patch collided with a LSM documentation patch,
> thankfully the solution is relatively simple but if for some odd
> reason you need a respin let me know.

Oh, no, trivial things like these are truly not a problem at all.

The only time I may ask people to help with the resolution (or, more
commonly, ask them to just double-check what I did) is when there is
an actual and subtle code conflict where the code in question has been
re-organized a lot, and both sides did something fairly involved, and
the end result isn't really obvious.

For something like this, I do ask for it to be noted in the pull
request - exactly like  you did - but even that is mainly so that

 (a) I don't get surprised when I do the pull and see that I need to
resolve something, and

 (b) to give me the warm and fuzzies that the maintainers in question
have actually noticed and followed up on the reports from linux-next.

So absolutely no need for any re-spin, and you did the right thing. Thanks,

                      Linus
