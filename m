Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31392E8FDBF
	for <linux-security-module@archiver.kernel.org>; Tue,  3 Oct 2023 23:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjJCX1j (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 3 Oct 2023 19:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjJCX1j (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Oct 2023 19:27:39 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E827C90
        for <linux-security-module@vger.kernel.org>; Tue,  3 Oct 2023 16:27:35 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59bbdb435bfso18482817b3.3
        for <linux-security-module@vger.kernel.org>; Tue, 03 Oct 2023 16:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696375655; x=1696980455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6EEzjb9woXtKM1XWdqMTYQ/Qn5fCSu9QJUtD9HcqFI=;
        b=STWTr8+FSXXHn74aPOMnU3t+iap6Ge3dKEs0ldtVoXHXoT+FbyMdt/lciYVl5eVxCi
         4kpBMleGZKSwGv3HvhUwNunZJwp6UltrmusAOTKOQ/FNIokUYt/uDTGjXfTH7jyBowIG
         Y1tPLJOwh3fRJc9GAQRpcKTk8OvnEjgAYacJbGdyLZt/kQ5eeaRH2L7gMZ6e3s8r1/4H
         pj80Ewv/l0VfqrmYuJ3Azx49+smU+02YCDyHTRnPBf/oBnW013rBCh9EsRpoA2za3li7
         SW0iA3+3TZNznbMQsjOkICr6ToS7wIc9r3Tcc3Vh8w3Vz/qjHjPxmKF4caMKK5wXp3Dp
         MXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375655; x=1696980455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6EEzjb9woXtKM1XWdqMTYQ/Qn5fCSu9QJUtD9HcqFI=;
        b=viQ2RmwG6B5wn9sT7RNRUYsY/a2cdqE9R6lwxVfct31ZQ/lNhMtrHpMx7vvG4zqrec
         2/+FZb7jGlo3qW7QXCqAAa2f4Kt/oHO5w69abmKLTMqBp3CsPaQtKJGZg3FKK64qqJCz
         E1sgxxp0Rh988T3EHBKvORymK6Hty4mCSLwrpg/bnm/pdtBxwQtgcWPCvL4r0QE5M3dB
         zaVcyDGnzAcRyYBQg9rgcrm55QjYx75s1sQgKHODGIKMxkDmqqbpUK+C3amMwjwPZDty
         v/khVif/exAjgAhWkVVPgb/hdEJePMVsGR9z6eC35TSNU5h9PZFCAyjI98du8KcaEiJF
         1VFw==
X-Gm-Message-State: AOJu0YzQBBZdIU065kcTtFMaFf/dkJ3XNkzitc2I5F3htxYW9HCKGX76
        jvNDfRE8RO6aNzZmef0WHtDaGYucRh5zUV+8GU+3
X-Google-Smtp-Source: AGHT+IGrdMOQTLEOZ57tZ8K5VezOh07U6l7QNiD7CrlB39f5mm5e63BAMR7N3mEJI6u6cycSgu+mSvFySWGbka6cBdU=
X-Received: by 2002:a25:f910:0:b0:d81:894b:28e4 with SMTP id
 q16-20020a25f910000000b00d81894b28e4mr627591ybe.51.1696375655158; Tue, 03 Oct
 2023 16:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp> <CACYkzJ5k7oYxFgWp9bz1Wmp3n6LcU39Mh-HXFWTKnZnpY-Ef7w@mail.gmail.com>
In-Reply-To: <CACYkzJ5k7oYxFgWp9bz1Wmp3n6LcU39Mh-HXFWTKnZnpY-Ef7w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 Oct 2023 19:27:24 -0400
Message-ID: <CAHC9VhTCHPA+xY=KuLAzUsAKzXG8bMi0SGhGArtHMQVr85MTFw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
To:     KP Singh <kpsingh@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        bpf <bpf@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 27, 2023 at 12:02=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:
>
> Until I hear the real limitations of using BPF, it's a NAK from me.

There is a lot going on in this thread, and while I'm still playing
catch-up from LSS-EU and some time off (ish) it looks like most of the
most important points have already been made, which is great.
However, I did want to comment quickly on the statement above.

We want to be very careful about using an existing upstream LSM as a
reason for blocking the inclusion of a new LSM upstream.  We obviously
want to reject obvious duplicates and proposals that are sufficiently
"close" (with "close" deliberately left ambiguous here), but we don't
want to stifle new ideas simply because an existing LSM claims to "do
it all".  We've recently been trying to document this, with the latest
draft viewable here:

https://github.com/LinuxSecurityModule/kernel#new-lsm-guidelines

--=20
paul-moore.com
