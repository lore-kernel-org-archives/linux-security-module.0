Return-Path: <SRS0=2Rj0=N7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1041C04EBA
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 03:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF4820870
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 03:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NjYoLH36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF4820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbeKTNcx (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Nov 2018 08:32:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38075 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbeKTNcx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Nov 2018 08:32:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so234812pgc.5
        for <linux-security-module@vger.kernel.org>; Mon, 19 Nov 2018 19:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zAQSluj1LNS3RqNFhmyQt214e3JGfMk7B1IzjwWm7vI=;
        b=NjYoLH36JubPR2mYvQ0ONtTdVP55JHb4Gs75phBdtDUL2QPYLlBuGipk4WZQa7zNdF
         H7hs9CFWSSE6fJNWm/UTyEfNSngmTfSiPiXdQok8i5QsbOZHID1I0BFfxfw1TWp/rz2e
         6fchL9BERHTpcTmgD19+slGFO7jUdd9uxX70/5J3ld/7zVvCscmqDmQAFNmH7AoqtCot
         XgwEqgUE2HLkGI4he7uJMKlTaKfTGUtjqvNlzWvRa/FI9LEIh9ZMko3ba4FDVg8qk9r+
         NyplyKRItEXNpMubHPkJce7yhO5hM8e8QoX0ewJA53lomTNuYvp0MNYxIdVDeXULFC1u
         UdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zAQSluj1LNS3RqNFhmyQt214e3JGfMk7B1IzjwWm7vI=;
        b=tsLYQRI7S2WXOvEUjC3z0NU3mJs4mm3M8n0wnlZTK1YtHvnmD7QBV3T1/VGG8JYWDw
         yOyqGxdlCHyuxzRXsyT0pgvVguBDvL3kdeBKMrdUfiUzLxBsKpkcr8TErH2EA+remHIE
         3pLLq2S01YV1BHqCE5QRxiUzWH4SCwTAffgB9tAq589DLgFIQPT3EcCoF1gm+4H3mwSj
         gy3G9HBIkf9b8MQaJML+q6FP5DdLYEEap0jtqKXEBWqswgu1S0BnUtW+mqvMeSTtophL
         DppovdJJkWc69WkhaZ5Z+6vTZAIGrmmPTEapy8SBH92HTi+DZvCI0PJPB3tWpvTGnfOp
         n/zQ==
X-Gm-Message-State: AGRZ1gJF83W3sCzRsA/SUPVkXz6CIpk4g5n1wO0p43MlIVWxvlplJn6j
        ddq8u9AND5tUDUS1t3tqVgR3WQ==
X-Google-Smtp-Source: AJdET5de6ak6nzEnVXKswflTTRDRyrixXeR/SNbB0WAYEXdMtkmqw5MMfyLN0bcJ4QRMAR+2GjnhtQ==
X-Received: by 2002:a62:3c6:: with SMTP id 189-v6mr333586pfd.19.1542683158826;
        Mon, 19 Nov 2018 19:05:58 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id p11sm37596853pgn.60.2018.11.19.19.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 19:05:58 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gOwMO-0001bP-Up; Mon, 19 Nov 2018 20:05:56 -0700
Date:   Mon, 19 Nov 2018 20:05:56 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        monty.wiseman@ge.com, Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of bus
 interposer attacks
Message-ID: <20181120030556.GP4890@ziepe.ca>
References: <1542648844.2910.9.camel@HansenPartnership.com>
 <20181119200505.GF4890@ziepe.ca>
 <1542658839.2910.32.camel@HansenPartnership.com>
 <20181119211911.GH4890@ziepe.ca>
 <1542663281.2910.44.camel@HansenPartnership.com>
 <20181119214426.GK4890@ziepe.ca>
 <1542666988.2910.49.camel@HansenPartnership.com>
 <20181119230826.GN4890@ziepe.ca>
 <1542675272.2910.63.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542675272.2910.63.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 19, 2018 at 04:54:32PM -0800, James Bottomley wrote:
> On Mon, 2018-11-19 at 16:08 -0700, Jason Gunthorpe wrote:
> > On Mon, Nov 19, 2018 at 02:36:28PM -0800, James Bottomley wrote:
> > > On Mon, 2018-11-19 at 14:44 -0700, Jason Gunthorpe wrote:
> > > > On Mon, Nov 19, 2018 at 01:34:41PM -0800, James Bottomley wrote:
> > > > > On Mon, 2018-11-19 at 14:19 -0700, Jason Gunthorpe wrote:
> > > > > [...]
> > > > > > Sure, for stuff working with shared secrets, etc, this make
> > > > > > sense. But PCR extends are not secret, so there is no reason
> > > > > > to
> > > > > > encrypt them on the bus.
> > > > > 
> > > > > OK, there's a miscommunication here.  I believe the current
> > > > > document states twice that there's no encryption for PCR
> > > > > operations.  We merely use a salted HMAC session to ensure that
> > > > > they're reliably received by the TPM and not altered in-flight.
> > > > 
> > > > Sure, but again, what is this preventing?
> > > 
> > > It prevents the interposer having free reign to set the PCR values
> > > by substituting every measurement you send to the TPM.  
> > 
> > But the threat model for PCR excludes the possibility of an
> > interposer. If you have an interposer the PCB is broken and all PCR
> > security is already lost.
> 
> Yours might, mine doesn't and I think I can mitigate the we can give
> you approved PCRs attack ... I can't prevent the we muck with your PCRs
> attack.

It is not 'mine' or 'your' threat model. These trade offs are baked
into the TPM protocol design itself.

I guess I haven't really heard you explain what your threat model
is.

I would think if an interposer can muck with the PCRs then the main
attack would be to cause the CPU to run code that does not match the
PCRs while tricking the TPM into thinking the PCR matches.

This would let an attack unseal, say, a disk encryption secret while
running a hostile version of Linux. A big failure of the fundamental
PCR guarentee.

So any point along the PCR trust chain that does not do secure PCR
updates is a failure point. Since the BIOS doesn't do it, one would
probably start by replacing the bootloader and kernel in conjunction
with the interposer?

The incremental gain from having the kernel do this seems negligible
to me.

I think to properly address this threat work needs to be done in the
TPM spec to establish a secure TPM communication channel at power on..

> > > some scope for detecting the presence of an interposer if it does
> > > try to tamper with your measurements.
> > 
> > But I can still tamper with them.. I can have the interposer
> > delete/fail the kernel PCR commands and issue un-hashed ones.
> 
> You can't because you don't have the HMAC key to fake the response, so
> as long as I check the HMAC return I know you've tampered.

.. and you stop using the TPM after this. Otherwise the interposer can
fail the command, issue an extend with the right data, and cause the
PCRs to match trusted data while running actually untrusted code.

> > The kernel would have to do something extreme like fault the TPM and
> > totally disable the linux device if any PCR extend fails. That should
> > probably be included in the plan?
> 
> If we detect an interposer (if one of the HMACs or encrypt/decrypt
> fails) it depends on policy what you do.  We certainly log a message
> saying TPM integrity is compromised.  I think we should also disable
> the TPM, but I haven't done that yet because I thought it would bear
> more discussion.

Logging doesn't seem useful - if a HW interposer is present then
someone is already in control of the HW and will happily ignore
warnings ...

Jason
