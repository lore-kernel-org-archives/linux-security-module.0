Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEB3C07E95
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Jul 2021 19:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D12CD61C6D
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Jul 2021 19:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhGGTec (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Jul 2021 15:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGGTec (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Jul 2021 15:34:32 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32A7C061574
        for <linux-security-module@vger.kernel.org>; Wed,  7 Jul 2021 12:31:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id s15so4868059edt.13
        for <linux-security-module@vger.kernel.org>; Wed, 07 Jul 2021 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPg1H7me9qbdg7UVxK09AOFutkX6+2jjmGZLpP+9rFE=;
        b=Gk8b0Lglm9tXpIUGTSA+BdAdYFO01tU4/ih0LElLxUv84iB5oXNSeu91aDRJ/CLOd2
         hJCmRSTZ03TY7odHpSknbfl7YLtvbiU4e0ZAVnWMlHzlY4eKn29VkADWqWGvZgDIUHS2
         qr8tUuOReXID4F77MCK1ebc5hdK98+Fqzg0GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPg1H7me9qbdg7UVxK09AOFutkX6+2jjmGZLpP+9rFE=;
        b=trUpULEuyCaVgV0D46Q0Q6+qJ2vnjFpGw9x7HRorYHsFlf3gD+Yf23KS0YylksPaii
         XWk8s9ofP3S1cPAmoUukYtKncpKDXKGM3PhriPboEl2T0No88JRXXkb4BeT9rT0b4Si2
         XlZSpF5PK/upXNfaZkBpuky7+qGDdZNouNldAdczWl532FI/07LJLaBXiYTGbboMAqZ+
         0NdJ/+X4BfV5g0M1fW3Qh4guoYwFJwQ1RjMLiPl5OhwSBrkAlZieYpk3rZtMo//EwY3U
         MZChw9yIYhCcVLDKxLRv8UOBHL4Yj/9AE+7pU5OgYoumysEwtWNjSsdMnkZpx0mN/5pr
         KbTw==
X-Gm-Message-State: AOAM533hFno+TRqzOhWyI9JSubSR+vuyUngxmduzeVqCYPKNvkXbqPaB
        38tvNU7zo6bdjlEti6qz6nwwRNdHjOHP4Rs3Pqo=
X-Google-Smtp-Source: ABdhPJzXby6TN3oKtVJM5COvlJ8Sdaxhi+juXQ28m/1WBVYlw2AuPVdWof355UNh1LPXoenE/S8oZw==
X-Received: by 2002:a05:6402:c10:: with SMTP id co16mr31484912edb.192.1625686310138;
        Wed, 07 Jul 2021 12:31:50 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id d13sm12828edz.53.2021.07.07.12.31.50
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 12:31:50 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id f17so4354524wrt.6
        for <linux-security-module@vger.kernel.org>; Wed, 07 Jul 2021 12:31:50 -0700 (PDT)
X-Received: by 2002:a2e:b55b:: with SMTP id a27mr9830494ljn.251.1625686299582;
 Wed, 07 Jul 2021 12:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210707024403.1083977-1-eric.snowberg@oracle.com> <20210707024403.1083977-6-eric.snowberg@oracle.com>
In-Reply-To: <20210707024403.1083977-6-eric.snowberg@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Jul 2021 12:31:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEncBgRdv0FZjmZGQP5tzcdYA0XJrxmBEOevi06dimtw@mail.gmail.com>
Message-ID: <CAHk-=wgEncBgRdv0FZjmZGQP5tzcdYA0XJrxmBEOevi06dimtw@mail.gmail.com>
Subject: Re: [PATCH RFC 05/12] integrity: Introduce mok keyring
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        scott.branden@broadcom.com, Wei Yongjun <weiyongjun1@huawei.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, nramas@linux.microsoft.com,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Jones <pjones@redhat.com>, Gary Lin <glin@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 6, 2021 at 7:45 PM Eric Snowberg <eric.snowberg@oracle.com> wrote:
>
> Introduce a new keyring called mok.  This keyring will be used during
> boot. Afterwards it will be destroyed.

Already discussed elsewhere, but yeah, when using TLA's, unless they
are universally understood (like "CPU" or "TLB" or whatever), please
spell them out somewhere for people who don't have the background.

I saw that you said elsewhere that MOK is "Machine Owner Key", but
please let's just have that in the sources and commit messages at
least for the original new code cases.

Maybe it becomes obvious over time as there is more history to the
code, but when you literally introduce a new concept, please spell it
out.

           Linus
