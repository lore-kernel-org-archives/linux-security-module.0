Return-Path: <SRS0=2B8k=XS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C967C432C1
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Sep 2019 21:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22018206C2
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Sep 2019 21:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569274552;
	bh=diYMA/O6NLFOVNj4TPX/3etTJQHQdavAYL2sljSgdDM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DBoWDjHq/6UgAjX9dvHK2xMTXEZqSsltM0t8vNKKNTaaRuHbMRrxRC1334glLm2NS
	 SulIrrzrQn+/Jxlu+VyNGu4hYSFByy/GY2Wm7DN8UW0J1G4fIReFTBuSJf8KQMsr8v
	 HSCdaRfhMP0dltq0mi1IxPeOl4X5qijFPzRY5ZIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfIWVfv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 23 Sep 2019 17:35:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34287 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390339AbfIWVfu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Sep 2019 17:35:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19so13711314lja.1
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2019 14:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9rPInDrQugcHITDKVlAr25OdVNJWqsDyo3I0eQIcB8s=;
        b=QRQw9OiPKf3NL4+42cCQt9hdrKOKSwqrn7y+nD4tFRTZhdtc1rRPQE3KLj7T0ud8Nb
         O4lyuCLSC6h7R9V0+6rlQYTgkDuHSM2x3HgaHrXIDvJa8n/IcSMtLHWVemU5M7jQVfQ1
         K7zBB1/KHELfhnbpTOVxgWweyzfVmmjNrhRtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9rPInDrQugcHITDKVlAr25OdVNJWqsDyo3I0eQIcB8s=;
        b=ePX8HGJF3brTVHF+LP3iu36DOZgSvOZ1D7V57AO5OlVbHGiheAKAKad6MGVjmv7QTU
         Y280xx69QN2apqiKTKKJlioywkUzSk7GR6QXfdOqJ/hEyxmeOZ0fk+boYbiEgnkKd7qr
         k2qwAMmjXVqiZpaECf5FMLcyZfvj6vPJrbqGfNPnYt+IwwnFOkdf8AAi3XhFYI8bAgJz
         jFp4IxW+2aWG1IUieu81W+Pr4JEbPS6JdG0r6OkV23FCO0BbyY5ipBbGNGkMfEprzTVS
         nawlzA7hp/P1+yY8PboWU6WkeEmQcQcAD2YNE7OEuyKbnrnElpxjZTuf1Iy4WEPp4iGk
         EfSw==
X-Gm-Message-State: APjAAAX+xbAcK+AEe/vLcFox0GyaJCS0/4pNFICBQGnkfuyd5oqJ45RI
        y2VJeGamyTcCeRkjpQjgEveUN4Ze9p4=
X-Google-Smtp-Source: APXvYqyNB6fuv9b5vL8dp3Kzlnprd5yQ1uuMI7wENbp5vIc/yj8AbfXRWuPsDnd7MCw2IcrWcVrvWA==
X-Received: by 2002:a2e:b4c5:: with SMTP id r5mr853623ljm.54.1569274546153;
        Mon, 23 Sep 2019 14:35:46 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id n2sm2574173ljj.30.2019.09.23.14.35.45
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 14:35:45 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id n14so10155156ljj.10
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2019 14:35:45 -0700 (PDT)
X-Received: by 2002:a2e:3015:: with SMTP id w21mr814171ljw.165.1569274544776;
 Mon, 23 Sep 2019 14:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <745ac819-f2ae-4525-1855-535daf783638@schaufler-ca.com>
In-Reply-To: <745ac819-f2ae-4525-1855-535daf783638@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Sep 2019 14:35:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1zkUTdnx5pNVOf=uuSJiEywNiztQe4oRiPb1pfA399w@mail.gmail.com>
Message-ID: <CAHk-=wg1zkUTdnx5pNVOf=uuSJiEywNiztQe4oRiPb1pfA399w@mail.gmail.com>
Subject: Re: [GIT PULL] Smack patches for v5.4 - retry
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 23, 2019 at 1:14 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Thank for the instruction. I think this is correct.

Looks fine, pulled.

That said, when I look closer:

> Jia-Ju Bai (1):
>       security: smack: Fix possible null-pointer dereferences in smack_socket_sock_rcv_skb()

This one seems wrong.

Not seriously so, but the quoting the logic from the commit:

    In smack_socket_sock_rcv_skb(), there is an if statement
    on line 3920 to check whether skb is NULL:

        if (skb && skb->secmark != 0)

    This check indicates skb can be NULL in some cases.

and the fact is, skb _cannot_ be NULL, because when you test the
security of receiving an skb, you by definition always have an skb.

There is one single place that calls security_sock_rcv_skb(), and it
very much has a real skb.

So instead of adding a _new_ test for skb being NULL, the old test for
a NULL skb should just have been removed. It really doesn't make any
sense to have a NULL skb in that path - if some memory allocation had
failed on the receive path, that just means that the receive is never
done, it doesn't mean that you'd test a NULL skb for security policy
violations.

Anyway, it's pulled, but I think somebody should have checked and
thought about the automated tool reports a bit more..

               Linus
