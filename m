Return-Path: <SRS0=iPov=N6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A45C43610
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Nov 2018 20:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B196A20870
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Nov 2018 20:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pSx26Hdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B196A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbeKTGaV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:30:21 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:33652 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730417AbeKTGaU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Nov 2018 01:30:20 -0500
Received: by mail-pf1-f171.google.com with SMTP id v68-v6so15375118pfk.0
        for <linux-security-module@vger.kernel.org>; Mon, 19 Nov 2018 12:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L2pizqYcbQWl7ppbvDy3SZLSh7p3RDnzeCBwd8aZq0I=;
        b=pSx26HdnjlNYhUsa1svE8APHH/E8/l+fjxwhW9Nlsc+3zlS+D3GYz4dGdJDwNLpmhT
         UJhMryhR5BvW3X3s3PGBnIRcypFzqtfAfB215E7Enyrgn8S6nfpeG3joYOjqvEJbbzcz
         vSqazf2+sTWp4khHLJui2Q/7SNY9//N6eGzXm1M2WyD10N1OzWdZ/3jb/RgOBpfSBLkH
         WV9RbvvRw4X+C4SstN0w7x3PaPaoa2acqSzpTRrUjK2uUXCwp10XuVbHRH0fAzMR/wLv
         gS6YqA5J1Y5n4soDuJDuE18laaaiumGG2age/PZNHhyo6Xg6CUYZe8SULA8cxxmOhzKl
         hzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L2pizqYcbQWl7ppbvDy3SZLSh7p3RDnzeCBwd8aZq0I=;
        b=B+igHHwoKe8ENnW37q7DKcPd2zYhAdNEIWatUXPjwFwUcp2YASMSh34dpoT9vZuhrS
         qRWxY1PxoCmUPjTFlVXzIVtZDyLlt6XDqU823Pnu95jM8lnMp/limQ2hMz6L2dKCKaHD
         Uhpobtt2XjUbK4ClUemJpvL7M1+FsEZjzGa31go6ZjTA/emPYBnE7nzEAms+OhKWc0V7
         GU1d5p8pOyCUm9+82jM7vQbeKQBPoa+V61SkPiMRf7glIz3JTsxLn3G7Wde0+KHYvW1V
         Rs3UNQVQ2njT31L73QvUi6oWYX/aNcCBqxXRubL8T2g+JEsA+VzebTEaR86MGFklG1fR
         VluA==
X-Gm-Message-State: AGRZ1gKEwRTZQqROHnkm9chMc7zD/FbxnVEuNNWbtWRvIcgkbNRb8pZU
        Uofu3UDQ3Ndzl1MRW1s93Xm4yA==
X-Google-Smtp-Source: AFSGD/U6NvOeKQVZ7hltZ46IsJfi+6FwBdV8fnSj+5ImjcjkBiqv1BTmhNkJA9Khy2MvJcLKcat3uw==
X-Received: by 2002:a62:6204:: with SMTP id w4mr669504pfb.5.1542657907569;
        Mon, 19 Nov 2018 12:05:07 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id p15-v6sm69892086pfj.72.2018.11.19.12.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 12:05:06 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gOpn7-0005to-Rp; Mon, 19 Nov 2018 13:05:05 -0700
Date:   Mon, 19 Nov 2018 13:05:05 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        monty.wiseman@ge.com, Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of bus
 interposer attacks
Message-ID: <20181119200505.GF4890@ziepe.ca>
References: <1542648844.2910.9.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542648844.2910.9.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 19, 2018 at 09:34:04AM -0800, James Bottomley wrote:

> The current state of the art for snooping the TPM Genie hardware
> interposer https://www.nccgroup.trust/us/our-research/tpm-genie/ which
> is a simple external device that can be installed in a couple of
> seconds on any system or laptop.  However, the next phase of research
> seems to be hacking existing devices on the bus to act as interposers,
> so the fact that the attacker requires physical access for a few
> seconds might evaporate.  However, the goal of this document is to
> protect TPM secrets and integrity as far as we are able in this
> environment and to try to insure that if we can't prevent the attack
> then at least we can detect it.
> 
> Unfortunately, most of the TPM functionality, including the hardware
> reset capability can be controlled by an attacker who has access to
> the bus, so we'll discuss some of the disruption possibilities below.
> 
> Measurement (PCR) Integrity
> 
> Since the attacker can send their own commands to the TPM, they can
> send arbitrary PCR extends and thus disrupt the measurement system,
> which would be an annoying denial of service attack.  However, there
> are two, more serious, classes of attack aimed at entities sealed to
> trust measurements.
> 
> 1. The attacker could intercept all PCR extends coming from the system
>    and completely substitute their own values, producing a replay of
>    an untampered state that would cause PCR measurements to attest to
>    a trusted state and release secrets
> 
> 2. At some point in time the attacker could reset the TPM, clearing
>    the PCRs and then send down their own measurements which would
>    effectively overwrite the boot time measurements the TPM has
>    already done.

I can just de-solder the TPM, attach it to a rig and do whatever I
want to it, including fake PCR loads and trigger seal/uneal of any
data I like.

The promise of the TPM was never that PCR protected elements would be
secure against something that has control over the physical hardware
bus.

The treat model for PCR users always contained the implicit assumption
that the security of the physical TPM HW, and the secure linkage to
the CPU (ie secure control over reset, and other things) is
maintained.

So, I'm not sure adding more crypto here really fits with the threat
model the TPM lives in?

That said, certainly there are other non-PCR use cases where this
stuff becomes important. For instance anything using shared secrets
should absolutely establish a crypto unsnoopable path to the TPM.

> Certain information passing in and out of the TPM, such as key sealing
> and private key import and random number generation, is vulnerable to
> interception which HMAC protection alone cannot protect, so for these
> types of command we must also employ request and response encryption
> to prevent the loss of secret information.

Thwarting passive observation seems like a reasonable goal to
me. Attaching a snooper has much less invasion and risk than doing
something active.

But I'm not sure the complexity of a null key is needed here? Won't
any readable key in the TPM do this job?

Jason
