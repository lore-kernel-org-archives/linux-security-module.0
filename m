Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411F6C7EE29
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Jun 2023 17:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbjFBRis (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 2 Jun 2023 13:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbjFBRir (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 2 Jun 2023 13:38:47 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A0A1B8
        for <linux-security-module@vger.kernel.org>; Fri,  2 Jun 2023 10:38:46 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96fab30d1e1so505910666b.0
        for <linux-security-module@vger.kernel.org>; Fri, 02 Jun 2023 10:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685727524; x=1688319524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPpIUifsrj3WhrOLcjmDKG+n28eYiyTfgghRaS6XkRs=;
        b=UvCO7b36trGYA7jPwC4uUnaAo8v+TtUCL0eyfuINNpnEdHdEHS6eUmhhkP+WyhUdjn
         Oxqh3nfxL/QQ7wnOazvNrAp+kr6eSrklf6VqYQSws208yzwJXB3ATpZelSTTnkN0CJK7
         ILnk5hxIXlC3oknVRYnPQJqkz/MzEfFbg/l3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685727524; x=1688319524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPpIUifsrj3WhrOLcjmDKG+n28eYiyTfgghRaS6XkRs=;
        b=gbh8SkHz3cLQydOINIQxCpF9OzQIxyLIHYySTM1RCkeSH+QuvS+Oh/FwJDd1M3iwpD
         mXIkSzcscq1ZhFr7snMPGnCs2KsnhxDj3pAXe8Dhx+NvREHHmxQA/LnP6AZg61io9jT4
         UnHdzBroXQC25kGbtUYc7ejeh9XZWI2EOE5vFsXeVEeT4PtFjkNX+ZI/bhIi9DiL9E8O
         qjzy6TyztaqkXTJRGjD0sRAHekDGY0dwePExP1HTKDGHZmybi8reKTcS9on0pjh7ERCB
         WFZ9qfTgHV0RnCbqwglMgVuKy44b07uf7VYRCgXo0gaN98iGJJXrPWi1rWx6EqbeiQJM
         wv1w==
X-Gm-Message-State: AC+VfDw+T5ZZFjvfvao8Rjpc6mnYxibYtRfmA3+EKqysE0xBFOSnoprh
        fC4dgCYo2RNU1Fy+qifYCg+09kujJAoBqb2lLbj/UtfL
X-Google-Smtp-Source: ACHHUZ6JaxdOaxSniHBJflxP2HAEj1H1wkYbLB6hIOIPHElocvKbolTZPqYSaFCAVbpacUCW/f1ZDA==
X-Received: by 2002:a17:907:da9:b0:94e:4b26:233c with SMTP id go41-20020a1709070da900b0094e4b26233cmr6116894ejc.16.1685727524509;
        Fri, 02 Jun 2023 10:38:44 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id q19-20020a170906b29300b0094f23480619sm992677ejz.172.2023.06.02.10.38.43
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 10:38:44 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so7494334a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 02 Jun 2023 10:38:43 -0700 (PDT)
X-Received: by 2002:a05:6402:202e:b0:505:d16:9374 with SMTP id
 ay14-20020a056402202e00b005050d169374mr3588912edb.9.1685727523436; Fri, 02
 Jun 2023 10:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com>
In-Reply-To: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2023 13:38:26 -0400
X-Gmail-Original-Message-ID: <CAHk-=wj4S0t5RnJQmF_wYwv+oMTKggwdLnrA9D1uMNKq4H4byw@mail.gmail.com>
Message-ID: <CAHk-=wj4S0t5RnJQmF_wYwv+oMTKggwdLnrA9D1uMNKq4H4byw@mail.gmail.com>
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

On Fri, Jun 2, 2023 at 10:41=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> sorry for this unusual procedure of me requesting a patch to be pulled.
> I asked for several months the maintainers (David: asymmetric keys,
> Jarkko: key subsystem) to pick my patch but without any luck.

Hmm.

The patch behind that tag looks sane to me, but this is not code I am
hugely familiar with.

Who is the caller that passes in the public_key_signature data on the
stack to public_key_verify_signature()? This may well be the right
point to move it away from the stack in order to have a valid sg-list,
but even if this patch is all good, it would be nice to have the call
chain documented as part of the commit message.

> I signed the tag, but probably it would not matter, since my key is not
> among your trusted keys.

It does matter - I do pull from people even without full chains, I
just end up being a lot more careful, and I still want to see the
signature for any future reference...

DavidH, Herbert, please comment:

>   https://github.com/robertosassu/linux.git tags/asym-keys-fix-for-linus-=
v6.4-rc5

basically public_key_verify_signature() is passed that

     const struct public_key_signature *sig

as an argument, and currently does

        sg_init_table(src_sg, 2);
        sg_set_buf(&src_sg[0], sig->s, sig->s_size);
        sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);


on it which is *not* ok if the s->s and s->digest points to stack data
that ends up not dma'able because of a virtually mapped stack.

The patch re-uses the allocation it already does for the key data, and
it seems sane.

But again, this is not code I look at normally, so...

               Linus
