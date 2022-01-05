Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70EFC433F5
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Jan 2022 06:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbiAEG6Q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Jan 2022 01:58:16 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:38694
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236444AbiAEG6P (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Jan 2022 01:58:15 -0500
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4CC023FFDF
        for <linux-security-module@vger.kernel.org>; Wed,  5 Jan 2022 06:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641365894;
        bh=K7KhCCRGwBeqa84RMcXQSaKtKWeSUZPZtO3lWY1KoAw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=RbDd+/rRw5kvRUrlGIvPmNTFNjzmbLml/70wUWzyZLSb5hctIuo8SxYyOMpLv9BUr
         suKmdfe2M4MvPV4ibU5X3p4YlL1IQiuSafi+Sd9XU3J7ibgN9DHAikgY9FkgnL0Mjy
         V4C/5LIu3XKo/l5fB0X7WsCW7SJrX88ZtS8qCyRoruL5CXxitmBdZWkG4O8wuI++54
         Yxu+3nmnFG+quvbUcLgrNY7NtrkBeuVucfT0XZiUeK64OEWxg9a1ACr0kQCQibU7A7
         6JsoeIS7rXaC+1AmJxaMr6rdbDLKfVd2CjebNY6VC1KVO54tN7yV/BwnFJpC40eMp6
         E6ETTqHk1pSUw==
Received: by mail-ot1-f69.google.com with SMTP id c22-20020a9d67d6000000b00567f3716bdbso10122717otn.11
        for <linux-security-module@vger.kernel.org>; Tue, 04 Jan 2022 22:58:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K7KhCCRGwBeqa84RMcXQSaKtKWeSUZPZtO3lWY1KoAw=;
        b=MqjyT4v4PVTQnztcyZl2w2oBdKLiHm/gciOpXuiiHPbfibmvekhE5VFzMkcbsTEgNs
         mTH/3pkreFpaS52B3eiZ6qxnzhwhx3c56pkuj+SUWMeIBqKs3cIBtt1/EZ/W4aXd5Uqx
         IWaA27MSnoSL5mc/Xckf8Z4Jt2ElV8x+0wW1I/mFC0zOUWZaGGJAUEOHLbx8v+STUhZH
         Z4DffswS0PKWvkFMujnBIM8eiP890TwCUsxlBe5nVYpOx8Vo/CNoRpanhXTkpTWYRVOI
         q2f5zXMF6pd0UfilSTzu8C2EUsfD9Ym3gi2cSq6wOZAUY+RoAIlvoGsZRGmYgXM+Je3l
         R5yw==
X-Gm-Message-State: AOAM531mowHJ/CTLHgWr/DPqsDOJEbSjE46ZSDc8o2+oF6xJd5co1AsI
        CaQ7oJZcHiVqiEdmc5IM0J3tH1jEzcLiV+QfY94A3x2foHlUZAdzC5tXZfRKanDabofIBpqIHL+
        GcOb4z9fqdjc7xeQiyT4SBef0s+2WRiHNVzN1bjamNhdqGDdCNDveSU2o+hElh0M4qQ7VKA==
X-Received: by 2002:a05:6830:1d87:: with SMTP id y7mr37862059oti.269.1641365891201;
        Tue, 04 Jan 2022 22:58:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNEUrV1/+wUr9dPal3uCYsIG1bY6qJIscVrBikSe+RUdub75zP+CxdWyhqtxOWGkSB4MQIVWIg4kS3Iyo32aI=
X-Received: by 2002:a05:6830:1d87:: with SMTP id y7mr37862043oti.269.1641365890949;
 Tue, 04 Jan 2022 22:58:10 -0800 (PST)
MIME-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
 <20190820001805.241928-13-matthewgarrett@google.com> <CAAd53p6d2CsZcwaX0ZtjmOmQv1Dru4qmM-uRxtHJi0k5PnFMFQ@mail.gmail.com>
 <20220105064827.GA30988@srcf.ucam.org>
In-Reply-To: <20220105064827.GA30988@srcf.ucam.org>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 5 Jan 2022 14:57:57 +0800
Message-ID: <CAAd53p5A9ajyP=8edXW20MB1eLRAF3SsmXfdnkA2isBJD2Bd+w@mail.gmail.com>
Subject: Re: [PATCH V40 12/29] x86: Lock down IO port access when the kernel
 is locked down
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Matthew Garrett <matthewgarrett@google.com>, jmorris@namei.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jan 5, 2022 at 2:48 PM Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> On Wed, Jan 05, 2022 at 02:25:41PM +0800, Kai-Heng Feng wrote:
>
> > This patch breaks ioperm() usage from userspace programs with CAP_SYS_RAWIO cap.
> >
> > I wonder if it's possible to revert this commit?
>
> When lockdown is enabled, or under all circumstances? It's expected to
> be blocked when lockdown is enabled - allowing userland to use port IO
> would potentially allow reconfiguration of PCI devices in ways that
> could alter kernel behaviour in ways relevant to security, which is what
> lockdown aims to prevent. What's being broken by this?

Only when lockdown is enabled.

The affected system from the customer has SecureBoot enabled (and
hence lockdown), and the kernel upgrade surprisingly broke ioperm()
usage.
The userspace program is proprietary so I can't share it here.

Basically this patch makes ioperm() a noop on SecureBoot enabled x86 systems.
If reverting is not an option, what else can we do to circumvent the regression?

Kai-Heng
