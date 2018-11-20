Return-Path: <SRS0=2Rj0=N7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DF3C43610
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 23:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6F32147A
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 23:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="e9UlUVZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6F32147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbeKUKKw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:10:52 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35929 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeKUKKv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Nov 2018 05:10:51 -0500
Received: by mail-pl1-f195.google.com with SMTP id y6-v6so2590904plt.3
        for <linux-security-module@vger.kernel.org>; Tue, 20 Nov 2018 15:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JoJDF4Jve8GOIQJZW7DaShOnnQbEYSLbl7K9ZWZew7Q=;
        b=e9UlUVZ19QFserdXADsLheyDWNH2BTJchMpE1i9bRlMgorbF3Lp24U8TxOy00FGi6g
         3zeRxC6jaiaBl8pBvm4ne9NDCu+UV4O6HZe7udwGDClu8bRluJ13G2D0393VZTsWKu+5
         ByUa5DXDsK5pKvBOu8o/x7b45ILZJr5a75iIrXaNrSFlhGqqLzVSduw9Je/HGRiUC+Gs
         JefFWpkTKr7ejUOP7JpI7+YFxlTVcRvVDrs53iuQnTIMKuPaqorAPB384quBjyzXtPKm
         7Bo2vWSPZZaeCQ/BL4DmPUxw2CS+nIxrir1TNlvJ6CM8ESwixcazIR7mt4yk686+m8pV
         n9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JoJDF4Jve8GOIQJZW7DaShOnnQbEYSLbl7K9ZWZew7Q=;
        b=X58b86Omj+igNj75EHriCaDBmEevQWs/XvuBjQkM6T1esKjFUWdWYNukKZ6mN+F5GU
         Vb4FT4Dc3huyKvO5jtzUzWKXQMymwAa7Z1KveoFzCdmJ9DA8mUmdJ4WY7fcSQGvBiYoq
         myub5N7SSL8k8qIr2eETurvkwVfnD4w8YmnAEUyjIGXJOnwVOaOPnjPavy9LrhSPioQP
         U8TaRNgzZeGu0BxW0QylK4PVw0mhkZ4EpLOxyG2RpENXKGXxbcoDtKCTiDOGHvFYRqmX
         AnKZePfvjfj3ssifz9sSc5Iy6DUv8oj1fUFFKD+2J4WOLbl74PIRwKAllOy+Q9L3biZD
         hJQg==
X-Gm-Message-State: AA+aEWYBg/Q4lyd5OjNgUFe1BtC/VhpRyG/7q5w01UYZItgNbal6E9/D
        2imCIfEekceCgd6xnESoQ+N9nw==
X-Google-Smtp-Source: AFSGD/XNTiyBOKHy3zBme3Bu6RxMY5QNgunENzkMNb7q/0bHV4TErvP5t/hk3jXt2k98y0teCvjTtw==
X-Received: by 2002:a17:902:20c6:: with SMTP id v6mr3793495plg.156.1542757146850;
        Tue, 20 Nov 2018 15:39:06 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id y26-v6sm2990362pfi.123.2018.11.20.15.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 15:39:05 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gPFbk-0003Ir-R6; Tue, 20 Nov 2018 16:39:04 -0700
Date:   Tue, 20 Nov 2018 16:39:04 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        monty.wiseman@ge.com, Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of bus
 interposer attacks
Message-ID: <20181120233904.GF22023@ziepe.ca>
References: <20181119211911.GH4890@ziepe.ca>
 <1542663281.2910.44.camel@HansenPartnership.com>
 <20181119214426.GK4890@ziepe.ca>
 <1542666988.2910.49.camel@HansenPartnership.com>
 <20181119230826.GN4890@ziepe.ca>
 <1542675272.2910.63.camel@HansenPartnership.com>
 <20181120030556.GP4890@ziepe.ca>
 <1542734279.2814.23.camel@HansenPartnership.com>
 <20181120213345.GC22023@ziepe.ca>
 <1542753292.2814.45.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542753292.2814.45.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 20, 2018 at 02:34:52PM -0800, James Bottomley wrote:

> https://trustedcomputinggroup.org/resource/implementing-hardware-roots-of-trust/

Notice none of their examples include 'prevent tampering with the
hardware' all are focused on pure software attacks, which the TPM is
excellent at preventing. The TPM was never supposed to prevent
physical attacks against the HW for the PCR feature.

The only HW guarentee it ever provided is to prevent theft of the
private secrets, even with physical access.

> > It doesn't need contact with the CPU. The basic flow would be to use
> > the interposer on SPI or LPC to block the Nth PCR update, having
> > determined that Nth comes from the BIOS and covers the
> > bootloader.. The BIOS ignores the error, or can't tell the PCR update
> > was corrupted. From there it is easy to see how to get into a hostile
> > kernel and extend the PCRs to match a trusted kernel.
> 
> Right, but that's why I want to detect the error and shut down the TPM.

Well, I think this is a lot of industry effort and still leaves open
other fairly simple physical attacks, like wire-to-the-reset.

I can always make an interposer that did wire-to-the-reset, I don't
need to do complicated dynamic things with PCR extend commands.

And the null key doesn't really protect against wire-to-the-reset, as
the null key doesn't participate in the PCR extend. So
unseal/seal/attest commands don't know if the TPM was booted
authentically or via a wire-to-the-reset and a hostile kernel.

Yes, it lets a trusted kernel detect a problem, but a threat model
that includes an interposer and excludes a hostile kernel doesn't
sound so interesting to me???

Like I said at the start, the way the spec is written, PCR requires
trusted HW. Without a TPM spec change we can't fix this basic
assumption.

A better mitigation to the interposer threat is for PCB manufactures
to use BGA packages, blind vias and internal traces to physically deny
easy access to the TPM bus and reset signal.

The last TPM project I worked on took physical security into account
when designing the PCB and TPM chip placement, others should do the
same :)

Jason
