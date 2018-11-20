Return-Path: <SRS0=2Rj0=N7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0177C5ACBA
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 22:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9A62147D
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 22:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="XTK6mVDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9A62147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeKUJGU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Nov 2018 04:06:20 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44488 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725960AbeKUJGU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Nov 2018 04:06:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9EB328EE2C9;
        Tue, 20 Nov 2018 14:34:53 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ft2PKOFo6ufd; Tue, 20 Nov 2018 14:34:53 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 131CF8EE0E2;
        Tue, 20 Nov 2018 14:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1542753293;
        bh=CV4oSLWVLLwffgEV59Vb83lr1xWPrS9Wa9xCKmvD6jM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XTK6mVDbZ0OBvZfw+m+2ed4aHiCoc02jXhxL1L4wrV0bbuosx/LseQ1XGfgTggh45
         9JwsOZi+N8W68N4U1/i3gEeGtM4N/AJTtsXWp5/KRZwa2fgs9XMCDj5PIB64A4Jkyi
         /1xjFiIrE7fSMGorViY+XRkulNEQ55vdPzVyBRiU=
Message-ID: <1542753292.2814.45.camel@HansenPartnership.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of
 bus interposer attacks
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        monty.wiseman@ge.com, Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Tue, 20 Nov 2018 14:34:52 -0800
In-Reply-To: <20181120213345.GC22023@ziepe.ca>
References: <20181119200505.GF4890@ziepe.ca>
         <1542658839.2910.32.camel@HansenPartnership.com>
         <20181119211911.GH4890@ziepe.ca>
         <1542663281.2910.44.camel@HansenPartnership.com>
         <20181119214426.GK4890@ziepe.ca>
         <1542666988.2910.49.camel@HansenPartnership.com>
         <20181119230826.GN4890@ziepe.ca>
         <1542675272.2910.63.camel@HansenPartnership.com>
         <20181120030556.GP4890@ziepe.ca>
         <1542734279.2814.23.camel@HansenPartnership.com>
         <20181120213345.GC22023@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 2018-11-20 at 14:33 -0700, Jason Gunthorpe wrote:
> On Tue, Nov 20, 2018 at 09:17:59AM -0800, James Bottomley wrote:
> 
> > > > Yours might, mine doesn't and I think I can mitigate the we can
> > > > give you approved PCRs attack ... I can't prevent the we muck
> > > > with your PCRs attack.
> > > 
> > > It is not 'mine' or 'your' threat model. These trade offs are
> > > baked into the TPM protocol design itself.
> > > 
> > > I guess I haven't really heard you explain what your threat model
> > > is.
> > 
> > OK, the TPM is supposed to provide attestation of the correct
> > environment on a device under someone else's control (the classic
> > example is laptop provided by a company to an employee).  The
> > device is under the physical control of the entity you don't
> > entirely trust so the TPM is supposed to attest that they're
> > running an approved OS ... we have whole TCG specs for that
> > situation.
> 
> Well.. Attestation started out as a way to prove things about
> hardware you physically control - ie data center servers. That they
> haven't been manipulated.
> 
> I'm not surprised people want to use this on the client, but in this
> case you really have to trust the employee to not disassemble the
> laptop...
> 
> The idea that it could extend to HW you don't control is, frankly, a
> bit of wishful thinking. The system is strong enough to defend
> against casual abuse, but a determined and funded adversary has,
> many, many, options to create a situation where the TPM attests the
> system is running software that it actually isn't.

I don't disagree, but this is their site not mine:

https://trustedcomputinggroup.org/resource/implementing-hardware-roots-of-trust/

and the industry expects us at least to make an effort to support them
in using it.  I fully agree it's nowhere near foolproof.  However, I
think the plan proposed is a reasonable course of action against
interposers ... it's certainly better than doing nothing.

> The scary thing about the interposer is how inexpensive and simple it
> is, many other attacks require considerable determination and
> funding.

Yes, that's my exact point: a nation state can definitely overcome a
TPM in a system they possess.  Previously it wasn't thought possible
with $10 of hardware, a screwdriver and about 5 minutes of access,
which has tipped the tables somewhat.

> > > I would think if an interposer can muck with the PCRs then the
> > > main attack would be to cause the CPU to run code that does not
> > > match the PCRs while tricking the TPM into thinking the PCR
> > > matches.
> > 
> > The interposer sits on the serial bus ... it has no contact with
> > the CPU.  That's the point about it, it's a simple to attach easy
> > to construct device because the TPM bus (LPC, i2c, spi etc) is easy
> > to interface to.  getting a device which can man in the middle the
> > main CPU address bus, say, is at least an order of magnitude more
> > difficult.
> 
> It doesn't need contact with the CPU. The basic flow would be to use
> the interposer on SPI or LPC to block the Nth PCR update, having
> determined that Nth comes from the BIOS and covers the
> bootloader.. The BIOS ignores the error, or can't tell the PCR update
> was corrupted. From there it is easy to see how to get into a hostile
> kernel and extend the PCRs to match a trusted kernel.

Right, but that's why I want to detect the error and shut down the TPM.

> But even this convoluted attack is kind of silly. If I can touch the
> TPM physically then just boot into my hostile kernel and *trigger TPM
> reset*. Then I can simply issue reset and then extends from the
> hostile kernel to mimic a trusted system. Easy! One wire and a
> microscope will do the job!
> 
> So it really is essential that all steps, including the BIOS use
> secure PCR updates, or you may as well not bother in Linux, at least
> for security reasons.

Absolutely agreed on this point: the next step, in fact, is to
circulate the document to Microsoft and the UEFI people to see if they
want to use it as part of their defence against this.  Ideally if we
all agree on the null seed proposal, we can add passing the name
through the boot interfaces for standardisation.

> And I think you were on the right track, the TPM should have a
> per-boot authorization that flows through all layers of the TPM stack
> and guarantees the TPM hasn't been rebooted and with crypto prevents
> lost PCR updates. 
> 
> But that does require standardization, as we do need the BIOS to
> participate.

Right, that's why I'll be trying to get that consensus.  Us agreeing
among ourselves is just the first step, the second, and much harder is
getting the other consumer (Microsoft) and the BIOS (UEFI/Tianocore
because they're a single entity) communities to follow.

> Though keep in mind, tt doesn't prevent physical access from
> manipulating the PCRs, it just makes it more expensive than one wire
> and a microscope. Maybe it now involves de-soldering, etc.

Sure ... but at least we're moving back to only well funded entities
and nation states, not just the average hacker in the street ...

James

