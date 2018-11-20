Return-Path: <SRS0=2Rj0=N7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77CFC46463
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 17:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B299208E3
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 17:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="N9RveaRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B299208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbeKUDsN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:48:13 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:40072 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727085AbeKUDsN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Nov 2018 22:48:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BE5BA8EE2C9;
        Tue, 20 Nov 2018 09:18:00 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r9NZRm4T5UhM; Tue, 20 Nov 2018 09:18:00 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 27C8B8EE0E2;
        Tue, 20 Nov 2018 09:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1542734280;
        bh=JYKM3XlJqSl0C9Lzs07AhVJRdim36VUbzN14RwVkMlI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=N9RveaRE/zn0SyNLNWanZ0I8F192ou1eGsbWFY8x8UOY88YaZ86esBC0xZmYNGhs+
         O8yaq0aYT5hX1XPgg9056gaKa9GSsKaQZJTWxyTSHO/pfVWADo8wVsuyGbbDuUCkVm
         F+ixcd3826TgtLZL+DAiIvcGV8ty5Gn495llKytI=
Message-ID: <1542734279.2814.23.camel@HansenPartnership.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of
 bus interposer attacks
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        monty.wiseman@ge.com, Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Tue, 20 Nov 2018 09:17:59 -0800
In-Reply-To: <20181120030556.GP4890@ziepe.ca>
References: <1542648844.2910.9.camel@HansenPartnership.com>
         <20181119200505.GF4890@ziepe.ca>
         <1542658839.2910.32.camel@HansenPartnership.com>
         <20181119211911.GH4890@ziepe.ca>
         <1542663281.2910.44.camel@HansenPartnership.com>
         <20181119214426.GK4890@ziepe.ca>
         <1542666988.2910.49.camel@HansenPartnership.com>
         <20181119230826.GN4890@ziepe.ca>
         <1542675272.2910.63.camel@HansenPartnership.com>
         <20181120030556.GP4890@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 2018-11-19 at 20:05 -0700, Jason Gunthorpe wrote:
> On Mon, Nov 19, 2018 at 04:54:32PM -0800, James Bottomley wrote:
> > On Mon, 2018-11-19 at 16:08 -0700, Jason Gunthorpe wrote:
> > > On Mon, Nov 19, 2018 at 02:36:28PM -0800, James Bottomley wrote:
> > > > On Mon, 2018-11-19 at 14:44 -0700, Jason Gunthorpe wrote:
> > > > > On Mon, Nov 19, 2018 at 01:34:41PM -0800, James Bottomley
> > > > > wrote:
> > > > > > On Mon, 2018-11-19 at 14:19 -0700, Jason Gunthorpe wrote:
> > > > > > [...]
> > > > > > > Sure, for stuff working with shared secrets, etc, this
> > > > > > > make sense. But PCR extends are not secret, so there is
> > > > > > > no reason to encrypt them on the bus.
> > > > > > 
> > > > > > OK, there's a miscommunication here.  I believe the current
> > > > > > document states twice that there's no encryption for PCR
> > > > > > operations.  We merely use a salted HMAC session to ensure
> > > > > > that they're reliably received by the TPM and not altered
> > > > > > in-flight.
> > > > > 
> > > > > Sure, but again, what is this preventing?
> > > > 
> > > > It prevents the interposer having free reign to set the PCR
> > > > values by substituting every measurement you send to the TPM.  
> > > 
> > > But the threat model for PCR excludes the possibility of an
> > > interposer. If you have an interposer the PCB is broken and all
> > > PCR security is already lost.
> > 
> > Yours might, mine doesn't and I think I can mitigate the we can
> > give you approved PCRs attack ... I can't prevent the we muck with
> > your PCRs attack.
> 
> It is not 'mine' or 'your' threat model. These trade offs are baked
> into the TPM protocol design itself.
> 
> I guess I haven't really heard you explain what your threat model
> is.

OK, the TPM is supposed to provide attestation of the correct
environment on a device under someone else's control (the classic
example is laptop provided by a company to an employee).  The device is
under the physical control of the entity you don't entirely trust so
the TPM is supposed to attest that they're running an approved OS ...
we have whole TCG specs for that situation.

You seem to be saying it's not viable to expect the TPM to function in
the above environment and I'm saying I think it is but we may have to
adjust our definition of "function".

This is the situation where I want to get confirmation that PCR
measurements went to the TPM and detach it if they don't.

request/response encryption is probably most useful in the case of self
owned devices that may have suffered third party interference with a
view to stealing secrets (think foreign government finds your powered
off laptop in your hotel room), the so called "evil maid" attack.

Personally, since I own my own laptop, I care about the latter, but I
think, since we have infrastructures relying on it that we, as
responsible kernel developers, have to care about the former as well.

> I would think if an interposer can muck with the PCRs then the main
> attack would be to cause the CPU to run code that does not match the
> PCRs while tricking the TPM into thinking the PCR matches.

The interposer sits on the serial bus ... it has no contact with the
CPU.  That's the point about it, it's a simple to attach easy to
construct device because the TPM bus (LPC, i2c, spi etc) is easy to
interface to.  getting a device which can man in the middle the main
CPU address bus, say, is at least an order of magnitude more difficult.

The point about interposers is that they address the technology gap. 
Sure it was possible to use a Focussed Ion Beam to extract secrets from
a decapped TPM like the black hat guys did but that's just impractical
for the average user as is the JTAG technology that would allow you to
interface with the main CPU bus.  An interposer is a very practical and
easy to install device.

James


> This would let an attack unseal, say, a disk encryption secret while
> running a hostile version of Linux. A big failure of the fundamental
> PCR guarentee.
> 
> So any point along the PCR trust chain that does not do secure PCR
> updates is a failure point. Since the BIOS doesn't do it, one would
> probably start by replacing the bootloader and kernel in conjunction
> with the interposer?
> 
> The incremental gain from having the kernel do this seems negligible
> to me.
> 
> I think to properly address this threat work needs to be done in the
> TPM spec to establish a secure TPM communication channel at power
> on..
> 
> > > > some scope for detecting the presence of an interposer if it
> > > > does
> > > > try to tamper with your measurements.
> > > 
> > > But I can still tamper with them.. I can have the interposer
> > > delete/fail the kernel PCR commands and issue un-hashed ones.
> > 
> > You can't because you don't have the HMAC key to fake the response,
> > so
> > as long as I check the HMAC return I know you've tampered.
> 
> .. and you stop using the TPM after this. Otherwise the interposer
> can
> fail the command, issue an extend with the right data, and cause the
> PCRs to match trusted data while running actually untrusted code.
> 
> > > The kernel would have to do something extreme like fault the TPM
> > > and
> > > totally disable the linux device if any PCR extend fails. That
> > > should
> > > probably be included in the plan?
> > 
> > If we detect an interposer (if one of the HMACs or encrypt/decrypt
> > fails) it depends on policy what you do.  We certainly log a
> > message
> > saying TPM integrity is compromised.  I think we should also
> > disable
> > the TPM, but I haven't done that yet because I thought it would
> > bear
> > more discussion.
> 
> Logging doesn't seem useful - if a HW interposer is present then
> someone is already in control of the HW and will happily ignore
> warnings ...
> 
> Jason
> 

