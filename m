Return-Path: <SRS0=9iMC=74=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66458C433E1
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 16:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4029820679
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592239194;
	bh=6/U87RsqukwiOYF4cYCU+xUnJ7CuWABq/8Lbgo9CtRc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jtnJTD7SAgFbVHbbVEI12cA6nuW2/vhICy6ZCuDPyuFi+g1DhLtQU6FTYdvzA1neV
	 sIaR5qE0z0bDLbO8n9320tjhe4tk4sf+Vlokv5kEcGShxWMT6bAjB6jXmCRytuTJr6
	 UP9CxFxL+/PTGfk/PulAJADoELteicwKm5WrD3ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbgFOQjx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730920AbgFOQjw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jun 2020 12:39:52 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5770C061A0E
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2020 09:39:51 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y11so20020549ljm.9
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2020 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Cx2AztWHzzxrSgmq+Me98oVJt/pCqP1GcYCCJga1v3o=;
        b=hYqsrzQyaCq1kQgp0spHAppAk0hS2j5g++6SYxCLxYxJXAmMfKqTQ18qJkn1C27/AG
         eJGDl4TDVRdRqRzTxahAgnZfaGDf0lo3JVIvuqg2IKhggaqVKPMvCx5tTM7h4m+tvAMI
         wN5LBnLvHufylZ12CACwK78MI49zcsJYaDln8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cx2AztWHzzxrSgmq+Me98oVJt/pCqP1GcYCCJga1v3o=;
        b=LM7RlN4ZTYgPzCcF1MAt2jfQN12w19Mk2ttETpa7yOUfO+gziLUdhpHMf7K2Lntfsj
         h//Pzp55JkP3znyV/ZEqQ638T9MUJNKdqC7Ezb9EJqij6waOEkHndYOIKRDitpInfIDz
         3nYdTHqVWPJfDTfd1fvMVlZwof+437cXppVFdto8aesw4u91IrVNLjysvzgGXe5BWe52
         O5/LSlPfaNoJ0lvN/C5juEufcqplDNdFjjOkoCLicjmIZjIW6XJ33G9fvBWpW81CFiQy
         1SnuwAyC4s7GmEr1Fp8d5wTQQ/jl7t9BJWOZbLjxLkx/IO0iLzMisuPYFgrfZxr6oS77
         sEww==
X-Gm-Message-State: AOAM5336SGcFGrJPzId9PzFpJYhLAuQ4aAm28dJTjsXE6m8cGkdLh2V4
        GTNVtise2qX5y6zq1UzTVvDMu0WETFw=
X-Google-Smtp-Source: ABdhPJybD6nNf2ADjByHkXzGxkTcP/t5Qy2eTut+JahnMqLC/FF/NB6S30Dk87tAppMgVHcbRf4mpA==
X-Received: by 2002:a2e:b5b9:: with SMTP id f25mr13818620ljn.50.1592239189411;
        Mon, 15 Jun 2020 09:39:49 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id u8sm4640499lff.38.2020.06.15.09.39.48
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 09:39:48 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id s1so20024589ljo.0
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2020 09:39:48 -0700 (PDT)
X-Received: by 2002:a2e:974e:: with SMTP id f14mr12917365ljj.102.1592239187960;
 Mon, 15 Jun 2020 09:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200615121257.798894-1-hch@lst.de> <20200615121257.798894-6-hch@lst.de>
In-Reply-To: <20200615121257.798894-6-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jun 2020 09:39:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfMo7gvco8N5qEjh+jSqezv+bd+N-7txpNokD39t=dhQ@mail.gmail.com>
Message-ID: <CAHk-=whfMo7gvco8N5qEjh+jSqezv+bd+N-7txpNokD39t=dhQ@mail.gmail.com>
Subject: Re: [PATCH 05/13] fs: check FMODE_WRITE in __kernel_write
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 15, 2020 at 5:13 AM Christoph Hellwig <hch@lst.de> wrote:
>
> We still need to check if the f=D1=95 is open write, even for the low-lev=
el
> helper.

Is there actually a way to trigger something like this? I'm wondering
if it's worth a WARN_ON_ONCE()?

It doesn't sound sensible to have some kernel functionality try to
write to a file it didn't open for write, and sounds like a kernel bug
if this case were to ever trigger..

                Linus
