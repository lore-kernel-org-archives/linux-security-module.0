Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69322C4332F
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Nov 2022 18:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241998AbiKRSow (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 18 Nov 2022 13:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbiKRSov (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 18 Nov 2022 13:44:51 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E861617B
        for <linux-security-module@vger.kernel.org>; Fri, 18 Nov 2022 10:44:50 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id q9so5701891pfg.5
        for <linux-security-module@vger.kernel.org>; Fri, 18 Nov 2022 10:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iIVWvMnPp0udnU9lBRQaW7nP9e5c4lZLKdQftgMUv+w=;
        b=1WHjdSPla+YTGhJo6Tgd9o1tz1c+F96nwp4oFJwnM5hgNBOl3R/gpZlEUMdtbwKE9k
         gnZqUoyo9tt2xVnEjqpmfw+BunLQF81ZVyd1Q2iaZmr/vhKpYvIa5ILyu0zlGe9xCQUn
         Dy8HXOJPe8B5KI+lzwUJWBoJjHUflhkhRJ82jbZZMWqwri42ZfEZelnVufRRpSSECFTo
         RxPi7Rxje6ATjVwUzQOIwbYqPt0+l5pZU2Kq6gW0ntR4kKm58frPPk6cK5In+9GIcTzs
         WWsfv0rLigmdlXArfOJ3+Xulczset0c0KoHLzjD4BWMmee15uNloNSMAKbA3tF7Dx99o
         mseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iIVWvMnPp0udnU9lBRQaW7nP9e5c4lZLKdQftgMUv+w=;
        b=ijjyfL5hEmf1kF7hSML6gzfR3fXrGIedPDYnB4UDjx5bPabaxf+t/ONLGMTSKPqM9Z
         Ynol81H+mO1IYxMnv4fW09q9DcnZPu/cpa/SoE6UXhnQL9QgxHesDhaDvI3NuD8Ykn5Z
         30qGgz9EGuUfP8h/I/BUcVCj4Y2oeBEfd+2KgqD8+3bTvn3MGyVqTz9p/d2VQimaNLIP
         DqKjio7+Wjpk1eAKFXVsFBNAAbDmqt6UUOMJuIGd7pZSXDBCq6xQ0yzslyFR+e1+9XLZ
         mHjq2X8wbQt2O4vFOcxaMKxGnZDwiST7SQxAv5kr2Ic3NmSooOIPD7y8d833rmINSZB6
         Q8nQ==
X-Gm-Message-State: ANoB5pmxlW461YfCeEyPASnHMsgBk82aRvSbWtyXQauEXGNn9AwJLq0C
        EKQ4YERTzYYXm45YSnSCUN476JhUrJprHeA4hkdBQV97Oeq2
X-Google-Smtp-Source: AA0mqf5ghq1/aB3R63SaTCi+KcluiZlDk9b0Aj3FhTNs3a+V0OlVUOJC7FLDXMZmfubCJzDvRwbV+DWXavhIWAyoLn4=
X-Received: by 2002:aa7:9518:0:b0:56c:8c13:24fd with SMTP id
 b24-20020aa79518000000b0056c8c1324fdmr9148535pfp.2.1668797089684; Fri, 18 Nov
 2022 10:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20221110043614.802364-1-paul@paul-moore.com> <20221118015414.GA19423@mail.hallyn.com>
 <CAHC9VhSNGSpdYWf_6if+Q+8BZvR-zYYxBMmoYhRNH9rWpn7=AA@mail.gmail.com> <9989ecccca46cbbecd12ae8ecdfc693ea115a09a.camel@linux.ibm.com>
In-Reply-To: <9989ecccca46cbbecd12ae8ecdfc693ea115a09a.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Nov 2022 13:44:38 -0500
Message-ID: <CAHC9VhRUfJAYxZUDSkmoHdr5Z+TPCHSbv-nfvJ8t4_zg04NNXQ@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm,fs: fix vfs_getxattr_alloc() return type and
 caller error paths
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Nov 18, 2022 at 1:30 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Fri, 2022-11-18 at 08:44 -0500, Paul Moore wrote:
> > On Thu, Nov 17, 2022 at 8:54 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> > > On Wed, Nov 09, 2022 at 11:36:14PM -0500, Paul Moore wrote:
> > > > The vfs_getxattr_alloc() function currently returns a ssize_t value
> > > > despite the fact that it only uses int values internally for return
> > > > values.  Fix this by converting vfs_getxattr_alloc() to return an
> > > > int type and adjust the callers as necessary.  As part of these
> > > > caller modifications, some of the callers are fixed to properly free
> > > > the xattr value buffer on both success and failure to ensure that
> > > > memory is not leaked in the failure case.
> >
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > >
> > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > >
> > > Do I understand right that the change to process_measurement()
> > > will avoid an unnecessary call to krealloc() if the xattr has
> > > not changed size between the two calls to ima_read_xattr()?
> > > If something more than that is going on there, it might be
> > > worth pointing out in the commit message.
> >
> > Yes, that was the intent, trying to avoid extra calls to krealloc().
> >
> > Mimi, have you had a chance to look at this patch yet?  In addition to
> > cleaning up the vfs_getxattr_alloc() function it resolves some issues
> > with IMA (memory leaks), but as you're the IMA expert I really need
> > your review on this ...b
>
> All the other vfs_{get/set/list}xattr functions return ssize_t.  Why
> should vfs_getxattr_alloc() be any different?

The xattr_handler::get() function, the main engine behind
vfs_getxattr_alloc() and the source of the non-error return values,
returns an int.  The error return values returned by
vfs_getxattr_alloc() are the usual -E* integer values.

> The only time there could be a memory leak is when the
> vfs_getxattr_alloc() caller provides a buffer which isn't large enough.
> The one example in IMA/EVM is the call to evm_calc_hmac_or_hash(),
> which is freeing the memory.
>
> Perhaps I'm missing something, but from an IMA/EVM perspective, I see a
> style change (common exit), but not any memory leak fixes.  I'm fine
> with the style change.

Picking one at random, what about the change in
ima_eventevmsig_init()?  The current code does not free @xattr_data on
error which has the potential to leak memory if vfs_getxattr_alloc()'s
second call to the xattr get'er function fails.  Granted, the
likelihood of this, if it is even possible, is an open question, but I
don't think that is an excuse for the callers to not do The Right
Thing.

-- 
paul-moore.com
