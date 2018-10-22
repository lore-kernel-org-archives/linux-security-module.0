Return-Path: <SRS0=zjoR=NC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F08C7112C
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Oct 2018 14:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9ABA20665
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Oct 2018 14:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="hX9ijEhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9ABA20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeJVWg4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Oct 2018 18:36:56 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53810 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727146AbeJVWg4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Oct 2018 18:36:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7B6AC8EE0FC;
        Mon, 22 Oct 2018 07:18:10 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tOnAijf3eOK5; Mon, 22 Oct 2018 07:18:10 -0700 (PDT)
Received: from [172.22.37.2] (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3C68D8EE0BA;
        Mon, 22 Oct 2018 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1540217890;
        bh=jtpaFqv7wpFL/vcgMtaFsj9MiCeMQKYPhx99BpWBFF4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hX9ijEhfUIta1VlyQ5CK/w1TdLgyKczDmYQXca2/dX9hxdp9386rnDtt2C7KUrjtm
         6+U/ednHmg6TCnWSk7lsh051s78YX/SQEC5sKAfuEpTnmUAuSgWsebs3RT8nJyQ9xs
         6UtebEIZ0/fHun5u1g8mKROGgjm01NxxQ5q9D8E0=
Message-ID: <1540217887.3012.14.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 0/7] add integrity and security to TPM2 transactions
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ken Goldman <kgold@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 22 Oct 2018 15:18:07 +0100
In-Reply-To: <a8a69222-94fb-7406-d9b2-207079727eb8@linux.ibm.com>
References: <1540193596.3202.7.camel@HansenPartnership.com>
         <a8a69222-94fb-7406-d9b2-207079727eb8@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 2018-10-22 at 09:53 -0400, Ken Goldman wrote:
> On 10/22/2018 3:33 AM, James Bottomley wrote:
> > By now, everybody knows we have a problem with the TPM2_RS_PW easy
> > button on TPM2 in that transactions on the TPM bus can be
> > intercepted and altered.  The way to fix this is to use real
> > sessions for HMAC capabilities to ensure integrity and to use
> > parameter and response encryption to ensure confidentiality of the
> > data flowing over the TPM bus.
> 
> Does this design assume that there was at time zero no monitoring?
> This would permit some shared secret to be established.
> 
> Or does it assume that the interception may have been present from
> the first boot?  If so, how is the first shared secret established.
> Salting using the EK is the usual method, but this requires walking
> the  EK certificate chain and embedding the TPM vendor CA
> certificates in the  kernel.

The design establishes the shared secret at start of day using an EC
derived key from the null seed.  This can obviously be spoofed by a TPM
Genie running before the system was rebooted.  However, the computed
key name is exposed to user space and TPM2_Certify will fail when
userspace checks the null seed so you will know after the fact whether
the communication channel established on boot was secure or not.

It is possible to use either the EPS or SPS if we pass in the public
points as kernel parameters but this is getting rather complicated for
casual users.

> > This patch series is about adding a simple API which can ensure the
> > above properties as a layered addition to the existing TPM handling
> > code.  This series now includes protections for PCR extend, getting
> > random numbers from the TPM and data sealing and unsealing.  It
> > therefore eliminates all uses of TPM2_RS_PW in the kernel and adds
> > encryption protection to sensitive data flowing into and out of the
> > TPM.
> > 
> > In the third version I added data sealing and unsealing protection,
> > apart from one API based problem which means that the way trusted
> > keys were protected it's not currently possible to HMAC protect an
> > authority that comes with a policy, so the API will have to be
> > extended to fix that case
> 
> TPM 2.0 observations (questioning 'not possible'):

Actually, let me correct that: not possible with the way policy based
trusted keys API works because it expects you to pass in a policy
session handle.  The way to fix this is to fix the API to pass in the
actual policy sequence instead of the commands, but that's long term.

> 1 - Any policy that requires a password (policypassword) can
> substitute
> an HMAC (policyauthvalue) at the callers discretion.  They result
> in the same policy digest.

Right but this requires the co-operation of the policy handle creator,
so it's an API change.

> 2 - Any command can be HMAC protected, even one like pcrread that
> does not require authorization.  Start an HMAC session and specify
> audit Of course, a shared secret has to be used, either a bind or
> salted session.

Right, so if we create the session, we can then set it up to use a
salted session, but we don't create it under the current API.

> 3 - If the command is already using a policy session, but does not 
> require a password, I believe that the same technique #2 can be
> used - specify audit with that policy session.
> 
> I've tested #3 with bind but not salt.  I can test if there's
> interest.

I think the API is going to have to change, so if we're looking at a
new API, we should set it up to do the right thing with policy anyway. 
It turns out to be quite easy as I found out when Huawei patched the
openssl_tpm2_engine to add policy to keys.

James

> > In this fourth version, I tidy up some of the code and add more
> > security features, the most notable is that we now calculate the
> > NULL seed name and compare our calculation to the value returned in
> > TPM2_ReadPublic, which means we now can't be spoofed.  This version
> > also gives a sysfs variable for the null seed which userspace can
> > use to run a key certification operation to prove that the TPM was
> > always secure when communicating with the kernel.
> > 
> > I've verified this using the test suite in the last patch on a VM
> > connected to a tpm2 emulator.  I also instrumented the emulator to
> > make sure the sensitive data was properly encrypted.
> 
> 

