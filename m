Return-Path: <SRS0=iPov=N6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E234C04EBA
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Nov 2018 21:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0578D2086A
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Nov 2018 21:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="QPB0/M/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0578D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbeKTIAS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:00:18 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57174 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725898AbeKTIAS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Nov 2018 03:00:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AEC398EE2C9;
        Mon, 19 Nov 2018 13:34:43 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vstpW1oJ1i9i; Mon, 19 Nov 2018 13:34:43 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1DD218EE0BA;
        Mon, 19 Nov 2018 13:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1542663283;
        bh=yZ26XjzS0WuoDquNSp01dC1RtG2lxy497m/AEpO5B3k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QPB0/M/4Qg1gkbXTZtsNXmosSnYT+MPDpPf2abFj2KZOYcopJhiFMsa5VTYCL+1xR
         HTdHBOIyTZa3uR7jhuuV0lDKjvm2Aw2DDn5vrFDT++efGffIKOWpLd3Rw8X8AbRBe2
         bmHH+yvNBSBCOLRJAEKZJuW4nMg1vNTsFkcY68ww=
Message-ID: <1542663281.2910.44.camel@HansenPartnership.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of
 bus interposer attacks
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        monty.wiseman@ge.com, Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Mon, 19 Nov 2018 13:34:41 -0800
In-Reply-To: <20181119211911.GH4890@ziepe.ca>
References: <1542648844.2910.9.camel@HansenPartnership.com>
         <20181119200505.GF4890@ziepe.ca>
         <1542658839.2910.32.camel@HansenPartnership.com>
         <20181119211911.GH4890@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 2018-11-19 at 14:19 -0700, Jason Gunthorpe wrote:
[...]
> Sure, for stuff working with shared secrets, etc, this make sense.
> But PCR extends are not secret, so there is no reason to encrypt them
> on the bus.

OK, there's a miscommunication here.  I believe the current document
states twice that there's no encryption for PCR operations.  We merely
use a salted HMAC session to ensure that they're reliably received by
the TPM and not altered in-flight.

> And if someone manipulates the unencrypted PCR extend commands then
> we are back to 'the PCB is broken' and all PCR based security has
> been lost.
> 
> > In theory, but we don't seem to have one.  The theory is that TPMs
> > come provisioned according to the TCG guidance which specifies RSA
> > and EC storage keys be at 81000001 and 81000002 respectively ... it
> > just seems that the current TPM generation don't respect this, so
> > they come with no permanent keys at all.
> 
> Seems surprising.. And the use models you have don't alwaus load a
> key that could be used for this?

I think it's because Microsoft realised after the first generation of
TPM 2.0s that not having any key at all was a problem, so lots of them
shipped before the spec got updated and manufacturers are somewhat slow
to retool production lines.  My TPM 2.0 doesn't even have an EC
certificate (although Nuvoton now claims this was a manufacturing
mistake) never mind a derived primary key.

James

