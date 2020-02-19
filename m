Return-Path: <SRS0=QiiV=4H=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD7FC35254
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Feb 2020 21:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129C124673
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Feb 2020 21:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582146025;
	bh=TJkZi3j+dhUK0k6i8hFThhPmsZ/TuJ6LjIHOiZrUA58=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HF7OdTGr2d7AnCS2L7eDzy6F7rzfVbtejaR76VVSF3b9P5At57YuLdTXFP5TCXjWN
	 N8PgFpmJpfwNdw2XVGtq5c0QYa1goRF0LFe9BwI7IyKaMOBUbJ454heQuxLwbmkE66
	 gwdpOmQ+qj6ZTz1/GPwH4P05m266pC+iRxNxxXSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgBSVAY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:00:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbgBSVAY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Feb 2020 16:00:24 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C672A2467C
        for <linux-security-module@vger.kernel.org>; Wed, 19 Feb 2020 21:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582146024;
        bh=TJkZi3j+dhUK0k6i8hFThhPmsZ/TuJ6LjIHOiZrUA58=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ch5ardAnJ18Fc9jtIT3DAHWB2kP5uJHOH8A5GLZiFYpUAZulLmkXxWZBgFwtcRcYg
         7QpCeccP9ZW9/8OICGrriM/QLtGOdTCCuO92/0FuJaDT39pSrwGyWzlWHq6zWmzPRv
         03NhM3woEoL7uGLg7kM2knNahKppsOemixKA4LGU=
Received: by mail-wm1-f45.google.com with SMTP id a5so2207067wmb.0
        for <linux-security-module@vger.kernel.org>; Wed, 19 Feb 2020 13:00:23 -0800 (PST)
X-Gm-Message-State: APjAAAW40ANgvB7aFm77LU0/IfIrlrGDYrLviUPRNIeMi6bbT3x0cTp0
        wQGxfKqVOPGHFlf2paaQgTLJ41KLCGf5xrcgobnGdg==
X-Google-Smtp-Source: APXvYqxyM/lxKvLeCAXUFUbYNNjRx6BxZzdxagSXjUJ2m/ZiWEfMvEkt2cTcyPPIOcinYGzX85tCav6dCc6/yiJrioI=
X-Received: by 2002:a1c:b603:: with SMTP id g3mr12630279wmf.133.1582146022109;
 Wed, 19 Feb 2020 13:00:22 -0800 (PST)
MIME-Version: 1.0
References: <20200219171907.11894-1-ardb@kernel.org> <20200219171907.11894-10-ardb@kernel.org>
 <20200219204603.GA28639@mail.hallyn.com>
In-Reply-To: <20200219204603.GA28639@mail.hallyn.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Feb 2020 22:00:11 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_c4mhMN5LBoH5jJWwMHaMxKY7zcp4hiqdRFiadPT8Nww@mail.gmail.com>
Message-ID: <CAKv+Gu_c4mhMN5LBoH5jJWwMHaMxKY7zcp4hiqdRFiadPT8Nww@mail.gmail.com>
Subject: Re: [PATCH 9/9] integrity: check properly whether EFI GetVariable()
 is available
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Graf <agraf@csgraf.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeff Brasen <jbrasen@nvidia.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 19 Feb 2020 at 21:46, Serge E. Hallyn <serge@hallyn.com> wrote:
>
> On Wed, Feb 19, 2020 at 06:19:07PM +0100, Ard Biesheuvel wrote:
> > Testing the value of the efi.get_variable function pointer is not
> > the right way to establish whether the platform supports EFI
> > variables at runtime. Instead, use the newly added granular check
> > that can test for the presence of each EFI runtime service
> > individually.
> >
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  security/integrity/platform_certs/load_uefi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> > index 111898aad56e..e2fe1bd3abb9 100644
> > --- a/security/integrity/platform_certs/load_uefi.c
> > +++ b/security/integrity/platform_certs/load_uefi.c
> > @@ -76,7 +76,7 @@ static int __init load_uefi_certs(void)
> >       unsigned long dbsize = 0, dbxsize = 0, moksize = 0;
> >       int rc = 0;
> >
> > -     if (!efi.get_variable)
> > +     if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
>
> Sorry, where is this defined?
>

Apologies, I failed to cc everyone on the whole series.

It is defined in the first patch.

https://lore.kernel.org/linux-efi/20200219171907.11894-1-ardb@kernel.org/
