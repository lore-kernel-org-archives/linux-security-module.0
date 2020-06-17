Return-Path: <SRS0=EaTW=76=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D70C433E0
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Jun 2020 15:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B51A320897
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Jun 2020 15:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ojk5dxH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgFQPZh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 17 Jun 2020 11:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgFQPZg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Jun 2020 11:25:36 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F552C06174E
        for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2020 08:25:36 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id m26so1527415lfo.13
        for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2020 08:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6nIuDWwcfkNRxXhFGKJnyws0bUwaKcz08/Ho8g5tJI=;
        b=Ojk5dxH9+DvMUGom64AEv7XfBLXa9lBuwrzwGTnlOsPxiMkrbDSwj3LZ3zSHPWkGyz
         9ToRm9j64HKaH0C201cTSBPfUeD4L0jyv5gL+/6/qmIuqmzEXURqwTgpPiQXDB2VaGwF
         qZGvTCrWNr19Q9uHIQ+fcZ1aHaKDOq/bAgerWk0+0yn6/A9lDR5bDmAYvM4uNp9prxVZ
         6DKX/iKAs8nUP3ny4EOtz7D3j7wO3sIdHgCvXEeJ9MwLbCjJEVdGxS6Z/XsWBmYs70uj
         wm5KADMa/2iKCqFHgyU/T9kpJ7tGuHoa9yFAJtaAAvyHQEClmKdmqy0zBbSl7zmeo1PX
         BUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6nIuDWwcfkNRxXhFGKJnyws0bUwaKcz08/Ho8g5tJI=;
        b=uGcmDLk8ufW3gqo97a/iO2z5Y3YMLAzXvA8LfRmMKn9+JFlq4vvSMWCN5EIIo/JS9p
         DbuRNLK6Kn+WYF8G2/Tsa6iZ6fRKDbvedqAX8Vt47iB9UjNX1403euqxKm3tHGnYzfSc
         kbmYKGe98Oqx253byTDnOcxFhfgNTzbG6rdqbqxnWoV7S1EsEKFuvp83JUiIYFKr/nWk
         NWTsgsoFt708GvuKDXjdxiZMVPKxIC3btwauqEwvyAukY2IF0SWdTKaQDyxSCFp8fw9a
         IJj6LeyrH/31Dw9iVJLaH/fe3HWg46CEPp8+P/qpcUTvcDM2aP7rbJz1VVp416C1cSOP
         bvAg==
X-Gm-Message-State: AOAM531TniGM4HlKYOzSqI3DpjCuxzkZLUIkN3RjBe7FO6OQ+psrIN3y
        M3WilOuQR9tnbrcOoqZkALRASmBozx5LDqyz+OVdTQ==
X-Google-Smtp-Source: ABdhPJxW0KcrhfVMM8iiEPssL/hOtSCDm+eXlggQ0rLGtwI+PEd2JAjBdOK9N11hcJ5LAh8Ytoew3jtobcblKdwkZyE=
X-Received: by 2002:ac2:544b:: with SMTP id d11mr4879243lfn.157.1592407533670;
 Wed, 17 Jun 2020 08:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200616074934.1600036-1-keescook@chromium.org> <20200616074934.1600036-4-keescook@chromium.org>
In-Reply-To: <20200616074934.1600036-4-keescook@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 17 Jun 2020 17:25:07 +0200
Message-ID: <CAG48ez0-jSSaw85=ku35UM3vMe98Vz97B68LsUoNd8ftwpunkQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] seccomp: Introduce SECCOMP_PIN_ARCHITECTURE
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 16, 2020 at 9:49 AM Kees Cook <keescook@chromium.org> wrote:
> For systems that provide multiple syscall maps based on architectures
> (e.g. AUDIT_ARCH_X86_64 and AUDIT_ARCH_I386 via CONFIG_COMPAT), allow
> a fast way to pin the process to a specific syscall mapping, instead of
> needing to generate all filters with an architecture check as the first
> filter action.

This seems reasonable; but can we maybe also add X86-specific handling
for that X32 mess? AFAIK there are four ways to do syscalls with
AUDIT_ARCH_X86_64:

1. normal x86-64 syscall, X32 bit unset (native case)
2. normal x86-64 syscall, X32 bit set (for X32 code calling syscalls
with no special X32 version)
3. x32-specific syscall, X32 bit unset (never happens legitimately)
4. x32-specific syscall, X32 bit set (for X32 code calling syscalls
with special X32 version)

(I got this wrong when I wrote the notes on x32 in the seccomp manpage...)

Can we add a flag for AUDIT_ARCH_X86_64 that says either "I want
native x64-64" (enforcing case 1) or "I want X32" (enforcing case 2 or
4, and in case 2 checking that the syscall has no X32 equivalent)? (Of
course, if the kernel is built without X32 support, we can leave out
these extra checks.)

> +static long seccomp_pin_architecture(void)
> +{
> +#ifdef CONFIG_COMPAT
> +       u32 arch = syscall_get_arch(current);
> +
> +       /* How did you even get here? */
> +       if (current->seccomp.arch && current->seccomp.arch != arch)
> +               return -EBUSY;
> +
> +       current->seccomp.arch = arch;
> +#endif
> +       return 0;
> +}

Are you intentionally writing this such that SECCOMP_PIN_ARCHITECTURE
only has an effect once you've installed a filter, and propagation to
other threads happens when a filter is installed with TSYNC? I guess
that is a possible way to design the API, but it seems like something
that should at least be pointed out explicitly.
