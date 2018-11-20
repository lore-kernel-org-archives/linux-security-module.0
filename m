Return-Path: <SRS0=2Rj0=N7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE75C43610
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 00:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603E82089F
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 00:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="qSanhPsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603E82089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbeKTLU6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:20:58 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59686 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725961AbeKTLU6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Nov 2018 06:20:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id F0DD38EE2C9;
        Mon, 19 Nov 2018 16:54:33 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K_IX2Otl1R0G; Mon, 19 Nov 2018 16:54:33 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 61B6A8EE0BA;
        Mon, 19 Nov 2018 16:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1542675273;
        bh=3Nx+t45VWhyU0MoQobQxbni5FepA8KxwYb6lrkWKqxs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qSanhPsIdSpD41I9UH8OoJc2Kjeh4teKEajDnQ27ZQ1dbiIe9OnCnwCRFujq6CiL2
         y/UNaRoY6+RVxIKHfV/+BN1+rgDjEpJrbkDCSlW7p4HivNxvhlfjr9PIyp8SLaZaYZ
         1C5PAQVnE7RYHpZHT3wm8UNQWCZzm6CvRm1S+OU4=
Message-ID: <1542675272.2910.63.camel@HansenPartnership.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of
 bus interposer attacks
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        monty.wiseman@ge.com, Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Mon, 19 Nov 2018 16:54:32 -0800
In-Reply-To: <20181119230826.GN4890@ziepe.ca>
References: <1542648844.2910.9.camel@HansenPartnership.com>
         <20181119200505.GF4890@ziepe.ca>
         <1542658839.2910.32.camel@HansenPartnership.com>
         <20181119211911.GH4890@ziepe.ca>
         <1542663281.2910.44.camel@HansenPartnership.com>
         <20181119214426.GK4890@ziepe.ca>
         <1542666988.2910.49.camel@HansenPartnership.com>
         <20181119230826.GN4890@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 2018-11-19 at 16:08 -0700, Jason Gunthorpe wrote:
> On Mon, Nov 19, 2018 at 02:36:28PM -0800, James Bottomley wrote:
> > On Mon, 2018-11-19 at 14:44 -0700, Jason Gunthorpe wrote:
> > > On Mon, Nov 19, 2018 at 01:34:41PM -0800, James Bottomley wrote:
> > > > On Mon, 2018-11-19 at 14:19 -0700, Jason Gunthorpe wrote:
> > > > [...]
> > > > > Sure, for stuff working with shared secrets, etc, this make
> > > > > sense. But PCR extends are not secret, so there is no reason
> > > > > to
> > > > > encrypt them on the bus.
> > > > 
> > > > OK, there's a miscommunication here.  I believe the current
> > > > document states twice that there's no encryption for PCR
> > > > operations.  We merely use a salted HMAC session to ensure that
> > > > they're reliably received by the TPM and not altered in-flight.
> > > 
> > > Sure, but again, what is this preventing?
> > 
> > It prevents the interposer having free reign to set the PCR values
> > by substituting every measurement you send to the TPM.  
> 
> But the threat model for PCR excludes the possibility of an
> interposer. If you have an interposer the PCB is broken and all PCR
> security is already lost.

Yours might, mine doesn't and I think I can mitigate the we can give
you approved PCRs attack ... I can't prevent the we muck with your PCRs
attack.

> > some scope for detecting the presence of an interposer if it does
> > try to tamper with your measurements.
> 
> But I can still tamper with them.. I can have the interposer
> delete/fail the kernel PCR commands and issue un-hashed ones.

You can't because you don't have the HMAC key to fake the response, so
as long as I check the HMAC return I know you've tampered.

> The kernel would have to do something extreme like fault the TPM and
> totally disable the linux device if any PCR extend fails. That should
> probably be included in the plan?

If we detect an interposer (if one of the HMACs or encrypt/decrypt
fails) it depends on policy what you do.  We certainly log a message saying TPM integrity is compromised.  I think we should also disable the TPM, but I haven't done that yet because I thought it would bear more discussion.

> > tamper, like there is for confidentiality of sealed data and random
> > numbers, but it seems to be an improvement on what's currently
> > there given that we have to install the session machinery for
> > encryption/decryption anyway.
> 
> Sure, if you have the machinery and it can be used at PCR time, then
> why not use it.. But I think any description about why this is being
> done should be clear about what the threat model is for PCR. 

Right, the threat model for me is complete control of the PCRs.  I can
mitigate that by HMACing the request and response and checking the
response HMAC.

> I'm mostly concerned about how the document was written which makes
> it seems like security of extend beyond what is integral to the
> PCB/chipset is meaningful, considering the threat model PCR is based
> on.
> 
> We don't want people to become confused and think they are getting
> more security than there really is.

Agreed.

> > > If you accept that PCB trust is essential for PCR security, then
> > > I think trusting the PCB to deliver the PCR extends is perfectly
> > > fine.
> > 
> > The *current* interposer is a hardware device on the bus.  The next
> > gen is reported to be more software based.
> 
> Well, that is terrifying.
> 
> But a SW based attack that can toggle TPM reset or alter TPM commands
> in flight getting very much into the 'chips are broken' territory
> where the chain of trust required for PCR is broken. This is breaking
> fundamental assumptions of the threat model here :(
> 
> It is hard to know if more crypto could really prevent problems
> without knowing the details of how this is being done??

I think if I can mitigate some of the PCR problems and prevent snooping
for the hardware interposer, it will also go a long way to defeating
the more software one ... of course, not having seen it, this is just a
guess, but it's based on the idea that the software one probably has
the same or more limited access to the bus.

James

