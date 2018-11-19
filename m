Return-Path: <SRS0=iPov=N6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34A9C43610
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Nov 2018 23:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A9420823
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Nov 2018 23:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BADYtdrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A9420823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbeKTJe2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:34:28 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39035 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731651AbeKTJe2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Nov 2018 04:34:28 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5-v6so15293833pla.6
        for <linux-security-module@vger.kernel.org>; Mon, 19 Nov 2018 15:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n9NwBzT3yKC230Y5/NO41+bZNMQ1Dr5/lSY4GJPduIo=;
        b=BADYtdrFKgHosKuh7ApBlx/LDRom9831LYNh4BFd6Z29rdE8y4+hEMcgckPyxgGr+8
         dV3ZzUNPdQGT4MO7AN+CBB5VJQFsIdFBBiYzHJ0lqZ4+zRYUx63iBHumNZO7WbWo1i1k
         1PuWCrJn4mEC7bmIRPxpmhgNhNoICxbybPX4SrR6ApbKTXP8IKZF24U2prbWS4RPlWC9
         HiEeLbat+xka4BfE7o8bU/gB0CZhcZCknwe7SbRYricL1jABbuFv0XeGMGKfbMIbFN4r
         84MN298wERJfuswbVm6hNUTODqXR6sSnhyCUgCU1QX5zoGIl/qpzb8Tc/CyYCYGe9/jH
         KHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n9NwBzT3yKC230Y5/NO41+bZNMQ1Dr5/lSY4GJPduIo=;
        b=iJJa98sJn+vtiwnMbyiSi+qK+M4vrek2sjR7t0/N3B+Pi878+L7Hoc/bFR04j1XNWI
         ZEWJx0/uKnOSZIrOXUJ28ItPJrM0CdT93p8oYDc10gC64WlIxpf8aC5OhU8kdI0vSM89
         lCKGgYfz7ccm4OuWZO6Dz30xQN8myYYm1iQUemWR8C7fIjqMPcb7Nz1btpP7UlNyLGug
         VjhMtq8+vGWsEjLg12JDyw+RIGQAdEN1i9iqrhf3ZogvNpEyXLnrS/E32YhtXpxH7/5E
         m60SJaQn2mPle90HskpAe2WPtsC9udyneM6rb80QM1Y5kd2ojghiKpLVICcjOq9OD/SY
         BJsQ==
X-Gm-Message-State: AGRZ1gIRytLVC7t4Ez2fLcXUagMVbrKzxLsTDgUwLyCQ2ZDAa7Bdv43m
        XMV/tjty9M+vNf4BcQskQuc1yw==
X-Google-Smtp-Source: AJdET5doEfeJed63GvvkHgsUDlvMqAjqXs4UBsnQTXFFpPEXLs0We5Ncxi/F3YYWCMw1II9CQYKYRQ==
X-Received: by 2002:a17:902:6b46:: with SMTP id g6mr16721791plt.21.1542668908894;
        Mon, 19 Nov 2018 15:08:28 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id r12sm36661738pgv.83.2018.11.19.15.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 15:08:28 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gOseY-0008OP-VH; Mon, 19 Nov 2018 16:08:26 -0700
Date:   Mon, 19 Nov 2018 16:08:26 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        monty.wiseman@ge.com, Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of bus
 interposer attacks
Message-ID: <20181119230826.GN4890@ziepe.ca>
References: <1542648844.2910.9.camel@HansenPartnership.com>
 <20181119200505.GF4890@ziepe.ca>
 <1542658839.2910.32.camel@HansenPartnership.com>
 <20181119211911.GH4890@ziepe.ca>
 <1542663281.2910.44.camel@HansenPartnership.com>
 <20181119214426.GK4890@ziepe.ca>
 <1542666988.2910.49.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542666988.2910.49.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 19, 2018 at 02:36:28PM -0800, James Bottomley wrote:
> On Mon, 2018-11-19 at 14:44 -0700, Jason Gunthorpe wrote:
> > On Mon, Nov 19, 2018 at 01:34:41PM -0800, James Bottomley wrote:
> > > On Mon, 2018-11-19 at 14:19 -0700, Jason Gunthorpe wrote:
> > > [...]
> > > > Sure, for stuff working with shared secrets, etc, this make
> > > > sense. But PCR extends are not secret, so there is no reason to
> > > > encrypt them on the bus.
> > > 
> > > OK, there's a miscommunication here.  I believe the current
> > > document states twice that there's no encryption for PCR
> > > operations.  We merely use a salted HMAC session to ensure that
> > > they're reliably received by the TPM and not altered in-flight.
> > 
> > Sure, but again, what is this preventing?
> 
> It prevents the interposer having free reign to set the PCR values by
> substituting every measurement you send to the TPM.  

But the threat model for PCR excludes the possibility of an
interposer. If you have an interposer the PCB is broken and all PCR
security is already lost.

> some scope for detecting the presence of an interposer if it does try
> to tamper with your measurements.

But I can still tamper with them.. I can have the interposer
delete/fail the kernel PCR commands and issue un-hashed ones.

The kernel would have to do something extreme like fault the TPM and
totally disable the linux device if any PCR extend fails. That should
probably be included in the plan?

> tamper, like there is for confidentiality of sealed data and random
> numbers, but it seems to be an improvement on what's currently there
> given that we have to install the session machinery for
> encryption/decryption anyway.

Sure, if you have the machinery and it can be used at PCR time, then
why not use it.. But I think any description about why this is being
done should be clear about what the threat model is for PCR. 

I'm mostly concerned about how the document was written which makes it
seems like security of extend beyond what is integral to the
PCB/chipset is meaningful, considering the threat model PCR is based
on.

We don't want people to become confused and think they are getting
more security than there really is.

> > If you accept that PCB trust is essential for PCR security, then I
> > think trusting the PCB to deliver the PCR extends is perfectly fine.
> 
> The *current* interposer is a hardware device on the bus.  The next gen
> is reported to be more software based.

Well, that is terrifying.

But a SW based attack that can toggle TPM reset or alter TPM commands
in flight getting very much into the 'chips are broken' territory
where the chain of trust required for PCR is broken. This is breaking
fundamental assumptions of the threat model here :(

It is hard to know if more crypto could really prevent problems
without knowing the details of how this is being done??

Jason
