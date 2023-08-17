Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092F6C64EB4
	for <linux-security-module@archiver.kernel.org>; Thu, 17 Aug 2023 21:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345000AbjHQVLX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 17 Aug 2023 17:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355193AbjHQVKw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Aug 2023 17:10:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DE635BF
        for <linux-security-module@vger.kernel.org>; Thu, 17 Aug 2023 14:10:50 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-525bd0b2b48so286545a12.0
        for <linux-security-module@vger.kernel.org>; Thu, 17 Aug 2023 14:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692306649; x=1692911449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KARGt4PpfElbzZwIBwRvtX7xaDZsIxyiYVnKOlHTyhg=;
        b=EMas5cliax2QlhrsgcLYZMuSfwfe/lrHBDdnXv8OeJuSjZqTxUD+OZXcX/Ht1U22l6
         ZempxHUD1+qbME5BTq3+Rb/fVDrYt0Xsf9Jq6la0Ep0XIK5zSzbwnATK5cVKHG7TIpdY
         Ixug0lIMRN5lg8SiQM04v7hq+ADFVdrXfBDIK4qHLZ4VQMXEioqxQL8544TEM9okZDed
         joGeDPnlHJoBAq8bV6ydNOvVL0TXKIjbx4QG3gSgbefXPb5vZA7qk8SnqGmcasHODjCT
         qNiliLD7bbAZgFmL5rDBo2WZFE5zFods2jhHiQ6muHP1Sx+2N6MTG/IXFS8KTtBE4Mmh
         M6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692306649; x=1692911449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KARGt4PpfElbzZwIBwRvtX7xaDZsIxyiYVnKOlHTyhg=;
        b=hWWz2WkWQoW0Jn6BhpDmwvnXXQBuc3MnUm7TK7eHd4cjR9hU1UB2hiqSol9iZdk8q/
         otRYIFrjYch3wEyxDQ2NefVt1jeSUxBabXbqhrVYj6j74YqgyJuOY6USzUjthIF3iWVp
         Uj4TfBG2ag97RzKD/STtlZw8S3Y86jnx+JiDVr83fauGFT2cg3TqA3pURZZhhPT7091u
         syk8LqQLFPmDNu1Oqs4U2s1hevWCO5w4tobVU7iZksCyQEkIxU3JK8B5Z9ZI8gLEUJeN
         pH6TNE+f/XSvYAX1qGGKKxcVpSIX+qulBtCwkgmJTiNd5SqzsgpDhmZMG4pWgX8N7rie
         vUxQ==
X-Gm-Message-State: AOJu0YyEvf6g1xdKIRdWLVnTOcEVJd9xc1seugZbLYHM6cNYOs+lt36T
        J79MLptYhjfmJXFv4Q3jT0qoU1l2uJB6qK0BYY5gfHSS6olXdXZYjno=
X-Google-Smtp-Source: AGHT+IGQ252tbGd55IHLjvFB05JtySU6DsEPcHY63A2z15VmmlPP1Kf8NpHuhsLCPory5NR5VYiCYmQ6GRmX3/JgH5g=
X-Received: by 2002:aa7:d791:0:b0:525:6d6e:ed4a with SMTP id
 s17-20020aa7d791000000b005256d6eed4amr655363edq.23.1692306648647; Thu, 17 Aug
 2023 14:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230817210257.never.920-kees@kernel.org>
In-Reply-To: <20230817210257.never.920-kees@kernel.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 17 Aug 2023 14:10:37 -0700
Message-ID: <CAFhGd8qiOQkYB=rW5F6=jp4piwoXvJfnM=ncCzpwK6jauL-huA@mail.gmail.com>
Subject: Re: [PATCH] landlock: Annotate struct landlock_rule with __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 17, 2023 at 2:03=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct landlock_rule.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: "Micka=C3=ABl Sala=C3=BCn" <mic@digikod.net>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  security/landlock/ruleset.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index d43231b783e4..55b1df8f66a8 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -67,7 +67,7 @@ struct landlock_rule {
>          * @layers: Stack of layers, from the latest to the newest, imple=
mented
>          * as a flexible array member (FAM).
>          */
> -       struct landlock_layer layers[];
> +       struct landlock_layer layers[] __counted_by(num_layers);
>  };
>
>  /**
> --
> 2.34.1
>
