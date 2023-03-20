Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05776C6FD1C
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Mar 2023 22:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjCTWRu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Mar 2023 18:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjCTWRr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Mar 2023 18:17:47 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C143936444
        for <linux-security-module@vger.kernel.org>; Mon, 20 Mar 2023 15:17:08 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i5so5786241eda.0
        for <linux-security-module@vger.kernel.org>; Mon, 20 Mar 2023 15:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679350626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPrDTO6iMVUmjsFudsdQ6YBX68bwKPdUhbwstJv4XRI=;
        b=U9pCEA/2HPHSqwZzPiHP/qfKDCjVpG6XCI8XxaO2Lplmo38RjSSj5QnZheuIwgVmm2
         7Vs42NzwDz83AqAHsQ8qmNdD5VkquV6MeRmOTXuxa4GxMR0tlKI9pPsvUQFJYwFKCape
         Dmszt+dpWmbhSWOczSMnE51zYN5nGNlsnFZxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679350626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPrDTO6iMVUmjsFudsdQ6YBX68bwKPdUhbwstJv4XRI=;
        b=1X7GEdhNIeZnl2BTcQgqqbGBwBZqUFwo7Dvu/GEycX8sXutnGvRTw9kFTPgTcz56Nl
         yR0N6ihfVkm6g9TR+CXpbauPCZRD8l2YuDTt5lI+wSlg7+h5YXgfHBMkSZgekkRMGgcM
         Uh8Z0H2m+R/1qbtQFokgshuyQzt+8KZUMv1hqpzAO8714LGDaLqawyoBc0CIUqMCgCpI
         YzZFYRHw385x0K/QQKFq9ROqjNUa7AL5jMf87Xd/613xjzMDsfn0cvITocau/7BGHvy1
         MqrnEzHjenGV0LVeoWyyRBm9vzrSzRlhog0NIXtIfMzICguOxyod+10+aqa/Rv3291ph
         DIbg==
X-Gm-Message-State: AO0yUKVX9lm/pHR9h+iZzqoyQ3JojqBiR5EFj4fVzkG4U2X6pCJiqwzl
        2C+OrVl2hg9TE/ovZwubjzewqzvPsLumDsqSMiUuXSTz
X-Google-Smtp-Source: AK7set9t32g6vuiCNEZNcfsO6zXPzzUhDTQEPlfpipk9vjXfFa3Mjdxw6Vu8piqyEZyFPvSnCk4IdQ==
X-Received: by 2002:aa7:cd89:0:b0:4fc:687a:c29d with SMTP id x9-20020aa7cd89000000b004fc687ac29dmr1128899edv.1.1679350626722;
        Mon, 20 Mar 2023 15:17:06 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id i28-20020a50871c000000b004fd204d180dsm5410187edb.64.2023.03.20.15.17.05
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 15:17:05 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id eh3so52647895edb.11
        for <linux-security-module@vger.kernel.org>; Mon, 20 Mar 2023 15:17:05 -0700 (PDT)
X-Received: by 2002:a50:9546:0:b0:4fb:2593:844 with SMTP id
 v6-20020a509546000000b004fb25930844mr582214eda.2.1679350625492; Mon, 20 Mar
 2023 15:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230320205617.GA1434@sol.localdomain>
In-Reply-To: <20230320205617.GA1434@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Mar 2023 15:16:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=whefxRGyNGzCzG6BVeM=5vnvgb-XhSeFJVxJyAxAF8XRA@mail.gmail.com>
Message-ID: <CAHk-=whefxRGyNGzCzG6BVeM=5vnvgb-XhSeFJVxJyAxAF8XRA@mail.gmail.com>
Subject: Re: [GIT PULL] fscrypt fix for v6.3-rc4
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Mar 20, 2023 at 1:56=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
>       fscrypt: check for NULL keyring in fscrypt_put_master_key_activeref=
()

Side note: please just use WARN_ON_ONCE() for things like this, not WARN_ON=
.

If it's triggerable, it should be triggered only once rather than
flood the logs and possibly cause a DoS.

And if it's not triggerable, the "ONCE" doesn't matter.

I note that fscypt in general seems to be *way* too happy with
WARN_ON() as some kind of debugging aid.

It's not good in general (printf for debugging is wonderful, but
shouldn't be left in the sources to rot for all eternity), but it's
particularly not good in that form.

              Linus
