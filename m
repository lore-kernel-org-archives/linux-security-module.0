Return-Path: <SRS0=r65R=RD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5272C43381
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8B62133D
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Feb 2019 23:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jr40GoDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbfB1XN0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:13:26 -0500
Received: from mail-it1-f176.google.com ([209.85.166.176]:35006 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388220AbfB1XNR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Feb 2019 18:13:17 -0500
Received: by mail-it1-f176.google.com with SMTP id 188so18543236itb.0
        for <linux-security-module@vger.kernel.org>; Thu, 28 Feb 2019 15:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U4EKtO8Lt7LtImVbYr492MAgae5N97F7gOgi1ky7qcA=;
        b=jr40GoDsA4xDK8qdPIT9cYlD4zAlUwWZfhzOTKJso8uZo4FClC7lw+WzSx866wul2F
         JlLJtbRRvwiyTzqAe6Oj6iNBu3wQQoFEnts48KGzv3gWbtKpdyr94UUFMU+OqyVFnMck
         Xxz3Zsgfg7C9ICnWW/JgS9WDw8Vugr9o2CI/IPJJLTlzZoHvc1jqf5F883/JfdZ1ECQr
         bzIESikqDXoQuXwZE5JK4OALLdc1MlaUl9HX0b5W9PgaCjt6gWmnfX/pdtDtoMkIWbHI
         c/YFbbu7ZwsvI0NHXNxboma7qsWJmx0zKSPr6cC6C0pC0C845IwmMxXPmN1IhvmP1koH
         VUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U4EKtO8Lt7LtImVbYr492MAgae5N97F7gOgi1ky7qcA=;
        b=eGKAIjU51bmsfqgTUEY9DbPXPxIPs8kUVRTuKy+qsNG6c9i6SuvyqW93jrxs16WLUM
         DBaunX2xuG1+qp+zzlWExGYX14P9PAVe+uq+VJyzwk4A2pL8CJBdqTXZbHbLbwTLt1Iu
         9hAyaW38o3V0M9Bp3SKEfwSRqki0HsvdXELJUZ8FlP5BeUZmoKocA6Q/2CZ7+i+Y9nER
         CeJ0YBVuSP76icD2jkWHArxB/KKiUBzJXfbmhDnnoO2niP4y5C/q+3LkuPz7ObFPbIqW
         ygAsdcRZ5jKmogoWKQiZamHKvWB4oSQMSdHQ74ttfs+CKPg6gaOnfKk1URwT8+PWgKvZ
         96WQ==
X-Gm-Message-State: APjAAAXkZPFVo2fAeVaqiSQy48gstMMK8oG5c8jauUoj4qCuClC1wDzc
        u91+4w6QRVHGdUFN2gDamGEgjCrsbPYL5xEfkUYdIg==
X-Google-Smtp-Source: APXvYqz49WocE11CgsRXANBEQe+ZzeNp8fRk6ac+dQcVzskgkQjLkTIhBdKt27Ihk0Vb/VCnBgpwpRWnVN+z3V6fY2k=
X-Received: by 2002:a02:76c2:: with SMTP id z185mr966343jab.102.1551395596607;
 Thu, 28 Feb 2019 15:13:16 -0800 (PST)
MIME-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <1551392438.10911.227.camel@linux.ibm.com>
In-Reply-To: <1551392438.10911.227.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 28 Feb 2019 15:13:05 -0800
Message-ID: <CACdnJuvwnh0PKr5jUTm2h=P5-u-oLgBjvThX+DxcegShXReCdA@mail.gmail.com>
Subject: Re: [PULL REQUEST] Lock down patches
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     jmorris@namei.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Feb 28, 2019 at 2:20 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Thu, 2019-02-28 at 13:28 -0800, Matthew Garrett wrote:
> > This PR is mostly the same as the previous attempt, but with the
> > following changes:
>
> Where/when was this latest version of the patches posted?

They should have followed this, but git-send-email choked on some
reviewed-by: lines so I'm just trying to sort that out.

> >
> > 1) The integration between EFI secure boot and the lockdown state has
> > been removed
> > 2) A new CONFIG_KERNEL_LOCK_DOWN_FORCE kconfig option has been added,
> > which will always enable lockdown regardless of the kernel command
> > line
> > 3) The integration with IMA has been dropped for now. Requiring the
> > use of the IMA secure boot policy when lockdown is enabled isn't
> > practical for most distributions at the moment, as there's still not a
> > great deal of infrastructure for shipping packages with appropriate
> > IMA signatures, and it makes it complicated for end users to manage
> > custom IMA policies.
>
> I'm all in favor of dropping the original attempt to coordinate
> between the kexec PE and IMA kernel image signatures and the kernel
> appended and IMA modules signatures, but there has been quite a bit of
> work recently coordinating the different types of signatures.
>
> Preventing systems which do use IMA for signature verification, should
> not limit their ability to enable "lock down".  Does this version of
> the "lock down" patches coordinate the different kexec kernel image
> and kernel module signature verification methods?

It's a little more complicated than this. We can't just rely on IMA
appraisal - it has to be based on digital signatures, and the existing
patch only made that implicit by enabling the secure_boot policy. I
think we do want to integrate these, but there's a few things we need
to take into account:

1) An integrated solution can't depend on xattrs, both because of the
lagging support for distributing those signatures but also because we
need to support filesystems that don't support xattrs
2) An integrated solution can't depend on the current secure_boot
policy because that requires signed IMA policy updates, but
distributions have no way of knowing what IMA policy end users require

In any case, I do agree that we should aim to make this more
reasonable - having orthogonal signing code doesn't benefit anyone.
Once there's solid agreement on that we can extend this support.
