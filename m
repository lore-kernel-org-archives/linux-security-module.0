Return-Path: <SRS0=+97+=OT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53549C5CFFE
	for <linux-security-module@archiver.kernel.org>; Mon, 10 Dec 2018 17:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130F32064D
	for <linux-security-module@archiver.kernel.org>; Mon, 10 Dec 2018 17:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="hC5VDccC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130F32064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeLJRat (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:30:49 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58412 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbeLJRat (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 Dec 2018 12:30:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E92AB8EE0E2;
        Mon, 10 Dec 2018 09:30:48 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FARv9fhhzGgG; Mon, 10 Dec 2018 09:30:48 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 84C288EE0D3;
        Mon, 10 Dec 2018 09:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1544463048;
        bh=YpVj9ECOjNpr2cu/Y4fZhAyh3FjCRhfZKlkQycGbz54=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=hC5VDccC9T2S/QFbZGaWK51gG++If82lEqVXn6ocLRKFqkqcSlmTXh7ctIUP7LhMs
         lpFJvxnSTiT5m0UCCvVvoleMIrgf3MbiIXYzZtQKgFx1qdAdH4JS1AFzIbj/06Ueqo
         AikLFkPWmNeu+N1Y6d/tPX0uMsS1VaVaxZv1g3EI=
Message-ID: <1544463047.2753.24.camel@HansenPartnership.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of
 bus interposer attacks
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ken Goldman <kgold@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Mon, 10 Dec 2018 09:30:47 -0800
In-Reply-To: <16c8baf7-e2a9-6e12-b736-a0e2384282ed@linux.ibm.com>
References: <1542648844.2910.9.camel@HansenPartnership.com>
         <16c8baf7-e2a9-6e12-b736-a0e2384282ed@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 2018-12-10 at 11:33 -0500, Ken Goldman wrote:
> On 11/19/2018 12:34 PM, James Bottomley wrote:
> 
> > 2. At some point in time the attacker could reset the TPM, clearing
> >     the PCRs and then send down their own measurements which would
> >     effectively overwrite the boot time measurements the TPM has
> >     already done.
> > [snip]
> > However, the second can only really be detected by relying
> > on some sort of mechanism for protection which would change over
> > TPM reset.
> 
> FYI: TPM 2.0 has a resetCount that can be used to detect, but not 
> protect against, this attack.

Yes, but that would be an additional check we'd have to do.  Using the
NULL seed for salt means the HMAC and Encryption on commands instantly
breaks if the TPM is reset.

> > Every TPM comes shipped with a couple of X.509 certificates for the
> > primary endorsement key.  This document assumes that the Elliptic
> > Curve version of the certificate exists at 01C00002, but will work
> > equally well with the RSA certificate (at 01C00001).
> 
> A nit.  The RSA cert is at 01c00002.  The ECC cert is at 01c0000a.

Is this actually published somewhere? ... I was guessing from the TPM
2.0 provisioning guide.

James

