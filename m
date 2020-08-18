Return-Path: <SRS0=wQ8B=B4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E44EC433E1
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Aug 2020 12:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8AF320578
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Aug 2020 12:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="kwpEsN1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgHRMuu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgHRMur (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Aug 2020 08:50:47 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059B5C061389
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2020 05:50:47 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a14so15145820edx.7
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2020 05:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fFLadAGytIbd6Cde9KqrXGMzmbxXEZAqgtRrBn6qG1k=;
        b=kwpEsN1R8kGzBgmiohXGBZgKhiEohfySxA4S1MY16t8M7GjlXhS8WB6B+ckdr+Ugzu
         NyGaVnYxne0bipWKHzdc7aHgrK7BCFA5GPEZ4KlzlIVwgbsHkZbCaCsbUfEym5+PO6MQ
         8EEjkbG/zZtLFIzG+9In1Pyo0bXAM7GI10ja4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fFLadAGytIbd6Cde9KqrXGMzmbxXEZAqgtRrBn6qG1k=;
        b=YfcBYp4FzvzZnWWjP3TtnnGxQAvN18OWwzUk0zBMBleLg2kzO/5/x3LQrH4tn2KjSb
         XK/m0n669foBuhnXsTmXTk/fJ/gUDsdJndis7aG5wZY1OWGrGsXUSKxCJRCKx5//WXT3
         Zz+8pflNmfQ+6r235+YGXeK2vRzukzlDDSeu5VRtMN/r2FVWemEE3n8yFCLIji6+vQE7
         +XjKpnHIgpgmcdSamsOfs9zCUnbCwubGBvZNIvC6hqOkucdDWUcSEbUypZELhIs1H3dn
         lInBc2Ofitzbt/ABKkgndyq9zV+WZqGkF+t1OgGicDazE0CVEZZBeM4QAhj2XUOsI2Rd
         A08g==
X-Gm-Message-State: AOAM533Gx82yMLcdyGmOdZNI1UNBlKMoh/V7qocrknK7mEnG4F37ToS+
        Dhi0OkpHPzG9unaRWomul2cpGCmUPi0zhw0pXXbKHA==
X-Google-Smtp-Source: ABdhPJxXjvpMrRuOGDAZZiMkm9L4E1Gzc1z9smi3A79LHbSHxaELKwrkyMmeNUkO/4bFpdYJUvYB0HAAUfI7kyaNEms=
X-Received: by 2002:a05:6402:13d4:: with SMTP id a20mr20108726edx.161.1597755044073;
 Tue, 18 Aug 2020 05:50:44 -0700 (PDT)
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
In-Reply-To: <CAHk-=wh4qaj6iFTrbHy8TPfmM3fj+msYC5X_KE0rCdStJKH2NA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 18 Aug 2020 14:50:32 +0200
Message-ID: <CAJfpegsr8URJHoFunnGShB-=jqypvtrmLV-BcWajkHux2H4x2w@mail.gmail.com>
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

On Tue, Aug 18, 2020 at 12:44 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> So please. Can we just make a simple extended statfs() and be done
> with it, instead of this hugely complex thing that does five different
> things with the same interface and makes it really odd as a result?

How do you propose handling variable size attributes, like the list of
fs options?

Otherwise I'm fine with a statx-like interface for querying fs/mount attributes.

Thanks,
Miklos
