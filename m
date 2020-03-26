Return-Path: <SRS0=UFfU=5L=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF903C2D0E9
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Mar 2020 19:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CC520714
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Mar 2020 19:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ae4waGDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgCZTj0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:39:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40797 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgCZTj0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Mar 2020 15:39:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id a81so8678931wmf.5
        for <linux-security-module@vger.kernel.org>; Thu, 26 Mar 2020 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=krcVqiMkQPdhe4hMOEoqIQl0MN9jc0hPZ4AdMO9emGc=;
        b=ae4waGDSfrW9e13opPTyj3EkP01ZIr9H99lNvLUCbfhdmjAkVIUtf8myeSBASMioQ6
         5sCM+aSj8GGGtOOkAKA2sF1svVbQ++wWd19/SurEr9i3eRmKckpaJhNNdJcmhr+X+2S/
         4ey4IIauUMub88gCWUR3ECmD1rDjjStPObuGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=krcVqiMkQPdhe4hMOEoqIQl0MN9jc0hPZ4AdMO9emGc=;
        b=GZYAe0K9QMAg4roG0X69pxlgipbZAE1/0P57R7faT3hARqaBggYOY0xi8v605h3JhZ
         K4/KbUPspKZegF7DLY0xu3oIXxmDxQ3SpSTWN0Sa4XXqrLbaTVcBqgUs15j4oRvzvt3Q
         X46HKnpfmRYaR/UPEZZ3Rp+9mkz9NyFQE/PTLmg/i0Ikc3HXvX/WaRzGLUe7XoehWyC7
         E6nldFUf5Z/dl2OLZG2P/mQKBQTEzxA55fwf66TtsEl3zT4yu/wjwFnLz6Si76aQMlLQ
         x/B1eYWxHUNRqf6kxIJCUdONuBoy1BwU65J7qaU7OH1AvURXDrbW4M61e6WMm/Fq29sy
         zeJQ==
X-Gm-Message-State: ANhLgQ0yedR2VMOL4y1w1rP8jHcRJj/xMSCwuM99ccdrVIhDnbUrDkjx
        2Q2kVvKnpF6FgnyLd4oWJmbrow==
X-Google-Smtp-Source: ADFU+vuZM/wrLQkZhph4tN0p0oWmZhN1XoQuxypzKDgxWIL5L41sJf8NBc/Sk7/A4MmAvbLnE6Xgqw==
X-Received: by 2002:a1c:5604:: with SMTP id k4mr1483516wmb.57.1585251564109;
        Thu, 26 Mar 2020 12:39:24 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id w7sm4886527wrr.60.2020.03.26.12.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 12:39:23 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 26 Mar 2020 20:39:21 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v7 4/8] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <20200326193921.GA15273@chromium.org>
References: <20200326142823.26277-1-kpsingh@chromium.org>
 <20200326142823.26277-5-kpsingh@chromium.org>
 <CAEf4BzaS8xLLrbaWgWbWSEVfc3YBPURQhZxe=zR06B021jH5BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaS8xLLrbaWgWbWSEVfc3YBPURQhZxe=zR06B021jH5BA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 26-Mär 12:12, Andrii Nakryiko wrote:
> On Thu, Mar 26, 2020 at 7:29 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > JITed BPF programs are dynamically attached to the LSM hooks
> > using BPF trampolines. The trampoline prologue generates code to handle
> > conversion of the signature of the hook to the appropriate BPF context.
> >
> > The allocated trampoline programs are attached to the nop functions
> > initialized as LSM hooks.
> >
> > BPF_PROG_TYPE_LSM programs must have a GPL compatible license and
> > and need CAP_SYS_ADMIN (required for loading eBPF programs).
> >
> > Upon attachment:
> >
> > * A BPF fexit trampoline is used for LSM hooks with a void return type.
> > * A BPF fmod_ret trampoline is used for LSM hooks which return an
> >   int. The attached programs can override the return value of the
> >   bpf LSM hook to indicate a MAC Policy decision.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > Reviewed-by: Florent Revest <revest@google.com>
> > ---
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
> 
> >  include/linux/bpf_lsm.h | 11 ++++++++
> >  kernel/bpf/bpf_lsm.c    | 28 ++++++++++++++++++++
> >  kernel/bpf/btf.c        |  9 ++++++-
> >  kernel/bpf/syscall.c    | 57 ++++++++++++++++++++++++++++-------------
> >  kernel/bpf/trampoline.c | 17 +++++++++---
> >  kernel/bpf/verifier.c   | 19 +++++++++++---
> >  6 files changed, 114 insertions(+), 27 deletions(-)
> >
> 
> [...]
> 
> > @@ -2479,6 +2496,10 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
> >                 }
> >                 buf[sizeof(buf) - 1] = 0;
> >                 tp_name = buf;
> > +               break;
> > +       default:
> > +                       err = -EINVAL;
> > +                       goto out_put_prog;
> >         }
> 
> is indentation off here or it's my email client?

You're mail client is fine :) It's me.

- KP

> 
> [...]
