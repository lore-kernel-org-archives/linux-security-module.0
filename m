Return-Path: <SRS0=Dufg=QI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ECDC282DB
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Feb 2019 18:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F10218FD
	for <linux-security-module@archiver.kernel.org>; Fri,  1 Feb 2019 18:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AHkQBSm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfBASE5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:04:57 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36152 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfBASE4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Feb 2019 13:04:56 -0500
Received: by mail-lf1-f67.google.com with SMTP id a16so5748539lfg.3
        for <linux-security-module@vger.kernel.org>; Fri, 01 Feb 2019 10:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EgeSA8RapEzaEBIQTqVc0HMpXA+lL4rs9Yi3JGdgs88=;
        b=AHkQBSm4TqXQTK1J3JDbTpXlehljteke8FWJqC3iyhu1++ihRp0bAKrqTGWaXmGBvU
         +lG1AJiS81P9ugUO1n7CxenFxnK+n0Y8fgPyge1eRM0UzyRjS/vyYUKdIsYulgFzN2gT
         R3y9HdJ23wKUNcNPaHKMU5lw00sSYOSIiRnwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EgeSA8RapEzaEBIQTqVc0HMpXA+lL4rs9Yi3JGdgs88=;
        b=ET5fVUrYGKLECPWZDhZ7nMIpC27HZzq9oa0C76YvLKaSi4t8aU50va4WPi2BbyMdue
         Dr5It/FeeBynU+lVEeGnwipekhKOv+nBlnEG1p53GBkA0Z7Yq2f2dvI8xoSHBeyXmU6g
         YbDNRAVvM1Aj3cULRf3NlZHjS/JYSJbpNST/QOKKBXKyi3tNkfzMWSq2k2ECkpBu5Vrd
         Flgk8yxQ+dpwuvz3i7+O0FfCLwLa1Vakd+hIyEv3Qf9yqVLqTWNKUxaKbqqvyGHFvKsM
         QV2K/z8PC5unQWgo6ZNPjQq3MCdBdCdzgHi/05j7pV7AoIlCmKnYPl1idLs1Fe3GArdL
         TohQ==
X-Gm-Message-State: AJcUukeq0Zaj8L4ITOlzPVWMZLUNBMaMdrojGL9hpXYyo1PK+Ig+/CUE
        ThcwZO0io1bnowFIA2H0JEnBRLArOpg=
X-Google-Smtp-Source: ALg8bN7lff6ieDIdiJPdo74BfKXDPTMybcREMhTvOQfF5Uf8ie7xqrR0hr2B8WLv03yZuthVnm1N7Q==
X-Received: by 2002:a19:ced3:: with SMTP id e202mr33346254lfg.13.1549044293909;
        Fri, 01 Feb 2019 10:04:53 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id y9sm1470628lfe.75.2019.02.01.10.04.52
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 10:04:52 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id a16so5748433lfg.3
        for <linux-security-module@vger.kernel.org>; Fri, 01 Feb 2019 10:04:52 -0800 (PST)
X-Received: by 2002:a19:1a14:: with SMTP id a20mr30859610lfa.1.1549044292236;
 Fri, 01 Feb 2019 10:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20190122132910.GA2720@linux.intel.com> <CAHk-=wgdOfi+zVVfKDDqJMs2Y7Lq0uufmP8Hx8JzQFA9UzNrBw@mail.gmail.com>
 <20190123153638.GA8727@linux.intel.com> <CAHk-=whgoJ8aAYH37hnyFjZ8jbYyswyf9wZZ82tTFL5f2he+6g@mail.gmail.com>
 <20190129132016.GA1602@linux.intel.com> <20190131122606.GA12470@linux.intel.com>
 <20190131160437.GA5629@linux.intel.com> <20190131170603.GA18349@linux.intel.com>
 <20190131183530.GA27112@linux.intel.com> <CAHk-=wj0pRLS9Z+_LKfiTvnnquGQjOySVuqiObC9sDXp8SCP0A@mail.gmail.com>
 <20190131204510.GA354@linux.intel.com>
In-Reply-To: <20190131204510.GA354@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Feb 2019 10:04:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=whO_TqDzQXSuSbgyZdVj9qeyRSxpjWXBQUWgvKGT2dnug@mail.gmail.com>
Message-ID: <CAHk-=whO_TqDzQXSuSbgyZdVj9qeyRSxpjWXBQUWgvKGT2dnug@mail.gmail.com>
Subject: Re: Getting weird TPM error after rebasing my tree to security/next-general
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jan 31, 2019 at 12:45 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> I understand what you mean. Just surprised that this hasn't failed
> before to anyone (the same driver has been even successfully used
> on ARM64 with TrustZone based fTPM implementation). It has been in
> for three years now.

Just to finish this thread off: it turns out that both ARM and ARM64
worked fine, because neither did a memcpy(), but had explicit IO copy
routines.

And in those explicit routines, 32-bit ARM did only byte accesses, and
64-bit ARM did 8-byte accesses for the bulk transfer part, but byte
accesses for the unaligned head and tail of the IO area.

So I think it's all good. x86 used to work by luck (either because all
machines that used that TPM chip always had ERMS, or because the
people who didn't have it never cared), and ARM just worked because it
would never do unaligned IO accesses anyway (well, I guess you can
force them with "readl()" on an unaligned address, but then you just
have yourself to blame).

           Linus
