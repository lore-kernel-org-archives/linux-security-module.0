Return-Path: <SRS0=KU/V=SK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D241AC10F13
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Apr 2019 15:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A356D21473
	for <linux-security-module@archiver.kernel.org>; Mon,  8 Apr 2019 15:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PgSR3bmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDHPDI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:03:08 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:36557 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbfDHPDH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Apr 2019 11:03:07 -0400
Received: by mail-ua1-f48.google.com with SMTP id k32so1075751uae.3
        for <linux-security-module@vger.kernel.org>; Mon, 08 Apr 2019 08:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GG5EnYnMlbn7HpOwBGU4nQCGdfn3UOPmyGhAFDOMTgc=;
        b=PgSR3bmDXWWuwH3xQHgwQ+UYts1iRpMTckoeVAu0LnkhorNY0kunm0SllpO2mwT0Wf
         qt9/DpfE/vR6Xh+SyS2mlHqbnumjNBp+V7bvUYpKrWLoKUBr5guavjXf51mF5Ku1zObX
         +CraGH8VuQVcZ+c/mlCORZGN/kW+ImY7EzXCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GG5EnYnMlbn7HpOwBGU4nQCGdfn3UOPmyGhAFDOMTgc=;
        b=irJ71HvrjhiqkqBgu/1lPlXkfAdNmRhYawSUF1Ok/f29OSliK/2dJjYELWPbP7WY1c
         mbAH6Iv0KxACTuUUrTqoKdtK7afAh1L2qvjJgRsSTubNMBq3Npc4CNRD6HOFXqCPIgCC
         d3/pHKC1496u2GrcHfxhuwpJ5SX8HVQ2lf6W0cM6BtAOJMIRJOufo8tldTddFLqkG5/C
         nSDV+C79IdEqlrJTeUTNfDTgDCx04g4dwD/Cji52klKgIomvRZrkw2L5rH9r87JdJvl8
         MQ7YKztn1J67vyu4VlU4kbzsZtUgmuFsrXwsNIxOS7mwS5k9zZDq2/+17zv++kyJ0Ifa
         LPOQ==
X-Gm-Message-State: APjAAAUzSf25bWMMnLa1VQNY6/9YRhrEjNOxQyaWSJzVaE2V1dpY5HQK
        zGIFS0hLr7V3hSlAgPn902Io7xYnmPk=
X-Google-Smtp-Source: APXvYqws8yPtgxewm6vkhZHWH0qDmxc0vY/chTcTD0/C7N+AACecUpGZv0O5bn3/97vPTvPIWrXqXQ==
X-Received: by 2002:ab0:474c:: with SMTP id i12mr16178215uac.9.1554735785109;
        Mon, 08 Apr 2019 08:03:05 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id u6sm23459728vke.54.2019.04.08.08.03.03
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:03:04 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id k32so1075657uae.3
        for <linux-security-module@vger.kernel.org>; Mon, 08 Apr 2019 08:03:03 -0700 (PDT)
X-Received: by 2002:ab0:a97:: with SMTP id d23mr14537862uak.99.1554735783323;
 Mon, 08 Apr 2019 08:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <CADyDSO6k8vYb1eryT4g6+EHrLCvb68GAbHVWuULkYjcZcYNhhw@mail.gmail.com>
In-Reply-To: <CADyDSO6k8vYb1eryT4g6+EHrLCvb68GAbHVWuULkYjcZcYNhhw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 8 Apr 2019 08:02:51 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL8ijV8AXLeeakvP7iXeYGSgyVWOUw+Mp_M0oxL7jf0ZA@mail.gmail.com>
Message-ID: <CAGXu5jL8ijV8AXLeeakvP7iXeYGSgyVWOUw+Mp_M0oxL7jf0ZA@mail.gmail.com>
Subject: Re: [REGRESSION] AppArmor module parameter layout changed with c5459b829b716
To:     David Rheinsberg <david.rheinsberg@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 8, 2019 at 12:21 AM David Rheinsberg
<david.rheinsberg@gmail.com> wrote:
>
> Hi
>
> A recent commit changed how `/sys/module/apparmor/parameters/enabled`
> looks. It was "Y"/"N" before, now it is an integer. I *think* the
> commit that changed this was:

Oooh... the _output_ appears differently based on the type. Argh. Let
me work something up...

> commit c5459b829b716dafd226ad270f25c9a3050f7586
> Author: Kees Cook <keescook@chromium.org>
> Date:   Thu Sep 13 22:28:48 2018 -0700
>
>     LSM: Plumb visibility into optional "enabled" state
>
> I haven't recompiled with a revert, but changing the module-parameter
> type looks like the obvious culprit. I don't see how this change can
> be safe?
>
> This breaks the AppArmor detection of `dbus-broker`. Can the commit be reverted?

Thanks for catching this!

-- 
Kees Cook
