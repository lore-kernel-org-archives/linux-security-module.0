Return-Path: <SRS0=32Xp=S7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D75C04AA6
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Apr 2019 13:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71B320675
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Apr 2019 13:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="nC/2UciM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfD2N5P (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 29 Apr 2019 09:57:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40113 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfD2N5P (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Apr 2019 09:57:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id t10so8402390ljg.7
        for <linux-security-module@vger.kernel.org>; Mon, 29 Apr 2019 06:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zr0gKPwou2dH6S7GhfaHwXxswbhzR7i0BNPHc9FdfXA=;
        b=nC/2UciMGyHO6xXe20S6Ef7FXUNkJmmvo6rZ9FcrxlwDnZoRz7JGOKegFpxvTmn2ya
         bYt4+VCQVPdEbgUD0cjKih7CY56j03xB5fEOdBW0Nf8yTvDRjeA7n4kgajmKVSVhoFQQ
         4GtyK+jgqGUde21PO7aG/wHkaUMm/T4zGzuCh04TUXksZPijwde1jWt8Kc1uITbzm8rQ
         OqKnbdaUbigPM+dj0Z9lyNHNVL2K45Kn7mFLcrfD9gtE509SdQFqN8IBBR3iuHT/aecX
         W5T2+43tDYSEM/+j5sIk+6IU6tw5Q9t3YIiwEKYszh6/q9dVjbD/41ABfVXLTpcDZbEN
         kQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zr0gKPwou2dH6S7GhfaHwXxswbhzR7i0BNPHc9FdfXA=;
        b=qC3Xb9TU2DQex4WoKGHp0FbJPnyd7kj8PyvhUaWmaeXOUICbh1OhGaSqFyooIeBQFY
         py10MghaVPBz54je8xWeCUWAM8byL7gZ1lqe0zKcIOcJPwNSL+3jAaom2G16GQrjOjA5
         h46lXSWIfHlHZrk22ycUA5yIS2aE9VBnAzJKLW2FJQTD8edQHLmLKNZII7KLwVihXNdD
         6WC+V5YZwNcAO9se38w58ERYNVEd+x/Sgt1RS2WKdMyJV7Nqf3D6rBScr4CKvjB462VE
         4Rg6l08uppEy9RFOGJfRCgxMXQ/7CqTaqH4OwH/hsziEhTHGR4euJEC+c/o5QfzFHmsA
         lRvg==
X-Gm-Message-State: APjAAAXhWjAm+nD+VUJnTNfvNHiBOX7cDduGrx/YZIBtX75FaebqwnP0
        5KjG/bSeHYOF+1e4/O4ZxyYWuHdaZiAyEfpnmcTj
X-Google-Smtp-Source: APXvYqxJk1RRtlHAlSWgtaSL5hKbWALp9D7v943BWDG2te36TTmQXQt0ysxuu/D+j6d7vo+QPujWvQ/7Iq4eC5jrtOc=
X-Received: by 2002:a2e:888a:: with SMTP id k10mr19149144lji.57.1556546232626;
 Mon, 29 Apr 2019 06:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <155570011247.27135.12509150054846153288.stgit@chester>
 <CAHC9VhQKE3Rnbz8qxm0UKNB=GT6xPu-Le=ZZM0_XisOS+v3jKg@mail.gmail.com> <alpine.LRH.2.21.1904200626400.21756@namei.org>
In-Reply-To: <alpine.LRH.2.21.1904200626400.21756@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 29 Apr 2019 09:57:01 -0400
Message-ID: <CAHC9VhTbNhgO4SHDbmALH_E1CdUSe90vpnvTS=me7Y21NK1dbQ@mail.gmail.com>
Subject: Re: [PATCH] proc: prevent changes to overridden credentials
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        cj.chengjian@huawei.com, john.johansen@canonical.com,
        casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Apr 19, 2019 at 4:27 PM James Morris <jmorris@namei.org> wrote:
> On Fri, 19 Apr 2019, Paul Moore wrote:
> > On Fri, Apr 19, 2019 at 2:55 PM Paul Moore <paul@paul-moore.com> wrote:
> > > Prevent userspace from changing the the /proc/PID/attr values if the
> > > task's credentials are currently overriden.  This not only makes sense
> > > conceptually, it also prevents some really bizarre error cases caused
> > > when trying to commit credentials to a task with overridden
> > > credentials.
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Reported-by: "chengjian (D)" <cj.chengjian@huawei.com>
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  fs/proc/base.c |    5 +++++
> > >  1 file changed, 5 insertions(+)
> >
> > I sent this to the LSM list as I figure it should probably go via
> > James' linux-security tree since it is cross-LSM and doesn't really
> > contain any LSM specific code.  That said, if you don't want this
> > James let me know and I'll send it via the SELinux tree assuming I can
> > get ACKs from John and Casey (this should only affect SELinux,
> > AppArmor, and Smack).
>
> This is fine to go via your tree.

Okay.  I just merged this into selinux/next.  I was sitting on this
patch to see how the other thread developed, but that doesn't really
seem to be reaching any conclusion and I really want this to get at
least one week in -next before the merge window opens.

Thanks everyone.

-- 
paul moore
www.paul-moore.com
