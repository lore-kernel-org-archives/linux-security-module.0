Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3577C433F5
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Sep 2021 20:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D13F611C7
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Sep 2021 20:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhI0Uei (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:34:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236549AbhI0Ueh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Sep 2021 16:34:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65ADE611C2;
        Mon, 27 Sep 2021 20:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632774779;
        bh=22nWlWnDmtNp2WnqM9ZNiUmQzfa+9IVOtQRm7d78mok=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uYgLXRf1XZNjqp3iglRg4yomKl+H+T1vfmrw67HjOtRZwihoDpHuBuYCzSe0SYKVm
         6RHsTjKfT2W6xtK8ajWKbtG6Gqq+uZDISGkz/aXlJj1uEOl+7F8gXoZYre2Uqkjxvl
         LIsUfZxuwjvLors9Z4IXSnnS+QMp+UqJhXro0RVxlmK8bR5K+pUTSzGnFkdNd/LFXE
         gXyH7bFxTm69sbju9xpIfelwWSFyRKSheFroIedRhWjDqav5Ppb+j+C2R9Slu3E3oD
         yNyp93c5J08HprR4LHe7qsrPXlxhj0f11bKhf+3T1DuKjqEKvZrcBBLH7yURnZiuBW
         KRc/sPT6LH1NA==
Received: by mail-wr1-f42.google.com with SMTP id w29so53951646wra.8;
        Mon, 27 Sep 2021 13:32:59 -0700 (PDT)
X-Gm-Message-State: AOAM533RxVSJ6jwfsmzxE5uAu3j2ooBQjwS1rYheyhHTuYVooQi/PcxZ
        cPA/9zPiM0XpJdQHWgZki2236A/0IoEjJzaJ/d4=
X-Google-Smtp-Source: ABdhPJz0F3sVfabhuqg/xPQANShIHDfJBRVMGgrqYP9V2mzKTWKIhzZFW0YiOETj671U2uH6dcg88h0qYJviXC6ijws=
X-Received: by 2002:a05:6000:1561:: with SMTP id 1mr2072524wrz.369.1632774778042;
 Mon, 27 Sep 2021 13:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210927100919.1500526-1-arnd@kernel.org> <9ef5889e-243a-5906-31cd-820a96859034@canonical.com>
In-Reply-To: <9ef5889e-243a-5906-31cd-820a96859034@canonical.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 27 Sep 2021 22:32:42 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3QsmyZzadDRZA-qMX9hW6wyydQSo8DbHAxFHtX1p5DPg@mail.gmail.com>
Message-ID: <CAK8P3a3QsmyZzadDRZA-qMX9hW6wyydQSo8DbHAxFHtX1p5DPg@mail.gmail.com>
Subject: Re: [PATCH] [RESEND] apparmor: avoid -Wempty-body warning
To:     John Johansen <john.johansen@canonical.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 27, 2021 at 9:59 PM John Johansen
<john.johansen@canonical.com> wrote:
>
> On 9/27/21 3:09 AM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
>
> Arnd, yep my bad for various reasons I haven't done a merge request since then.

Ok, no worries. I was just going through my backlog of stuff that is still
needed for clean randconfig builds.

> I can pickout a set of minor fixes including this and send them up this week.

Thanks!

      Arnd
