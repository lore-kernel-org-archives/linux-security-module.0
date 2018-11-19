Return-Path: <SRS0=iPov=N6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA87C43610
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Nov 2018 20:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4233C2086A
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Nov 2018 20:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="xU6kw+Q0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4233C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbeKTGp5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:45:57 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56132 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728844AbeKTGp5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Nov 2018 01:45:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 96D478EE2C9;
        Mon, 19 Nov 2018 12:20:40 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KCPv5swtL1Jv; Mon, 19 Nov 2018 12:20:40 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id F21968EE0BA;
        Mon, 19 Nov 2018 12:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1542658840;
        bh=Wm6fSzDmHZQwYXrm47j/oa+Xkppnoa0EkTIZRPpXYLA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=xU6kw+Q0SuPQt6FUV1PSUcYmBUk5G8rQ8s8cCl3SMSWnh241eHd7Fl71D1Cs2yNTw
         d1dMBoYrPHrzkWr3S7WQVBKWSsmuMciQcjxnGIEM4rS6gJqGnqUVZzH2qUB8J6jLtW
         LYRYitpYqRglI/go+WrLEKT3XY2bTLxY2ude4yUg=
Message-ID: <1542658839.2910.32.camel@HansenPartnership.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of
 bus interposer attacks
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        monty.wiseman@ge.com, Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Mon, 19 Nov 2018 12:20:39 -0800
In-Reply-To: <20181119200505.GF4890@ziepe.ca>
References: <1542648844.2910.9.camel@HansenPartnership.com>
         <20181119200505.GF4890@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 2018-11-19 at 13:05 -0700, Jason Gunthorpe wrote:
> On Mon, Nov 19, 2018 at 09:34:04AM -0800, James Bottomley wrote:
> 
> > The current state of the art for snooping the TPM Genie hardware
> > interposer https://www.nccgroup.trust/us/our-research/tpm-genie/
> > which
> > is a simple external device that can be installed in a couple of
> > seconds on any system or laptop.  However, the next phase of
> > research
> > seems to be hacking existing devices on the bus to act as
> > interposers,
> > so the fact that the attacker requires physical access for a few
> > seconds might evaporate.  However, the goal of this document is to
> > protect TPM secrets and integrity as far as we are able in this
> > environment and to try to insure that if we can't prevent the
> > attack
> > then at least we can detect it.
> > 
> > Unfortunately, most of the TPM functionality, including the
> > hardware
> > reset capability can be controlled by an attacker who has access to
> > the bus, so we'll discuss some of the disruption possibilities
> > below.
> > 
> > Measurement (PCR) Integrity
> > 
> > Since the attacker can send their own commands to the TPM, they can
> > send arbitrary PCR extends and thus disrupt the measurement system,
> > which would be an annoying denial of service attack.  However,
> > there
> > are two, more serious, classes of attack aimed at entities sealed
> > to
> > trust measurements.
> > 
> > 1. The attacker could intercept all PCR extends coming from the
> > system
> >    and completely substitute their own values, producing a replay
> > of
> >    an untampered state that would cause PCR measurements to attest
> > to
> >    a trusted state and release secrets
> > 
> > 2. At some point in time the attacker could reset the TPM, clearing
> >    the PCRs and then send down their own measurements which would
> >    effectively overwrite the boot time measurements the TPM has
> >    already done.
> 
> I can just de-solder the TPM, attach it to a rig and do whatever I
> want to it, including fake PCR loads and trigger seal/uneal of any
> data I like.

You wouldn't be able to resolder the TPM without causing a reset and
losing the PCR values.

The TPM is not designed to be secure against physical attacks that go
after its internal seed values, that's true.  It is supposed to be
secure against attacks that go after the information transmission into
and out of the TPM, which is what the interposer is doing ... it's just
far lower in the stack than we were expecting.

> The promise of the TPM was never that PCR protected elements would be
> secure against something that has control over the physical hardware
> bus.

I agree as I say ... all we can guarantee is that our extensions go to
the PCRs or we see an error ... we can't guarantee the integrity of the
final measurements because the attacker can still have undetectably
added their own PCR extensions.

> The treat model for PCR users always contained the implicit
> assumption that the security of the physical TPM HW, and the secure
> linkage to the CPU (ie secure control over reset, and other things)
> is maintained.
> 
> So, I'm not sure adding more crypto here really fits with the threat
> model the TPM lives in?

It is, because the attack is a man in the middle, even if it's at the
bus level, which TPM crypto and HMAC is supposed to thwart.  For the
PCR case I just care about forcing our measurements or detecting their
loss ... that's good enough, I think because it means that the attacker
can disrupt the TPM measurements but can't set them to expected values
which is a reasonable thing to guarantee if we do secrets sealing to
PCR values.

> That said, certainly there are other non-PCR use cases where this
> stuff becomes important. For instance anything using shared secrets
> should absolutely establish a crypto unsnoopable path to the TPM.
> 
> > Certain information passing in and out of the TPM, such as key
> > sealing and private key import and random number generation, is
> > vulnerable to interception which HMAC protection alone cannot
> > protect, so for these types of command we must also employ request
> > and response encryption to prevent the loss of secret information.
> 
> Thwarting passive observation seems like a reasonable goal to
> me. Attaching a snooper has much less invasion and risk than doing
> something active.
> 
> But I'm not sure the complexity of a null key is needed here? Won't
> any readable key in the TPM do this job?

In theory, but we don't seem to have one.  The theory is that TPMs come
provisioned according to the TCG guidance which specifies RSA and
EC storage keys be at 81000001 and 81000002 respectively ... it just
seems that the current TPM generation don't respect this, so they come
with no permanent keys at all.

Since we have to derive a primary key anyway, the null seed seems more
useful because of the reset detection.

James

