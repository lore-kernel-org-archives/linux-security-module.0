Return-Path: <SRS0=f9NI=R6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4493DC43381
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Mar 2019 16:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148D4206C0
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Mar 2019 16:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M79gIw9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfC0Qzd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:55:33 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53289 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbfC0Qzd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Mar 2019 12:55:33 -0400
Received: by mail-it1-f196.google.com with SMTP id y204so1247812itf.3
        for <linux-security-module@vger.kernel.org>; Wed, 27 Mar 2019 09:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZszyTtRF4sHiwangw3H/m8V0aWY+bOEBhByx7XP37/s=;
        b=M79gIw9HCV82g4XpuEVjztM1XAmvhjLbNndudce0CqkXhG+I7FgR26SMsImL8Tk5YV
         oqk85VHUtl2gamGGt1YkunwpjXEMTLk1zyLETfXdBI+TXY6tSoCHcF7GA9K3rq96rn5f
         X549QhcvFXGJPJzGh4dzRRiFLFB06EVnL6HXVCS525ZT3CiL3MYqPnqU/DZOjIYa6I49
         L5iDwCOM9lntttsMy3QZAIKe29OzFJy+1HljawQM7p0FgD5hRBgWp9BGgSsfYzTl+D8M
         kXAaIag2gLCodOynS/QXTGVYZnZ5UASpNf83zotliL1TpPijAza6bWLjmbyAy0EMBDOj
         6avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZszyTtRF4sHiwangw3H/m8V0aWY+bOEBhByx7XP37/s=;
        b=brvVDuM9Cj+wmgXeX2wR4XRl3/dhPaZ2T6ctIK6e4BWvlWVeSQRqpICyMevYPkWfYE
         34f1/j0yRysfhrardenRStD8pdcxE9UwhLIWFHlyah2ukOxWc/UGxa1Q7vW5Bah6VIRS
         F46QK89b/qY6MjW8Oxcc8HpO6ti1iNhKEDtB4efWPEpTiFIwUFAqb6gZ1PrD7Kaek0jz
         7geeaFabR6XiZilna/QGU7m6HdT9kKrqyQtF52j9TKBI9xwAY7qzmBdX+4Zl63DZC/YQ
         cZm23pMgwTZT7NiZZeUPAu89/PY50XS3nGHqoQrS7eNrKU9D1J/9WJTkXhVPwIg2J0tD
         Etfw==
X-Gm-Message-State: APjAAAUSwy+Va+tk8v3+nrzWJJjZSJtGk9ZqBrdhd/uWPgkraNmopupW
        LrZOzSZTHwxCYK4q4z8QDNIEPHpurv0WF/yqD9anh/Wf8Br53w==
X-Google-Smtp-Source: APXvYqzKVlIc5myKpqLCnzElqMwoj1ybJfgfjdPEZITuFjuuEXyvCtRUV9B8g9wo8X/E2fs/Yjr/8JnVF/d5oQXXME4=
X-Received: by 2002:a24:2c48:: with SMTP id i69mr4469887iti.161.1553705732048;
 Wed, 27 Mar 2019 09:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-20-matthewgarrett@google.com> <20190327115749.5770a102@gandalf.local.home>
In-Reply-To: <20190327115749.5770a102@gandalf.local.home>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 27 Mar 2019 09:55:20 -0700
Message-ID: <CACdnJuv82qUnVhtZXHaHAJH0x9edS=j5X8awhhJmFfGAz5Ayzg@mail.gmail.com>
Subject: Re: [PATCH V31 19/25] x86/mmiotrace: Lock down the testmmiotrace module
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 27, 2019 at 8:57 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 26 Mar 2019 11:27:35 -0700
> Matthew Garrett <matthewgarrett@google.com> wrote:
>
> > From: David Howells <dhowells@redhat.com>
> >
> > The testmmiotrace module shouldn't be permitted when the kernel is locked
> > down as it can be used to arbitrarily read and write MMIO space. This is
> > a runtime check rather than buildtime in order to allow configurations
> > where the same kernel may be run in both locked down or permissive modes
> > depending on local policy.
> >
>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
> I'm curious. Should there be a mode to lockdown the tracefs directory
> too? As that can expose addresses.

That sounds like a reasonable thing to do in the confidentiality mode,
I don't think it'd be necessary in the integrity mode.
