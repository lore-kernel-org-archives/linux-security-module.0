Return-Path: <SRS0=08hy=RP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF93C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Mar 2019 00:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACC32084F
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Mar 2019 00:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dX1i2jSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfCLAmu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:42:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34801 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfCLAmu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 Mar 2019 20:42:50 -0400
Received: by mail-io1-f68.google.com with SMTP id n11so586751ioh.1
        for <linux-security-module@vger.kernel.org>; Mon, 11 Mar 2019 17:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvqMwPmDKPaOeSABeD2s16ykBRIp+PzgwWPBhWyxVEQ=;
        b=dX1i2jSKZA4k2wZVaRbGVlOezSHggBIsV5kLw8RrBaLOPLmspsgVoGcvMJqguCUerK
         ZXjOxBHo+QUaUq4URYfyldyG5Zzv4kty3PoFduEHaz82xy9+mwA7lL+SswBTN+qVf32A
         7M/5ic/YrrJdBRgbpDsy0GXoINrmb2d5RicvwHT2FtsrrVZb5TItDhbpVkZLczf0ElO9
         bQ3I7ITpjH8owFH7XEzYfZqnsBDDsjeei2t05ThBeLUKWUiqt0OtEqEhQ3df9Iub7Mv9
         430dYIwg2VG4LNI/gqwxbfjgyXBz6BSUFfTnUOcoiYHDlu+ym45B5n6bGbcw2PcAPQGf
         ETPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvqMwPmDKPaOeSABeD2s16ykBRIp+PzgwWPBhWyxVEQ=;
        b=qRkK/DkMoILLb5kN5SCluQPVDbNPkjOtzS0sVo23remPKA4HcUpgiqWue73hrMC90X
         bGHv1moq0x0GPose71WVJG437Boe6zJ6u7uj6oNMuK++qBurnyI+yoxsCoNtMSzCrgi6
         0uyS3j74rOPLjPt6IYDriHVwJpK/rAKvnoyAlnwzQGoRhPy7KGOYvX7wTXRVir19TxgM
         3sEfZMv6sXZBHdfK73fs40GYfzzagKrPBrIpLhmDKXOO88142847T+Kn9ygxhKTjdW+B
         Wp2xQUMvdvRIAUpmM/D/p95KcjEEnM6Ef3S2KoYfvCPrVXyd4rKWjiuRTV+mKMCGxSQ2
         KWCQ==
X-Gm-Message-State: APjAAAUhQydd0NNf7gjTECYbl2Ikgyu3f8p1qCBgMhCnbBLmMU5nPCrh
        SNBOWEMECsNo9hxm/nv06TxzKcL6ZUu4shnloTanrQfpl3s=
X-Google-Smtp-Source: APXvYqxPE3Y0ZduynIOXnYlimlXcEVFvYKo6rh21YlcvE9mHTDddoOF7IceyW08WfpqyGbLMKJEYYcdH3a0XqfZrOeE=
X-Received: by 2002:a5e:c901:: with SMTP id z1mr3331209iol.304.1552351369117;
 Mon, 11 Mar 2019 17:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
 <1551930990.31706.279.camel@linux.ibm.com> <CACdnJuuib7kYEw1o0Bh1p=X+MmJH+pqupECWnWTJ2e2jE2XRkg@mail.gmail.com>
In-Reply-To: <CACdnJuuib7kYEw1o0Bh1p=X+MmJH+pqupECWnWTJ2e2jE2XRkg@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 11 Mar 2019 17:42:38 -0700
Message-ID: <CACdnJuszfo4gTUD88p+8jeHU5e3hSdp+GEr8_=F1AMThPb7yWg@mail.gmail.com>
Subject: Re: [PULL REQUEST] Kernel lockdown patches for 5.2
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 6, 2019 at 8:24 PM Matthew Garrett <mjg59@google.com> wrote:
>
> On Wed, Mar 6, 2019 at 7:56 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > The kexec and kernel modules patches in this patch set continues to
> > ignore IMA.  This patch set should up front either provide an
> > alternative solution to coordinate the different signature
> > verification methods or rely on the architecture specific policy for
> > that coordination.
>
> Hi Mimi,
>
> I'm working on a patch for this at the moment which can then be added
> to either patchset. Is there a tree that contains the proposed Power
> architecture policy? I want to make sure I don't accidentally end up
> depending on anything x86.

I've been digging into this some more, and want to ensure that I get
the appropriate semantics. Are we happy with the x86 solution for
module signing (ie, if the arch policy is enabled and the kernel
supports module signatures, use module signatures rather than IMA
signatures)? If so, that just leaves kexec. For platforms that support
PE signing for kernels (x86 and arm), are we ok punting to that? If so
then to maintain the semantics we have for lockdown in general (ie, no
way for a user to modify ring 0 code) then I think that would mean
allowing kexec_file() only when the following criteria are met:

1) IMA is appraising kexec with digital signatures, either ima digital
signatures or ima hashes with associated EVM digital signatures
2) CONFIG_INTEGRITY_TRUSTED_KEYRING is set in order to prevent an
attacker being able to add a key to the keyring

Does this sound reasonable? Are there any further criteria that are
required for this?
