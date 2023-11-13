Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB89C4167B
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Nov 2023 04:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjKMEIo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 12 Nov 2023 23:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjKMEIk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 12 Nov 2023 23:08:40 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6511FCB
        for <linux-security-module@vger.kernel.org>; Sun, 12 Nov 2023 20:08:36 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a87ac9d245so46989447b3.3
        for <linux-security-module@vger.kernel.org>; Sun, 12 Nov 2023 20:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699848515; x=1700453315; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPgHOPbGKf3poJBQcIdt/n0zgP5lLoYzkeW2c8zKNXE=;
        b=QldvPWY9ppWMoHFnZ1wyb1MdtOWpSCrAfOruGHRCGAVWclcJAtmp/WWarzhXkW7yA0
         +pU0bVuj7Pja5y5sxuiyzmlFMaMYGcl7H/4A1Yle57wmf2KyZtA89zE6VzyqkKfTINZj
         7pcFfWIRhlRzRBH03gDtOLPKIUA9kdLn9nRgjth4Xntev55HnlXITXZkNyg19hFdEybo
         biGhZ44l/S+eqZn16y1q6D+/MPuJhSOpRwDOCWpNnXdzR1qftKFE9C+N5Qs5iPszNwo3
         vUs5W9DY9QcLwe0uvETzAlMlF+pIwecllZnJ6NAysq55FdUOMsq3rkRuQM6oaP6PfGgP
         24sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848515; x=1700453315;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPgHOPbGKf3poJBQcIdt/n0zgP5lLoYzkeW2c8zKNXE=;
        b=ktw+wB/cACM+S8Tb3z6C3XdvD0Sm6j28YNlEsBsM3f20SFX0D+68Tqq4ghFAn3Zk9x
         Qsb3jzF/0C6iFiZ+BnQd3MftfslrErJNwbNO+6QzIyWPmp4drBdPZRUZMfg+5FYh51h4
         8h/Uo3tDZ3adCjFdI8Q/lqjA4rJ3MpzEVMH427tK16cw6MQjBuZStvnIaxqwi0nw4u0K
         v3VT9n6XPzW1g4rh8OGvAMj7sUEkMmXo+sw4uzmC9ZzdY3BWHpPjeLzG+K9HqwBFwXbP
         wXEiwR3oFVSq/ClfjppdmbI+t2adifGJExAHEaIiSbq9XDGSa4/cYXOAQOwsM/Vex/Ll
         AQEg==
X-Gm-Message-State: AOJu0YyTrXLlvZnisNuQsGUYYZhWMHNUdNxxVmJhejjtS5DRPWSnjnHy
        W9I7StTkjFmKus1pNkQmXXVvrs17YGbIox2To0x4jstdu1nphHE=
X-Google-Smtp-Source: AGHT+IFwjhZJLo+9DrXl56ELfxA/rM2C64B9VBTVRMbfbWRqoUH6q/Amgsfcw0mscGsvUGNlFPqC+jBhVGZRdP1G5gI=
X-Received: by 2002:a25:d6d1:0:b0:dae:4dfd:f6f5 with SMTP id
 n200-20020a25d6d1000000b00dae4dfdf6f5mr5166183ybg.27.1699848515526; Sun, 12
 Nov 2023 20:08:35 -0800 (PST)
MIME-Version: 1.0
References: <20231102015337.510827-2-paul@paul-moore.com> <CAHC9VhQk+t0XYXfLrpTWEjLOp4-Dvxt5Qv2ZC=--J7PH64J4+A@mail.gmail.com>
In-Reply-To: <CAHC9VhQk+t0XYXfLrpTWEjLOp4-Dvxt5Qv2ZC=--J7PH64J4+A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 12 Nov 2023 23:08:24 -0500
Message-ID: <CAHC9VhT0TnC=2Nza5h0fHFUkcjLjNgUbHOqEpC_fQ-8NBmKX=Q@mail.gmail.com>
Subject: Re: [PATCH] lsm: align based on pointer length in lsm_fill_user_ctx()
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Nov 5, 2023 at 6:24=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Wed, Nov 1, 2023 at 9:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > Using the size of a void pointer is much cleaner than
> > BITS_PER_LONG / 8.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/security.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Merged into lsm/dev-staging.

Now merged into lsm/dev.

--=20
paul-moore.com
