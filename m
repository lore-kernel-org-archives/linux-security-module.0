Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC61C7EE29
	for <linux-security-module@archiver.kernel.org>; Thu, 25 May 2023 21:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjEYVyF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 May 2023 17:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241965AbjEYVyE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 May 2023 17:54:04 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D12183
        for <linux-security-module@vger.kernel.org>; Thu, 25 May 2023 14:54:02 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-b9daef8681fso154253276.1
        for <linux-security-module@vger.kernel.org>; Thu, 25 May 2023 14:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685051642; x=1687643642;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CD5qxy0Rx+9b9N3zzketlqcg16DNfdz3K8d9nltKurw=;
        b=ToTTX1lWEmVjHekpk/vclY4Hv++wOfVB/KB2+Q0qSey+eQxeTN50xRn26Eu9PHbR9m
         3NcHw00Yi0q/ikxKhHhZb7LbD4fx57smcJ0tBN6mPKYuSLjOigtgovOyXNK4LVb+2fuN
         jgINqN/nZKoXnrLlIGcfd1fhqUexBH0Cw/uecEX1VP7s/vfxJ9BcWKq7x4sQgO4zsZ+c
         9htG2Kp8HZdsFqbQh/f0ipsEZbwErAfNzB7wGSb0rwkQRyIwaXWm0Dn7UWGMHxBbudnA
         wLOH9zlsuHXjuTW4VHg0FeGCfvhwL7IX6QTe/uQIw71fqbQqtXTtGtl2uTnfrIZiZjX7
         ce6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685051642; x=1687643642;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CD5qxy0Rx+9b9N3zzketlqcg16DNfdz3K8d9nltKurw=;
        b=SRWhAOWvOokVgci3GVX//vhE403Cxfh/S8OdxaWxfu0maP9LXAxKoG00OBiAJS+5qs
         /aDgtFoni0OL6v7HSoC+kvShShwimvuuQRftL8NMTy+SNbFPtt0nG2w2o3q2jblEMnCX
         fEgnJWHF7Ke5upjdWJCQ+xM6nHA/32f8xLxmtgwtapeEMHiJBTQtgyuj3ksgKXZ+luKc
         C+ma5hk4TuSqvY1WnyLWZKaCE7NrIG/H2HOue8luhb5AlxCMlYiNkFr8P6GrAgz2l/oU
         0rh2gUbzbsEFWX5U56TQFVasHFMtAg93l8P660rc+GJ6IjLUPx20RzORJ7E1ozyBepnQ
         r5JQ==
X-Gm-Message-State: AC+VfDyG4GjUcwlwHriLzwBbWXNu5mKwQC6PvEZGlDwScnzdUixoWNmu
        3bU4u7ozKBZVAbZZkGRno5PuDSuPPuk2W5+zRNPc7GiIvryhtEE=
X-Google-Smtp-Source: ACHHUZ7uXkBL8DB/AFcf1ECyyyqeL07x42Eo7/h2fGx7Sz3g4BKYIsdNajvxgHw+P1GogQRb8lUbAyyXnbiauOX9rVM=
X-Received: by 2002:a0d:dc86:0:b0:55a:98ff:f077 with SMTP id
 f128-20020a0ddc86000000b0055a98fff077mr1041561ywe.2.1685051641744; Thu, 25
 May 2023 14:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230525031953.105125-1-paul@paul-moore.com>
In-Reply-To: <20230525031953.105125-1-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 25 May 2023 17:53:51 -0400
Message-ID: <CAHC9VhQOz47T-5i3ztRt3U4dNRKoF2bTPWw+sejzq=rry4yFzQ@mail.gmail.com>
Subject: Re: [PATCH] lsm: fix a number of misspellings
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 24, 2023 at 11:19=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> A random collection of spelling fixes for source files in the LSM
> layer.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/commoncap.c     | 20 ++++++++++----------
>  security/device_cgroup.c |  2 +-
>  security/lsm_audit.c     |  2 +-
>  security/security.c      |  4 ++--
>  4 files changed, 14 insertions(+), 14 deletions(-)

Merged into lsm/next.

--=20
paul-moore.com
