Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E9EC6FD1E
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Mar 2023 22:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjCJWfw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Mar 2023 17:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjCJWfe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Mar 2023 17:35:34 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CCD12C0FE
        for <linux-security-module@vger.kernel.org>; Fri, 10 Mar 2023 14:34:12 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id e194so6817765ybf.1
        for <linux-security-module@vger.kernel.org>; Fri, 10 Mar 2023 14:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678487632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEqMrbXf4+0rUojKZeV+/yCgoA9VPbTp19zx2WV07vA=;
        b=VN0pAvf6sUR96XBRDOxcDOZzkuEPTsnPMpkOyW6+8hPj8X4JptdaE1YRuDIt0EMzfD
         2gCGWpVzyOrFNtwUNTQ5sBb7vTQChtr6KBWLPMTfxRmQnZw6Ig1o/0SgoSSg+diKNYqA
         ZeKx75DxgneqlCWpeFSYarvBkULxvZvafnsaqMftPasaarzi31PUcFrxWsr8UKqN1qRW
         q2NocXpN1ipmKP39HLfVP12e7Lzjl+uoNTnxf0zsmV+YQk6iOp8dspJM3L6MhOKWkAtX
         ATmgiB9o/H6LBE4Nq2Ddm4ESKPwwIcCvrPVV25Q1sW47raVXVzW6RAdSpcfYmvjB8FFO
         hTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEqMrbXf4+0rUojKZeV+/yCgoA9VPbTp19zx2WV07vA=;
        b=ybRe2YlLlL6qwtTedB2tWJ4bYGyYx5maazqBxr/ndXhclvkv+ySI4/A6Abj8F3Jiv0
         AD32Arqd5g18hO+2mK0e/luLV248Xn+C81PdcekInZ+ylptzQyE6M4sx2vuelGvw6ej6
         gEnxAk+0uXxyLm7wxOB7oOhRXkXKgBIzgymzmqKxNaFb2WImuXzFbPhkBjnXduKbmkJd
         gP5X7wFfIcFH8eQjhfka/CPBx34rwZI7npfJ76S2uwZebrOUzsuKhFhlSTDjUPztisa6
         nM3HJKrOc5JX52f1i2SPCynZMF7jZpwbtgxi3x51Ehg6gm4otDjncL+Df8rff+euoAKm
         qdaQ==
X-Gm-Message-State: AO0yUKVGfgEwfF1sOSMKUK3IS3zNMfYITSUnawarDl24MC5P9UtBwlxz
        oorDHAjj/88qIRnj85IhFG4aoOT4Yj1CY+eU/ebt
X-Google-Smtp-Source: AK7set+T1Mnofqh3OrYW6OYLxLKBqekqP7LDRV8/1bf8W8w0FxiAqHqDBOusMIPzCxxXySZQ/lR8YBEQgQYMfvo/8UM=
X-Received: by 2002:a5b:f87:0:b0:b30:8d4b:230e with SMTP id
 q7-20020a5b0f87000000b00b308d4b230emr1663841ybh.7.1678487632489; Fri, 10 Mar
 2023 14:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20230310192614.GA528@domac.alu.hr>
In-Reply-To: <20230310192614.GA528@domac.alu.hr>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Mar 2023 17:33:41 -0500
Message-ID: <CAHC9VhSzppHevG_Td+hKU4KRSDgV_NYf2RSeKA06PR-rD+dJLw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add destructor hook to LSM modules
To:     Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Frederick Lawler <fred@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Mar 10, 2023 at 2:26=E2=80=AFPM Mirsad Goran Todorovac
<mirsad.goran.todorovac@alu.hr> wrote:
>
> LSM security/integrity/iint.c had the case of kmem_cache_create() w/o a p=
roper
> kmem_cache_destroy() destructor.
>
> Introducing the release() hook would enable LSMs to release allocated res=
ources
> on exit, and in proper order, rather than dying all together with kernel =
shutdown
> in an undefined order.
>
> Thanks,
>         Mirsad
>
> ---
>  include/linux/lsm_hooks.h | 1 +
>  security/integrity/iint.c | 7 +++++++
>  2 files changed, 8 insertions(+)

I only see the 1/2 patch, did you send the 2/2 patch to the LSM list?
If not, you need to do that.

--=20
paul-moore.com
