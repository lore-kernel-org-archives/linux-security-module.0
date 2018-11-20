Return-Path: <SRS0=2Rj0=N7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A41C5ACC7
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 21:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C8721479
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 21:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DkAX/Qnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C8721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeKUIFA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:05:00 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:45146 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeKUIFA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Nov 2018 03:05:00 -0500
Received: by mail-pl1-f169.google.com with SMTP id a14so2159107plm.12
        for <linux-security-module@vger.kernel.org>; Tue, 20 Nov 2018 13:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w1isbWz0VyCJtTz0p0auPA2uj/B3E3bTBWjznR4YTzk=;
        b=DkAX/QnmQTI2PXR9U5jyJP042u8qtcNbuHKBDdkrR6rD3UR4Zl87vLnfZnEbTUug3n
         Wen9a+7tcPGm4PKS5sGQ1UbuNM2hFZs0TWCRrxZc4Qtykv/4LioNG/aVIElcEf64zHmQ
         WvBXezlwUcOJVhE5JcEL4pkhZjhiLG1+sG2wKGAmS0YiEsziOpkoyIppwhy49bGkqVuR
         6oyO4hXZS5w42LJ5wZUdV22OdC7LPAI2vXEHLYq6eXkCKvDbeWIqmIRXQ4SVV2i561t0
         gLFfnMrEFzLPI6k6KErOB51kWLMlJ11XQtnJML47QpdgW+KpHKWQOCBuKMjYcbpC9vFY
         R4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w1isbWz0VyCJtTz0p0auPA2uj/B3E3bTBWjznR4YTzk=;
        b=gaBdTUEPwhErELQbFsKKTiyacedQYf724VHEhaZ2haUmE+ZpLP2ccCR+q1aL0pHMxi
         I92cCDd3B3WSGXp6zSZQLV8L8vVqWWoEIa+KJD9kSFovePzzCRfe81Lxv9DFf+mBz9NS
         wwxRNfoBH0UqaA4/Qur/6/S2YGHi6ZIqBOaeoztuiaMSXRFzD5m8PGYrhoZXLLXtMjIn
         tYFgKSmL5nXGmvRFTycHOBq5qOnN95tattUHpw+/bhy3fVKz+V2hGp3+yy1FdF/rfc/W
         IgYA0fFX8u4ria/AzF4Ho3+eTB21bS2L5qvDSzONSaWRmewdCJUVgg7KTwGOqTEPJIa/
         5hhQ==
X-Gm-Message-State: AA+aEWYzKbFHghjOUZIeG3rYxnalwOtZuVc/2rp0276vsEwk0Aw91PoI
        Z1Z8UgqoOYYEi5ikCYqvrsXJI+rpESc=
X-Google-Smtp-Source: AFSGD/VyvB36tsGVCxc31BrnbqB1jKkKWwciGozvkBlyRIUF9EeqJ8X69e2IZ4UnzFPkw/3HXqltUQ==
X-Received: by 2002:a17:902:bd0b:: with SMTP id p11-v6mr3929546pls.35.1542749627212;
        Tue, 20 Nov 2018 13:33:47 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id f64sm94725390pfh.0.2018.11.20.13.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 13:33:46 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gPDeT-0008Si-98; Tue, 20 Nov 2018 14:33:45 -0700
Date:   Tue, 20 Nov 2018 14:33:45 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        monty.wiseman@ge.com, Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of bus
 interposer attacks
Message-ID: <20181120213345.GC22023@ziepe.ca>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542734279.2814.23.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 20, 2018 at 09:17:59AM -0800, James Bottomley wrote:

> > > Yours might, mine doesn't and I think I can mitigate the we can
> > > give you approved PCRs attack ... I can't prevent the we muck with
> > > your PCRs attack.
> > 
> > It is not 'mine' or 'your' threat model. These trade offs are baked
> > into the TPM protocol design itself.
> > 
> > I guess I haven't really heard you explain what your threat model
> > is.
> 
> OK, the TPM is supposed to provide attestation of the correct
> environment on a device under someone else's control (the classic
> example is laptop provided by a company to an employee).  The device is
> under the physical control of the entity you don't entirely trust so
> the TPM is supposed to attest that they're running an approved OS ...
> we have whole TCG specs for that situation.

Well.. Attestation started out as a way to prove things about hardware
you physically control - ie data center servers. That they haven't
been manipulated.

I'm not surprised people want to use this on the client, but in this
case you really have to trust the employee to not disassemble the
laptop...

The idea that it could extend to HW you don't control is, frankly, a
bit of wishful thinking. The system is strong enough to defend against
casual abuse, but a determined and funded adversary has, many, many,
options to create a situation where the TPM attests the system is
running software that it actually isn't.

The scary thing about the interposer is how inexpensive and simple it
is, many other attacks require considerable determination and funding.

> > I would think if an interposer can muck with the PCRs then the main
> > attack would be to cause the CPU to run code that does not match the
> > PCRs while tricking the TPM into thinking the PCR matches.
> 
> The interposer sits on the serial bus ... it has no contact with the
> CPU.  That's the point about it, it's a simple to attach easy to
> construct device because the TPM bus (LPC, i2c, spi etc) is easy to
> interface to.  getting a device which can man in the middle the main
> CPU address bus, say, is at least an order of magnitude more difficult.

It doesn't need contact with the CPU. The basic flow would be to use
the interposer on SPI or LPC to block the Nth PCR update, having
determined that Nth comes from the BIOS and covers the
bootloader.. The BIOS ignores the error, or can't tell the PCR update
was corrupted. From there it is easy to see how to get into a hostile
kernel and extend the PCRs to match a trusted kernel.

But even this convoluted attack is kind of silly. If I can touch the
TPM physically then just boot into my hostile kernel and *trigger TPM
reset*. Then I can simply issue reset and then extends from the
hostile kernel to mimic a trusted system. Easy! One wire and a
microscope will do the job!

So it really is essential that all steps, including the BIOS use
secure PCR updates, or you may as well not bother in Linux, at least
for security reasons.

And I think you were on the right track, the TPM should have a
per-boot authorization that flows through all layers of the TPM stack
and guarantees the TPM hasn't been rebooted and with crypto prevents
lost PCR updates. 

But that does require standardization, as we do need the BIOS to
participate.

Though keep in mind, tt doesn't prevent physical access from
manipulating the PCRs, it just makes it more expensive than one wire
and a microscope. Maybe it now involves de-soldering, etc.

Jason
