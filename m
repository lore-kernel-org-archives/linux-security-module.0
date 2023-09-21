Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552DBE7D0A4
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Sep 2023 17:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjIURu3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 21 Sep 2023 13:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjIURuD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 Sep 2023 13:50:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0EB400D4
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 10:15:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29983C4163C
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 08:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695286409;
        bh=yWOM98GrJUSl/51rD4fzrw/49rcFITI86C4+kaaw8lA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HswWjIdiL0FJ2BzSTQcfNhVEUsrZxCUmCJWXTl1y418/TWIWZEDnurJOSv7Q2F+ZH
         vNvW7yK6lOjwgi/zeB5ggItUhhvva1jMthuTwjvD9Q4LTwUyidx3ZCpIgqVQDLGWM9
         oPjfufdXRo+mRPXvXCmAPcF/mvIUSWIJo0PnI5crbeduzaReDECxJOVLkGPJDCjLwE
         p+LvE7wOub5NIdbds03ZtRqZUx4j7jmolgkjwNjfBG8LbI3FB2F8fjYF3iZ5ms1rP6
         Tc2JvYSVq3a9lwA/khojl4+Gep5vlYxKcAcGPPCtn5k/E/S7vQJLp1Lhyn2mGxWlJM
         8EM+4xaCU0mbA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-53339349956so572364a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 01:53:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YxBpVYMx26K6HYtUB4g70uHEtT6duIwee5sUsZzitcVTWM/p47V
        wYH9GY5VY4z0I2KTiEmsPB+h4f0GxIkoJW//Fd/BZw==
X-Google-Smtp-Source: AGHT+IFODSX0/bLsjx987uQ54fAeDFKQvhKE55UvUQ0zcQvqwsDaNR5e0PTrcMAcc47n1yRlUIq3R8O5zVXOKtRTgQo=
X-Received: by 2002:aa7:c547:0:b0:522:31d5:ee8e with SMTP id
 s7-20020aa7c547000000b0052231d5ee8emr4474297edr.8.1695286407631; Thu, 21 Sep
 2023 01:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230918212459.1937798-1-kpsingh@kernel.org> <20230918212459.1937798-6-kpsingh@kernel.org>
 <202309200840.722352CCB@keescook>
In-Reply-To: <202309200840.722352CCB@keescook>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 21 Sep 2023 10:53:16 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7H=3g01T75mV8Ni+9+WrPbFzj1H9zsNhmUGvvuD0JY4A@mail.gmail.com>
Message-ID: <CACYkzJ7H=3g01T75mV8Ni+9+WrPbFzj1H9zsNhmUGvvuD0JY4A@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

[...]

> > +config SECURITY_HOOK_LIKELY
> > +     bool "LSM hooks are likely to be initialized"
> > +     depends on SECURITY
> > +     default y
> > +     help
> > +       This controls the behaviour of the static keys that guard LSM hooks.
> > +       If LSM hooks are likely to be initialized by LSMs, then one gets
> > +       better performance by enabling this option. However, if the system is
> > +       using an LSM where hooks are much likely to be disabled, one gets
> > +       better performance by disabling this config.
>
> Since you described the situations where it's a net benefit, this could
> be captured in the Kconfig too. How about this, which tracks the "major"
> LSMs as in the DEFAULT_SECURITY choice:
>
>         depends on SECURITY && EXPERT
>         default BPF_LSM || SECURITY_SELINUX || SECURITY_SMACK || SECURITY_TOMOYO || SECURITY_APPARMOR\

I think for BPF_LSM the option would not be y. But yeah I like this suggestion.

>
>
> --
> Kees Cook
