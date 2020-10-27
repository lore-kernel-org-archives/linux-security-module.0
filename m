Return-Path: <SRS0=YDB1=EC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D160C6369E
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Oct 2020 16:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C33D322264
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Oct 2020 16:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrFeVRKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1801810AbgJ0PoZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Oct 2020 11:44:25 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43618 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1799418AbgJ0PbZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Oct 2020 11:31:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id l28so2838520lfp.10;
        Tue, 27 Oct 2020 08:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fHBOxQ4ds2L5zAe+IuVRpnyZ/0NNh1Z4K/iPh0DplL0=;
        b=FrFeVRKYfjR60SUSEWYarWyVfbowL0Ud1Eji9GIT0h5PaTT8VDCPnslo8AaFuNtyTd
         jWYa1PiIUnDfYqal6c8SXQEGtn35Dx21FF1vpSXT/Btm2N9+/PYsVDp7eH9bU0f59QPY
         HXARwhnWZ8mHG6Me8oDKdLMsoWrWhpCPn802tusd2n260z0+Ji2TSVsZbPB3dojZQcre
         FMzxlua8ApZGgx/pHHhBci76Np9dDQWX7/3v8iziLolh76ZICVvcLICkNuqidccCVUJ8
         kIBYt1gFcoDUs80eLG3Kpj0NEfPuZB7bqQtufpYzTE2XOQepKo+kxYGjR6bCRzFbtDm/
         Lx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fHBOxQ4ds2L5zAe+IuVRpnyZ/0NNh1Z4K/iPh0DplL0=;
        b=dYOmeYo2MQqLAiD6bHUSem9hN3ZDOnXnGdPHkL167i9owALV3wqjWBIxzGikS9Idon
         Co1exfnMC15jTnokCHej5ZYVlyZM4jXz/r1Boj/ckaK0zRjxyXBcZaM6GFgzC4S48UB6
         CKv0WBYwEbPfetAOK86lj6ekd0nnnjfl+0qRhe0zZVq9OttPiSzvg4jzdTqZlf+SgXep
         ABmdOxSOjxUTWMOglM5Uf80hPlTNILLxbS7e4a3kg4/tDLfS5pt0Vi23HY8Zx03nJoj+
         6zNE5XCbG42bciGKcK8QZxCDy0baSd2hexddyxS9OcS1tfkOAw3oQh5Fcicc9ObB/5Si
         /jxg==
X-Gm-Message-State: AOAM531E0I6e0oqsSkiOXCwRNhgIZS9a9mO6wA52wbWrFn0lsbIAa33k
        yVBA8S6bVGED0Xjr7Db/6acFCFiuXkEZPIzzx1lOZnKMrDY=
X-Google-Smtp-Source: ABdhPJyNHgiM1WZV6kimlOxnv8sy1Xt8EYt2qlI4JysJ/j1JiAgXlQLt4MJyxmzzEcCrEQ+POBbOR25Kj72oKnNqHiE=
X-Received: by 2002:a19:7fc2:: with SMTP id a185mr970412lfd.84.1603812683068;
 Tue, 27 Oct 2020 08:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201026125227.54520-1-a.nogikh@gmail.com> <20201026125227.54520-3-a.nogikh@gmail.com>
In-Reply-To: <20201026125227.54520-3-a.nogikh@gmail.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Wed, 28 Oct 2020 00:31:11 +0900
Message-ID: <CAC5umyjZn+gtO=u8GhptVggzodbY-vnk9NNTOqyZyUW2up2ASQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] docs: add fail_lsm_hooks info to fault-injection.rst
To:     Aleksandr Nogikh <a.nogikh@gmail.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>, keescook@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

2020=E5=B9=B410=E6=9C=8826=E6=97=A5(=E6=9C=88) 21:52 Aleksandr Nogikh <a.no=
gikh@gmail.com>:
>
> From: Aleksandr Nogikh <nogikh@google.com>
>
> Describe fail_lsm_hooks fault injection capability.
>
> Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
> ---
> v2:
> - Added this commit.
> ---
>  Documentation/fault-injection/fault-injection.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/fault-injection/fault-injection.rst b/Document=
ation/fault-injection/fault-injection.rst
> index 31ecfe44e5b4..48705adfbc18 100644
> --- a/Documentation/fault-injection/fault-injection.rst
> +++ b/Documentation/fault-injection/fault-injection.rst
> @@ -48,6 +48,12 @@ Available fault injection capabilities
>    status code is NVME_SC_INVALID_OPCODE with no retry. The status code a=
nd
>    retry flag can be set via the debugfs.
>
> +- fail_lsm_hooks
> +
> +  injects failures into LSM hooks. When a fault is injected, actual hook=
s
> +  are not executed and a code from /sys/kernel/debug/fail_lsm_hooks/retv=
al
> +  is returned (the default value is -EACCES).

In addition to this global one, what do you think about per-hook fault
injection,
i.e. /sys/kernel/debug/fail_lsm_hooks/<FUNC>/retval ?

In this case, we need a fault_attr for each hook. (Maybe, we can use the sa=
me
technique that is used to define security_hook_heads).
