Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C683CC001B0
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Aug 2023 01:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjHJBXF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 9 Aug 2023 21:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHJBXE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Aug 2023 21:23:04 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A1B810D8;
        Wed,  9 Aug 2023 18:23:03 -0700 (PDT)
Received: from [192.168.87.33] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 306FA207F5A7;
        Wed,  9 Aug 2023 18:23:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 306FA207F5A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691630582;
        bh=bnyN1ioY9d5da9MP76r8u/PYucM9RcXgBXwj7glxDzI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J73xUhApar6cGSwznTcwtaXCRZweAtzrglnLh+E41AtN8uxrbnvZMEIto5To7NMm1
         0Kcs5lCVhAdz7blS893tvpaW207q2vrvAEK1DP+ok+sDotcBfVSNhTZk42oFR4InJM
         QVWIMvWNqtZdRJ/B/lSziLwOCRX9sGx3CVWe60f0=
Message-ID: <72f195f3-d96e-c516-d9e6-983ad7f86cdc@linux.microsoft.com>
Date:   Wed, 9 Aug 2023 18:23:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
Content-Language: en-US
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc:     code@tyhicks.com, nramas@linux.microsoft.com,
        linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <b748230c8ee291288afcf48898507556c3aa7c71.camel@HansenPartnership.com>
 <5d21276a-daac-fc9b-add9-62e7c04bbdcd@linux.ibm.com>
 <8ad131f35c33cf10788344be6c981473971f9c1c.camel@HansenPartnership.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <8ad131f35c33cf10788344be6c981473971f9c1c.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

hi James,
Thanks for addressing Stefan's concerns.

On 8/8/23 05:35, James Bottomley wrote:
> On Mon, 2023-08-07 at 18:49 -0400, Stefan Berger wrote:
>>
>> On 8/1/23 17:21, James Bottomley wrote:
>>> On Tue, 2023-08-01 at 12:12 -0700, Sush Shringarputale wrote:
>>> [...]
>>>> Truncating IMA log to reclaim memory is not feasible, since it
>>>> makes the log go out of sync with the TPM PCR quote making remote
>>>> attestation fail.
>>> This assumption isn't entirely true.  It's perfectly possible to
>>> shard an IMA log using two TPM2_Quote's for the beginning and end
>>> PCR values to validate the shard.  The IMA log could be truncated
>>> in the same way (replace the removed part of the log with a
>>> TPM2_Quote and AK, so the log still validates from the beginning
>>> quote to the end).
>>>
>>> If you use a TPM2_Quote mechanism to save the log, all you need to
>>> do is have the kernel generate the quote with an internal AK.  You
>>> can keep a record of the quote and the AK at the beginning of the
>>> truncated kernel log.  If the truncated entries are saved in a file
>>> shard it
>> The truncation seems dangerous to me. Maybe not all the scenarios
>> with an attestation client (client = reading logs and quoting) are
>> possible then anymore, such as starting an attestation client only
>> after truncation but a verifier must have witnessed the system's PCRs
>> and log state before the truncation occurred.
> That's not exactly correct.  Nothing needs to have "witnessed" the
> starting PCR value because the quote vouches for it (and can vouch for
> it after the fact).  The only thing you need to verify the quote is the
> attestation key and the only thing you need to do to trust the
> attestation key is ensure it was TPM created.  All of that can be
> verified after the fact as well.  The only thing that can be done to
> disrupt this is to destroy the TPM (or re-own it).
Agreed.
>
> Remember the assumption is you *also* have the removed log shard to
> present.  From that the PCR state of the starting quote can be
> calculated and checked for matching the quote.  If you lose that, it's
> equivalent to the log being tampered with and all bets are off.  The
> assumption is that because of the impossibility of engineering TPM
> extensions, it should be impossible to come up with a fake log that
> produces the PCRs of the real one.  If that's violated, then IMA itself
> becomes useless.
Totally agreed. I believe our proposal is consistent with your
comments. Please let us know if you see any inconsistencies or technical
blockers.

~Tushar

>
> James

