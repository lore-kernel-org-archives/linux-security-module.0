Return-Path: <SRS0=cN3+=7Q=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27EFC433DF
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Jun 2020 11:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A92820674
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Jun 2020 11:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CcT9D9lZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgFCLpe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgFCLpe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Jun 2020 07:45:34 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE3DC08C5C1
        for <linux-security-module@vger.kernel.org>; Wed,  3 Jun 2020 04:45:33 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 202so1115171lfe.5
        for <linux-security-module@vger.kernel.org>; Wed, 03 Jun 2020 04:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R6lEVGZYGJxxHN7lE3eo9NqLzCsnQCicun988jWmqf0=;
        b=CcT9D9lZNg/SMdu0oTdh0D/2xb8iHgHFyH7fmH90WYrNn/U+znPsNUWsM5AsKxoBUC
         vVFKe4LUjup9xTgkizKTwyQ0mp3tl+y8Welh9N/GllG4VLXKlxXHjSr9F6k+N7aS+Mdu
         brRhX1nAh2aZFrsppZeJGN+BzJyK3Lq86tRW/+cuA0RgpK9vhrG7icHwQdZTE/6WgEzE
         i9QfGI97QzeIy4v9j5Ft+ogMFQd85zLlT19K8GDYCEQMP+XrX3bHBWhIxegbA2Ze1qk9
         Tp4ZMNmBt1B0C5WbcpAKgxOqrlvbotQ7CtwkSesdW9/OtKZup/VpnJtb/cWiuTEdTFjl
         3sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R6lEVGZYGJxxHN7lE3eo9NqLzCsnQCicun988jWmqf0=;
        b=EwNPVn8nMEGyvWsjewJm8YCYfTCCdXKGSiBSvarltcJr7esPxT5yVQBYHVTMwyOV7n
         KIqxHIfKqieDYPrspJoBTw8cg9BMrED88OQ/WrlJHMPCsZT8w+LNGTTSpN3GL/LCFaXD
         YcnOkn9EZu7vpG9qO8uKXdbYuMf5K9qvRoJMcLeMkSm1u8afKZ28aaVzlkEjN0SqS91K
         GZTqXrnzNBXkD5KhyxtBTLpl/zgAvQf/rmDsUlqWvsYCkfrALaIdGt7Zaa7gmchr+iiw
         0aLibXchnF1jyqEMmvAeL8+QLJzVFMHI8dhrgOfrCfZRbbruuVfntWOUEd08drq6r0rd
         X2jA==
X-Gm-Message-State: AOAM532RecM96POZk8U/FlYmrTmry19iNxJIRujlT+abIxnj0ON7GsnZ
        5XxOvHy9T29Yor4N2hSMa73HXYR5I+E63wVW8/tgeg==
X-Google-Smtp-Source: ABdhPJxrRq5dz8jR0pX7TOEXl5+O6MeJ4s3D9zLb2o4VMf6+9QwUKNjv2xRDI0+UrWAaW8w3feNHDUNL6jPLIkqDsJg=
X-Received: by 2002:ac2:44bb:: with SMTP id c27mr2301161lfm.59.1591184732251;
 Wed, 03 Jun 2020 04:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <1591107505-6030-1-git-send-email-sumit.garg@linaro.org>
 <1591108981.4253.17.camel@linux.ibm.com> <CAFA6WYOoMdLJ2g3gocZBZWdu-7Nfw7LKHnzX8S8FKeC7cuNwYg@mail.gmail.com>
 <CAKrSGQSLKpb8T=H9zUoPP1B6EFrgMTMP3ZX1pEv99JtdPq7H0w@mail.gmail.com>
In-Reply-To: <CAKrSGQSLKpb8T=H9zUoPP1B6EFrgMTMP3ZX1pEv99JtdPq7H0w@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 3 Jun 2020 17:15:20 +0530
Message-ID: <CAFA6WYOFO8YptYp2JrY7nQL0MeM02VLCHvtnxUCEDd5-fb-z+Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Introduce TEE based Trusted Keys support
To:     Luke Hinds <lhinds@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 3 Jun 2020 at 14:20, Luke Hinds <lhinds@redhat.com> wrote:
>
>
>
> On Wed, Jun 3, 2020 at 9:08 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>>
>> On Tue, 2 Jun 2020 at 20:14, James Bottomley <jejb@linux.ibm.com> wrote:
>> >
>> > On Tue, 2020-06-02 at 19:48 +0530, Sumit Garg wrote:
>> > > Add support for TEE based trusted keys where TEE provides the
>> > > functionality to seal and unseal trusted keys using hardware unique
>> > > key. Also, this is an alternative in case platform doesn't possess a
>> > > TPM device.
>> >
>> > So here's a meta problem: in the case when the platform possesses both
>> > TEE and TPM  what should it do?
>>
>> IMO, trust source (either a TPM or a TEE) should be unique and
>> carefully chosen as per platform security policy corresponding to a
>> particular threat model.
>>
>> And moreover TEEs have been mostly used in the embedded world where
>> having a hardware TPM is cumbersome given constraints regarding BoM
>> cost and hardware resources.
>>
>> >  Things like this:
>> >
>> > > --- a/security/keys/trusted-keys/trusted_core.c
>> > > +++ b/security/keys/trusted-keys/trusted_core.c
>> > > @@ -25,6 +25,8 @@
>> > >
>> > >  #if defined(CONFIG_TRUSTED_TPM)
>> > >  static struct trusted_key_ops *trusted_key_ops =
>> > > &tpm_trusted_key_ops;
>> > > +#elif defined(CONFIG_TRUSTED_TEE)
>> > > +static struct trusted_key_ops *trusted_key_ops =
>> > > &tee_trusted_key_ops;
>> > >  #else
>> >
>> > Say it's either/or at a Kconfig level: so if you select both TEE and
>> > TPM based trusted keys at compile time, we intall the TPM ops and
>> > ignore the TEE ops, is that right?  Surely this should be runtime
>> > selectable based on what the platform has ...
>>
>> This dynamic selection was already part of v4 patch-set but after
>> objection from Jarrko here [1], I switched to compile time mode
>> instead.
>>
>> [1] https://lkml.org/lkml/2020/6/2/139
>
>
> Unless I have misunderstood, my concerns about compile time are that distributors will be cornered into releasing kernels with an opinionated selection of either TEE or TPM and any users needing the non default will need to compile their own kernel.
>

I echo with your concerns.

Jarrko,

If it's fine with you then I can switch back to dynamic approach again
in the next version.

-Sumit

>>
>>
>> > perhaps it should even be
>> > selectable per key?
>> >
>> > Once it is runtime selectable, what should be selected in the both
>> > case?  Or should we allow the user to decide, if so, how?
>> >
>> > when you pipe a trusted key, I think the subtype (TEE or TPM) should be
>> > part of the piped information, so it loads again seamlessly.  This
>> > would actually be fixed by something like the ASN.1 scheme I'm trying
>> > to upstream, at least for TPM keys, but do TEE keys have a recognized
>> > ASN.1 format?
>> >
>>
>> I guess this is something which we can refine later if there are real
>> platforms that have a particular security requirement to support both
>> TPM and a TEE.
>>
>> -Sumit
>>
>> > James
>> >
>>
>
