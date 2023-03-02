Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE14FC6FA8E
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Mar 2023 19:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjCBTEq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Mar 2023 14:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCBTEp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Mar 2023 14:04:45 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3119A7D9F
        for <linux-security-module@vger.kernel.org>; Thu,  2 Mar 2023 11:04:21 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id f13so1086474edz.6
        for <linux-security-module@vger.kernel.org>; Thu, 02 Mar 2023 11:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677783859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AnYuQNqFQzpvHhao5pD6YcV74LJjlnHRsuGa2HUaWQ=;
        b=SsugrDxTzxQaFR4GfzqNTP07kufWy48KpQ6Tgqx9YqxlSUMdjbwKXpsZfyQdfu19v7
         bLlUbt5oZ11YyQwxfAIPuCFCEcBAOdwB0hX8i282S4mGyermCha8uIDspd5yJEgf4sT7
         1BhWIOmng/AcxZVFVolW8cVBXu7aJI3tL4r6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677783859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AnYuQNqFQzpvHhao5pD6YcV74LJjlnHRsuGa2HUaWQ=;
        b=kx0hSDJm68Mjrj2Xz60lSoDC4VXK6DkNTFw/Oci+LQ7fFLbb6g99msCoGiOIdWdfNa
         ciJA4hM4FjY3mIClWe/xVItrfocJ5BQJwT4wBQM19MqWNHSqRK/PXOJSTFlNs6ahE2s2
         DViICF2xgYcHE8Xv8wQCeEvS6KCXAKcFlvvJ3H3+kr8j3ekU9Q+FFaDmrP9Qz++muLtm
         fKLxHey415U+j5KHixYb8bmYdcB/piwcUBoju7KWtAlmNYwcVb7TUeFHGLYJJQ3lD9O3
         bccno4mqQpQx+GBZj8PzLr3FLigrO7WzKBRitmRP9LU5EBMW7a/tbLtP8R8gTfWRwmsO
         YcOg==
X-Gm-Message-State: AO0yUKXPSKvqsIrZLEEA8JuWCNdDXgntEyKuuun/4vlnCHgWXeF948jS
        ysc+Qk207r8VQcwjBEVhKSKRy6zpIKpFJATteWk=
X-Google-Smtp-Source: AK7set8QSTOM0TnmQa6N/Rly1pB5MLIAi3rKtdRmpf4WVaRoJWjArUZf6wM7g7kKALyzBHttcmwHCA==
X-Received: by 2002:aa7:d555:0:b0:4a2:223d:4514 with SMTP id u21-20020aa7d555000000b004a2223d4514mr11830179edr.8.1677783859137;
        Thu, 02 Mar 2023 11:04:19 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id y64-20020a50bb46000000b004bc2d1c0fadsm227965ede.32.2023.03.02.11.04.16
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 11:04:17 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id g3so1197391eda.1
        for <linux-security-module@vger.kernel.org>; Thu, 02 Mar 2023 11:04:16 -0800 (PST)
X-Received: by 2002:a50:aa94:0:b0:4c2:1a44:642e with SMTP id
 q20-20020a50aa94000000b004c21a44642emr1116225edc.5.1677783856044; Thu, 02 Mar
 2023 11:04:16 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com> <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
 <20230302083025.khqdizrnjkzs2lt6@wittgenstein> <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
 <CAGudoHF9WKoKhKRHOH_yMsPnX+8Lh0fXe+y-K26mVR0gajEhaQ@mail.gmail.com>
 <ZADoeOiJs6BRLUSd@ZenIV> <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
In-Reply-To: <CAGudoHFhnJ1z-81FKYpzfDmvcWFeHNkKGdr00CkuH5WJa2FAMQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Mar 2023 11:03:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
Message-ID: <CAHk-=wjp5fMupRwnROtC5Yn+MVLA7v=J+_QJSi1rr3qAjdsfXw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 2, 2023 at 10:22=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> Ops, I meant "names_cache", here:
>         names_cachep =3D kmem_cache_create_usercopy("names_cache", PATH_M=
AX, 0,
>                         SLAB_HWCACHE_ALIGN|SLAB_PANIC, 0, PATH_MAX, NULL)=
;

That code just needs a __GFP_SKIP_ZERO.

It might be best if we actually exposed it as a SLAB_SKIP_ZERO thing,
just to make it possible to say - exactly in situations like this -
that this particular slab cache has no advantage from pre-zeroing.

This doesn't sound like a vfs issue, this is a hardening issue where
apparently people now use that INIT_ON_ALLOC_DEFAULT_ON in "real use"
and then you notice how horrid the performance impact can be.

But there might also be some possible interactions with KASAN etc.

Adding some hardening people to the cc.

           Linus
