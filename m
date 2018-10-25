Return-Path: <SRS0=wXFO=NF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95D4C46475
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Oct 2018 15:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D09F20834
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Oct 2018 15:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D09F20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeJZANL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:13:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:59978 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbeJZANL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Oct 2018 20:13:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 08:39:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,424,1534834800"; 
   d="scan'208";a="85550354"
Received: from mstribae-mobl.ger.corp.intel.com ([10.249.254.38])
  by orsmga006.jf.intel.com with ESMTP; 25 Oct 2018 08:39:48 -0700
Date:   Thu, 25 Oct 2018 16:39:47 +0100 (IST)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ken Goldman <kgold@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v4 0/7] add integrity and security to TPM2 transactions
In-Reply-To: <1540366876.3008.11.camel@HansenPartnership.com>
Message-ID: <alpine.DEB.2.21.1810251638090.4065@jsakkine-mobl1>
References: <1540193596.3202.7.camel@HansenPartnership.com>          <a8a69222-94fb-7406-d9b2-207079727eb8@linux.ibm.com>  <1540217887.3012.14.camel@HansenPartnership.com>  <alpine.DEB.2.21.1810240307080.8524@jsakkine-mobl1>
 <1540366876.3008.11.camel@HansenPartnership.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 24 Oct 2018, James Bottomley wrote:
> On Wed, 2018-10-24 at 03:13 +0300, Jarkko Sakkinen wrote:
>> On Mon, 22 Oct 2018, James Bottomley wrote:
>>> On Mon, 2018-10-22 at 09:53 -0400, Ken Goldman wrote:
>>>> On 10/22/2018 3:33 AM, James Bottomley wrote:
>>>>> By now, everybody knows we have a problem with the TPM2_RS_PW
>>>>> easy button on TPM2 in that transactions on the TPM bus can be
>>>>> intercepted and altered.  The way to fix this is to use real
>>>>> sessions for HMAC capabilities to ensure integrity and to use
>>>>> parameter and response encryption to ensure confidentiality of
>>>>> the data flowing over the TPM bus.
>>>>
>>>> Does this design assume that there was at time zero no
>>>> monitoring? This would permit some shared secret to be
>>>> established.
>>>>
>>>> Or does it assume that the interception may have been present
>>>> from the first boot?  If so, how is the first shared secret
>>>> established. Salting using the EK is the usual method, but this
>>>> requires walking the  EK certificate chain and embedding the TPM
>>>> vendor CA certificates in the  kernel.
>>>
>>> The design establishes the shared secret at start of day using an
>>> EC derived key from the null seed.  This can obviously be spoofed
>>> by a TPM Genie running before the system was rebooted.  However,
>>> the computed key name is exposed to user space and TPM2_Certify
>>> will fail when userspace checks the null seed so you will know
>>> after the fact whether the communication channel established on
>>> boot was secure or not.
>>>
>>> It is possible to use either the EPS or SPS if we pass in the
>>> public points as kernel parameters but this is getting rather
>>> complicated for casual users.
>>
>> Where was the code that exposes it to the user space?
>
> It's patch 6/7.  It exposes the null ec primary name in sysfs:
>
> jejb@jarvis~> cat /sys/class/tpm0/tpm/null_name
> 000ba4fa35ecfbf7c85e5407d07edc27f6a522c8b1a011bcb68c60b27baf21f9d9ec
>
> The key certification gives you back a signed copy of the name which
> you can verify against this.
>
> James

I missed 6/7, sorry.

Do you have an example user space program for doing the verification
by using this file?

/Jarkko
