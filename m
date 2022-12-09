Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252E9C4332F
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Dec 2022 18:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLISPQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Dec 2022 13:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLISPP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Dec 2022 13:15:15 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A65A4334
        for <linux-security-module@vger.kernel.org>; Fri,  9 Dec 2022 10:15:14 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o12so5589362pjo.4
        for <linux-security-module@vger.kernel.org>; Fri, 09 Dec 2022 10:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGtkhaHKIrr5OpNYU4T9L+BnCs/0pP1qyXvWMaI760s=;
        b=6iTO86Yg/c+D/tyDbB1/u7VSMypyassCrDFcKnXQLmk+pJtNANCaCBZuPVolwpgZPD
         5nhxxtWuGJ2hOBupmq8Zp03kmnFxZTPpg4ncChc9D84/DYQEhZ6L78LuSbF4rg7/5ML+
         PHzcnP+a9LvHU+6LbXtQRNYCgdeZZP4Rsn2bGT97VZ3TYa9w4c5m1P0JrOjGxKzzkyQx
         zYy0WDCkxyrXBY2SRUWDt5YZ5/rAOeHt7q/EmCpBIX4Qc8ulYIKshX6FTvXnyGFniucB
         qdAnrLLt90D1lPP44uJhr8AnfFHJDV6Hf/XTPtyy0NYDd3GXcJn9j1Z0KMbiKPaXD8y9
         y9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGtkhaHKIrr5OpNYU4T9L+BnCs/0pP1qyXvWMaI760s=;
        b=jqEf/6L2JgtMa225RcgDPLI6Kn1hAs++asgMv8FfEcEZoiLGJZ0y6pi3orpS4+qUk3
         WdYjYwdOJu0+ZHehyOWMq/FPQxILXEAwtnVBoBOSic+QpxY437oC+1DztG44/96Gf323
         /cMyhyPacyfJX4f9zuioLx262lDDpINehQkhgDgz17ni8ghK1u4EE23tPwo/W3QZFZoi
         P1fhHWDflkbI7EZZ7xjq3nteqSV0C4Ia+UH+B8//rjBomENG7Fu7H54EWTH/3t5PW+Nl
         OytptQRnqmv0m2qCsGjYx05x34tv9UdVKHERinQtKeu+TThJXHluL5EHoOGbof8YwTM7
         U/SA==
X-Gm-Message-State: ANoB5plkx4cnQPrBZHjXAUp8ZIOaWk7S3HuK3T7ZVQQWIZL3z7AtHPwq
        BfS4pI4nS0Da42JiI+r39xy5My6kRCdZyjkdpkKF
X-Google-Smtp-Source: AA0mqf4XkzUN61EgDM5th316VM+D1Q3XG+pvsxXjlS+qJMhlXby8XRLO4K+xY63ljp1PmYb4MaI6gOJ3nG0Lf1RB7sE=
X-Received: by 2002:a17:90a:2f22:b0:219:8ee5:8dc0 with SMTP id
 s31-20020a17090a2f2200b002198ee58dc0mr31097837pjd.72.1670609714373; Fri, 09
 Dec 2022 10:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20221209160453.3246150-1-jeffxu@google.com>
In-Reply-To: <20221209160453.3246150-1-jeffxu@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 9 Dec 2022 13:15:03 -0500
Message-ID: <CAHC9VhQ2P0rif2hiVGMGafWXQyZqPQc-yGQDEzjEehH1gzWgSA@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] mm/memfd: introduce MFD_NOEXEC_SEAL and MFD_EXEC
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, keescook@chromium.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Dec 9, 2022 at 11:05 AM <jeffxu@chromium.org> wrote:
> From: Jeff Xu <jeffxu@google.com>
>
> Since Linux introduced the memfd feature, memfd have always had their
> execute bit set, and the memfd_create() syscall doesn't allow setting
> it differently.
>
> However, in a secure by default system, such as ChromeOS, (where all
> executables should come from the rootfs, which is protected by Verified
> boot), this executable nature of memfd opens a door for NoExec bypass
> and enables =E2=80=9Cconfused deputy attack=E2=80=9D.  E.g, in VRP bug [1=
]: cros_vm
> process created a memfd to share the content with an external process,
> however the memfd is overwritten and used for executing arbitrary code
> and root escalation. [2] lists more VRP in this kind.

...

> [1] https://crbug.com/1305411

Can you make this accessible so those of us on the public lists can
view this bug?  If not, please remove it from future postings and
adjust your description accordingly.

--=20
paul-moore.com
