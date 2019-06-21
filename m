Return-Path: <SRS0=QDjJ=UU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B14C43613
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jun 2019 20:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4A820673
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jun 2019 20:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xj6Qle4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfFUUSQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Jun 2019 16:18:16 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35726 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfFUUSQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jun 2019 16:18:16 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so492398ioo.2
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2019 13:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8efNcZtDwk7IidLHvLtP2hUl2fc9Kq5GohdU6xk+B0=;
        b=Xj6Qle4/q+GM5Ky8b2Khzf+oX1HiCniPCrEDrmA+nj/WMc5akAtYIQ6OJAj94ohBnb
         aX/9RTXO5LkDnk+mBUQQ3x5MOXNAP593Aaj9qJC62m3BuAAYVd0BM7x93MxB/eZMb564
         ViDCqclpjT6u2cPNdJPmy22KXsTS0PnyoaQr4/78/7lxat7WAmkNrYzoalaarcBaxu4F
         NSSswrNR2IN5nwO5k82C1Yn/EoGPNInSbjbOYm6PbKtTaMEFc7ghnTss+GAsTc0VT3co
         iuuiNOnnE44+qY9sKAADPI3IEyStp11UrDg0PBvvcQhHnmGq9z6GO7nxez9WzxkFMPbs
         k7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8efNcZtDwk7IidLHvLtP2hUl2fc9Kq5GohdU6xk+B0=;
        b=eRAC0Z8rk2ZZeALxjq7laLmyMYyW7VVZw/X7wesoeLJe1D7OWGTEJJvnp7kbpEto4b
         5ykHdC0xkHhO4RuPEY8iiG3iNkRY4xUu1MBbkFL8jLSPFlD3lWkfp7UVyxM6zym1ZzaH
         TxSPa9Lv+d1Xjd1JWFkiFTnU1YSE/zvYXWffCx81D3oV/bACiWqZOly03PIqIfN1jPQ/
         i1lJYiOmjg3Y6Itya3lDostAC1DntNvKAXfklZcZ8NPtXQ2BEBzTJIOMdW2J+LzqltuR
         qsWKKKG1DFxhJXt3rPXZOd3p5w3dTflzMBeLxv7MGjs9IkkPMMCPGuvqjfgLqyTxw5zU
         CuFg==
X-Gm-Message-State: APjAAAXp2BeUl3PuYtOIUa0F6FJBs83My5zGE16Be01rFezNJRKrIl9L
        0JrSIm9CkGMr2jYV24pCoOaFAgQf68Cd55VezBjopg==
X-Google-Smtp-Source: APXvYqy23qbovsSsoFJ0RjtLQmZBZKdQgbpWtLEgyUTQHuLRdPlhf28KgpZ4L8+7/6SG64J+AK2cPMuORXLcoLNPoN4=
X-Received: by 2002:a05:6638:3d3:: with SMTP id r19mr12698566jaq.53.1561148294551;
 Fri, 21 Jun 2019 13:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-8-matthewgarrett@google.com> <20190621064340.GB4528@localhost.localdomain>
In-Reply-To: <20190621064340.GB4528@localhost.localdomain>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 21 Jun 2019 13:18:03 -0700
Message-ID: <CACdnJut=J1YTpM4s6g5XWCEs+=X0Jvf8otfMg+w=_oqSZmf01Q@mail.gmail.com>
Subject: Re: [PATCH V31 07/25] kexec_file: Restrict at runtime if the kernel
 is locked down
To:     Dave Young <dyoung@redhat.com>
Cc:     James Morris <jmorris@namei.org>, Jiri Bohac <jbohac@suse.cz>,
        Linux API <linux-api@vger.kernel.org>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 20, 2019 at 11:43 PM Dave Young <dyoung@redhat.com> wrote:
>
> On 03/26/19 at 11:27am, Matthew Garrett wrote:
> > From: Jiri Bohac <jbohac@suse.cz>
> >
> > When KEXEC_SIG is not enabled, kernel should not load images through
> > kexec_file systemcall if the kernel is locked down.
> >
> > [Modified by David Howells to fit with modifications to the previous patch
> >  and to return -EPERM if the kernel is locked down for consistency with
> >  other lockdowns. Modified by Matthew Garrett to remove the IMA
> >  integration, which will be replaced by integrating with the IMA
> >  architecture policy patches.]
> >
> > Signed-off-by: Jiri Bohac <jbohac@suse.cz>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > Signed-off-by: Matthew Garrett <mjg59@google.com>
> > Reviewed-by: Jiri Bohac <jbohac@suse.cz>
> > cc: kexec@lists.infradead.org
> > ---
> >  kernel/kexec_file.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 67f3a866eabe..a1cc37c8b43b 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -239,6 +239,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
> >               }
> >
> >               ret = 0;
> > +
> > +             if (kernel_is_locked_down(reason, LOCKDOWN_INTEGRITY)) {
> > +                     ret = -EPERM;
> > +                     goto out;
> > +             }
> > +
>
> Checking here is late, it would be good to move the check to earlier
> code around below code:
>         /* We only trust the superuser with rebooting the system. */
>         if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
>                 return -EPERM;

I don't think so - we want it to be possible to load images if they
have a valid signature.
