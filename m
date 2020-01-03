Return-Path: <SRS0=IjdJ=2Y=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086BFC2D0C2
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Jan 2020 09:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB7321835
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Jan 2020 09:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="buQmi+65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgACJcy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Jan 2020 04:32:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30440 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725972AbgACJcy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Jan 2020 04:32:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578043972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=peCLyUcHcZDtrn11rrPNe5EtP4MeO4tPS8pTg/OSCns=;
        b=buQmi+65BppowjJQECiYIM86Xb0SNN20At5HcktBk/3iuihDTibpanY0LRRw67kkVMoldb
        fKUfhiPBdlKl0Kedm6Y8hKYQfC73HoexXsig2+9yzUrwYbY9mteoz7OXcArEnELU3rOE17
        1OnNvp9vGiy1HBi6c5onmUh+qfNUyVU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-MqkTmSEBPM-ibgNKk5nhMw-1; Fri, 03 Jan 2020 04:32:51 -0500
Received: by mail-oi1-f200.google.com with SMTP id n130so11603504oib.5
        for <linux-security-module@vger.kernel.org>; Fri, 03 Jan 2020 01:32:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hG5Q9vhcZG5Wd6ocJI6dU3GALHIbQ+VzDS0McYQNwxQ=;
        b=o74yk4a/nMw/gTyvks/pzFptqBZTZKxqPj6ByiOG66rt7HjRazaMB7gIE+VnvIA8Rx
         215fVwmypfvfsYU2yTwkt1Y5NK6CxZADjqBHR5twYYkZzyZDFt5txEaTDQaTnhISjUDY
         djLoq5vz2juZ+adwrRjyqf5JdEv0op0mtHsfXuGpFQrtGeIrEA4Y5sQKwrSSRi8+2G8y
         jk8y+5ZW0gWqPsQlqn5XfNL+5dsQvK6CDPsBAO1J2EDu+jYa63VTbwFxrkEdMVvLfLyu
         GcwCA5IHc4JAaRP/65PmU6xycxEr1NnHtjbkorXCb1v7jlXBgas6wKjf/4S/EQP+RCQv
         4RQA==
X-Gm-Message-State: APjAAAWI/D1oXK/tAV3BW7Bs0OhWx7qxU4HDIm7u/+jbl6om+Mryk8/D
        0+E8SyiHtuERyHiUQLQYnPHe+/8Ft6H+yGgB2oyvFBF40wahLQdkoR21imSH+qkp5fQUpOoVt5Y
        DGSZBr3n1ys14NyxKQKQCO4zoJRWyeLcyIR/nQbwHMVRq8w9Wxrzw
X-Received: by 2002:a9d:68d1:: with SMTP id i17mr80060860oto.367.1578043970747;
        Fri, 03 Jan 2020 01:32:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqytjxQEJPalZMGDnik9IRoxtCxyOMSp3eFv1NtMz+TbTI3pmpfamRWNYnoNosMnG3Dk+6fGK3es/mWhhNRcLFY=
X-Received: by 2002:a9d:68d1:: with SMTP id i17mr80060840oto.367.1578043970454;
 Fri, 03 Jan 2020 01:32:50 -0800 (PST)
MIME-Version: 1.0
References: <157678334821.158235.2125894638773393579.stgit@chester>
 <CAFqZXNvXuWx-kCJeZKOgx4NSesCvnC63kHf6-=_SrFLH4xubag@mail.gmail.com> <CAHC9VhTHroatmHKt3Saru18TktFY8EXjsxkx-pWvx87-RUx8HA@mail.gmail.com>
In-Reply-To: <CAHC9VhTHroatmHKt3Saru18TktFY8EXjsxkx-pWvx87-RUx8HA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 3 Jan 2020 10:32:39 +0100
Message-ID: <CAFqZXNubaXZtF-yN6tMBuM+AGmSy=1nTcTimFfXaok32GY3aYA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: deprecate disabling SELinux and runtime
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
X-MC-Unique: MqkTmSEBPM-ibgNKk5nhMw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jan 2, 2020 at 10:38 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Jan 2, 2020 at 4:24 AM Ondrej Mosnacek <omosnace@redhat.com> wrot=
e:
> > On Thu, Dec 19, 2019 at 8:22 PM Paul Moore <paul@paul-moore.com> wrote:
> > > Deprecate the CONFIG_SECURITY_SELINUX_DISABLE functionality.  The
> > > code was originally developed to make it easier for Linux
> > > distributions to support architectures where adding parameters to the
> > > kernel command line was difficult.  Unfortunately, supporting runtime
> > > disable meant we had to make some security trade-offs when it came to
> > > the LSM hooks, as documented in the Kconfig help text:
> > >
> > >   NOTE: selecting this option will disable the '__ro_after_init'
> > >   kernel hardening feature for security hooks.   Please consider
> > >   using the selinux=3D0 boot parameter instead of enabling this
> > >   option.
> > >
> > > Fortunately it looks as if that the original motivation for the
> > > runtime disable functionality is gone, and Fedora/RHEL appears to be
> > > the only major distribution enabling this capability at build time
> > > so we are now taking steps to remove it entirely from the kernel.
> > > The first step is to mark the functionality as deprecated and print
> > > an error when it is used (what this patch is doing).  As Fedora/RHEL
> > > makes progress in transitioning the distribution away from runtime
> > > disable, we will introduce follow-up patches over several kernel
> > > releases which will block for increasing periods of time when the
> > > runtime disable is used.  Finally we will remove the option entirely
> > > once we believe all users have moved to the kernel cmdline approach.
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > Looks reasonable, informal ACK from me.
>
> Thanks.  You want to make that a formal ACK? ;)

Sure, if you find it useful :)

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

