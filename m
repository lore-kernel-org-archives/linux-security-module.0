Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BD6E7C4F2
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Oct 2023 20:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjJDUKA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 4 Oct 2023 16:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjJDUJ7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Oct 2023 16:09:59 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322E1C1
        for <linux-security-module@vger.kernel.org>; Wed,  4 Oct 2023 13:09:56 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d84f18e908aso286046276.1
        for <linux-security-module@vger.kernel.org>; Wed, 04 Oct 2023 13:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696450195; x=1697054995; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=094nbv/TcLCTI/RdyxqTztCZ6ImpSpY8hstBB41nqY8=;
        b=X+52q7oiY8wflz+limfE8UfppmOI6FDvfq+4sNg80F7paZgnHw4XcYqmqR7iqRWAAs
         mlYL9gMT9t6UDFYXvqnGsWJK0eGWZkzdGVaZ+pMEpGqTw6VsXBimTin7QNfgaDvsDhxe
         bE+g2hHnl3hRm1RM5vgAtlmyWVLe+UMr+BUoDv1pe5frbOsNBEkL2+yD046jjO3Fu3sa
         GzkalXPbPjG3tFN5kModZaJTtxXzNgmLuo1qKcbSLiw8Cf+zT/pCmERqzwnoKz1TY8U5
         xSHbJYG9LAffvgT+1NsEzg/De5dN4su3g+MX26I/ZZ4jWK0uQb+Pk0ljk6mjjBl1IyZX
         yMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696450195; x=1697054995;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=094nbv/TcLCTI/RdyxqTztCZ6ImpSpY8hstBB41nqY8=;
        b=Q/Ri9WS8yGegQ9kAJIc1AiqG9LLrcnDAp8c+zKSIHyub3en298D5YAn/ccVeJ/aO/3
         upPcpMhjun8nP/spRWTR8iNYstxBpYepw4Z7U+XNtR5H9CH3TBU/4rGXpcIPfWbsCNUh
         0PEIAE/GlVhaecY9xNqMe4cKCRBEvmL17dDuiy6ZYyh58IXd+pK+IGI0Tuqz6BtZVg7x
         DpCeMmLp2Hpi6kR0grBGaNG5ByDDUcEk7TytCYmLjUFgRrGVyobP4MjHGb3oEKkZDvZg
         voogeEqhtXCi5uxzGIAMdwRyUkuGTWsKqBmQURkCL3n44W7/QGQl9aQhwUm//LLqOEqk
         w4uQ==
X-Gm-Message-State: AOJu0YxAyNjSOP2JgK45u9aXc5rJB/XAZs8Jz8ErZyqy2HzqmBrnOIP/
        hM9bLgMIZMkfjrGfVQwBDD2yJxakOND41vU9XDQAxoeMUZNeXwo=
X-Google-Smtp-Source: AGHT+IEkCdXnqctcEOe8XL+75fVmAUu+1HDTZrFvsaotjexugKDP2KPOz3aoUAvyzkITP23Mz5DenS6uJehbjKQEAr0=
X-Received: by 2002:a25:d611:0:b0:d7b:9ac8:f439 with SMTP id
 n17-20020a25d611000000b00d7b9ac8f439mr3210397ybg.40.1696450195177; Wed, 04
 Oct 2023 13:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231004200808.317935-2-paul@paul-moore.com>
In-Reply-To: <20231004200808.317935-2-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 4 Oct 2023 16:09:44 -0400
Message-ID: <CAHC9VhTVhWgPP1qxqtjptdh7E78TWDFASJ9C6dU6UaaFg7x1+w@mail.gmail.com>
Subject: Re: [PATCH] lsm: fix a spelling mistake
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 4, 2023 at 4:08=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> Fix a spelling mistake in the security_inode_notifysecctx() kdoc
> header block.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

... and it's merged into lsm/next without delay because it's trivial,
obviously correct, and is limited to the comments (no code change).

--=20
paul-moore.com
