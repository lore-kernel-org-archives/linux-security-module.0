Return-Path: <SRS0=nDQO=AA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B46C433E0
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Jun 2020 15:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D740B21532
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Jun 2020 15:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592582138;
	bh=Ex6skR9YdgJtGYQMG45wy7W10lh2P9b//LxuoOro6ag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=M6zLYlFnqhNxYGbhKr8NyF1DNjjA1nM1EzDV3ck6ot2uluepzCyvOgQPrz4fxBk0a
	 zPDhBBRw3tQj8VEJh0CQ7FLLqF9thHYVaGFbk9hqKCkCRkUQHwEeJ5p3u2MpfVdvYs
	 GOCAmF6+/27orRUkjaRjB8G7Cd3Zf9dkaFAMJiDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404025AbgFSPzd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:55:33 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37479 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392508AbgFSPzc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Jun 2020 11:55:32 -0400
Received: by mail-ot1-f65.google.com with SMTP id v13so7646330otp.4;
        Fri, 19 Jun 2020 08:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKylRjNEpAqnQ+WaZirKknI5bexwPLrj3iuq9vdD0CA=;
        b=X/TKFmBJ0UPo7r4Ys16Gep89hMzFRiip4ieBT+C7dIZtCM16II3nJagzP6F5FL05Gb
         yJhTWgEKqoQHICjp2DA92Svl7pVT4L5ZhHdDVQ80H9ZkWJHCMTqPKTw4V3hbGDmZWrU6
         8SVUSuGyDexnwTyrSBKcscCrHlPGcYxjxq+S42RO6vxN90+dYWVd+mwuoc7zhAPJ4RYZ
         uU8Perr8d6ecpqhQa7q9WxCKsrA4sTMPIlbQcA3GTOJJNKvKBh8u0zBcvoLJWwXe6DNN
         MmZwXFOSVT74aY1584rV93g29RnpapT1pmsfWfxiRJCeDoTIgxHLBEnlq/5EGAne4Zrh
         HrkQ==
X-Gm-Message-State: AOAM530AH5zlRgi+iGSZzUVyBrMfcQh30YH2iN/MzW086JPeMW2foesn
        dZMJc5YDV4PaaJ0CB7d8N0MJQUqkULtKaEiKFA8KeQ==
X-Google-Smtp-Source: ABdhPJyhSqxeDfqtJxbOwrEXIFkN5IH/piua+hwM2UpE8o4bHRdGgkaqYQt5l8gSyJB6dHPW44SLsjC9Q+fprChYt5U=
X-Received: by 2002:a9d:7d15:: with SMTP id v21mr3480467otn.118.1592582131467;
 Fri, 19 Jun 2020 08:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200331214949.883781-1-stefanb@linux.vnet.ibm.com>
 <20200401083729.GD17325@linux.intel.com> <CAJZ5v0gQ04h1+zN4wHj1vkwPvqu3RPfsY60VJ+GOtgUrvWuxLQ@mail.gmail.com>
 <20200402192145.GB10314@linux.intel.com> <dfd2d622-90cb-9621-7b7d-5282f5ee7359@linux.ibm.com>
In-Reply-To: <dfd2d622-90cb-9621-7b7d-5282f5ee7359@linux.ibm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 Jun 2020 17:55:19 +0200
Message-ID: <CAJZ5v0isZCK8o6hopUV3SP25P5+BwZGSSRFtGQrunQ0n45t68g@mail.gmail.com>
Subject: Re: [PATCH v3] acpi: Extend TPM2 ACPI table with missing log fields
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-integrity@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 19, 2020 at 5:14 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>
> On 4/2/20 3:21 PM, Jarkko Sakkinen wrote:
> > On Wed, Apr 01, 2020 at 11:05:36AM +0200, Rafael J. Wysocki wrote:
> >> On Wed, Apr 1, 2020 at 10:37 AM Jarkko Sakkinen
> >> <jarkko.sakkinen@linux.intel.com> wrote:
> >>> On Tue, Mar 31, 2020 at 05:49:49PM -0400, Stefan Berger wrote:
> >>>> From: Stefan Berger <stefanb@linux.ibm.com>
> >>>>
> >>>> Recent extensions of the TPM2 ACPI table added 3 more fields
> >>>> including 12 bytes of start method specific parameters and Log Area
> >>>> Minimum Length (u32) and Log Area Start Address (u64). So, we extend
> >>>> the existing structure with these fields to allow non-UEFI systems
> >>>> to access the TPM2's log.
> >>>>
> >>>> The specification that has the new fields is the following:
> >>>>    TCG ACPI Specification
> >>>>    Family "1.2" and "2.0"
> >>>>    Version 1.2, Revision 8
> >>>>
> >>>> Adapt all existing table size calculations to use
> >>>> offsetof(struct acpi_table_tpm2, start_method_specific)
> >>>> [where start_method_specific is a newly added field]
> >>>> rather than sizeof(struct acpi_table_tpm2) so that the addition
> >>>> of the new fields does not affect current systems that may not
> >>>> have them.
> >>>>
> >>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >>>> Cc: linux-acpi@vger.kernel.org
> >>> I think I'm cool with this but needs an ack from ACPI maintainer.
> >>>
> >>> Rafael, given that this not an intrusive change in any possible means,
> >>> can I pick this patch and put it to my next pull request?
> >> Yes, please.
> >>
> >> Thanks!
> > Great, thanks Rafael.
> >
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >
> > Do you mind if I add your ack to the commit?
>

It looks like I missed the previous message from Jarkko.

Yes, please, feel free to add my ACK to the patch, thanks!
