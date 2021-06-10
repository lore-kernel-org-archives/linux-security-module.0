Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25902C47094
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jun 2021 15:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02EE4613FF
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jun 2021 15:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhFJPIE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 10 Jun 2021 11:08:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230410AbhFJPIE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Jun 2021 11:08:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C761613DD
        for <linux-security-module@vger.kernel.org>; Thu, 10 Jun 2021 15:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623337568;
        bh=V7eNmiMbl6bCy9ghEtEcjAOUpi2+bknVdLKMfwFCIDc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jXy1KynAzoRlPpgft9TpuMfwoaAx+YFugg2opUtQKbYbv945aKKgb2NPHHH8bJ7Z3
         E3iz1MuhfYICmQx8KHSU6xoDUOdeIZeY2erideLOKEVntuLNbGWgox/IWoZBal44XQ
         t994/HXNYKK5vY33zsRryyRQnRU359+CdZamDC3sS3Nuoj0J67GKkv44yvbAOnrxrW
         mH/0NPEdeBF0tQj9gyym+Tf+G0HaatEG5yeu5wr4B8VG92gLf9dwjUTV0pzfS8UNyF
         fp16tMBxeee1qHX3z+EgrQTzYGS6gnaM5auPIOhljh++8ZcSXn7P2aE4uYgW2dUup9
         N0sPb6pon/q2g==
Received: by mail-ot1-f41.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so23385388oth.9
        for <linux-security-module@vger.kernel.org>; Thu, 10 Jun 2021 08:06:08 -0700 (PDT)
X-Gm-Message-State: AOAM5326GcC+6aPKzTRhTh5a4KJOdMp0JqzC9CbjlezqOI685daKVn56
        yjFwwMpzSDQ7ilJGzRf6zdODLTkVm3v4eVRQ+NM=
X-Google-Smtp-Source: ABdhPJwRT6ucdaFMnGkpJauNMiRRUMwPStLfcFpGez4Te42VL6DRUXOLNGxTk7iK2UryC6QDMO5uXAijMXRWnEiAcuk=
X-Received: by 2002:a9d:4c83:: with SMTP id m3mr2795425otf.77.1623337567444;
 Thu, 10 Jun 2021 08:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210209164506.54176-1-andriy.shevchenko@linux.intel.com>
 <CAMj1kXGjoZ4qXxfB-2eH84k9Dg93cWs10DmDkZwv-C3_nKi_Ow@mail.gmail.com> <YL5TN6oTtgggIFvv@smile.fi.intel.com>
In-Reply-To: <YL5TN6oTtgggIFvv@smile.fi.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 10 Jun 2021 17:05:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFHG4G+KCv4KaL6XYtAPs99bsQ-0fik8oKv4GWDw2+GJg@mail.gmail.com>
Message-ID: <CAMj1kXFHG4G+KCv4KaL6XYtAPs99bsQ-0fik8oKv4GWDw2+GJg@mail.gmail.com>
Subject: Re: [PATCH v1] efi: Don't use knowledge about efi_guid_t internals
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 7 Jun 2021 at 19:11, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Feb 09, 2021 at 05:51:45PM +0100, Ard Biesheuvel wrote:
> > On Tue, 9 Feb 2021 at 17:45, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > When print GUIDs supply pointer to the efi_guid_t (guid_t) type rather
> > > its internal members.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>
>
> Thanks!
>
> Can we get this applied, please?
>

Apologies, this one slipped behind the desk.
