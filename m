Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596CCC7EE25
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Jun 2023 19:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjFHTkK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 8 Jun 2023 15:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjFHTkJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Jun 2023 15:40:09 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F37C18C
        for <linux-security-module@vger.kernel.org>; Thu,  8 Jun 2023 12:40:08 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-569386b7861so31533487b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 08 Jun 2023 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686253207; x=1688845207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dJBCTsq9Xw5p421JbO2Khi1BzsFXDH5KI5pOiwejyE=;
        b=T8+ajB0IGaul1f4L9rSxr7/sO33HCz42RRag+mNL8dvn6SBlBQFzcr/KANcsaZnvaj
         ZwPFxcHeRf3RARJ2g31tSBQQjG8/c9VridAq3j+SXN5jvfDA1REreBx4NySPMG0DLtsQ
         BteLRnXcaZMUP5zSDD4PYcpg/A0L0NqBeRO+CsdKlh9lqxI/uZdGa/kFjliAnIKX/2m6
         acYZnOJVy4sQscQUCBe5mRkVrbG4vwEH6dQ8ABBVlRfnj6olPHwjyN/tn+Mb1iXFJ13X
         HSywuz+7HXNrV3/5QlE911s1K/2jEIxDWwLcMrc0vUEhAUr5TUyNERJpj60wWa1FUCAj
         8Gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686253207; x=1688845207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dJBCTsq9Xw5p421JbO2Khi1BzsFXDH5KI5pOiwejyE=;
        b=ShrwqA3tqZWrW0xluZ+Q4KYBDHuPzYXPU8PFfFHsL1marwN2JaXrFs8jLoABFhXEfY
         zYvpHvA5ciqkyUs8QJbBE1u9t2LwLfFwyb8emfH7Nl7+bkYsHOGACYHaNCpLhyirJtUi
         b0GbaZpqT2oOhI0LdV5uWEiktFnaYpL/ieIYDf/O9FRotl9lSyxOyrfrUiErTC/OhFoL
         ZuZ/hTBuh/sdL+9iK/l0mnIIOf+kh+Ll3le8KenohSDwI6cBVa+nOoSD6o/KGMsnvnxH
         ojCDw6qcNRKmnNNe14fQmH/Z8rQj+6RikqHoRL4RzFjZZ303hyImQV5l0dN3Lif7IRw5
         x9EQ==
X-Gm-Message-State: AC+VfDwUKBbxQCNotJAh4n1+ZZHtS45tNjWTuD+YiCL7GlOLHyPjf2cj
        Q+IADpQbxzVJhO3m0JNVYQHWZbt+mmoUkD6esADqlFXZKOBy/3s=
X-Google-Smtp-Source: ACHHUZ49nh4oyyb4CFZgWniE1i3Pa7CJZ8qs4NQxwbKEeSQhylZPIIIuabe6hbeH2QUXqSwGtIouVaoc/kjRFSbDY34=
X-Received: by 2002:a81:6ccd:0:b0:569:ef2b:e20 with SMTP id
 h196-20020a816ccd000000b00569ef2b0e20mr482524ywc.23.1686253207277; Thu, 08
 Jun 2023 12:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230608191304.253977-2-paul@paul-moore.com>
In-Reply-To: <20230608191304.253977-2-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 8 Jun 2023 15:39:56 -0400
Message-ID: <CAHC9VhTcLJRc-8z86Re1=5HxSQkvgr0cSH_TArAOuC+jGr3PzQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: move labeled networking to "supported"
To:     linux-security-module@vger.kernel.org
Cc:     netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 8, 2023 at 3:13=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> My current employer, Microsoft, cares very much about the development
> and maintenance of the upstream Linux Kernel so we can consider
> labeled networking to be "supported" according to the definition in
> MAINTAINERS:
>
>   S: *Status*, one of the following:
>       Supported:  Someone is actually paid to look after this.
>       Maintained: Someone actually looks after it.
>       ...
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

FYI, I just merged this via lsm/next.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7e0b87d5aa2e..8818cd866009 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14667,7 +14667,7 @@ NETWORKING [LABELED] (NetLabel, Labeled IPsec, SE=
CMARK)
>  M:     Paul Moore <paul@paul-moore.com>
>  L:     netdev@vger.kernel.org
>  L:     linux-security-module@vger.kernel.org
> -S:     Maintained
> +S:     Supported
>  W:     https://github.com/netlabel
>  F:     Documentation/netlabel/
>  F:     include/net/calipso.h
> --
> 2.41.0

--=20
paul-moore.com
