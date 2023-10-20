Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA72CDB474
	for <linux-security-module@archiver.kernel.org>; Fri, 20 Oct 2023 13:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376984AbjJTNSq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 20 Oct 2023 09:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376933AbjJTNSq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 Oct 2023 09:18:46 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132B41A8
        for <linux-security-module@vger.kernel.org>; Fri, 20 Oct 2023 06:18:44 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9c603e2354fso176913266b.1
        for <linux-security-module@vger.kernel.org>; Fri, 20 Oct 2023 06:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1697807922; x=1698412722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RjDLc0f7CsZ3ZAhf+7oO+KfDgSRyr9/BS+BP5jxyc4=;
        b=KUOW6tHoH0YoRWmfTiYARPJh3y1s6CDX5alQWBN3z01Pox70KX1YmMeO4X8gmj80tz
         K4RAjFE7F6eu6sKWA8DNl5+VOzXiOhmW2Purw1TYWmojIpSfMpme5ITPOvFlXJW6gkOs
         RUxubMSHkKeGzfJUt/vfeX5Uvqu3tle5S0pJ1kJxeDkH9ty7a5MtTh6X0UWOjNkr/NSy
         GR2ERAP5mG5IONJh4g0dqFblVKeR620s2ZyBbRuOvXXt+WPG/xWFf1UHvocjUakUUMWV
         Sy7YWU6fCNmb4JC58tx/qKchZHrcWyHiJcH9jxYAOKOnVZzjUG9M47GXWwKI/rtndEKX
         BwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697807922; x=1698412722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RjDLc0f7CsZ3ZAhf+7oO+KfDgSRyr9/BS+BP5jxyc4=;
        b=RLtmU9Ion27M/v9u4X7R50p1BmBLIKp+jKEoJZJC2XFrNOedvWhkOr0Rb54eJbc42Z
         qNYuzQvA1P3P7g7bCTm61k4m7RW4+Ne0QAvWp497Irp5TYJj4YUzuHP+UqFJWxfxd92C
         /rwnq+EhDpvTpVydnJhDIQnVCEf7JHxFXaECZ/i44mngvq4i653CNy7RlOZlBsFOfhpX
         aKwRQF0CVRON51eOvH22hR9E6QEVkW2XDHtJCRf3SU0kAe3U0Qu5ATfwaszUYZEoguSV
         Y2uIczIVyY/iQl1LrVk5H46Xx5ZZ5tSGehLJZN/8LImMdoKSMdLadLzWOkE6CYgpeOmf
         cTsQ==
X-Gm-Message-State: AOJu0Yydb93Yvy8a25pTXufwwA9r5PjBpx2GJbVP6EiEw7Nb8KGOOJXM
        I+KgDLkIf4bOVQy5tujLVzdCvGLSL4VHjf4teeLXxQ==
X-Google-Smtp-Source: AGHT+IHJ0YVjts5wXBN5Jqp31pQ7zOyCplhCxmKRWiIG/OBUb9hPTVLkywcsxvesYEBUsruBmhSCSDcUubMxrq+Mqbc=
X-Received: by 2002:a17:907:7f2a:b0:9ae:659f:4d2f with SMTP id
 qf42-20020a1709077f2a00b009ae659f4d2fmr1364024ejc.26.1697807922329; Fri, 20
 Oct 2023 06:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231016180220.3866105-1-andrii@kernel.org>
In-Reply-To: <20231016180220.3866105-1-andrii@kernel.org>
From:   Lorenz Bauer <lorenz.bauer@isovalent.com>
Date:   Fri, 20 Oct 2023 14:18:31 +0100
Message-ID: <CAN+4W8hu+zWiWejWtc72WwQb6ydL3U3LXvaFBdc0o826JKzoAQ@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 00/18] BPF token and BPF FS-based delegation
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 16, 2023 at 7:03=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
...
> This patch set adds a basic minimum of functionality to make BPF token id=
ea
> useful and to discuss API and functionality. Currently only low-level lib=
bpf
> APIs support creating and passing BPF token around, allowing to test kern=
el
> functionality, but for the most part is not sufficient for real-world
> applications, which typically use high-level libbpf APIs based on `struct
> bpf_object` type. This was done with the intent to limit the size of patc=
h set
> and concentrate on mostly kernel-side changes. All the necessary plumbing=
 for
> libbpf will be sent as a separate follow up patch set kernel support make=
s it
> upstream.
>
> Another part that should happen once kernel-side BPF token is established=
, is
> a set of conventions between applications (e.g., systemd), tools (e.g.,
> bpftool), and libraries (e.g., libbpf) on exposing delegatable BPF FS
> instance(s) at well-defined locations to allow applications take advantag=
e of
> this in automatic fashion without explicit code changes on BPF applicatio=
n's
> side. But I'd like to postpone this discussion to after BPF token concept
> lands.

In the patch set you've extended MAP_CREATE, PROG_LOAD and BTF_LOAD to
accept an additional token_fd. How many more commands will need a
token as a context like this? It would cause a lot of churn to support
many BPF commands like this, since every command will have token_fd at
a different offset in bpf_attr. This means we need to write extra code
for each new command, both in kernel as well as user space.

Could we pass the token in a way that is uniform across commands?
Something like additional arg to the syscall or similar.

Lorenz
