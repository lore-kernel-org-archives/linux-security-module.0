Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D867C64EC7
	for <linux-security-module@archiver.kernel.org>; Tue, 28 Feb 2023 20:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjB1Ut2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 28 Feb 2023 15:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjB1UtZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 Feb 2023 15:49:25 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E8B35262
        for <linux-security-module@vger.kernel.org>; Tue, 28 Feb 2023 12:49:17 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id d30so45451620eda.4
        for <linux-security-module@vger.kernel.org>; Tue, 28 Feb 2023 12:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677617356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtXAIoXvfiyUjZh/JqW45RZBaGUEv0yeFwHGzzsBvFc=;
        b=BqPLg4e0P5XceC6DuLMXjbNjtwfFBQZUvrIzJKKJ2YILg/egsIgykSSGRRHoMXgd93
         s4z6+PCjGm1hOpODiIf4nM12zkW8nFvL6ib8hT2DiU21goJ3EgqqP86tS9h8M5yGgr4V
         B5l3f8JhoRMXC+EwxCFI0HM3NNC6HC+BT/SfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677617356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtXAIoXvfiyUjZh/JqW45RZBaGUEv0yeFwHGzzsBvFc=;
        b=qQHaG/tOFE0/0J+CAlI/i/htDGdrZfuS5PxjYcGhgOQr5U7kLvTgvDtukUwncy9nLk
         bZtnWLNCRPKkok7dDF8qyzal9NjRlQrPB2L6UEGFiR6/Dt7zLSMDH56ZY3yKrMpEh6yN
         muvceoRgg3DQ+WlFtrB/0BvT+pRabk++++8PiQix4kGytySB7urNb6e6aVkpdiFUz3iA
         Qc997CM5At3gDnSYcF6bqx2FEjUKB4nzdT6ODTOi1yh3HxpGMvGxA4bsRcX6rCVYmJGK
         9EG1PL8Ku9MLRnW8wiDaTdRPbiL54EGTKBJiZivibTGVE5NV6kiiP0ab1BdH+lBt2ljC
         MVhg==
X-Gm-Message-State: AO0yUKWK5RpZW1Eodi3dY51gLIKCOaNwi7Akn+M4ooRdgtQL73RHsIQE
        8z73Kwhf3UYzyj3y+3taRvtjtBolq4sebpSck/Q=
X-Google-Smtp-Source: AK7set+d3eSIqpU9NBYNMzl97ODbAOqy/kCO9+6T9DuuaGeO2EBtPx8TCo1p9hcii0upsAfEzTwVtA==
X-Received: by 2002:a05:6402:1117:b0:4ad:7224:ce94 with SMTP id u23-20020a056402111700b004ad7224ce94mr5460761edv.15.1677617356221;
        Tue, 28 Feb 2023 12:49:16 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id m30-20020a50d7de000000b004acb3026af2sm4840314edj.59.2023.02.28.12.49.15
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 12:49:15 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id ck15so45658029edb.0
        for <linux-security-module@vger.kernel.org>; Tue, 28 Feb 2023 12:49:15 -0800 (PST)
X-Received: by 2002:a05:6402:500b:b0:4af:70a5:5609 with SMTP id
 p11-20020a056402500b00b004af70a55609mr3449762eda.1.1677617354960; Tue, 28 Feb
 2023 12:49:14 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com> <CAHk-=wjz8O4XX=Mg6cv5Rq9w9877Xd4DCz5jk0onVKLnzzaPTA@mail.gmail.com>
 <97465c08-7b6e-7fd7-488d-0f677ac22f81@schaufler-ca.com> <CAGudoHEV_aNymUq6v9Trn_ZRU45TL12AVXqQeV2kA90FuawxiQ@mail.gmail.com>
 <CAHk-=wgCMTUV=5aE-V8WjxuCME8LTBh-8k5XTPKz6oRXJ_sgTg@mail.gmail.com>
In-Reply-To: <CAHk-=wgCMTUV=5aE-V8WjxuCME8LTBh-8k5XTPKz6oRXJ_sgTg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Feb 2023 12:48:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=whwBb5Ws8x6aDV9u6CzMBQmsAtzF+UjWRnoe9xZxuW=qQ@mail.gmail.com>
Message-ID: <CAHk-=whwBb5Ws8x6aDV9u6CzMBQmsAtzF+UjWRnoe9xZxuW=qQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] capability: add cap_isidentical
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Serge Hallyn <serge@hallyn.com>, viro@zeniv.linux.org.uk,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 28, 2023 at 11:39=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This actually looks sane enough that I might even boot it. Call me crazy.

LOL.

I had to go through the patch with a find comb, because everything
worked except for some reason network name resolution failed:
systemd-resolved got a permission error on

    Failed to listen on UDP socket 127.0.0.53:53: Permission denied

Spot the insufficient fixup in my cut-and-paste capget() patch:

  kdata[0].effective   =3D pE.val;
        kdata[1].effective   =3D pE.val >> 32;
  kdata[0].permitted   =3D pP.val;
        kdata[1].permitted   =3D pP.val >> 32;
  kdata[0].inheritable =3D pI.val;
        kdata[0].inheritable =3D pI.val >> 32;

Oops.

But with that fixed, that patch actually does seem to work.

             Linus
