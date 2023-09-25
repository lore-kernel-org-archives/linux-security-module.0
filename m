Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99246CE7A97
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Sep 2023 22:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjIYWCV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Sep 2023 18:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIYWCU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Sep 2023 18:02:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FD2116
        for <linux-security-module@vger.kernel.org>; Mon, 25 Sep 2023 15:02:13 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so50849115ad.0
        for <linux-security-module@vger.kernel.org>; Mon, 25 Sep 2023 15:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695679333; x=1696284133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jIm/cOjAUf8gm+eb/2LJmZ6n9G3ThUBS4oFwikE7Fu8=;
        b=lKK+VgGbVlU1oQ2MOdySSS9+mO7bWnOkfcjYYEpv+nrEc16Z0K0IHnvrT+G94vzyNs
         O4kZSnQHoPc048nrROdEQo0hvBoNQRbKx9wjNuSgUj7kxbG3aj53A0+SYrBn/9kjwRDJ
         ycFQKUKUMSxFAOST/58bF4DmWWyTZqAfFAb9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695679333; x=1696284133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIm/cOjAUf8gm+eb/2LJmZ6n9G3ThUBS4oFwikE7Fu8=;
        b=bE6lZesxdDEJMB5F8vUMSLs6FazWFJEYeksL7wpzS8pFF2iMNpFE7oopACNZf7rZAd
         Dr6+H7AD6dcxnCvtUq8oEY4K2WTThR7Bl9JLa+I6j1Ou/8g3OlFl+4IK94jazxq9Dnqn
         f+kBjF6vlvUKMqam8EMXo5PqJA34eZmy6TU0M+nD5WXzh1nPC3rH5FzIn3jL5Jjh077r
         MUfZjf1fHOF+vZBYpHu4qs1Nrd/dWsnX0n8XrLT43Iz6FW7SjsuVc+Bq3LYdXDGje8KF
         JmrZBZkdikwC8HVxJaDnRPyc9dB3EVmhG5XvM7NrqBu3BRenM20IIeVQdoUWmXV6Ke/D
         qkmQ==
X-Gm-Message-State: AOJu0Yyqt4LATijMR9pkSfYnhk3XGqgX8ZNiEZV/D51jClVovEhNdV5t
        36tNoLiFxhASSI7zPxSPUEDsSw==
X-Google-Smtp-Source: AGHT+IGp1td/ukjkCNci2jzFtAsWNrJSOxLnJChMCPfFPTaLkvfQN/uCFTw0eypjSXm48FWFmTLuEg==
X-Received: by 2002:a17:902:ced2:b0:1bd:a42a:215e with SMTP id d18-20020a170902ced200b001bda42a215emr7198535plg.38.1695679333053;
        Mon, 25 Sep 2023 15:02:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902ce8900b001c5076ae6absm9418062plg.126.2023.09.25.15.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 15:02:12 -0700 (PDT)
Date:   Mon, 25 Sep 2023 15:02:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, renauld@google.com
Subject: Re: [PATCH v4 0/5] Reduce overhead of LSMs with static calls
Message-ID: <202309251500.B80E2D66@keescook>
References: <20230922145505.4044003-1-kpsingh@kernel.org>
 <20230922184224.kx4jiejmtnvfrxrq@f>
 <CACYkzJ67gw6bvTzX6wx_OtxUXi6kpVT196CXV6XCN1AaGQuKAw@mail.gmail.com>
 <CAGudoHE+od5oZLVAU4z3nXCNGk6uangd+zmDEuoATmDLHeFLGQ@mail.gmail.com>
 <CAGudoHFiVLmaMbFJno47_-x3Rs2tvgXNKyNznJeCq_cF8hFVvA@mail.gmail.com>
 <202309231925.D9C4917@keescook>
 <CAGudoHHm-ofzATMdE_HU2e0voKiQnkkcL+1+F73azxNeHCvYSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHHm-ofzATMdE_HU2e0voKiQnkkcL+1+F73azxNeHCvYSA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 25, 2023 at 10:08:39PM +0200, Mateusz Guzik wrote:
> On 9/24/23, Kees Cook <keescook@chromium.org> wrote:
> > That said, I've long advocated[1] for a way to explicitly disable LSMs
> > without affecting operational ordering. I think it would be very nice to
> > be able to boot with something like:
> >
> > lsm=!yama
> >
> > to disable Yama. Or for your case, "lsm=!tomoyo". Right now, you have to
> > figure out what the lsm list is, and then create a new one with the
> > LSM you want disabled removed from the list. i.e. with v6.2 and later
> > check the boot log, and you'll see:
> >
> > LSM: initializing lsm=lockdown,capability,landlock,yama,integrity,apparmor
> >
> > If you wanted to boot with Yama removed, you'd then pass:
> >
> > 	lsm=lockdown,capability,landlock,integrity,apparmor
> >
> > As a boot param. But I think this is fragile since now any new LSMs will
> > be by-default disabled once a sysadmin overrides the "lsm" list. Note
> > that booting with "lsm.debug=1" will show even more details. See commit
> > 86ef3c735ec8 ("LSM: Better reporting of actual LSMs at boot").
> >
> > So, if a distro has no support for an LSM but they want it _available_
> > in the kernel, they should leave it built in, but remove it from the
> > "lsm=" list. That's a reasonable bug to file against a distro...
> >
> 
> Maybe I once more expressed myself poorly, I meant to say stock Debian
> does not ship any tooling for tomoyo, but the kernel has support
> compiled in.

If there is no tooling Debian should either not build the support into
the kernel or should leave it out of the CONFIG_LSM list.

> Ultimately, after stacking got implemented, it was inevitable diestros
> like Debian will enable whatever modules and expect them to not be a
> problem if not configured by userspace.
> 
> I don't think any form of messing with CONFIG_LSM is a viable option,
> even if you make it a boot param.
> 
> What should happen instead is that modules which are not given any
> config don't get in the way.

Right -- this is an open problem, and I think we can solve it using the
static_call system (much like how the BPF LSM is doing it).

-Kees

-- 
Kees Cook
