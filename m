Return-Path: <SRS0=f9NI=R6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D84C4360F
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Mar 2019 17:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6ABA20651
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Mar 2019 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553708417;
	bh=jxqEa+uwiuNr1eLweO/E+2QzBcyhsLcjSwfwnHSiZww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ka2vHlfwK+PtRB6/YGNsRSwLm7f7IUFZ+HouD7KZx4dFAEpXqHXDbZITECoCaiXvt
	 8o9zMgftgj+xc4CSRV04sUQ3LCtMWebxeNsTuIV5DBNj6zu/VP/r+3AF7RtUB25yV2
	 Ie7D3HlT7kEhx/ZkVsmclGvb/w8j8fZgRKp6XO1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfC0RkL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbfC0RkH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Mar 2019 13:40:07 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 069F021741
        for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2019 17:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553708406;
        bh=jxqEa+uwiuNr1eLweO/E+2QzBcyhsLcjSwfwnHSiZww=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aCRstgT4IpUl3BZwNEnBJqzuH+iPi1XtD361b/M9ZbJ11FUvVCh5zD2T6vY3dtrk/
         37Uap6XbbreTgs85NG6RJg4Knn+Fkq92xi33UpK1YcoCl9/Wr3seOUKxGYNO5wlTIN
         h0MKg8RwqsxkRw5Bf4dqA9SOUZ0stEMHTwPDlpqg=
Received: by mail-wr1-f48.google.com with SMTP id w10so19616685wrm.4
        for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2019 10:40:05 -0700 (PDT)
X-Gm-Message-State: APjAAAUVFgmzTuZBivTy4TFp14c+9Ck4B9DBE6xYwzLZspitdIIbDrFF
        FhJK48yy/ABjwOIeOd1CQcro8iYIws8TLPdH53CUiQ==
X-Google-Smtp-Source: APXvYqyS+vtqEZt9mwHqVBGirVVb6B4nZsG3ESwiC+cnFEjtEANsAqLkNDffSXaqqPPYfkjmT02LQHrs+yEM87w3E9s=
X-Received: by 2002:adf:f011:: with SMTP id j17mr22216637wro.330.1553708404521;
 Wed, 27 Mar 2019 10:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-26-matthewgarrett@google.com> <CALCETrXDF2c2-gnOyNTnEn-uPAZp0AaSB_PB8e2y8jf7zo=Cyg@mail.gmail.com>
 <20190327003057.GA27311@kroah.com> <CALCETrVDDf4dj3Md1Nxc5P_NCToXGnAbEO3bGfwgKSfeVmU4Kw@mail.gmail.com>
 <20190327050615.GA548@kroah.com> <16124107-70D3-4CA0-9766-36FC6DC10128@amacapital.net>
 <20190327053342.GA17484@kroah.com>
In-Reply-To: <20190327053342.GA17484@kroah.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 27 Mar 2019 10:39:53 -0700
X-Gmail-Original-Message-ID: <CALCETrUW=r=xyr4pGiGnn9zUEevf=z6PP3111Ds6qguV5SjYUQ@mail.gmail.com>
Message-ID: <CALCETrUW=r=xyr4pGiGnn9zUEevf=z6PP3111Ds6qguV5SjYUQ@mail.gmail.com>
Subject: Re: [PATCH V31 25/25] debugfs: Disable open() when kernel is locked down
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 26, 2019 at 10:33 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 26, 2019 at 10:29:41PM -0700, Andy Lutomirski wrote:
> >
> >
> > > On Mar 26, 2019, at 10:06 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > >> On Tue, Mar 26, 2019 at 09:29:14PM -0700, Andy Lutomirski wrote:
> > >>> On Tue, Mar 26, 2019 at 5:31 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >>>
> > >>>> On Tue, Mar 26, 2019 at 12:20:24PM -0700, Andy Lutomirski wrote:
> > >>>> On Tue, Mar 26, 2019 at 11:28 AM Matthew Garrett
> > >>>> <matthewgarrett@google.com> wrote:
> > >>>>>
> > >>>>> From: Matthew Garrett <mjg59@google.com>
> > >>>>>
> > >>>>> debugfs has not been meaningfully audited in terms of ensuring that
> > >>>>> userland cannot trample over the kernel. At Greg's request, disable
> > >>>>> access to it entirely when the kernel is locked down. This is done at
> > >>>>> open() time rather than init time as the kernel lockdown status may be
> > >>>>> made stricter at runtime.
> > >>>>
> > >>>> Ugh.  Some of those files are very useful.  Could this perhaps still
> > >>>> allow O_RDONLY if we're in INTEGRITY mode?
> > >>>
> > >>> Useful for what?  Debugging, sure, but for "normal operation", no kernel
> > >>> functionality should ever require debugfs.  If it does, that's a bug and
> > >>> should be fixed.
> > >>>
> > >>
> > >> I semi-regularly read files in debugfs to diagnose things, and I think
> > >> it would be good for this to work on distro kernels.
> > >
> > > Doing that for debugging is wonderful.  People who want this type of
> > > "lock down" are trading potential security for diagnositic ability.
> > >
> >
> > I think you may be missing the point of splitting lockdown to separate integrity and confidentiality.  Can you actually think of a case where *reading* a debugfs file can take over a kernel?
>
> Reading a debugfs file can expose loads of things that can help take
> over a kernel, or at least make it easier.  Pointer addresses, internal
> system state, loads of other fun things.  And before 4.14 or so, it was
> pretty trivial to use it to oops the kernel as well (not an issue here
> anymore, but people are right to be nervous).
>
> Personally, I think these are all just "confidentiality" type things,
> but who really knows given the wild-west nature of debugfs (which is as
> designed).  And given that I think this patch series just crazy anyway,
> I really don't care :)
>

As far as I'm concerned, preventing root from crashing the system
should not be a design goal of lockdown at all.  And I think that the
"integrity" mode should be as non-annoying as possible, so I think we
should allow reading from debugfs.
