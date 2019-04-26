Return-Path: <SRS0=T836=S4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4D8C43219
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Apr 2019 15:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57246205ED
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Apr 2019 15:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HkHXy+C7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfDZPsX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:48:23 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:44047 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfDZPsX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Apr 2019 11:48:23 -0400
Received: by mail-vk1-f196.google.com with SMTP id q189so864956vkq.11
        for <linux-security-module@vger.kernel.org>; Fri, 26 Apr 2019 08:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DMbwsVTmLlgBSQ3AQVV7zhO03Dui6VOqPccFtIRcq3Y=;
        b=HkHXy+C75uEgB5TiO0Vne0wSo5yn2vGUtsU6jybLTVPKSb1T63ZmEiaBDbN8EW2xbt
         +orApMccp/6S1dVqxvtK+NUcWVOU8I/1XVk+Qtw739qlHa/XZP65T1BcIBfO9BdGoccC
         Dv9NF52KGawfYlKqzj04fjUkc1RNle2VK64j/nT7U7kUIsvJ3IC583S0kjlc2cvuFvMd
         OiXjjj+S0umBivuYz1hJFjZwJe7zVlPL+1Rg/dra3jcpqHXzPVjNf5gjXsg/xAUZJOFO
         DVtZwIb+aZbKpqpHW9FBplGFNuNcBHbxoMSHzp3Noqf6PWAot9GfK80aZaPI8cRY23ii
         rkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DMbwsVTmLlgBSQ3AQVV7zhO03Dui6VOqPccFtIRcq3Y=;
        b=mODjlLEuxVtb0+dMjb29dW6l6S03QsOInK01qW0WPQlUUDhouzUANVNYESqUceTcpi
         5yPtgL5vM9IVaf/Rtk6AbiRIVRWRNRufZm9dDlQ7wJGQ1FLDE1DWwD19DgQIoBvn7E46
         RstKHn8ueMvSvcaEBv+eR0fjhR3NncnHOreEOSgbGypS9LNF1LoXaA1VYlBqGIR1iG44
         xG+BJqKvJhZm0zNHfr71XLtrX/LsJ4DbCp3NkSkiixkVFT+Olg/RyQwPABHuw0+GB7To
         ApMo4GH4g8WLPADtOE9CGB17qrdnfukegrFUyNL2dnpqBZX9rSEXGYhNY0zgVp4R3AZK
         wrHg==
X-Gm-Message-State: APjAAAXn+lFh3xBW1tOyC9FMs7KfrCBRUcSqyQYV6riIKx9TFL4viP+i
        WkhZnNpnaAzTEGvfuRdqEz7KHfrBgymAECzcVOD81Q==
X-Google-Smtp-Source: APXvYqx79Ste/jagBrDiXzEeRcMMHgTKLywIMfjMi3Q+uv4eDclN5Z45Fkcx93NdwD001hssuNLIENwwifs2h9i9o8Q=
X-Received: by 2002:a1f:9487:: with SMTP id w129mr21556719vkd.29.1556293702099;
 Fri, 26 Apr 2019 08:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190418154208.131118-1-glider@google.com> <20190418154208.131118-2-glider@google.com>
 <alpine.DEB.2.21.1904260911570.8340@nuc-kabylake> <0100016a5a3f6121-e7ed483e-bc29-4d75-bd0a-8e3b973529f5-000000@email.amazonses.com>
In-Reply-To: <0100016a5a3f6121-e7ed483e-bc29-4d75-bd0a-8e3b973529f5-000000@email.amazonses.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 26 Apr 2019 17:48:10 +0200
Message-ID: <CAG_fn=Uj226XJqh_wErBLW6dLvp_eP_KaEJDuqxBhvag1Q=Jwg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: security: introduce the init_allocations=1 boot option
To:     Christopher Lameter <cl@linux.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Apr 26, 2019 at 5:24 PM Christopher Lameter <cl@linux.com> wrote:
>
> Hmmmm.... Maybe its better to zero on free? That way you dont need to
> initialize the allocations. You could even check if someone mucked with
> the object during allocation.
As mentioned somewhere in the neighboring threads, Kees requested the
options to initialize on both allocation and free, because we'll need
this functionality for memory tagging someday.
> This is a replication of some of the
> inherent debugging facilities in the allocator though.
I'm curious, how often do people use SL[AU]B poisoning and redzones these d=
ays?
Guess those should be superseded by KASAN already?
I agree it makes sense to reuse the existing debugging code, but on
the other hand we probably want to keep the initialization fast enough
to be used in production.
>
Re: poison_fn, it wasn't a good idea, so I'll be dropping it.

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
