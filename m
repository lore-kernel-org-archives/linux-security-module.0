Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E127CD13D2
	for <linux-security-module@archiver.kernel.org>; Mon, 18 Sep 2023 16:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjIRQbp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjIRQbb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 Sep 2023 12:31:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DA02D56
        for <linux-security-module@vger.kernel.org>; Mon, 18 Sep 2023 09:29:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0E7C116A1
        for <linux-security-module@vger.kernel.org>; Mon, 18 Sep 2023 16:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695054547;
        bh=bIScZDSarCmOldPejQYXyOwMlItQgnmEFeGCinR7+Ao=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YlOvnsWpTIEjzR1qfc8wGBF3yBnSgrHjHIP39Mb4tfQfZb4KRCP9uAH5QKaHC0HWQ
         6JhbD8Y2p2zYBaVPRQugu+oqZB2RRdTeuCK7OQ//C7X9wH+THBv+6+autKWkf1KK4n
         WKCnTLDVDqI3c7FKVoaJx54g7IhejPrFOLLgUJ+4c+iCd/u19C/izdNVLnt/U2CzBa
         PnRvZ3oo3LsNOARVV+wxy97Q7TSzhO6wUbRK2XzHP/zZNt0dhFA/iVmE+JeoMK2yj8
         lP5Sd5FxlFKbrhrY7DEZAs9aPKwZUfx6yoJGEbNhZ5ZsSanwTaSiLCk2s22+4GFwHX
         jwQ6bXsNnUzjg==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-52a49a42353so5809375a12.2
        for <linux-security-module@vger.kernel.org>; Mon, 18 Sep 2023 09:29:07 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzq2k6hnC3RFOVV7EW9if2fcls5Smn/CQVeVOR/oRECbDssWnUE
        Tv5Gq6OPKgk5ep8sGwrIp7BNk/HzZS3FXy+madWKHg==
X-Google-Smtp-Source: AGHT+IGFizkAWnjs6XKY7G7IkOr11E8gFY0Ec5SFArsvF9d7vzTnafn7UQ9cXA9NFbKD9mljtwgdWRoPupGMinp53OU=
X-Received: by 2002:aa7:d8d7:0:b0:52b:d169:b374 with SMTP id
 k23-20020aa7d8d7000000b0052bd169b374mr7709583eds.3.1695054546031; Mon, 18 Sep
 2023 09:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230616000441.3677441-1-kpsingh@kernel.org> <20230616000441.3677441-6-kpsingh@kernel.org>
 <CAHC9VhSSX0KRuWRURUmt2tUis6fbbmozUbcoeAPkLRmfR2jqAg@mail.gmail.com>
In-Reply-To: <CAHC9VhSSX0KRuWRURUmt2tUis6fbbmozUbcoeAPkLRmfR2jqAg@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 18 Sep 2023 18:28:55 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7KBBJV-CWPkMCqT6rK6yVEOJzhqUjvWzp9BAm-rx3Gsg@mail.gmail.com>
Message-ID: <CACYkzJ7KBBJV-CWPkMCqT6rK6yVEOJzhqUjvWzp9BAm-rx3Gsg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        keescook@chromium.org, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 18, 2023 at 3:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Jun 15, 2023 at 8:05=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> >
> > This config influences the nature of the static key that guards the
> > static call for LSM hooks.
>
> No further comment on the rest of this patch series yet, this just
> happened to bubble to the top of my inbox and I wanted to comment
> quickly - I'm not in favor of adding a Kconfig option for something

I understand, I will send the v3 with the patch for reference and we
can drop it, if that's the consensus.

> like this.  If you have an extremely well defined use case then you
> can probably do the work to figure out the "correct" value for the
> tunable, but for a general purpose kernel build that will have
> different LSMs active, a variety of different BPF LSM hook
> implementations at different times, etc. there is little hope to
> getting this right.  No thank you.
>
> --
> paul-moore.com
