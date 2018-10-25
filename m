Return-Path: <SRS0=wXFO=NF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE2CC46475
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Oct 2018 15:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807BC2083E
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Oct 2018 15:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807BC2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbeJZAaM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:30:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:7014 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbeJZAaM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Oct 2018 20:30:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 08:56:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,424,1534834800"; 
   d="scan'208";a="244333282"
Received: from mstribae-mobl.ger.corp.intel.com ([10.249.254.38])
  by orsmga004.jf.intel.com with ESMTP; 25 Oct 2018 08:56:46 -0700
Date:   Thu, 25 Oct 2018 16:56:45 +0100 (IST)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v4 2/7] tpm2-sessions: Add full HMAC and encrypt/decrypt
 session handling
In-Reply-To: <1540373514.3008.45.camel@HansenPartnership.com>
Message-ID: <alpine.DEB.2.21.1810251643080.4065@jsakkine-mobl1>
References: <1540193596.3202.7.camel@HansenPartnership.com>  <1540193787.3202.10.camel@HansenPartnership.com>  <alpine.DEB.2.21.1810232239140.8524@jsakkine-mobl1> <1540373514.3008.45.camel@HansenPartnership.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 24 Oct 2018, James Bottomley wrote:
>>> +static void KDFa(u8 *key, int keylen, const char *label, u8 *u,
>>> +		 u8 *v, int bytes, u8 *out)
>>
>> Should this be in lower case? I would rename it as tpm_kdfa().
>
> This one is defined as KDFa() in the standards and it's not TPM
> specific (although some standards refer to it as KDFA).  I'm not averse
> to making them tpm_kdfe() and tpm_kdfa() but I was hoping that one day
> the crypto subsystem would need them and we could move them in there
> because KDFs are the new shiny in crypto primitives (TLS 1.2 started
> using them, for instance).

I care more about tracing and debugging than naming and having 'tpm_' in
front of every TPM function makes tracing a lean process. AFAIK using
upper case letters is against kernel coding conventions. I'm not sure
why this would make an exception on that.

>> Why doesn't it matter here?
>
> Because, as the comment says, it eventually gets overwritten by running
> ecdh to derive the two co-ordinates.  (pointers to these two
> uninitialized areas are passed into the ecdh destination sg list).

Oh, I just misunderstood the comment. Wouldn't it be easier to say that
the data is initialized later?

>>> +	buf_len = crypto_ecdh_key_len(&p);
>>> +	if (sizeof(encoded_key) < buf_len) {
>>> +		dev_err(&chip->dev, "salt buffer too small needs
>>> %d\n",
>>> +			buf_len);
>>> +		goto out;
>>> +	}
>>
>> In what situation this can happen? Can sizeof(encoded_key) >=
>> buf_len?
>
> Yes, but only if someone is trying to crack your ecdh.  One of the
> security issues in ecdh is if someone makes a very specific point
> choice (usually in the cofactor space) that has a very short period,
> the attacker can guess the input to KDFe.  In this case if TPM genie
> provided a specially crafted attack EC point, we'd detect it here
> because the resulting buffer would be too short.

Right. Thank you for the explanation. Here some kind of comment might
not be a bad idea...

>> In general this function should have a clear explanation what it does
>> and maybe less these one character variables but instead variables
>> with more documenting names. Explain in high level what algorithms
>> are used and how the salt is calculated.
>
> I'll try, but this is a rather complex function.

Understood. I do not expect perfection here and we can improve
documetation later on.

For anyone wanting to review James' patches and w/o much experience on
EC, I recommend reading this article:

https://arstechnica.com/information-technology/2013/10/a-relatively-easy-to-understand-primer-on-elliptic-curve-cryptography/

I read it few years ago and refreshed my memory few days ago by
re-reading it.

>
>>> +
>>> +/**
>>> + * tpm_buf_append_hmac_session() append a TPM session element
>>> + * @buf: The buffer to be appended
>>> + * @auth: the auth structure allocated by
>>> tpm2_start_auth_session()
>>> + * @attributes: The session attributes
>>> + * @passphrase: The session authority (NULL if none)
>>> + * @passphraselen: The length of the session authority (0 if none)
>>
>> The alignment.
>
> the alignment of what?

We generally have parameter descriptions tab-aligned.

>> Why there would be trailing zeros?
>
> Because TPM 1.2 mandated zero padded fixed size passphrases so the TPM
> 2.0 standard specifies a way of converting these to variable size
> strings by eliminating the zero padding.

Ok.

> James

I'm also looking forward for the CONTEXT_GAP patch based on the
yesterdays discussion. We do want it and I was stupid not to take it
couple years ago :-) Thanks.

/Jarkko
