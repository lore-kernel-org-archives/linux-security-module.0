Return-Path: <SRS0=15+v=BV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00750C433E0
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Aug 2020 15:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07012078E
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Aug 2020 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597159548;
	bh=ebxY0fLYyFD3bCoJFQxYp3Sulg3by0GmfajwxeS0Trs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QNOD4YmCqJOA1l+hniJ/TSULc+8Blu0bVbTAPynRlWPi09dMeVAxzUpEkXONJZjNV
	 5eW6/HNYsu4vptRbL0e1gqPKnt0pPBEaw3urhzxd3sn/v4CJciyqaa3NXPqi+0aMJx
	 4e1Jq8AxCp1VrgBqlYpRxWa6gPwayJSfl/DCQfGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgHKPZs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgHKPZr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Aug 2020 11:25:47 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACD6C06174A
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2020 08:25:46 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id i80so6862586lfi.13
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2020 08:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bx6crtxCZeThOx4D4bD3ehsUEC/VPmmXSGnr3LbBSBM=;
        b=fuVOZ6VXbzk9u1owlS5IWY/26dqpjDl8Zn92+ZwUfu1Iht5ylUjVdvAnr4KRzCh7VV
         901ieKbmeI/uj2OiDMkFTEr6IDlawY4EVR5ym128Z6kvWcI5hAIhMBgVCcgpeT57dS6W
         FJmGAlO9FQumMVHcvcBKzUuxybYBj4tt5eXdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bx6crtxCZeThOx4D4bD3ehsUEC/VPmmXSGnr3LbBSBM=;
        b=PeOJvwMc4V2/7NpmJAi1Lyr+VTXyRE6hPXoHRv1//BLKYdzZrSOFCBOZZf3UCBHRDJ
         XAioKpvP+PLWoCTsjRi+vAuRrIBfrgvKiu2vbar03LY8oIZAKRUa48v0Dcz1XMAbMaq8
         Q/LGNrcGgI4dYGXAh4Z13F/dUen6YcuiEvRD00QS4W8sx9LFYsJiyerS76uypfbFMKuV
         oJEn1agKWiDTqebOR5eBjtHfKXnlvgyAh9kpzpz+3q68xzMMBIz2Hp9FR/V8Q43Ddt7g
         luH0IG9V6fSYawAI1mFVYYyCb5HpRX0t1B1NYbYZcF6OTbxoB45CmScJg8OTK/+96OKv
         7oeA==
X-Gm-Message-State: AOAM533PdOLkWAGPX7OFIazxU4F/OXbvIjcuSn4rFNPgyAd7s97npBS5
        qFSegTie6M234J3X6k2hLP+i65Z7TZQ=
X-Google-Smtp-Source: ABdhPJwIghWIAH+WZawmltsIVTkQpJUyisrZSCOz+2KmRVeZMtxbq+1xim+StletYezrFj+GIBWDCg==
X-Received: by 2002:a19:9149:: with SMTP id y9mr3590772lfj.81.1597159544401;
        Tue, 11 Aug 2020 08:25:44 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id e4sm10129311ljo.77.2020.08.11.08.25.43
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 08:25:44 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id h19so13954690ljg.13
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2020 08:25:43 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr3363842ljf.285.1597159240486;
 Tue, 11 Aug 2020 08:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com> <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
In-Reply-To: <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 08:20:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
Message-ID: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
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

[ I missed the beginning of this discussion, so maybe this was already
suggested ]

On Tue, Aug 11, 2020 at 6:54 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> >
> > E.g.
> >   openat(AT_FDCWD, "foo/bar//mnt/info", O_RDONLY | O_ALT);
>
> Proof of concept patch and test program below.

I don't think this works for the reasons Al says, but a slight
modification might.

IOW, if you do something more along the lines of

       fd = open(""foo/bar", O_PATH);
       metadatafd = openat(fd, "metadataname", O_ALT);

it might be workable.

So you couldn't do it with _one_ pathname, because that is always
fundamentally going to hit pathname lookup rules.

But if you start a new path lookup with new rules, that's fine.

This is what I think xattrs should always have done, because they are
broken garbage.

In fact, if we do it right, I think we could have "getxattr()" be 100%
equivalent to (modulo all the error handling that this doesn't do, of
course):

  ssize_t getxattr(const char *path, const char *name,
                        void *value, size_t size)
  {
     int fd, attrfd;

     fd = open(path, O_PATH);
     attrfd = openat(fd, name, O_ALT);
     close(fd);
     read(attrfd, value, size);
     close(attrfd);
  }

and you'd still use getxattr() and friends as a shorthand (and for
POSIX compatibility), but internally in the kernel we'd have a
interface around that "xattrs are just file handles" model.

               Linus
