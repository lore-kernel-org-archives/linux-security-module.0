Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409CFC4332F
	for <linux-security-module@archiver.kernel.org>; Sun,  5 Nov 2023 23:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjKEXZA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 5 Nov 2023 18:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKEXY7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 5 Nov 2023 18:24:59 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADB8CC
        for <linux-security-module@vger.kernel.org>; Sun,  5 Nov 2023 15:24:57 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5af5b532d8fso44620917b3.2
        for <linux-security-module@vger.kernel.org>; Sun, 05 Nov 2023 15:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699226696; x=1699831496; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7FApIuY8T8Kxami1VU8lHkbK1pyBWmjIPvWvOZHglI=;
        b=KwWZr+DcMEqHYSCbQ788fBmI5KtQGBZ3u0kvAHQd69ppWWRIeXu1LscK9bdEInyBPM
         dundnQgrhMfWmzDFXvR2lqhsXenX26pCf0ZC3JMYeWvEvQmfWNmi1qLMJarJue2Vt9O+
         kxtpH0fLp87oG+1D2j1Cur9vBKd8R3RNeYyk1FEHpsW+7ZdRivCl/G7JbSAllxXA0bju
         wB2pNSLne5ACU1tTdTIJkHrNR78mVw3NDPvPfZTHoTBol8375XL3kWYOeAwI92gH8igR
         j7jEW6jH+i0LHAWgcodwQRV/3WhXOidm4jV+9ptz9Y2UsUFbI2r8qKUnkeFlbY9HNy6e
         MsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699226696; x=1699831496;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7FApIuY8T8Kxami1VU8lHkbK1pyBWmjIPvWvOZHglI=;
        b=bJmLz3P4ILsDj4reBg0HKQa4OLdAV541wgtQUScGyRd5GKbT2KC2hCdoDFpEOh7eaB
         yGEx+pm5lW2iUPSiPehZUmYF3iZ9+5QFFNJLHCjNRA1NKCAPDD8p2kD3YaAjkB+rik3Q
         iyhhRRmMWwm7k9GufM762jktO0+HsbdbSLEcDHqvDYoYzd4M1VS7r9oEtCH7AqqhOVE3
         wH6CxhxFkgo31KFMD+AX1st4Tc5Xfsyoos28UBW+lbOn9Kmu7qxUmmEjBeo91WiqqWF6
         dXXIe8zHCO5NfLbv3Md1742qkOUNZc1uMR6sXDxU9m3AjAVgjzRRMS0hrt5uHdxcAoLX
         ba6Q==
X-Gm-Message-State: AOJu0Yzcno/j3/7q6p9fyWQWHX9PRQs1nTxnOVaKeoVsXEkwy+LmrorR
        1W6iwmNyiH16VQluyJu40/ROJrevu6noXv7+MdJKiSxtJkWviB0=
X-Google-Smtp-Source: AGHT+IEZHKb0ADA6oSIUwE8FT6LshvYo3vl1lg7qBn/AZg85uy9S4nKIzs0SNxZKuB7YT08sCAKFaJN7S9kZJPg5F4M=
X-Received: by 2002:a25:730c:0:b0:d9a:c22a:6edc with SMTP id
 o12-20020a25730c000000b00d9ac22a6edcmr28426442ybc.30.1699226696381; Sun, 05
 Nov 2023 15:24:56 -0800 (PST)
MIME-Version: 1.0
References: <20231102015354.511078-2-paul@paul-moore.com>
In-Reply-To: <20231102015354.511078-2-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Nov 2023 18:24:45 -0500
Message-ID: <CAHC9VhSoTQGK9CpiNZso5=R1YCw2e5hsjkZ6e6Rtn67rVSmjGw@mail.gmail.com>
Subject: Re: [PATCH] lsm: convert security_setselfattr() to use memdup_user()
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 1, 2023 at 9:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> As suggested by the kernel test robot, memdup_user() is a better
> option than the combo of kmalloc()/copy_from_user().
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310270805.2ArE52i5-lkp@i=
ntel.com/
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/security.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Merged into lsm/dev-staging.

--=20
paul-moore.com
