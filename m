Return-Path: <SRS0=NXRd=6Z=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B347C47255
	for <linux-security-module@archiver.kernel.org>; Mon, 11 May 2020 20:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F195206D5
	for <linux-security-module@archiver.kernel.org>; Mon, 11 May 2020 20:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYrJjecL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbgEKUIn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 May 2020 16:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKUIn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 May 2020 16:08:43 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E5FC061A0C;
        Mon, 11 May 2020 13:08:43 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id y13so444326vsk.8;
        Mon, 11 May 2020 13:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ftnhm3Zr3OB7tltZPhctvozPIZtqWAy6wfMsbhYuLqM=;
        b=UYrJjecLdCXE2oyNHV1wvVWIixMiuQMWDDpFgFVGKxB3uvKICUZNTKx7iZTusWpnv9
         98CMxMYmmm1MaVao8NGzPtcnWv0yVrlblv9O/QYsgOwP65UHxeYESnp2Uu4xCEKL7ual
         7ZZbbwsEOLAMIgVaIpPg6z2c/juibKOvKGUpllCDzYyO3UNIO5W2KUTgV1JJ0C+QchQz
         6XmnoE5GKOuRgHAigGHBWhmApXk23a7BJTe5PasQpBz8as42g7tMmzQ6wufQyRKyVElf
         +xaDCSmBzpo4q+XaLkCtqCepgv/UM+0Gpc4cQYL6rDIcW8oxvZUzXnHMRDa/s0nNIGqD
         kdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ftnhm3Zr3OB7tltZPhctvozPIZtqWAy6wfMsbhYuLqM=;
        b=mQm59nee//pa0aucZOZ+z8WJ+Zg7sgjzgwQ3kH1mc0wWJ0FvlQ6qPY2b2GnWRPh27w
         1OV05vUmi0srSrpRBmWUWBjm/3LhYaq3PYsOIL7XcyWYX5se3P2bU/i/Z907It7caaZi
         SHeThwRHWJ3Te+BQ9mO3HgAyKZNcr6ntz61S5At1wVErai4qY+yww7oYBvsHflMSEZ5M
         Sf2HygTlZ9pAEwxZnzvumhMsRRgFw1oa0VRdjNHC/PCHvtV5JvbE+ALQKJ/D7QjSz//u
         +r5mQHBw3bwK0iyikk5Hd6rgM9LEQPiavLDCPL3JR77m34jswCmXVrgTtTACrw09XwQ6
         KW+g==
X-Gm-Message-State: AGi0Pua9zi9EJWSUGf2DbyApp9FZOASafTniJgbDnCJZu/XFOeC4Js32
        gedrnGCevfNOeJNy/8ueusTXOE4qro2Ywkem99PmckByCzM=
X-Google-Smtp-Source: APiQypIvyaUOCT6biuJoQH0SW5M4ECNUvmnVuSzZNfzpLuyJOeuQB5thdX2N65PDxf8XMYxtIKxa31b2NYYJSEWzB9s=
X-Received: by 2002:a05:6102:1c:: with SMTP id j28mr13087496vsp.209.1589227722487;
 Mon, 11 May 2020 13:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <18e48255d68a1408b3e3152780f0e789df540059.camel@gmail.com>
 <aa217de398584fa7846cf4ac0c872036@AUSX13MPC101.AMER.DELL.COM>
 <CAD2FfiEk8Fq3=i_3NHvtuwip=-v_cGfnYSowdPi86U_BcgP2gQ@mail.gmail.com>
 <61c7782cd2e64bb9ab2aaf6a016bbb6c@AUSX13MPC101.AMER.DELL.COM>
 <CAD2FfiGweUHNJGdj7OUQFxEhQBYvMCbuWM-+ez=SpN=HbcaS4Q@mail.gmail.com>
 <70757953c25645baac2dddd7c6924d05@AUSX13MPC101.AMER.DELL.COM>
 <20200508082028.GP487496@lahna.fi.intel.com> <CAD2FfiG2c4iXmTjUpQAUqRVBVyH0Hm4VfO5PBTXf03VXHR22ng@mail.gmail.com>
 <20200511104504.GK487496@lahna.fi.intel.com> <CAD2FfiHn0PNaC3aFXE-hn9Mmtt5JW_D8BK0hOScYXR9EJLNbcw@mail.gmail.com>
 <20200511162811.GA487496@lahna.fi.intel.com>
In-Reply-To: <20200511162811.GA487496@lahna.fi.intel.com>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Mon, 11 May 2020 21:08:31 +0100
Message-ID: <CAD2FfiHo1EzRupjgKhtLX0Zguq-bVeW5+u_PNQGAzV0x+AtfVw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: Export LPC attributes for the system SPI chip
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Mario Limonciello <Mario.Limonciello@dell.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 11 May 2020 at 17:28, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> #if IS_ENABLED(CONFIG_SECURITY)
> static int lpc_ich_init_securityfs(struct pci_dev *dev)

I've done that, thanks.

> For the security stuff you are adding, do you need to look at the PCI
> device registers as well?

No, just the config space. I guess at some point I might want to put
some of the chipsec vulnerability checks into the module, although I'm
not happy adding anything remotely dangerous.

>   $ scripts/get_maintainers.pl path/to/the/patch

Will do, thanks. I'll polish up the list of DIDs and submit it again.

Richard.
