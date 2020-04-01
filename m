Return-Path: <SRS0=fDLm=5R=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FB1C43331
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Apr 2020 09:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3DE20772
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Apr 2020 09:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585731951;
	bh=dYnwFkWvQCi/4RsslUhKhGsUJy6ilgkHanAfAP9SWJc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O6z9Ncxd8/XMYXHMQ/OZ1sQJG5URl9bQlJjRcFbokRXwdW+sxZupCdfhj+GdPA4Wm
	 ksvJ+iPk7D7zFI/+nV05DUI78Fx88ezu+KTTLoFXZK5PXdQ11FBDVKEkTEU6viQ4PP
	 ZvpluDV/MDdktAvRN66vVULzKormRCkX2Z8SRimY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbgDAJFt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:05:49 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35003 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbgDAJFt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Apr 2020 05:05:49 -0400
Received: by mail-ot1-f68.google.com with SMTP id v2so20595618oto.2;
        Wed, 01 Apr 2020 02:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Fstvq6bf/isSvXClPNvU/mMqL1HK/pXGHf70k9sUOo=;
        b=knfpKXqvnLZzXvI4ynzplYgQYdnP6nXqncQM723/3EkvYgkE8EvFWO8h7kwBfPe0LE
         mR47Pa/+cZcdNO7lJ1j7mU6MnUQUYkeu/brEAhh+yD3V/ORqMjvEIThWQgx6N9mnXTBf
         /ICtFFh6kAbCsUuMQZPoG1ebFbK4y/VLFaigUc6Vqbs3Jn5xW70VzlwQEZUxrhh9Dx6Q
         k6wv2gO4S+nCGGTfVnikmavK+VJ2ScNXtbcamoFzeW38cOYbWRASDbpdPULRtYsozR9Z
         tE7ZpyAmcExwoMq7HCGoM1xyLwNZM45biBlouJFHh7OTwn8BZYzMYgEeswn5Ob1zOTyl
         +teg==
X-Gm-Message-State: ANhLgQ22Can+bKJ/LOIqQ2x0xPwu9ilzU9hKTOf7NxggGDqph2uZLqNy
        o7QV6PmuiZUzwWVa+B87f9PybZ8W7vrX1/8bVFLhWg==
X-Google-Smtp-Source: ADFU+vs8rdELrg94gi2naBSfmudqSPJ7IVSOD/AD2w9UhPFDQZB/mQeMNupqUem7PyopiRqiRpQkRQR4+RbvnVUVUEk=
X-Received: by 2002:a4a:7555:: with SMTP id g21mr16266455oof.46.1585731948303;
 Wed, 01 Apr 2020 02:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200331214949.883781-1-stefanb@linux.vnet.ibm.com> <20200401083729.GD17325@linux.intel.com>
In-Reply-To: <20200401083729.GD17325@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Apr 2020 11:05:36 +0200
Message-ID: <CAJZ5v0gQ04h1+zN4wHj1vkwPvqu3RPfsY60VJ+GOtgUrvWuxLQ@mail.gmail.com>
Subject: Re: [PATCH v3] acpi: Extend TPM2 ACPI table with missing log fields
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-integrity@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 1, 2020 at 10:37 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Mar 31, 2020 at 05:49:49PM -0400, Stefan Berger wrote:
> > From: Stefan Berger <stefanb@linux.ibm.com>
> >
> > Recent extensions of the TPM2 ACPI table added 3 more fields
> > including 12 bytes of start method specific parameters and Log Area
> > Minimum Length (u32) and Log Area Start Address (u64). So, we extend
> > the existing structure with these fields to allow non-UEFI systems
> > to access the TPM2's log.
> >
> > The specification that has the new fields is the following:
> >   TCG ACPI Specification
> >   Family "1.2" and "2.0"
> >   Version 1.2, Revision 8
> >
> > Adapt all existing table size calculations to use
> > offsetof(struct acpi_table_tpm2, start_method_specific)
> > [where start_method_specific is a newly added field]
> > rather than sizeof(struct acpi_table_tpm2) so that the addition
> > of the new fields does not affect current systems that may not
> > have them.
> >
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > Cc: linux-acpi@vger.kernel.org
>
> I think I'm cool with this but needs an ack from ACPI maintainer.
>
> Rafael, given that this not an intrusive change in any possible means,
> can I pick this patch and put it to my next pull request?

Yes, please.

Thanks!
