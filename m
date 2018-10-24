Return-Path: <SRS0=JlTe=NE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71435C004D3
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Oct 2018 07:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385EA206B5
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Oct 2018 07:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="BR5OX4VZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385EA206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbeJXQIQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:08:16 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44490 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729124AbeJXQIQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Oct 2018 12:08:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 287BD8EE0FC;
        Wed, 24 Oct 2018 00:41:20 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uORxSmfFMTnZ; Wed, 24 Oct 2018 00:41:19 -0700 (PDT)
Received: from [172.20.48.127] (unknown [62.232.21.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 973EF8EE0D5;
        Wed, 24 Oct 2018 00:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1540366879;
        bh=l4ZTafjFTbOAtI5Z1UwjsD95fPyiDlpOVesP36X4/uY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BR5OX4VZwfA2Tewm+LMZAnxz5+nluEL+7QhaO7U4con2MnaBPLukjb7DKIICISwNh
         6RHQLw4EiZRXPKE/Mr84mOKomQHDEU4+nuJo9e9GQjSRDWt+AtgwS8XpbQnK8enhYN
         Nfary3yhPP/YMu9UwakoaZZRfBhj/8GHtCmUKrBw=
Message-ID: <1540366876.3008.11.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 0/7] add integrity and security to TPM2 transactions
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Ken Goldman <kgold@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 24 Oct 2018 08:41:16 +0100
In-Reply-To: <alpine.DEB.2.21.1810240307080.8524@jsakkine-mobl1>
References: <1540193596.3202.7.camel@HansenPartnership.com>
                 <a8a69222-94fb-7406-d9b2-207079727eb8@linux.ibm.com>
         <1540217887.3012.14.camel@HansenPartnership.com>
         <alpine.DEB.2.21.1810240307080.8524@jsakkine-mobl1>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2018-10-24 at 03:13 +0300, Jarkko Sakkinen wrote:
> On Mon, 22 Oct 2018, James Bottomley wrote:
> > On Mon, 2018-10-22 at 09:53 -0400, Ken Goldman wrote:
> > > On 10/22/2018 3:33 AM, James Bottomley wrote:
> > > > By now, everybody knows we have a problem with the TPM2_RS_PW
> > > > easy button on TPM2 in that transactions on the TPM bus can be
> > > > intercepted and altered.  The way to fix this is to use real
> > > > sessions for HMAC capabilities to ensure integrity and to use
> > > > parameter and response encryption to ensure confidentiality of
> > > > the data flowing over the TPM bus.
> > > 
> > > Does this design assume that there was at time zero no
> > > monitoring? This would permit some shared secret to be
> > > established.
> > > 
> > > Or does it assume that the interception may have been present
> > > from the first boot?  If so, how is the first shared secret
> > > established. Salting using the EK is the usual method, but this
> > > requires walking the  EK certificate chain and embedding the TPM
> > > vendor CA certificates in the  kernel.
> > 
> > The design establishes the shared secret at start of day using an
> > EC derived key from the null seed.  This can obviously be spoofed
> > by a TPM Genie running before the system was rebooted.  However,
> > the computed key name is exposed to user space and TPM2_Certify
> > will fail when userspace checks the null seed so you will know
> > after the fact whether the communication channel established on
> > boot was secure or not.
> > 
> > It is possible to use either the EPS or SPS if we pass in the
> > public points as kernel parameters but this is getting rather
> > complicated for casual users.
> 
> Where was the code that exposes it to the user space?

It's patch 6/7.  It exposes the null ec primary name in sysfs:

jejb@jarvis~> cat /sys/class/tpm0/tpm/null_name
000ba4fa35ecfbf7c85e5407d07edc27f6a522c8b1a011bcb68c60b27baf21f9d9ec

The key certification gives you back a signed copy of the name which
you can verify against this.

James

