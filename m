Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3479C678D4
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Mar 2023 17:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjCBRwN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Mar 2023 12:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCBRwM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Mar 2023 12:52:12 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C1539BA5
        for <linux-security-module@vger.kernel.org>; Thu,  2 Mar 2023 09:52:11 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id cy23so159005edb.12
        for <linux-security-module@vger.kernel.org>; Thu, 02 Mar 2023 09:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677779529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5aFcQHv0N7yL7akZl+srFSiIjdpFMlk0jHiL9q2NCU=;
        b=Rg0CNtgX0eLMgdHgQfPOud2SKsPZqOhhVKlMy0ALZrL/PHjt/MVnWeuBIBz3oznil8
         n2igdVoUYYnz9o9meqnpj07f/GNys7NpBg7aaiI9JwdK5uF7yecJ2qT9EUUy+7x54Ya1
         qvVGdXUZ7F+oR+IKyvKYNwqUGp1/67jnibc+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677779529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5aFcQHv0N7yL7akZl+srFSiIjdpFMlk0jHiL9q2NCU=;
        b=F+kUeK73S2srD6GHWTgd6HTdxVaBODrJ7O6QF95T7tGxm2YRJTFiDiuGyiY/1nnM4C
         yaN6VBkhNxXMtYTrsD4RYSoMI4YE1SWOeO+X+9q4shaHMOW22Eo9yijZREq9R86YsxR7
         yDDxVAmK82U3OyGDWnLoljNSsGLfKlXhRqPY7BcKuywuktrrK3c58EuRrVj3C++liR58
         0klHPqaHfb5ohFYWCUNhewEEyyYcbjGKUaHJ61ptAz5aJiu75/vkqzIYXWTxIW30F/2m
         EuP5dWgNVIdnX4QioUn1uR2KVDkPuvzpJqsbTaLUEXXZJSyddRXv92gsjYeOc/6/hPY7
         M6KA==
X-Gm-Message-State: AO0yUKXN7ktwmexYk1u/D8VjBwJ1475dAwmopkaLlXltqt+I0iezcBdB
        Zccyks67vHPUBrAr8XeieI/IFaR+BmG8KmWs5mE=
X-Google-Smtp-Source: AK7set/9nohSz/w3IXZlzr8BUa+uRP5RUu9PyIw/PzrmRPiSrLaG51iGzbdx3xZpxFE8ZUm5S9S9qQ==
X-Received: by 2002:a17:906:cf91:b0:8b8:c04f:c5f9 with SMTP id um17-20020a170906cf9100b008b8c04fc5f9mr13941051ejb.73.1677779529391;
        Thu, 02 Mar 2023 09:52:09 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id g26-20020a170906199a00b008ea8effe947sm7351714ejd.225.2023.03.02.09.52.06
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 09:52:06 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id u9so382787edd.2
        for <linux-security-module@vger.kernel.org>; Thu, 02 Mar 2023 09:52:06 -0800 (PST)
X-Received: by 2002:a17:906:2ec8:b0:877:747e:f076 with SMTP id
 s8-20020a1709062ec800b00877747ef076mr5367831eji.0.1677779526028; Thu, 02 Mar
 2023 09:52:06 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com> <20230125155557.37816-2-mjguzik@gmail.com>
 <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com> <20230302083025.khqdizrnjkzs2lt6@wittgenstein>
In-Reply-To: <20230302083025.khqdizrnjkzs2lt6@wittgenstein>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Mar 2023 09:51:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
Message-ID: <CAHk-=wivxuLSE4ESRYv_=e8wXrD0GEjFQmUYnHKyR1iTDTeDwg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
        serge@hallyn.com, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 2, 2023 at 12:30=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Fwiw, as long as you, Al, and others are fine with it and I'm aware of
> it I'm happy to pick up more stuff like this. I've done it before and
> have worked in this area so I'm happy to help with some of the load.

Yeah, that would work. We've actually had discussions of vfs
maintenance in general.

In this case it really wasn't an issue, with this being just two
fairly straightforward patches for code that I was familiar with.

              Linus
