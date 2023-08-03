Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22590C41513
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Aug 2023 20:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjHCUzt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 3 Aug 2023 16:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHCUzs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Aug 2023 16:55:48 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8222211F
        for <linux-security-module@vger.kernel.org>; Thu,  3 Aug 2023 13:55:47 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5861116fd74so16093907b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 03 Aug 2023 13:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691096146; x=1691700946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxczLQkiLaZuHq0hioSngdMG27Z3CrO0BwzJE14vAuc=;
        b=TRpwMRLJ9HugaeZXVf6uPZswfjMJ2m8vM2cFL4fYQL8eJ1fWIt066rEFfKn/VbgiFU
         m7CrsMecG+82n+xGb4PlbPTod1RiSZMfWPUgvap9l0mPKd46SIH6jsJYscV8NhTbO7Jk
         nmgSc35UWjffaUh58vKqABzRpgkpPMKZlKmEzS8pI88RYmXOIdWpsXHUsbd731+gvlOs
         rHyyswSrJFxHgU0V2SPaXEOcVaN6AKI2/r+i6N8iCHz0WJmo4V9rWnq1t+qX8xsXM9SH
         wPN9w7tQiFF5ffzgEBsfIh2zesXv6nmiwO6zVANH7aQ4UWH2Lv3VGXwQqjrEkT52iUhp
         ZNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691096146; x=1691700946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxczLQkiLaZuHq0hioSngdMG27Z3CrO0BwzJE14vAuc=;
        b=MfiTKqwb79Reg+ZRK2UstIQlwK3o4ttPZ2ieKNAHcfj+S/Sw6Cbw9u8CFqRKqUpUb0
         K0mfT39BNGCXqyJTL6NPHw1MvEyuRacHW4UKDp0Esg4xyDRBV5+9M+Evl6/oO5k1gYgk
         F68TsahOXQ0Z2+eOT9KWCCTvB3V8cTPggRs5vw4XkGFdrDR1AOa9g9INRwngNvSztbc2
         0qh4slrZgcOWmpfSHWhuVq9LSGke9xqWd2mEig5VZXVuYJdUUwFMyF6WC5gV8zTw6fMR
         2vItKaTdtc00RiRV+I2goF4+F2vmTbGI0FmXYsswrkqvXp00lB8Tu+RUu8Wn10rn71Z0
         RGEA==
X-Gm-Message-State: AOJu0YwkaCPmxHnMJzBa9q9xzcAI3Tr1xO1qbR2kgkIOFI4f0y+ArLWb
        iA/z1Og2z30cIkl52fUhGURAbbw9xI4OkhRuW5GoREveUz8jC4xR5A==
X-Google-Smtp-Source: AGHT+IHriyC/W8GO5iHiqfCmT5yUjt5chifwCCM90JuMHhlYWAbUbuJ6EXLwRpb/U2GID+a+3tAyRuuPQ/mkevxpw0I=
X-Received: by 2002:a81:69c2:0:b0:586:9e6e:e2e6 with SMTP id
 e185-20020a8169c2000000b005869e6ee2e6mr1575963ywc.48.1691096146735; Thu, 03
 Aug 2023 13:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com> <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <20230802.doki9xoTh0ai@digikod.net> <CAHC9VhSb+=JF7GJ-98DX_3NO2eSLeurXO+w4xcgHuXFh6HqWVw@mail.gmail.com>
 <c1f1b7b7-fb2f-cd03-d962-70979082c1b4@infradead.org>
In-Reply-To: <c1f1b7b7-fb2f-cd03-d962-70979082c1b4@infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Aug 2023 16:55:35 -0400
Message-ID: <CAHC9VhT2oM2ancRuxXRd2-nmgmyu2fdvaedv2K-nF9s11WxqZg@mail.gmail.com>
Subject: Re: ANN: new LSM guidelines
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 2, 2023 at 6:36=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
> On 8/2/23 14:56, Paul Moore wrote:
> > I was looking for the original comments from Arjan but couldn't find
> > them in an archive anywhere, if anyone has a pointer it would be great
> > to share that.
>
> Are you referring to either of these?
>
> https://lore.kernel.org/all/20071026141358.38342c0f@laptopd505.fenrus.org=
/

Perfect, that is what I was looking for - thank you!

--=20
paul-moore.com
