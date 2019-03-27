Return-Path: <SRS0=f9NI=R6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8956CC43381
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Mar 2019 04:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5950A2146E
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Mar 2019 04:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553660969;
	bh=Zg1cTlPfZX1M+HOPd74bZBRElnN4Nw+XU23qLrCpyRs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SMzOHplbaP3WlWVCL86V9uif/5XCshueHOUHCfija1KuqOfDhq1pCqHqF0+to+Re+
	 itUXPmV1K3SPwAwYzI6glcYAMOhvrduoOFzHeJh6OqJm81FKhYCxIYQBQ6EnnGl0W0
	 Q3M/Phl8LN2/bMO3KjEVWVMuhhJTPCQm3LtkShEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfC0E32 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 27 Mar 2019 00:29:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfC0E32 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Mar 2019 00:29:28 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B085D21473
        for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2019 04:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553660968;
        bh=Zg1cTlPfZX1M+HOPd74bZBRElnN4Nw+XU23qLrCpyRs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sA/eXxPnJS7DK6nGEtYwuXdqYtM69Es4TCuSf5/hyJlaS9rpRY//H3t0blfOherEZ
         WMkal+8c6Q4rQ4bWQRYDbqd6OVxiDJ4FDSXqcVOfA4QsMls26ThblNhs8nLIxNWyoM
         OTiMqAhdzJe4CQN8syKYB8S7DDq9zSen0ZtWRt2Y=
Received: by mail-wm1-f54.google.com with SMTP id o10so3836085wmc.1
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2019 21:29:27 -0700 (PDT)
X-Gm-Message-State: APjAAAV5UwYqilfxvKY0HAOmLAEqD+S/2RuGr5sMZaMqhYZ8vsNFP7u6
        uvZp7MGeFTwQ7iwDm4ypH0YQJto2tyhpUmgYrghzCQ==
X-Google-Smtp-Source: APXvYqyb0u91xn/9EgQRLgm22x8g0mYSNDvWwLXKATo78HQo6yYrIf9lhtW2wyrdwbUhFR3xGGpTdh6ZjGSKOiDXoaY=
X-Received: by 2002:a1c:eb14:: with SMTP id j20mr11661928wmh.32.1553660966187;
 Tue, 26 Mar 2019 21:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-26-matthewgarrett@google.com> <CALCETrXDF2c2-gnOyNTnEn-uPAZp0AaSB_PB8e2y8jf7zo=Cyg@mail.gmail.com>
 <20190327003057.GA27311@kroah.com>
In-Reply-To: <20190327003057.GA27311@kroah.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 26 Mar 2019 21:29:14 -0700
X-Gmail-Original-Message-ID: <CALCETrVDDf4dj3Md1Nxc5P_NCToXGnAbEO3bGfwgKSfeVmU4Kw@mail.gmail.com>
Message-ID: <CALCETrVDDf4dj3Md1Nxc5P_NCToXGnAbEO3bGfwgKSfeVmU4Kw@mail.gmail.com>
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

On Tue, Mar 26, 2019 at 5:31 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 26, 2019 at 12:20:24PM -0700, Andy Lutomirski wrote:
> > On Tue, Mar 26, 2019 at 11:28 AM Matthew Garrett
> > <matthewgarrett@google.com> wrote:
> > >
> > > From: Matthew Garrett <mjg59@google.com>
> > >
> > > debugfs has not been meaningfully audited in terms of ensuring that
> > > userland cannot trample over the kernel. At Greg's request, disable
> > > access to it entirely when the kernel is locked down. This is done at
> > > open() time rather than init time as the kernel lockdown status may be
> > > made stricter at runtime.
> >
> > Ugh.  Some of those files are very useful.  Could this perhaps still
> > allow O_RDONLY if we're in INTEGRITY mode?
>
> Useful for what?  Debugging, sure, but for "normal operation", no kernel
> functionality should ever require debugfs.  If it does, that's a bug and
> should be fixed.
>

I semi-regularly read files in debugfs to diagnose things, and I think
it would be good for this to work on distro kernels.
