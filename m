Return-Path: <SRS0=x/8A=WB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40624C0650F
	for <linux-security-module@archiver.kernel.org>; Mon,  5 Aug 2019 19:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FE720B1F
	for <linux-security-module@archiver.kernel.org>; Mon,  5 Aug 2019 19:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565032690;
	bh=mFAWhKUiiM/QpD8h2CVsl+Yq4SH14saj9s2Pq4noprQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lvsFhMN/O8vFX1BRpgBfhpwDq3uJhYysFmsRgonNOEb3PLn0jJSwgBbNmFg32byTO
	 v5H0G3CVNOoEX/YhLtY/JBrQFce5UPd4MHR12//JRWtmbacfrETTkvFE8v5xcnApXT
	 X8eoaEkUbqlhhN+uRda8XaCjCxoM2Z0f2WIq5dTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfHETSJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:18:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37854 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHETSJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 5 Aug 2019 15:18:09 -0400
Received: by mail-lf1-f67.google.com with SMTP id c9so58847365lfh.4
        for <linux-security-module@vger.kernel.org>; Mon, 05 Aug 2019 12:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QY3x1Neqw88a4kC5L8IILTg/Eusc/r1ujGUtxNuyElI=;
        b=LTJMiN3M9Ray9BoJ54bRh6ytuEphVXUvDhxBtPFmrc9/OnveqmvtMAWLk4lnLLf2H8
         h8a1EgEOvlM4gYUf3GXkWxjCp0Vwl4QzU9AqjxkwCPMwl7zRUsS95bisq7r97GLkGd7B
         m9N62FqdWsBfNzIvnLNSJFjdD4wMIbKk/uylc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QY3x1Neqw88a4kC5L8IILTg/Eusc/r1ujGUtxNuyElI=;
        b=VsOTQ7QMcM90gSAqbSEc+5cqaMiwKKrIEfjeO+BuR82RvQvXwhXiCn54lTOd0jGR82
         S0olERGuQVPox/Xo/MK4dbMrgZXg/WIZbOi4TJju9tp1kJWyoTls+iH9S0CfT79nhfOG
         RGwTf+M+VVVxics92ZF/ZYfYhLKbkrfcLmJoosZb6pw4Z08VIMLKvjTAQWwmA1avGMA1
         6bziVYiMW0ga4EwMaQDbY8kfHQlnaqDd6N8DMX9VlNp4j0QtBLa8vk1nWGvcjFdz2HGp
         4aPwg2pF52yzt3hDXaiVzL0PE6lm47qmlXTIugJlSTiMM/dvRNZow87lfO2jfxz8/6Y3
         B9Ag==
X-Gm-Message-State: APjAAAURcaDz/otrBRdulj/sxlv367GDAz1oinjCUXsFZx6RF40JFqVk
        eqiY8P8H6/2/+P5FiYiZd4WqyAoAytI=
X-Google-Smtp-Source: APXvYqwCioAqN63n8BERzgDY7kTutve6moi97IjdMmqieHIlLZmKbivtnmyyvp9eh1b63WqmznvAwA==
X-Received: by 2002:a19:8c08:: with SMTP id o8mr2471lfd.57.1565032686961;
        Mon, 05 Aug 2019 12:18:06 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id n124sm15110736lfd.46.2019.08.05.12.18.05
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 12:18:06 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id b29so51664247lfq.1
        for <linux-security-module@vger.kernel.org>; Mon, 05 Aug 2019 12:18:05 -0700 (PDT)
X-Received: by 2002:a19:641a:: with SMTP id y26mr70249477lfb.29.1565032685615;
 Mon, 05 Aug 2019 12:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccMXEVktpuPS5BwkGqTo++dGcpHAuSUZo7WgJhAzFByz0g@mail.gmail.com>
 <CAHk-=whZzJ8WxAeHcirUghcbeOYxmpCr+XxeS9ngH3df3+=p2Q@mail.gmail.com>
 <CAJ-EccOqmmrf2KPb7Z7NU6bF_4W1XUawLLy=pLekCyFKqusjKQ@mail.gmail.com>
 <CAHk-=wgT7Z3kCbKS9Q1rdA=OVxPL32CdBovX=eHvD2PppWCHpQ@mail.gmail.com>
 <20190805142756.GA4887@chatter.i7.local> <CAHk-=wgdiiBVprEVoi8+mpicGnOVNZ4Lb9YUJVskOXahO50sXw@mail.gmail.com>
 <20190805191136.GB4887@chatter.i7.local>
In-Reply-To: <20190805191136.GB4887@chatter.i7.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 5 Aug 2019 12:17:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4xMXMM3EfW=NV6YuScA4zvcvaCAPou3bxegjGy6r-qA@mail.gmail.com>
Message-ID: <CAHk-=wg4xMXMM3EfW=NV6YuScA4zvcvaCAPou3bxegjGy6r-qA@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID MAINTAINERS file update for v5.3
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Micah Morton <mortonm@chromium.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 5, 2019 at 12:11 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> However, I suspect that getting message-ids for all your pull requests
> would significantly complicate your workflow.

Yeah, that would be a noticeable annoyance. If I were to process pull
requests the way I used to process emailed patches (ie "git am -s" on
a mailbox) that would be a natural thing to perhaps do, but it's not
at all how it ends up working. Having to save the pull request email
to then process it with some script would turn it into a chore.

I think the pr-tracker-bot clearly catches most cases as it is, and
it's only the occasional "somebody did something odd" that then misses
an automated response. Not a huge deal. For me it was actually more
the "I didn't understand why the response didn't happen", not so much
"I really want to always see responses".

                Linus
