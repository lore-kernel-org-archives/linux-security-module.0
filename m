Return-Path: <SRS0=iWO7=Y2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2552CA9EC7
	for <linux-security-module@archiver.kernel.org>; Sat,  2 Nov 2019 22:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7812214AF
	for <linux-security-module@archiver.kernel.org>; Sat,  2 Nov 2019 22:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572733041;
	bh=M91BK//G0AGxiPTVbAufD9sXjzn7Sec8N7JlW6FjSq0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fN2nSI2ioGtc+NBvN2soZDvX/eo44Aiw5qSc56uFi7/bDCPcTvk0GOqiU3f/SwZg1
	 2kSG7E+plOuRVpJXIi3v7TJcRQbhBJ6hMh3bErJLfcuOVrv7vrMF0TBGZPRY5kpnMo
	 a7F5nKxDEnzqfhDmne8KZzytgLirA4GNfW6RU/NY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfKBWRV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 2 Nov 2019 18:17:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33912 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfKBWRU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 2 Nov 2019 18:17:20 -0400
Received: by mail-lf1-f66.google.com with SMTP id f5so9613768lfp.1
        for <linux-security-module@vger.kernel.org>; Sat, 02 Nov 2019 15:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w/G6EKdeKHyA10XyqtoNEQBxMdg61j9NrYNZ+OC/8O0=;
        b=fiTiutJMMhzHoUatnMj/i0xks6LRSmy0r7/BRz4Oo2NzE6YmtOVVD9WTTp3vp/4Ftl
         susZvLuDrEDv2Y0EisfAoYbNX8c8ba0GWiLrv658sEXczCmotmacJTxLnXp7ikF2o1OS
         tH5KGMhlSFlbvPUr5HFJ0KdvbB3vKmi6HfEto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w/G6EKdeKHyA10XyqtoNEQBxMdg61j9NrYNZ+OC/8O0=;
        b=U0TdsKyKf2Xn6qndEiErEfshULGdFsIo9HfYHt6QZnxekzbTl+UyeY1/nmyuzEr5Fs
         fWrtrp/wMqzyTCnkx7RdUpYmhVSkTDYChFNUmHgf7fRbiKp5TQUMpyDQ41UU4420anG9
         2ygC0l8KYQD4yaaWBFHsnnINtKjuz5uV2h+Rdfx1QalVUBswFezzsGIicWv7wbxUQETL
         e9Lsatbi054OW/s0fbmBBneVmKibOHdULTxOPpM6TVhkoJPl3mQ5LjfGbBzixEkzME6m
         sjmAE41CH7XqIMWT5sOcpOLbmXW4amdAdPHQhOkBeZqNxAc5Bp6vQMlOllRNTuL3hgt4
         kkMA==
X-Gm-Message-State: APjAAAXAJN6piswdB+s6QAfOGYNBqy8joHQ8VYLmloZx9zjhi9wFnMbX
        Scqn9ONqme9KuJsnWnxs3ZpURrLUI6s=
X-Google-Smtp-Source: APXvYqx1e0Y3UaVT6iUcwPOXAuihejRLfwdvNiedDxNWdLWluL4cIjHbLpxjbCZ0KI1AYwROMc5iSg==
X-Received: by 2002:a19:4318:: with SMTP id q24mr11673038lfa.12.1572733036960;
        Sat, 02 Nov 2019 15:17:16 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id e27sm4797429lfb.79.2019.11.02.15.17.16
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 15:17:16 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id f5so9613759lfp.1
        for <linux-security-module@vger.kernel.org>; Sat, 02 Nov 2019 15:17:16 -0700 (PDT)
X-Received: by 2002:a19:6f0e:: with SMTP id k14mr11937953lfc.79.1572732565288;
 Sat, 02 Nov 2019 15:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <25886.1572723272@warthog.procyon.org.uk> <CC3328CC-2F05-461E-AAC3-8DEBAB1BA162@amacapital.net>
 <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
In-Reply-To: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Nov 2019 15:09:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNJYdEcomZKaD034S==-gEXg_V3JpW+DpKXFi5fJuruw@mail.gmail.com>
Message-ID: <CAHk-=wiNJYdEcomZKaD034S==-gEXg_V3JpW+DpKXFi5fJuruw@mail.gmail.com>
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     David Howells <dhowells@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Nov 2, 2019 at 3:03 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Nov 2, 2019 at 1:31 PM Andy Lutomirski <luto@amacapital.net> wrot=
e:
> >
> > Add in the fact that it=E2=80=99s not obvious that vmsplice *can* be us=
ed correctly, and I=E2=80=99m wondering if we should just remove it or make=
 it just do write() under the hood.
>
> Sure it can. Just don't modify the data you vmsplice. It's really that si=
mple.
>
> That said, if we don't have any actual users, then we should look at
> removing it (maybe turning it into "write()" as you say). Not because
> it's hard to use, but simply because it probably doesn't have that
> many uses.

Looking at debian code search, there are _some_ uses (including
openssl and fuse):

  https://codesearch.debian.net/search?q=3D%3D+vmsplice%28&literal=3D1

but I didn't check any more closely what they do.

             Linus
