Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01600C46CA1
	for <linux-security-module@archiver.kernel.org>; Mon, 18 Sep 2023 15:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjIRPy0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 Sep 2023 11:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIRPyZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 Sep 2023 11:54:25 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8C11992
        for <linux-security-module@vger.kernel.org>; Mon, 18 Sep 2023 08:50:49 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-274df3878a2so827103a91.1
        for <linux-security-module@vger.kernel.org>; Mon, 18 Sep 2023 08:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1695051984; x=1695656784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Irf/x7Bp+jiHwey/YAiDuVo4UVdOZIsn4X23hTZ4uKg=;
        b=Qeqrbz/QwrtXa+gwF4Q2SbfMeMk+olEYPQcXqFPYmN4DWh1YacjiTPS09zVcu0hg2q
         f4DGuPW9ARLlnIreU/QhvR9NYPvonLjNZiScC4HcLJCVj9RxU4JdQ6y+F1T8QLiXi189
         hQ5gk6lBzlnxojEpPCeE5GUCuCUFU64NoBGkE+thg+GT4YhEoN/I1wKHqoB2lnpl5FaI
         V5S+ztXOq+R2j/sSpto34HDMN787LK0FIrI7g1fopHWe1OgqohjVIbXwZjn21q0wIg2E
         wMZkuK3ZvZNeUZEeDDdvDUW3X4rCq9GqZA58UNgQyGQWGdYaY0a9tH32gK44YEpxyB1Y
         5chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051984; x=1695656784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Irf/x7Bp+jiHwey/YAiDuVo4UVdOZIsn4X23hTZ4uKg=;
        b=P2K1Evfk10ha1s3Tp0XV5Ps8Zxm+GuQSY8LicbC7JRWa0fUd2LZeBIb60C3pP6pw8w
         mKT69aRluQxsAoVMaMTxIMoIKqATNMbETYF9fz25FGM/nQ5i5o2h+ak+A3A57SeH8aqO
         XQcl3hg6DwWqdN9nTqLcdm2tU38z8DghE1SojFrttezB90dPYiUUX3DYkOdwsgHmHxv2
         XX4SKvoXAP/cBnSe1RDIuUZQThqcwtjF0RuxahVoDyFAzLZfxnD+xzOo83HqTh1QVjQa
         HQsE03wwinFytr/KZxV+L9pVwcVqzASsxAMkj469QopgMyTJHc0geKypdFxJ4DEZiggh
         560w==
X-Gm-Message-State: AOJu0YyV6NrfMRKqdxL7d+tJr89nXyWckqr0UfRfCDxaOw5gEhmMdCMQ
        Kxf6wRMTimdTPhdfd/CIhKYSVAOnzPsuETkn++Rm8ze1zEJbTqk=
X-Google-Smtp-Source: AGHT+IEY9guvH+H+a1GPkqEqVUEXKZHgyyxqPouezy+bEL0NRJ6QduLtiwQ2/tJ+MG3mC58mAuZmims6EZ4M9iL1wZw=
X-Received: by 2002:a25:50d8:0:b0:d0c:9ab2:72d3 with SMTP id
 e207-20020a2550d8000000b00d0c9ab272d3mr7977417ybb.14.1695045363162; Mon, 18
 Sep 2023 06:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230616000441.3677441-1-kpsingh@kernel.org> <20230616000441.3677441-6-kpsingh@kernel.org>
In-Reply-To: <20230616000441.3677441-6-kpsingh@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 18 Sep 2023 09:55:52 -0400
Message-ID: <CAHC9VhSSX0KRuWRURUmt2tUis6fbbmozUbcoeAPkLRmfR2jqAg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        keescook@chromium.org, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 15, 2023 at 8:05=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> This config influences the nature of the static key that guards the
> static call for LSM hooks.

No further comment on the rest of this patch series yet, this just
happened to bubble to the top of my inbox and I wanted to comment
quickly - I'm not in favor of adding a Kconfig option for something
like this.  If you have an extremely well defined use case then you
can probably do the work to figure out the "correct" value for the
tunable, but for a general purpose kernel build that will have
different LSMs active, a variety of different BPF LSM hook
implementations at different times, etc. there is little hope to
getting this right.  No thank you.

--=20
paul-moore.com
