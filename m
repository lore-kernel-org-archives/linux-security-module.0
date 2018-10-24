Return-Path: <SRS0=JlTe=NE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57B2C67863
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Oct 2018 03:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711272082E
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Oct 2018 03:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711272082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbeJXMBz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:01:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:49187 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbeJXMBz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Oct 2018 08:01:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 17:13:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,418,1534834800"; 
   d="scan'208";a="83620999"
Received: from pwolsza-mobl1.ger.corp.intel.com ([10.249.254.37])
  by orsmga007.jf.intel.com with ESMTP; 23 Oct 2018 17:13:03 -0700
Date:   Wed, 24 Oct 2018 03:13:01 +0300 (EEST)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
cc:     Ken Goldman <kgold@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v4 0/7] add integrity and security to TPM2 transactions
In-Reply-To: <1540217887.3012.14.camel@HansenPartnership.com>
Message-ID: <alpine.DEB.2.21.1810240307080.8524@jsakkine-mobl1>
References: <1540193596.3202.7.camel@HansenPartnership.com>         <a8a69222-94fb-7406-d9b2-207079727eb8@linux.ibm.com> <1540217887.3012.14.camel@HansenPartnership.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 22 Oct 2018, James Bottomley wrote:
> On Mon, 2018-10-22 at 09:53 -0400, Ken Goldman wrote:
>> On 10/22/2018 3:33 AM, James Bottomley wrote:
>>> By now, everybody knows we have a problem with the TPM2_RS_PW easy
>>> button on TPM2 in that transactions on the TPM bus can be
>>> intercepted and altered.  The way to fix this is to use real
>>> sessions for HMAC capabilities to ensure integrity and to use
>>> parameter and response encryption to ensure confidentiality of the
>>> data flowing over the TPM bus.
>>
>> Does this design assume that there was at time zero no monitoring?
>> This would permit some shared secret to be established.
>>
>> Or does it assume that the interception may have been present from
>> the first boot?  If so, how is the first shared secret established.
>> Salting using the EK is the usual method, but this requires walking
>> the  EK certificate chain and embedding the TPM vendor CA
>> certificates in the  kernel.
>
> The design establishes the shared secret at start of day using an EC
> derived key from the null seed.  This can obviously be spoofed by a TPM
> Genie running before the system was rebooted.  However, the computed
> key name is exposed to user space and TPM2_Certify will fail when
> userspace checks the null seed so you will know after the fact whether
> the communication channel established on boot was secure or not.
>
> It is possible to use either the EPS or SPS if we pass in the public
> points as kernel parameters but this is getting rather complicated for
> casual users.

Where was the code that exposes it to the user space?

/Jarkko
