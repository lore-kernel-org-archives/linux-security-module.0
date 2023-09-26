Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7BAE7F140
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Sep 2023 22:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjIZWj4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Sep 2023 18:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjIZWhz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Sep 2023 18:37:55 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C015263
        for <linux-security-module@vger.kernel.org>; Tue, 26 Sep 2023 14:23:16 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59f57ad6126so80467807b3.3
        for <linux-security-module@vger.kernel.org>; Tue, 26 Sep 2023 14:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1695763395; x=1696368195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvEGktDy6wVzsHKD7sbhO0JqQ1zPMg4qiAh3tOHA+/g=;
        b=bCIXZMLJA5wWRe9Lui102KzBEKXfl2XcEdGj4tt9DA/ZBUp27XbEuOcnV2xFbgEe1h
         od0lBnRIQA72IJl+gPnd2ocpZ+gi8q1F5fZSxDwZYhLvt/pEoN4blhk8g88Tpml9uBVX
         AiquYUzBPt5nVYETkE+vdLHbjKIROnsZIxe1cJ9MrOgGKOJtESGi7w+9xZMqAJPCHqB9
         e5kWxMM9EXoho/cIo7IaBH4eiIkdarC+qaF6Fc401HEZVv11lqay4pyWCGZJUx1laW1B
         08OhZ0iEswD6rJUL+nF9rYNvoUw0DMhiCfLaNwQu7d5EVSDJhJvhhkjQSGb0El/ECdCh
         btDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695763395; x=1696368195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvEGktDy6wVzsHKD7sbhO0JqQ1zPMg4qiAh3tOHA+/g=;
        b=mA2zcUmyKMmLv9yzWDAPbzdveLbA/YL1P9lvlMdKlMFNDIIM4CIL+ncUqH3k3qVnnU
         0+P/zFlaauIkH8RSCmZlCpvqnk73Z5/lXyHdLnIl0yiCW4KARQdabMzYjcpAb6Z//y1o
         KRMuBmb3gYtwSmmxF+wgdX7E6flbeoRDb7q8LsOj2WcqC6LqkteYoEVERRInQCKwzHI9
         +w/mC3P6dLPk5PH6FDaYOa0MY+2Q5AFh3SdSGby5j74qv4dC88YiMzSg7DzLEw3EmO6V
         X9JTBI4f1iuKVflumVtK57tQZfuqa4zgH3k/e6lcbmffRDEooZs/EDkaPcH7RQdiP/yA
         oIbA==
X-Gm-Message-State: AOJu0YygRc+dvDiGdG+mtYv1JBeRfYlSpEjdh8MDRvYMvzXT+8YPWeN/
        q83lkZ6+PE6SYEzcVocqLoalGDg/0FmFOTmUx9WV
X-Google-Smtp-Source: AGHT+IFSifY8rHWsv4ru2mx1UVdurLwMQssqx80hdP8CCE126cpTiZsmwmEZwqvNWwPuRfhNuW3XL2vD2eeHgauN9SM=
X-Received: by 2002:a0d:d515:0:b0:595:59f:28d7 with SMTP id
 x21-20020a0dd515000000b00595059f28d7mr191922ywd.48.1695763395674; Tue, 26 Sep
 2023 14:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <CAHC9VhQhf+ik5S_aJOVn59pax1Aa0vO5gJ4YoxrtGRKtoWh7sA@mail.gmail.com>
 <f8f32da5-6f31-d197-7405-8f308bd29228@I-love.SAKURA.ne.jp>
 <CAHC9VhTktg4RFWw+rSZ6wWQ8iR3n2p8XaOO95BbJ1QGAd4y9fg@mail.gmail.com>
 <43d84d6c-18ac-6689-cddc-d079cfa19d4d@I-love.SAKURA.ne.jp>
 <CAHC9VhSG2UzE9N0-tAJc8B3Mj1PEuJ2b6wso_DUs_Y83yqwhjA@mail.gmail.com>
 <c8d58922-9af4-b425-03c6-6710ad17b739@schaufler-ca.com> <CAHC9VhTdtF=_4nj3-eQvBUhWhnEss28KKUKCciBCrBL9pN+uQw@mail.gmail.com>
 <8912fc96-cb8e-ec3b-273d-6bd8ad6b5513@I-love.SAKURA.ne.jp>
 <202309241827.6818149EC8@keescook> <6e1c25f5-b78c-8b4e-ddc3-484129c4c0ec@I-love.SAKURA.ne.jp>
In-Reply-To: <6e1c25f5-b78c-8b4e-ddc3-484129c4c0ec@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Sep 2023 17:23:04 -0400
Message-ID: <CAHC9VhRmvyEOFLePc3fhQ0XPruzxwe-yrqTAyy8k1ATDz0t1SQ@mail.gmail.com>
Subject: Re: ANN: new LSM guidelines
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <kees@kernel.org>,
        linux-security-module@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 25, 2023 at 12:32=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Casey and Paul, do you agree to change your policy for assigning LSM ID ?

No LSM ID value is guaranteed until it is present in a tagged release
from Linus' tree, and once a LSM ID is present in a tagged release
from Linus' tree it should not change.  That's *the* policy.

--=20
paul-moore.com
