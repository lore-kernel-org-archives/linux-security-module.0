Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4D4C432BE
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Aug 2021 16:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A9E60E75
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Aug 2021 16:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhHZQiF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 26 Aug 2021 12:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243106AbhHZQiF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Aug 2021 12:38:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 276C260FD9
        for <linux-security-module@vger.kernel.org>; Thu, 26 Aug 2021 16:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629995838;
        bh=ClIHzNtlzVQhWL96OxLoL/QxOkO5WvOQTPqUNkwurpk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IIkTqcg3q955ZX40Oa5PLKZJ2+ATI1NGbcHek7YpazffyD/zzKXSrhte7/Ciq7t6U
         vofZCYen6u4H4zujpxoRd41xz9Nrkm5ytp7Vq0u5Hu5tbsLl1jz1V+DJhkGCqVCJ3F
         exwKzCMT/Kvc2DrIxjitijX83487v7o+BE0D7bjmYSs8MerBZbR96Rx8D12MUUnNNI
         5lLy9VY8fLxFJOxf6gdx1WxHXZJYcmUy6FUpXbqouFLtNpjBHgrCLrqE2uQ0mmY32X
         Wn/NtwctV3G6PdiwCRl9RP8oeVDKQ+f+44X+dncNaiEjTVI7qV+vCEbfL+ZhPBs+Mp
         UrCeCyUbncAsA==
Received: by mail-ot1-f43.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so4262889otk.9
        for <linux-security-module@vger.kernel.org>; Thu, 26 Aug 2021 09:37:18 -0700 (PDT)
X-Gm-Message-State: AOAM533Tyf2f0XhDkNk4Pn9Uq9dYk1BomIl2n/3UyCdmjxydqyVaHnN2
        aOKV0W9IaJ+FzXc3pCmSRaxOv+HcSVNNCTlx5iw=
X-Google-Smtp-Source: ABdhPJyPYjC9ahpqxTh3cGV+1bMD3LK5gU5GJTtSTMP+oMbGsSvHFDvLSKhqDBlIxbywFag/rP+/oh67hc8uNest1D8=
X-Received: by 2002:a05:6830:444:: with SMTP id d4mr3908339otc.108.1629995837478;
 Thu, 26 Aug 2021 09:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210209164506.54176-1-andriy.shevchenko@linux.intel.com>
 <CAMj1kXGjoZ4qXxfB-2eH84k9Dg93cWs10DmDkZwv-C3_nKi_Ow@mail.gmail.com>
 <YL5TN6oTtgggIFvv@smile.fi.intel.com> <CAMj1kXFHG4G+KCv4KaL6XYtAPs99bsQ-0fik8oKv4GWDw2+GJg@mail.gmail.com>
 <YSeueHLVPsfCO0ah@smile.fi.intel.com>
In-Reply-To: <YSeueHLVPsfCO0ah@smile.fi.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 26 Aug 2021 18:37:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG6cZK+j-oEURuvLgntZxL-maUs0zk0UexHs3=S0wbLug@mail.gmail.com>
Message-ID: <CAMj1kXG6cZK+j-oEURuvLgntZxL-maUs0zk0UexHs3=S0wbLug@mail.gmail.com>
Subject: Re: [PATCH v1] efi: Don't use knowledge about efi_guid_t internals
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 26 Aug 2021 at 17:08, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jun 10, 2021 at 05:05:55PM +0200, Ard Biesheuvel wrote:
> > On Mon, 7 Jun 2021 at 19:11, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Feb 09, 2021 at 05:51:45PM +0100, Ard Biesheuvel wrote:
> > > > On Tue, 9 Feb 2021 at 17:45, Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > >
> > > > > When print GUIDs supply pointer to the efi_guid_t (guid_t) type rather
> > > > > its internal members.
> > > > >
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > >
> > > > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Thanks!
> > >
> > > Can we get this applied, please?
> >
> > Apologies, this one slipped behind the desk.
>
> Do I need to resend it?
>

No, but I need an ack from James or Serge as it targets security/
