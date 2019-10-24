Return-Path: <SRS0=mqlx=YR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4455CA9EAF
	for <linux-security-module@archiver.kernel.org>; Thu, 24 Oct 2019 21:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8561F21A4C
	for <linux-security-module@archiver.kernel.org>; Thu, 24 Oct 2019 21:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571952618;
	bh=e00/yHSlXvXqqf/JB2YJn64yA5+CxFA09Oq6zHURRsU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iENkDeOM0wZzBzC793xVwUKcGuqJxNqTGQ4Atdz8yLU2MxP7VtTLjDd4fmDQGMWU9
	 B/u+AxrmIUaCgiopE2OX7F3kCTJwzk2QclowROm5bqUe0t1uk8GNnb5EbR7wYGg+Zw
	 dMRF0aTXmII963geGKt/Z9kbh90RWqTuBnWvX+qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfJXVaR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 24 Oct 2019 17:30:17 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43724 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbfJXVaP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 Oct 2019 17:30:15 -0400
Received: by mail-lf1-f66.google.com with SMTP id v24so303425lfe.10
        for <linux-security-module@vger.kernel.org>; Thu, 24 Oct 2019 14:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h5FP/voiQdxeaQU3Va8HH5cRZmi1OHTMwBKcRrrOo6E=;
        b=G+CKE+0sNMbBuosjchwhgzz8NQwfbV/8kKBYcW1zgIA+wCHZXB0W4xnrddKNkrujly
         nBXQf8TMFFxtwDaqAlubm1WQBu/DIP2jq0ClHTeKxpnxD8j4n3vqHGpl41RLHFrD0jXc
         jfdzDY5G/0JxiPvAj8Pc7cihC14c7Kl2f6hiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h5FP/voiQdxeaQU3Va8HH5cRZmi1OHTMwBKcRrrOo6E=;
        b=BWnmU66FzPAcabS2DGLQZw9fjCtPxLuTUlORRBncgc2hymF52IQwqZfZC2ZEvKyXAb
         sRP/0USe30iqSrL5rT0UROQdf3EjHfcpU9uxquai/9PkSQ3LIrY6X8FujILdBTC43J6l
         uqc62nVUEETB7yc12jfNNwqhpDcRBt+FogdTk+uyFVm6kRuuiiip6S6XCrm8wRu3CKp3
         ToQwWWEblDk0ffbAw//bbIpYEFnL1uCggjqPe9y36ctECkLiGupXmMOW3k68LSm0+SgG
         2eI8O7+Lg44S5M8DuYuolT/uMfZidYtUE4R+6yVK6hNsb6SfxFyKB6aJK6V+xgJyDshD
         oegg==
X-Gm-Message-State: APjAAAW133BtJQnGFRlN9MRd1hVAGLQPPLh3OIj+EJx1/SrO4VxHItXj
        2ZKGsv6m9hggj7nWF7wm4i8LoimyHNMP6A==
X-Google-Smtp-Source: APXvYqwE2RUejjiYFx80DwJB5Oxq1JZ2FFvMatNPok9TWrlDtcsYznT+HGnL14dKMpF5muDyKx/l6g==
X-Received: by 2002:ac2:554d:: with SMTP id l13mr202721lfk.116.1571952611975;
        Thu, 24 Oct 2019 14:30:11 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id t24sm11266794ljc.23.2019.10.24.14.30.08
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 14:30:08 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id l21so270390lje.4
        for <linux-security-module@vger.kernel.org>; Thu, 24 Oct 2019 14:30:08 -0700 (PDT)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr3303284ljp.133.1571952607809;
 Thu, 24 Oct 2019 14:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <30394.1571936252@warthog.procyon.org.uk>
In-Reply-To: <30394.1571936252@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Oct 2019 17:29:51 -0400
X-Gmail-Original-Message-ID: <CAHk-=wiMho2AhcTWC3-3zGK7639XL9UT=AheMXY0pxGHDACn6g@mail.gmail.com>
Message-ID: <CAHk-=wiMho2AhcTWC3-3zGK7639XL9UT=AheMXY0pxGHDACn6g@mail.gmail.com>
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 24, 2019 at 12:57 PM David Howells <dhowells@redhat.com> wrote:
>
> pipe: Add fsync() support
>
> The keyrings testsuite needs the ability to wait for all the outstanding
> notifications in the queue to have been processed so that it can then go
> through them to find out whether the notifications it expected have been
> emitted.

Can't you just do

    ioctl(fd, FIONREAD, &count);

in a loop instead? "No paperwork. Just sprinkle some msleep() crack on
him, and let's get out of here"

               Linus
