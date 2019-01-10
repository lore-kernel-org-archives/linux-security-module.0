Return-Path: <SRS0=8Njt=PS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62820C43387
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jan 2019 18:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E474206B7
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Jan 2019 18:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gfCXChxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfAJSsJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:48:09 -0500
Received: from mail-vs1-f53.google.com ([209.85.217.53]:36212 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfAJSsJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Jan 2019 13:48:09 -0500
Received: by mail-vs1-f53.google.com with SMTP id v205so7659012vsc.3
        for <linux-security-module@vger.kernel.org>; Thu, 10 Jan 2019 10:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CgE9CgMkRGRCn2AEhFkh73okLj8D6tjsWaOby0PZoiY=;
        b=gfCXChxEeakZwapks/xNBbfTYCbsvkpBzUVw1n1CLvHksCpOzLnbKfrFq9OMtSG68c
         ixeuDKocWavACqDcPWX8TTgb8KbI3kzH+MWuytc4e7izj2U02Dzt67j2Fx+YdVQlfaQJ
         3f+OhIXFMCcztUDusAS7JLDUjLuCIrRF11BlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CgE9CgMkRGRCn2AEhFkh73okLj8D6tjsWaOby0PZoiY=;
        b=eHXc1HO27DCrxPwn0pDBXifQm/SLsMuJ2z2S1m47z49ZJFEGnhDXb8EYvuB56KOFpZ
         0OFU0Akj7KEgAinDD61RlXV+b/rZ7rHXPrYAtyMXz7JFTig5rq8QlR1gh/13zcrxhMj4
         ew/S+2tMHG7YgJzXu3LDqhfOiKyCN9Ybw0IkZOqiWUpkunOQJffsX4UO4r5aQgCAoLhk
         EBkPfahTvObzgMT1zVfEbpXC/Lt5aVcrTVkacaLGuM96wmIHKnChWpC9DHlAbowdNaNF
         SBtO28rzAmpFC1UvIYvtfsMDs5AjIOfZXIGjN4PkSZL1jrZjTwTOY+7ES/bXIiSIYSEa
         bCgg==
X-Gm-Message-State: AJcUukfbLQEBX7GpimlMOcXe+VBeAkWCl5vgGrqwT51GFOq4MfGPRkt4
        gvF0AUQkLLamL+l/c5QNNwsTqtdB3h0=
X-Google-Smtp-Source: ALg8bN5xVU6HaLyQ8GfUe45O5jY0MBqC32xFdpaTxIOXAgA9rk7j1o/vDQxbcv8Ud+MR7lBH7/s5eQ==
X-Received: by 2002:a05:6102:416:: with SMTP id d22mr4906338vsq.209.1547146087893;
        Thu, 10 Jan 2019 10:48:07 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id j95sm43786329uad.6.2019.01.10.10.48.06
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 10:48:06 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id v24so3921044uap.13
        for <linux-security-module@vger.kernel.org>; Thu, 10 Jan 2019 10:48:06 -0800 (PST)
X-Received: by 2002:a9f:2709:: with SMTP id a9mr4344546uaa.10.1547146086162;
 Thu, 10 Jan 2019 10:48:06 -0800 (PST)
MIME-Version: 1.0
References: <76013c9e-0664-ef5e-b6c0-d48f6ce5db3c@i-love.sakura.ne.jp>
 <20181022134634.GA7358@redhat.com> <201810250215.w9P2Fm2M078167@www262.sakura.ne.jp>
 <20181025111355.GA3725@redhat.com> <b0ac67e6-4279-91b3-0178-3176876abe70@i-love.sakura.ne.jp>
 <20181025121709.GD3725@redhat.com> <20181025130129.GE3725@redhat.com>
 <CAGXu5jJDkt0vR28Rzhi2gmb=9S7BwWkiMuVrN98AOABgngYY4A@mail.gmail.com>
 <20181029122356.GA29883@redhat.com> <20181029150546.GA30959@redhat.com> <0fc3493d-a50e-f386-20a8-28d348c19544@I-love.SAKURA.ne.jp>
In-Reply-To: <0fc3493d-a50e-f386-20a8-28d348c19544@I-love.SAKURA.ne.jp>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 10 Jan 2019 10:47:52 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJqG+UMb8L79rYTGgEN0HALmcmi70KOXrt=CqV0xgzDBQ@mail.gmail.com>
Message-ID: <CAGXu5jJqG+UMb8L79rYTGgEN0HALmcmi70KOXrt=CqV0xgzDBQ@mail.gmail.com>
Subject: Re: yama: unsafe usage of ptrace_relation->tracer
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jan 10, 2019 at 3:06 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> syzbot is hitting this problem as of linux-next-20190110.
> When a patch will be proposed?

Hi! Sorry, this got delayed over the holidays. Let me finish the patch
I was working on and get it published.

Thanks!

-- 
Kees Cook
