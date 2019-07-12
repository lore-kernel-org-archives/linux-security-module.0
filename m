Return-Path: <SRS0=X76I=VJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AB4C742C7
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Jul 2019 15:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03066208E4
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Jul 2019 15:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UUuGvnEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfGLPbA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 12 Jul 2019 11:31:00 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35054 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfGLPbA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Jul 2019 11:31:00 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so21244990ioo.2
        for <linux-security-module@vger.kernel.org>; Fri, 12 Jul 2019 08:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8aiIBdX3CQ0Y3g5rAmb69/5sP0ejqkH3yRc6q3yjULk=;
        b=UUuGvnEGWcs1s+SpnbnaJO3FKWIybKARHIXUfNxI4SuFLK9TQsLmVljuolpe+K55Vu
         ME3WFAH4MXJviiAe8u2P78Fpu9bEjc4+Op1k8lOMjTyv/3nR10FMIVlBA71p++Ssqssg
         zaJL9RrN2oxi/d+0Kj6+2CUlHBAHL8wLr27+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8aiIBdX3CQ0Y3g5rAmb69/5sP0ejqkH3yRc6q3yjULk=;
        b=izjoht4D+Ah+4nj4BAVgVzzXc9HSgPL9JXOSN5N4b6UADpoE/HLs1IHcdaGt6dKB9O
         PJ/vnTyjKuVDDcBd045v/Mz1JdDZrb7qd5QIjDVFn+OvfjiDGJ6vQwLI22SMsUtSgt08
         Ik9nMLPR2jIjw5KxNwNc4VMzfFoZdPCX2AEOkBv5GoGwcH3heUfh21YoEmQDzDmbSTk1
         bwFflSGiKzyAzOZ0JNd3CtGpczhKb491B4Bp11hmCJCVDAQS5j9qwRTWalP/rDQZkYgW
         DkEvKwcA04Mt3QM3X2VrKN6WOhD6Cydc9lhKUNY44AN5p+M4vUmECh3L0mHglMDM/c42
         KG0A==
X-Gm-Message-State: APjAAAU827rPVw57IgNv9U+mBP+zniv4i2laSKVXLCua4HirJSrQSxqD
        8Y4CWp0hQtbRgtmd1W+/kM7EMz3UiBsoINkwWsgG23OERTM=
X-Google-Smtp-Source: APXvYqz64ugOVf/tbaRUcYJqLsGBCgXGSbh3m4IeBZun6aRr3in9HtIqdpWffl8s+KBV2TNqZAO9M/BxbvEvTvS9BdE=
X-Received: by 2002:a6b:f816:: with SMTP id o22mr11654550ioh.166.1562945459382;
 Fri, 12 Jul 2019 08:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190522172241.192669-1-mortonm@chromium.org> <alpine.LRH.2.21.1905230341520.18826@namei.org>
In-Reply-To: <alpine.LRH.2.21.1905230341520.18826@namei.org>
From:   Micah Morton <mortonm@chromium.org>
Date:   Fri, 12 Jul 2019 08:30:48 -0700
Message-ID: <CAJ-EccPo2T6y=7Gw-naPZ4d25em+8TsZMSXp4C=pGeTutbPqZA@mail.gmail.com>
Subject: Re: [PATCH] LSM: Update MAINTAINERS file for SafeSetID LSM.
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi James,

Are we still merging this kind of thing through your tree?

Or does it make more sense for me to send this through my tree when I
get one up and running?

I was trying to get in the MAINTAINERS file since it seems that this
is a prerequisite for getting an account for hosting my tree on
git.kernel.org.

Thanks



On Wed, May 22, 2019 at 10:42 AM James Morris <jmorris@namei.org> wrote:
>
> On Wed, 22 May 2019, Micah Morton wrote:
>
> > This is in preparation for SafeSetID to be maintained in its own tree,
> > rather than going via the security tree.
> >
> > Signed-off-by: Micah Morton <mortonm@chromium.org>
>
>
> Acked-by: James Morris <jamorris@linux.microsoft.com>
>
> > ---
> >  MAINTAINERS | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3e5a5d263f29..0fcd34e64fa7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13561,6 +13561,12 @@ F:   drivers/media/common/saa7146/
> >  F:   drivers/media/pci/saa7146/
> >  F:   include/media/drv-intf/saa7146*
> >
> > +SAFESETID SECURITY MODULE
> > +M:   Micah Morton <mortonm@chromium.org>
> > +S:   Supported
> > +F:   security/safesetid/
> > +F:   Documentation/admin-guide/LSM/SafeSetID.rst
> > +
> >  SAMSUNG AUDIO (ASoC) DRIVERS
> >  M:   Krzysztof Kozlowski <krzk@kernel.org>
> >  M:   Sangbeom Kim <sbkim73@samsung.com>
> >
>
> --
> James Morris
> <jmorris@namei.org>
>
