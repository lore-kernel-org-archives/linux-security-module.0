Return-Path: <SRS0=9590=OA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5069C43610
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Nov 2018 05:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE962087E
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Nov 2018 05:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VYpJ4v63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE962087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeKUPto (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Nov 2018 10:49:44 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:40958 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeKUPto (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Nov 2018 10:49:44 -0500
Received: by mail-pl1-f181.google.com with SMTP id b22-v6so3703990pls.7
        for <linux-security-module@vger.kernel.org>; Tue, 20 Nov 2018 21:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=icx9gocQ95ZTtP0q5hQPP/LdR8YIQ4wgBXZggcGoLe0=;
        b=VYpJ4v63Jpt9JUPai5DR6+H/uHecIGgoai9LqKhzbSXDS5FN7pkdDV9dlQ4Q519WYM
         XDNPkcX2R28GCUNIVBpItTtjj4nuq2JX/Liv8qVubXEwFBKMyUPL+VKsCrn5vtfc+B4f
         HDbw8bl/pZSJG9pogRvK/HAsTGjhR3MVo1Beqq4TOlHgstS11SGv+L+0/aeYvMSdsgqw
         xjojmlUveGRyCct/FLRcdLU2KuvjVzlTBu0WXao3UiKqHQu+ZDr+pjEvAFLkJiwv1InB
         VlKTwi9O/fRwx+wJsfkXlXCYu03Z3PNBJWO6k7KHWZluN0SYdQ6LyD+o+srioZ1EONT7
         C12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=icx9gocQ95ZTtP0q5hQPP/LdR8YIQ4wgBXZggcGoLe0=;
        b=uhBY0FEiA378xcReZ0GP9n7CKFMGjoa4tlGDDb7IwsRaOY7DfhlXkmoRy5pQcmo2mJ
         PfPGF9aOopnsVULBhcalOA6UQ13364CEGFpcIDFpXcTuBFJimt0FzbcRLjsaiV1FdJAo
         np03t056u0t0kU0Dfak293lTHyg0SghfuURO8g0pWJV14RpWN5c02LMG6JudtpwmSp8E
         CoH+zESO+sx/IkUCdURPkky7MIpKPjIpXW0TQF4UinHLQoMsM5H6ht3ycUU2fVMeD55L
         j73QJhqhQ3N9NGh7Q88VC+ktGy019pPY0Te7yyXSl9kKmaZsUKcAv6nQAYVq+Z5HpToN
         +tYg==
X-Gm-Message-State: AGRZ1gLpcpL+2bVxb+s6H+wjNrSmCDiZLDBeM5UQ6wsjNHp4D1kT3399
        fs3S1A79ZiG8O6Ngdw/Y+xx5+A==
X-Google-Smtp-Source: AJdET5e7LZ0sthoCFTWPGG6q1k1g6gZ9bBrQcDyRJdZg2r5B5Nsne+dHExxwLWV6vcK4K+pDS9Lt0A==
X-Received: by 2002:a62:8dd9:: with SMTP id p86mr5238311pfk.143.1542777409760;
        Tue, 20 Nov 2018 21:16:49 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id o13sm18327143pfk.57.2018.11.20.21.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 21:16:48 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gPKsZ-0004bb-GS; Tue, 20 Nov 2018 22:16:47 -0700
Date:   Tue, 20 Nov 2018 22:16:47 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jeremy Boone <jeremy.boone@nccgroup.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "monty.wiseman@ge.com" <monty.wiseman@ge.com>,
        Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: EXTERNAL: Re: Documenting the proposal for TPM 2.0 security in
 the face of bus interposer attacks
Message-ID: <20181121051647.GA17002@ziepe.ca>
References: <20181119214426.GK4890@ziepe.ca>
 <1542666988.2910.49.camel@HansenPartnership.com>
 <20181119230826.GN4890@ziepe.ca>
 <1542675272.2910.63.camel@HansenPartnership.com>
 <20181120030556.GP4890@ziepe.ca>
 <1542734279.2814.23.camel@HansenPartnership.com>
 <20181120213345.GC22023@ziepe.ca>
 <1542753292.2814.45.camel@HansenPartnership.com>
 <20181120233904.GF22023@ziepe.ca>
 <01A99B24-E772-489C-A33F-2F3CC80281FA@nccgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01A99B24-E772-489C-A33F-2F3CC80281FA@nccgroup.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 21, 2018 at 02:24:18AM +0000, Jeremy Boone wrote:

> I think it’s worth recognizing that TPMs are used in a variety of
> deployments, each with their own unique threat model and attack
> surface.
> 
> For example, some users may care about evil maid scenarios. Heck,
> TPM-TOTP (and dare I mention the Qubes Anti-Evil Maid technology)
> utilizes the TPM to attest the boot state to the device owner.
> 
> Other users may care about the “lost in the back of a taxi” scenario
> wherein the attacker may have extended physical access to the mobile
> device (a phone or laptop) before returning it to the owner.
> 
> In other scenarios, the device user may be a different entity than
> the device owner, and as such, different security considerations
> must be applied. Think of a set top box that you’ve rented from your
> cable service provider which uses a TPM to remotely attest the
> firmware before being trusted to handle content decryption keys. Or
> a car share program that uses the TPM as a means to store temporary
> keyless-entry tokens — After all, the TCG Automotive Thin Profile is
> taking off, as are the SAE J3101 requirements which suggest the use
> of TPM in automotive applications.

> An interposer, or even a simple
> sniffer attached to test points on the bus, would be able to observe
> any secrets transmitted between the TPM and host.

Not quite, it is not 'any' secrets. We can and absolutely should
competently encrypt various things, like shared secrets for unlocking
keys private data to be seal/unsealed, etc. There are robust working
mechanisms for this already in the spec.

I think this is very important and I know I've always coded my TPM
implementations to make use of these features.

But PCR extend is not private data, the data is well known.

> I believe that the Linux kernel has an obligation to build in active
> defences that protect TPM users against serial bus attacks, and
> makes no blind assumptions about the ways in which a TPM may be used
> or deployed in a variety of creative or unexpected ways.
> 
> This is especially true in light of the fact that the TCG (and TPM
> chip manufacturers as well) have not plainly documented that,
> despite having expended considerable effort defending against
> invasive silicon attacks (see Chris Tarnovsky’s work), a trivial
> interposer can still defeat TPM security. I believe that many do not
> understand this fact, and conflate the idea that measured boot can
> detect “hardware tampering” vs. mere “firmware
> tampering”. 

This is basically my concern. HMACing the PCRs does not magically
allow measured boot to detect "hardware tampering". Even if all layers
from the BIOS down do this correctly. Pretending otherwise continues
to push the incorrect message that PCRs do anything beyond detecting
"firmware tampering", as you say.

> Regardless, it seems odd to me that we wish to defend against
> one-off attacks involving an electron microscope, but do not wish to
> defend against a simple microcontroller acting as a
> man-in-the-middle on the bus.

I agree with this, but if you want to defent against hardware
tampering then one should defend robustly against all hardware
tampering and call that a TPM capability. A half implemented hardware
tampering defence only gives a false sense of security.

I think it is possible to do, but it requires some updates to the TPM
specification.

A general proposal would go something like...

1) The TPM gains a new NV flag 'Secure Reset Required' and a new command
   'Secure Reset'
2) Issuing the'Secure Reset' command requires the TPM and CPU to both
   prove to each other they are authentic, using some crypto protocol
   (lots of options here)
2a) The TPM will store it's private secret for #2 either as a loaded blob
    against a NV key or in NV itself. There is some protocol during
    owning that allows the BIOS to initialize this stuff and set
    Secure Reset Required. Maybe we assume the HW is untampered during
    owning.
2b) The CPU will store its private secret for #2 encrypted using modern
    CPU encryption technology like Intel's SGX, or similar. The
    encrypted key will be stored in BIOS flash.
3) Upon boot the CPU will securely decrypt it's secret and issue
   'Secure Reset'. The TPM will not function until this command is
   issued. The only other option is a complete wipe.
4) During the 'Secure Reset' crypto the two sides will exchange
   trusted or secret information used to authenticate and encrypt
   all future communications
5) The BIOS will pass the #4 data down to the bootloader and to the
   kernel for use when executign TPM commands, or maybe the BIOS will
   transparently link it into the ACPI CRB executor or something.
6) TPM will reject any unathenticated&encrypted packet after Secure Reset

Now we have properly defended against a wide range of HW
tampering. You can't snoop/hijack the TPM bus. You can't reset the
TPM. You can't hack the BIOS FLASH and take over the BIOS before TPM
reset (assuming SGX is implemented properly). You can't replace the
trusted CPU with a hostile CPU. You can't desolder the TPM. This is an
excellent improvement in HW defense. If the SGX code also sets up DRAM
encryption then we are getting to be really properly secured against
HW tampering.

This is sort of what I mean when I say a spec update is needed. The
spec needs to be designed to properly detect and combat HW tampering.
We can't add this new feature robustly with only the functional
elements already in the spec.

[Of course this is kind of a silly thing to do, because if you have
 this CPU technology then you may was well just implement the TPM in
 the CPU.. But this is more of a thought experiment as to what would be
 needed to secure a discrete TPM against HW tampering]

> It’s true that with sufficient time and motivation, a dedicated and
> well-funded adversary can defeat almost any protection
> mechanism. But our job as defenders is to raise the bar so that
> cheap and inexpensive attacks are no longer feasible. By raising the
> cost of exploitation beyond the adversary’s appetite, we eliminate
> entire classes of attack.

My concern is we haven't done this simply because the reset-line
attack is less cost and complexity than the interposer on the data bus
attack, so we must prevent it first and foremost. Then prevent data
bus mangling, then prevent loading modified BIOS's, then prevent
hacked CPUs, and so on until things become properly expensive.

> Choosing to do nothing simply because other attack avenues exist is
> a little too defeatist of an attitude for me. Especially given that
> the TPM specification does support payload encryption and integrity
> protection through the use of Authorization Sessions. 

We absolutely should be using encrypted and authenticated sessions
when transporting any secret data.

> So we do have the necessary tools to begin to solve this
> problem. Unfortunately, it is also true that this issue extends
> beyond the kernel. We also need to land similar patches for every
> stage of the boot process that performs a PCR Extend
> operation. Otherwise the chain of trust can be broken before the
> kernel is even started.

Right, but this chain of trust starts at the reset line, not at the
BIOS. There is language in the spec requiring the platform to control
the reset line along with the CPU reset - this is critically necessary
to make PCRs work for 'measured boot'.

In my mind an interposer also means hostile control over the reset
line, so reset protection must be part of any complete defence against
an interposer.

The idea James had with the null key to detect reset doesn't mitigate
the case where hostile code is running on the CPU along with an
interposer. We can't make the assumption that only trusted code is
running in the CPU - if we could assume that we wouldn't need PCRs and
measured boot in the first place. ;)

Jason
