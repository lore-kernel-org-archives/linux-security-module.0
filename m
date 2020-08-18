Return-Path: <SRS0=wQ8B=B4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22DFC433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Aug 2020 20:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB332206B5
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Aug 2020 20:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="SELtgIId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgHRUSy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgHRUSm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Aug 2020 16:18:42 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCACFC061344
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2020 13:18:41 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id cq28so16293684edb.10
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2020 13:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QeMExisTCX54PfEU0UFsxsWYaAtAPl2dvOoQQ7l6gvs=;
        b=SELtgIId7tpSP3rmyBh4NRgeVCONpRS3Kwr7JecG6Xg6+vzYRIisCUg3FJv+Cr6T6n
         r4cGwCap2uiavvQL3GQY2HPmVJFtyyif7TGfGMQQV2oMQDdM+f6uaXHdF++Gpi5mVMhF
         widzUPi29Qjx42/Abjmra+ObbS6HtZ+ev4gqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QeMExisTCX54PfEU0UFsxsWYaAtAPl2dvOoQQ7l6gvs=;
        b=g/ANTOghUGlKLi1FAPfgjgnCqXOuOKnhOSuEWyz+TY5jXdm+EBxhbG1dCdgRyOUGOs
         fk4wn3B4llUzbCN4746BIJNyCkg03YnzXwrxoQpuTpjWQn+k8dIq8EzM6Wr5c8PnQpZG
         p/bwG43u4DSbPX/fDcyjcyQaxBimGusRCQyXaD9IyTiD+W+apUB1S59GpAFjiiDqn7kg
         tSAWkoe2otGSGH4MrW+ErzK/vbtKhqoYTR8hspZdDRMpgBDdWy64xnPLNMcoDqWKg015
         W634/93f/1VUxK16HWIZ2jP9BC5vCM/pGVCh97rkV/mX6waB+39g4XXwRQA5EawtZUDk
         jxAQ==
X-Gm-Message-State: AOAM531nvTZnn70P87ON+af8QptcUq0unJTWqVempuoucEoPYhKxUsSh
        4/3ojc60ZlMsx6Mg1oxaVA5ptdF1vVbkSASwsdJ/qA==
X-Google-Smtp-Source: ABdhPJwQ2obJGVbMSKVirBR81H6xRXbWQqC1R7MEO/Fz7AW23R0Arh8JQvECxjqKxtFxUrpY3WjBonHXIE3ypgOllSU=
X-Received: by 2002:aa7:d5d0:: with SMTP id d16mr20989643eds.212.1597781920338;
 Tue, 18 Aug 2020 13:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk> <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
 <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com> <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
 <94f907f0-996e-0456-db8a-7823e2ef3d3f@redhat.com> <CAHk-=wig0ZqWxgWtD9F1xZzE7jEmgLmXRWABhss0+er3ZRtb9g@mail.gmail.com>
 <CAHk-=wh4qaj6iFTrbHy8TPfmM3fj+msYC5X_KE0rCdStJKH2NA@mail.gmail.com>
 <CAJfpegsr8URJHoFunnGShB-=jqypvtrmLV-BcWajkHux2H4x2w@mail.gmail.com> <CAHk-=wh5YifP7hzKSbwJj94+DZ2czjrZsczy6GBimiogZws=rg@mail.gmail.com>
In-Reply-To: <CAHk-=wh5YifP7hzKSbwJj94+DZ2czjrZsczy6GBimiogZws=rg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 18 Aug 2020 22:18:29 +0200
Message-ID: <CAJfpegt9yEHX3C-sF9UyOXJcRa1cfDnf450OEJ47Xk=FmyEs8A@mail.gmail.com>
Subject: Re: file metadata via fs API
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 18, 2020 at 8:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> I think people who have problems parsing plain ASCII text are just
> wrong. It's not that expensive. The thing that makes /proc/mounts
> expensive is not the individual lines - it's that there are a lot of
> them.

I agree completely with the above.

So why mix a binary structure into it?  Would it not make more sense
to make it text only?

I.e. NAME=VALUE pairs separated by newlines and quoting non-printable chars.

Thanks,
Miklos
