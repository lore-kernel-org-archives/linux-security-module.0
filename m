Return-Path: <SRS0=dEQQ=WA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0399C433FF
	for <linux-security-module@archiver.kernel.org>; Sun,  4 Aug 2019 22:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F1E20880
	for <linux-security-module@archiver.kernel.org>; Sun,  4 Aug 2019 22:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564957239;
	bh=4+uDKxvqM9OIkq0s1X/uCEDzLdtlyFxWBL44sjlJLNY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=REyZpKbXseTu87/mhLxGaX/ur+9VmtNs/eZMBz9Ej9ElqR2bM9AHWT0aziBpMhEdA
	 5xsBlPoOeKAPlaJwASCLjpP1Hp04296BSd91XG8TybqUr1Plm8/C1HE7364QcpoPc0
	 EpKKmFVWc0dAdKlTsMe0YliG1fC2O9nudR2FcmhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfHDWUi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 4 Aug 2019 18:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfHDWUi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 4 Aug 2019 18:20:38 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACB1C21849
        for <linux-security-module@vger.kernel.org>; Sun,  4 Aug 2019 22:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564957238;
        bh=4+uDKxvqM9OIkq0s1X/uCEDzLdtlyFxWBL44sjlJLNY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gkx/Qoo7Ayjf9q3CDSkqpue+AINd98ZEg1JxTjj139nmf3ZgVzaY6p0f+8QjixjS/
         pJJO26DZZzw29AemJSNBhe2cz/2hzPcld9cx70vD4t+KdratPzWk3TqYGcdt1WWqO2
         x0iQK8HiR9dMVTsB5/0L3lXtu9QV7NZK8cfZbDsw=
Received: by mail-wm1-f41.google.com with SMTP id w9so5366072wmd.1
        for <linux-security-module@vger.kernel.org>; Sun, 04 Aug 2019 15:20:37 -0700 (PDT)
X-Gm-Message-State: APjAAAUbvr0AYb1OeFS2tFCKKtdNOtNqKM40ML7Csk8YC4+k25WgR3nq
        hs0YFmgzGktvwqbDFI6Ftzqda+VZu0ezT0ebT71MDQ==
X-Google-Smtp-Source: APXvYqypYUCkDQdokcmAHSDQYXibQ3M2IW5YYjvxRskvGd32mMTS3XclDKNYo+ABvlfFbHHa0Y348qCjKX1x2AaSd3c=
X-Received: by 2002:a1c:a942:: with SMTP id s63mr14669087wme.76.1564957236010;
 Sun, 04 Aug 2019 15:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190617222438.2080-5-sean.j.christopherson@intel.com>
 <dc3d59c2783ea81d85d4d447bd1a4a2d5fe51421.camel@linux.intel.com>
 <20190619152018.GC1203@linux.intel.com> <20190620221702.GE20474@linux.intel.com>
 <20190707190809.GE19593@linux.intel.com> <1b7369a08e98dd08a4f8bb19b16479f12bee130f.camel@linux.intel.com>
 <20190708161932.GE20433@linux.intel.com> <20190709160634.3yupyabf5svnj4ds@linux.intel.com>
 <20190710172553.GE4348@linux.intel.com> <CALCETrXMAwHod_KZYPGWjTjg-fxOb1=02=Qj2g1o624wOPfPZQ@mail.gmail.com>
 <20190801163839.wvcnq57hity4wwrk@linux.intel.com>
In-Reply-To: <20190801163839.wvcnq57hity4wwrk@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 4 Aug 2019 15:20:24 -0700
X-Gmail-Original-Message-ID: <CALCETrWBewZyqVUf3cPDj11eSWXqfDG0z50vVw+Yg0Z8r0AtCg@mail.gmail.com>
Message-ID: <CALCETrWBewZyqVUf3cPDj11eSWXqfDG0z50vVw+Yg0Z8r0AtCg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 04/12] x86/sgx: Require userspace to define enclave
 pages' protection bits
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>, linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Cedric Xing <cedric.xing@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        "Dr . Greg Wettstein" <greg@enjellic.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 1, 2019 at 9:38 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Jul 15, 2019 at 03:29:23PM -0700, Andy Lutomirski wrote:
> > I would say it differently: regardless of exactly how /dev/sgx/enclave
> > is wired up under the hood, we want a way that a process can be
> > granted permission to usefully run enclaves without being granted
> > permission to execute whatever bytes of code it wants.  Preferably
> > without requiring LSMs to maintain some form of enclave signature
> > whitelist.
>
> Would it be better to have a signer whitelist instead or some
> combination? E.g. you could whiteliste either by signer or
> enclave signature.
>

I'm not sure, and also don't really think we need to commit to an
answer right now.  I do think that the eventual solution should be
more flexible than just whitelisting the signers.  In particular, it
should be possible to make secure enclaves, open-source or otherwise,
that are reproducibly buildable.  This more or less requires that the
signing private key not be a secret, which means that no one would
want to whitelist the signing key.  The enclave would be trusted, and
would seal data, on the basis of its MRENCLAVE, and the policy, if
any, would want to whitelist the MRENCLAVE or perhaps the whole
SIGSTRUCT.

But my overall point is that it should be possible to have a conherent
policy that allows any enclave whatsoever to run but that still
respects EXECMEM and such.
