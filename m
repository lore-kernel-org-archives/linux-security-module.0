Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB744C7618E
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Apr 2023 18:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjDXS2b (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Apr 2023 14:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjDXS2b (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Apr 2023 14:28:31 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81DA618A
        for <linux-security-module@vger.kernel.org>; Mon, 24 Apr 2023 11:28:29 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50674656309so7342555a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 24 Apr 2023 11:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682360908; x=1684952908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0mJ70ipVZnf7pj55zQXoZhkDTwynyWYN66a++oKqLY=;
        b=J2oSDHI1aUyogyAr+4YuAISDnCKirGCUOj48r688k/SaUyo21gnxzXzf7vgYTSIY/R
         JIgXIIhPK6lmeFaUZPF1lJG9MxSUU1hIjlcLefZON1VXUT8b1fUc2AhEjn89Dpt5aI6K
         mmX36SRr9TKZSXX585f7CFKOIy8oXThkCa7ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682360908; x=1684952908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0mJ70ipVZnf7pj55zQXoZhkDTwynyWYN66a++oKqLY=;
        b=ZyZGu8KPSSFqhkxkAvTIaBQVuaBgMQEwjrZZVS+GJdBKBNbPmitP8otbEBarj5qWrE
         Ucpm8u2VjV7p8OePzE54RZl3LcKtbie2rlxMKQi8d5xHP07JY7idbEByRAufzMdNCZ/y
         LnSCeh4B01yuATZRb59nRFAmtvBFf6Tgi2OSH53/us69+3e/v27DAdnFqCWmSDuuTPrK
         +67Ur9ZWkSjNNctIXcs1iu0J2U0Q3C9FDPHwmJ6WdxFl10GAdQ+fgAWN5HyRQGDJ5Qm+
         7PZ42tYhm09W7j13RcPKPY8ttdE/JNKQwAmVEZjmeTx3BOIMVw5ooSH/PsdBUDeSP3LJ
         0HiQ==
X-Gm-Message-State: AAQBX9cOk0RH8sMwyLxS0eK0aAKhDvY4A2NKHLLPWga1JXye2nI+b2rz
        K3CEGbheIx1HyfzzQuG1XeS0RaYcKpctTJN64RTS/mvq
X-Google-Smtp-Source: AKy350ZcI9vl/3SzoV3xMX0p7QulE44zPsbM9DUxuMVue96mU1WcegjFKGtDuQbgNIykxlaoLE+YQQ==
X-Received: by 2002:a17:907:1de9:b0:94f:865d:fb8d with SMTP id og41-20020a1709071de900b0094f865dfb8dmr10285501ejc.11.1682360908085;
        Mon, 24 Apr 2023 11:28:28 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906174d00b0094e477eb441sm5731319eje.110.2023.04.24.11.28.27
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 11:28:27 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5083bd8e226so7321403a12.3
        for <linux-security-module@vger.kernel.org>; Mon, 24 Apr 2023 11:28:27 -0700 (PDT)
X-Received: by 2002:aa7:d985:0:b0:501:cf67:97f3 with SMTP id
 u5-20020aa7d985000000b00501cf6797f3mr12297483eds.25.1682360906714; Mon, 24
 Apr 2023 11:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQmV7=+eP0Rh6f+grz6=wigoHKuX5zZuMYVazsV8HVaVw@mail.gmail.com>
In-Reply-To: <CAHC9VhQmV7=+eP0Rh6f+grz6=wigoHKuX5zZuMYVazsV8HVaVw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Apr 2023 11:28:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wji9GerfEOQ=9O6OOULFmpHneLPdvYtv+HM2ZK+tB3FDw@mail.gmail.com>
Message-ID: <CAHk-=wji9GerfEOQ=9O6OOULFmpHneLPdvYtv+HM2ZK+tB3FDw@mail.gmail.com>
Subject: Re: [GIT PULL] LSM patches for v6.4
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Apr 20, 2023 at 4:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Due to some personal logistics challenges over the next few days I'm
> sending the LSM pull request for Linux v6.4 a bit early.  Here is a
> quick summary of the changes:

Well, you only had the summary, not where to pull from or what the
resulting diffstat and shortlog would be.

Normally I'd ask for a proper new pull request, but  since you
explicitly mention the logistics challenges, I looked around.

And it was obvious enough what the thing you wanted me to pull was:
you always use the same naming format for the tags etc, and the end
result matches what you described in the summary.

So I've pulled your 'lsm-pr-20230420' tag, but in general I really do
want to see that mentioned explicitly along with the diffstat etc
noise from 'git request-pull'.

Thanks,
               Linus
