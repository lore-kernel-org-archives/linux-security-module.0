Return-Path: <SRS0=iE4T=BP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1610CC433DF
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Aug 2020 19:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7BC922CA0
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Aug 2020 19:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ESNQC+z/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgHETyT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbgHEQtE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Aug 2020 12:49:04 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C8DC061A28
        for <linux-security-module@vger.kernel.org>; Wed,  5 Aug 2020 04:27:44 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id di22so25066018edb.12
        for <linux-security-module@vger.kernel.org>; Wed, 05 Aug 2020 04:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PziUKsmF372rDIV3S+ngIfNzzFjadVBOy4PT2Nbdg9M=;
        b=ESNQC+z/Z1LEOCf9ToNZZagALOrvVY3U7nd5sdzRXPULMbM6xqR4+e9C/gBHdlhIK9
         32emkrytIlYO22Vqrx5sMWa/8mJm96fGLmkbTQlIXqJuDV0q+qoQmFjtgdryN+NXUGAE
         MLgsqwyTs/PUyDehIURdGhYrpGdnku/6azmIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PziUKsmF372rDIV3S+ngIfNzzFjadVBOy4PT2Nbdg9M=;
        b=ZlCdn2ab8XWjEbEW1NqQUjHZBfmasm6Cwj7xKgQTtFllzSXjAz92eqZgNukfDTT+cb
         n4qCzv3WMcuXqQqIepsmZcEhIrWSs6+c3RwVebmOjWVs+syvSStvMIJS2cmy8WpTQ0k8
         urjhUNDXCf/pZq8uixjTFn97BZN+9LerLwepkv/Sc7KY6KQI6jAmAFvnArxdFb80qAc6
         uUqBrwlEuWLveBD6/oOwblIXjx+xWYGVTioTODDFDti1AvltL2lD9WzvgGclDAp6gJW2
         JJPZaekEMZ7JbS5ZrAMUqG84XSKcdqrxwmrbEer3GPKDNMdoNaNHCPwePVax1BFXprp6
         wzxg==
X-Gm-Message-State: AOAM531s56rRw46WK97LDQugmqZ821MnjMUdzT4B1CZU5ZKhWREj5Fdf
        yjPzBwLQUgjQ4etisv+yXZF0QZUk0o3aFTNMxdk1SfkYzN0=
X-Google-Smtp-Source: ABdhPJwSzAqAkDNRGBwPe3v9vu2XVDG8K6eixn5B+jSbX3QhBOxtZVeQ7GZvk7UuTYsR/liT1yvsvfZHUm//pGefN8E=
X-Received: by 2002:aa7:d5d0:: with SMTP id d16mr2258430eds.212.1596626862700;
 Wed, 05 Aug 2020 04:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646187082.1784947.4293611877413578847.stgit@warthog.procyon.org.uk>
 <20200804135641.GE32719@miu.piliscsaba.redhat.com> <94bba6f200bb2bbf83f4945faa2ccb83fd947540.camel@themaw.net>
 <5078554c6028e29c91d815c63e2af1ffac2ecbbb.camel@themaw.net>
 <CAJfpegs1NLaamFA12f=EJRN4B3_iC+Uzi2NQKTV-fBSypcufLQ@mail.gmail.com> <e1caad2bff5faf9b24b59fe4ee51df255412cc56.camel@themaw.net>
In-Reply-To: <e1caad2bff5faf9b24b59fe4ee51df255412cc56.camel@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 5 Aug 2020 13:27:31 +0200
Message-ID: <CAJfpeguvTspY7pi52n1aznebCF2jYki40hy5idkgu1D2y6C6mg@mail.gmail.com>
Subject: Re: [PATCH 10/18] fsinfo: Provide notification overrun handling
 support [ver #21]
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 5, 2020 at 1:23 PM Ian Kent <raven@themaw.net> wrote:
>
> On Wed, 2020-08-05 at 09:45 +0200, Miklos Szeredi wrote:

> > Hmm, what's the other possibility for lost notifications?
>
> In user space that is:
>
> Multi-threaded application races, single threaded applications and
> signal processing races, other bugs ...

Okay, let's fix the bugs then.

Thanks,
Miklos
