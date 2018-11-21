Return-Path: <SRS0=9590=OA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B5CC43610
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Nov 2018 05:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE3321104
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Nov 2018 05:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KMa2MjBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE3321104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeKUQPD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Nov 2018 11:15:03 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43760 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbeKUQPD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Nov 2018 11:15:03 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so3799563plb.10
        for <linux-security-module@vger.kernel.org>; Tue, 20 Nov 2018 21:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H7SVWUWEH3G5yFZ60uHnnDvQFhsmSlrfJaOE2TIQWG0=;
        b=KMa2MjBg9GrL5+BFBxgl+ACtB+ElrwWs+VaWd/9nWL8RXUjwGZi/RietvUCOZW6xiZ
         r4kmCtSiWofkG9CnIESUoMK+2A4MvUsaQmmxclimj0mKwNNFmiiPBpoMbaKT7tSICND5
         gvuLGsAduSo9STl+vTclmBh6ihX5Ih3tc45lIpRCenomyZYVhUXK0iDF6xpfQqVCQ7xQ
         cwlJl9uOrf63er/xAvyQ7t6BOGMkpuSOsefgEcIdq/PwRg5JMV2tHd1YD8BEZbcoPFdM
         lieWW4OFFAEbLtPmfswddA7oWv7qGwJervW/0DROSCFPIlSL8armA1HQPC5jz49aoxs/
         Hn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H7SVWUWEH3G5yFZ60uHnnDvQFhsmSlrfJaOE2TIQWG0=;
        b=cEZxWiSKKPUEY81J7R4rkcSCjnVO3LjJcMG5asOJWVdydAgSBkPnm/3gdxcekBRiE+
         gkmCBfZoitqmIk582gyYZWH4ex4mxUaI3OYjUgWJsPQzzD8nPXQ9R1lXcqY2kZGxeKZN
         9kMSKLpAgkyDVXV5e+W9ZI7RFyniWtpwUaA6CelhQYH/CALmnBnKWlAwnnJhkcGqHZ1/
         x6BkvrmRkVjYxwiiele4zXYhjhSAyFTzl6eI2zV4599oImJjSFDIW+PB02QJvHyTSw0/
         xhDncA2r9+1wLP6PDURDK2MjQzLPerQXD7LecSjZBRVGpXYSZJSkXS20Km5YQMikdHxt
         i1nQ==
X-Gm-Message-State: AA+aEWa0hCfwB5oyI0ntJpg0AiPZafbTMElNypHXz7pnqWA9R+8SSQQX
        qiGsBydGKB7NTkKf0JrwmN3s+Q==
X-Google-Smtp-Source: AFSGD/WaQ/VttaZSgwTP0v2TwlqISCZxrXNhTpdpD9Bx0rfBNvAOEvuvPMTnlvZYKz8nEMMQOCxbuA==
X-Received: by 2002:a63:5c41:: with SMTP id n1mr4531001pgm.1.1542778923670;
        Tue, 20 Nov 2018 21:42:03 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id g123-v6sm69125458pfc.155.2018.11.20.21.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 21:42:02 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gPLGz-0004jP-EC; Tue, 20 Nov 2018 22:42:01 -0700
Date:   Tue, 20 Nov 2018 22:42:01 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, monty.wiseman@ge.com,
        Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of bus
 interposer attacks
Message-ID: <20181121054201.GB17002@ziepe.ca>
References: <1542648844.2910.9.camel@HansenPartnership.com>
 <20181120111049.GC14594@linux.intel.com>
 <20181120124116.GA8813@linux.intel.com>
 <1542734743.2814.31.camel@HansenPartnership.com>
 <20181120231320.GI8391@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120231320.GI8391@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 21, 2018 at 01:13:20AM +0200, Jarkko Sakkinen wrote:
> On Tue, Nov 20, 2018 at 09:25:43AM -0800, James Bottomley wrote:
> > On Tue, 2018-11-20 at 14:41 +0200, Jarkko Sakkinen wrote:
> > > On Tue, Nov 20, 2018 at 01:10:49PM +0200, Jarkko Sakkinen wrote:
> > > > This is basically rewrite of TPM genie paper with extras. Maybe
> > > > just shorten it to include the proposed architecture and point to
> > > > the TPM Genie paper (which is not in the references at all ATM).
> > > > 
> > > > The way I see it the data validation is way more important than
> > > > protecting against physical interposer to be frank.
> > > > 
> > > > The attack scenario would require to open the damn device. For
> > > > laptop that would leave physical marks (i.e. evil maid). In a data
> > > > center with armed guards I would wish you good luck accomplishing
> > > > it. It is not anything like sticking a USB stick and run.
> > > > 
> > > > We can take a fix into Linux with a clean implementation but it
> > > > needs to be an opt-in feature because not all users will want to
> > > > use it.
> > > 
> > > Someone (might have been either Mimi or David Howells but cannot
> > > recall) correctly pointed out at LSS 2018 that you could just as
> > > easily spy and corrupt RAM if you have a time window to perform this
> > > type of attack.
> > 
> > Not using the simple plug in on the TPM bus, you can't.  The point is
> > basically the difference in the technology: the interposer is a simple,
> > easy to construct, plugin; a RAM spy is a huge JTAG thing that would be
> > hard even to fit into a modern thin laptop, let alone extremely
> > difficult to build.
> 
> Why you wouldn't use DMA to spy the RAM?

The platform has to use IOMMU to prevent improper DMA access from
places like PCI-E slots if you are using measured boot and want to
defend against HW tampering.

The BIOS has to sequence things so that at least pluggable PCI-E slots
cannot do DMA until the IOMMU is enabled.

Honestly not sure if we do this all correctly in Linux, or if BIOS
vendors even implemented this level of protection. The BIOS would have
to leave the PCI-E root port slots disabled, and configure the ports
to reject config TLPs from the hostile PCI-E device, and probably a
big bunch of other stuff.. Then Linux would have to enable the IOMMU
and then enable the PCI-E ports for operation.

Pretty subtle and tricky stuff.

Without IOMMU it would be trivial to plug a card in an open PCI-E slot
(or M.2 slot on a laptop) and breach all measured boot guarantees via
DMA. For instance, if IOMMU is not enabled during grub then I could
overwrite the trusted grub with DMA and cleverly make it jump to my
hostile code, then I can replay PCR extends to the TPM and
seal/unseal/attest using the PCRs set to a trusted sytem when running
hostile code. Oopsie.

This is a much easier attack than inserting a TPM interposer or
messing with the TPM reset line...

But again, measured boot does not protect against HW tampering, so
this is probably not included in the threat model the BIOS uses...

Jason
