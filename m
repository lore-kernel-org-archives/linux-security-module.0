Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087B7C7EE2D
	for <linux-security-module@archiver.kernel.org>; Sat,  3 Jun 2023 00:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbjFCACr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 2 Jun 2023 20:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbjFCACr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 2 Jun 2023 20:02:47 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DA3E42
        for <linux-security-module@vger.kernel.org>; Fri,  2 Jun 2023 17:02:44 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b1badb8f9bso1698501fa.1
        for <linux-security-module@vger.kernel.org>; Fri, 02 Jun 2023 17:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685750563; x=1688342563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIfddwJGgEUnwUCFA5IlnKSK6V7h4JvROQevxAQzNhk=;
        b=Xc3AyBTCKjaXrHR7Xn+gWHTG8qM31jMYo97046Wrqhe1Py0EkfgorGVdl7O+h8+E9L
         PaAZsESnLNkgwnMUxef6YPVRCpRivyvhVZ9fm2NvVOB11vXsyRO5P1OwgQUU1H/h8ieT
         aWMFYcJc91CVBIsodU5Pk+AT3AzlbRWZyKPhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685750563; x=1688342563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIfddwJGgEUnwUCFA5IlnKSK6V7h4JvROQevxAQzNhk=;
        b=EvckR1cOYIscc7BWeY1mzfs38cRRHKDMMNHAmQOQ41QquDICiq/qZT0asAUZWAd6Y+
         xMWo88Y6kW9klnS+zKZ9JMJO5I5GRndOXdjpkZOl47+5IUQzmzaBO4QHL5JaB0DyC1Wa
         sViNSF+6moFxT/7wqR4HeUEB5XrVnIdf14ZI/d1vie+zwQgkdUM1wpO5q0ZoB/PuvhgT
         J/21keOTCfF/qHu9tKHucm8vPiPHcpzMIKkeEWTLIrkIJVSwrLTIL9A9jb0MKbPiIqF+
         d2d834i15zHY/yHVwyJZfl/XgMJZQ2oPN8f6QvmjsGS6RDNLQhCGOLJKC5V+XeO4gh/Y
         uO7g==
X-Gm-Message-State: AC+VfDytYkL+Qkhusw4yCX12G9Z/KtHpK1G4CsbwV+kUw9rSIt4pBa12
        tShVAUsrrI4kBUiMVkJsoLaZ1Rqic3cwcfKvTRW2YVbt
X-Google-Smtp-Source: ACHHUZ5kKrY+GLfEpO78sVigDYW/BA+tzxs3cE68jnEQ8ngF06EEnfMRZZBq3f9Z79NYjPDIMK/m6g==
X-Received: by 2002:a2e:9f4f:0:b0:299:a7be:5775 with SMTP id v15-20020a2e9f4f000000b00299a7be5775mr853445ljk.35.1685750563017;
        Fri, 02 Jun 2023 17:02:43 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id w13-20020a2e300d000000b002af25598f07sm394940ljw.78.2023.06.02.17.02.40
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 17:02:41 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f4b80bf93aso3613590e87.0
        for <linux-security-module@vger.kernel.org>; Fri, 02 Jun 2023 17:02:40 -0700 (PDT)
X-Received: by 2002:ac2:52ba:0:b0:4f2:7b65:baeb with SMTP id
 r26-20020ac252ba000000b004f27b65baebmr2458573lfm.53.1685750560415; Fri, 02
 Jun 2023 17:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com> <CAHk-=wj4S0t5RnJQmF_wYwv+oMTKggwdLnrA9D1uMNKq4H4byw@mail.gmail.com>
In-Reply-To: <CAHk-=wj4S0t5RnJQmF_wYwv+oMTKggwdLnrA9D1uMNKq4H4byw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2023 20:02:23 -0400
X-Gmail-Original-Message-ID: <CAHk-=wgCUzRNTg4fC8DF=UFnznK0M=mNUBDcsnLt7D4+HP2_1Q@mail.gmail.com>
Message-ID: <CAHk-=wgCUzRNTg4fC8DF=UFnznK0M=mNUBDcsnLt7D4+HP2_1Q@mail.gmail.com>
Subject: Re: [GIT PULL] Asymmetric keys fix for v6.4-rc5
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 2, 2023 at 1:38=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The patch re-uses the allocation it already does for the key data, and
> it seems sane.

Ugh. I had to check that it was ok to re-use the key buffer, but it
does seem to be the case that you can just re-use the buffer after
you've done that crypto_akcipher_set_priv/pub_key() call, and the
crypto layer has to copy it into its own data structures.

I absolutely abhor the crypto interfaces. They all seem designed for
that "external DMA engine" case that seems so horrendously pointless
and slow.  In practice so few of them are that, and we have all those
optimized routines for doing it all on the CPU - but have in the
meantime wasted all that time and effort into copying everything,
turning simple buffers into sg-bufs etc etc. The amount of indirection
and "set this state in the state machine" is just nasty, and this
seems to all be a prime example of it all. With some of it then
randomly going through some kthread too.

I still think that patch is probably fine, but was also going "maybe
the real problem is in that library helper function
(asymmetric_verify(), in this case), which takes those (sig, siglen,
digest, digestlen) arguments and turns it into a 'struct
public_key_signature' without marshalling them.

Just looking at this mess of indirection and different "helper"
functions makes me second-guess myself about where the actual
conversion should be - while also feeling like it should never have
been done as a scatter-gather entry in the first place.

Anyway, I don't feel competent to decide if that pull request is the
right fix or not.

But it clearly is *a* fix.

            Linus
