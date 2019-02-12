Return-Path: <SRS0=n6I0=QT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1E9C282CA
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Feb 2019 18:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE13222BB
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Feb 2019 18:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k4nWs+tD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfBLS1F (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:27:05 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46528 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbfBLS1E (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Feb 2019 13:27:04 -0500
Received: by mail-vs1-f66.google.com with SMTP id n10so2174243vso.13
        for <linux-security-module@vger.kernel.org>; Tue, 12 Feb 2019 10:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mUTN2kVgPr9Rtx3niaarjV1+OXsIe+jmKVNS7ZlRBbk=;
        b=k4nWs+tDNGy0ynHcSKhJ+yAvoxk4/6erIg4nXcXkJQmK+UDcuJ9ZTwwN36K9Xr0uaB
         oauBPEPeyWrsMPyZozjMHqxHjJ2/V0Td51Iqq7boFOHaDkQClRVwmQmbdm065mUFsOtJ
         2cPSfBQT8ibSF/TOK923MTXQoVBguBQGJ1fo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUTN2kVgPr9Rtx3niaarjV1+OXsIe+jmKVNS7ZlRBbk=;
        b=q7pSYVKaLlh4Fg1EivdEa44dUhl+q4FZu8vXEIrrLg3J3JtHfKlLsWKfPyiFVAzzp5
         lhRD4QVFP/lUQ0PSJmc+tCNAMqUleg9r1hFDzxAk6R0SV8NK1YXD8COkcpLN8I00oTV3
         uWFgkkkWrRYDGaJHDZ8OA0oesS6673i6MoAKSc2qzjFTr5nbDQdQTVAcLLmc169Cmd1V
         eoeBYKqdBBj5AdaC4OYuq3goRKWHur3tHOV4B8HryCzS07+w8JwOVcJLFmRgPz5Y27GX
         lLGC5ITJzN5WULAR7IO9duybEwI1YBl0hXn88+JFPRaSb6FwN5nWtP05Gjj886EdxZKG
         PEAA==
X-Gm-Message-State: AHQUAubojlUKWK6sDZtCUEfTVO/3DfFbkQtTjdI4ZCZgF8pA8u6IcgAD
        p7U6q9X31gL+GF71Gz5D5SLkcQ0cpgI=
X-Google-Smtp-Source: AHgI3IYhBe6dr10fppMrxYJsyq11UXCOqbTWW03YOOdYwuAr58oea+54wb255fYfwXpQ+rfM0ZrBaQ==
X-Received: by 2002:a67:f31a:: with SMTP id p26mr2170664vsf.113.1549996023391;
        Tue, 12 Feb 2019 10:27:03 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id e67sm11843214vsd.32.2019.02.12.10.27.02
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 10:27:02 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id b20so2191651vsl.9
        for <linux-security-module@vger.kernel.org>; Tue, 12 Feb 2019 10:27:02 -0800 (PST)
X-Received: by 2002:a67:848a:: with SMTP id g132mr2071837vsd.222.1549996021985;
 Tue, 12 Feb 2019 10:27:01 -0800 (PST)
MIME-Version: 1.0
References: <201902120021.x1C0LeYB051392@www262.sakura.ne.jp>
 <CAGXu5jJ86XosW71111EaaSKcVwzw+UYvi4j619KwoBn=DNwrNw@mail.gmail.com> <201902120059.x1C0xEbp071744@www262.sakura.ne.jp>
In-Reply-To: <201902120059.x1C0xEbp071744@www262.sakura.ne.jp>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 12 Feb 2019 10:26:49 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKH83LJxd=yHs3kAfnjVxX9wphpivwaKnqvByJHwoi4XQ@mail.gmail.com>
Message-ID: <CAGXu5jKH83LJxd=yHs3kAfnjVxX9wphpivwaKnqvByJHwoi4XQ@mail.gmail.com>
Subject: Re: [PATCH] LSM: Ignore "security=" when "lsm=" is specified
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 11, 2019 at 4:59 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Kees Cook wrote:
> > On Mon, Feb 11, 2019 at 4:21 PM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > >
> > > Kees Cook wrote:
> > > > To avoid potential confusion, explicitly ignore "security=" when "lsm=" is
> > > > used on the command line, and report that it is happening.
> > >
> > > To maintain the existing behavior of CONFIG_DEFAULT_SECURITY, I also suggest this change.
> > > This saves e.g. Ubuntu users who are using only AppArmor from explicitly specifying
> > > security=apparmor when they don't want to enable other LSM_FLAG_LEGACY_MAJOR modules.
> >
> > No, this completely disables the purpose of lsm=
> >
> > I don't understand the use-case you're concerned about?
>
> The purpose of lsm= remains.
>
> I worry that distro users who don't explicitly specify security= parameter
> suddenly find TOMOYO messages because TOMOYO is no longer exclusive.

What's wrong with that? TOMOYO will start, see there is no policy, and
not do anything else.

> There are two ways for avoiding it. One is to explicitly specify security=
> parameter. The other is to remove tomoyo from CONFIG_LSM. This change adds
> the third way; preserve current security= behavior until they start explicitly
> specifying lsm= parameter.

"security=" has been deprecated due to the many many threads about how
it won't work moving forward. Leaving the CONFIG settings confuses the
situation and needlessly drags out the transition for no real gain.

But yes, if someone selects a "legacy major" LSM, the others
(including TOMOYO) will be disabled, which matches the old behavior.
Also, yes, removing it from CONFIG_LSM works; this is up to the distro
to decide.

-- 
Kees Cook
