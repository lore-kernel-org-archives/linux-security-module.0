Return-Path: <SRS0=wXFO=NF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354D8C46475
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Oct 2018 11:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CCB2082D
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Oct 2018 11:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VteSM1ge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CCB2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbeJYUIi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Oct 2018 16:08:38 -0400
Received: from mail-yb1-f173.google.com ([209.85.219.173]:37714 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeJYUIh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Oct 2018 16:08:37 -0400
Received: by mail-yb1-f173.google.com with SMTP id d18-v6so3516766yba.4
        for <linux-security-module@vger.kernel.org>; Thu, 25 Oct 2018 04:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5OtqBdCxn+2nij2R0vX3d4GQ9NzJ95vKYI4kpXZFnaE=;
        b=VteSM1geCP+tnucPiUSiTMVrCIDNbchyM9XlH/fJnLXZzue9y3NuHjnnplBCiTq5wK
         UV9W1dJGF0hIPz0au/EQXVe+5JGAiBt7B3jGqKc/ipNbummJtSY2IZ6gzwobtFT65trk
         TUgvKUnecSrxUwttJ5LKJPumR4Zp5nNFuFdEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5OtqBdCxn+2nij2R0vX3d4GQ9NzJ95vKYI4kpXZFnaE=;
        b=Nu393p/uVPnAFdvRDBwEewke4dTWvxaArPa7FMholS16kmle39nOHlmcopinLNrV4A
         LVf8OHVkuPmEJhL7P9HxH7ks3CSvI3Nehe3JuU+sAPCGFf16p/BkfeDYh3dexzHoDDQU
         wtwUoo9U2heeE0ie/Ney1uFELLVx459G4kU8+mBA+qE8+Q565CxWt6nuO41jHu41/D2B
         rZIUabkx2zqW4f6smJ79L6JmJxs5dfoOxJmKpdlF3bmSv/d8FMq+ZLDR/o+Nn/R/Wu18
         XmrxarA1I3DCHLscgzDuZjjjuvopoQOSdev5xeW1hzTI7xM/M/6G5nc7TmJ8DR/rkSfj
         iXFw==
X-Gm-Message-State: AGRZ1gIGDEuOUxfN+rxF9jnP3ZsumFDsnl3pqW2IIn8YDNC8ojprApIg
        WsUvQoM6OjxtXHLxJ2Z5yj+Pkht9lNw=
X-Google-Smtp-Source: AJdET5c766SeYv+W2cNdI6DXerUCtD5oe4rkcCHv22+RJ9UTv66axKgyhG65iipr9RCVevmEtmycBA==
X-Received: by 2002:a25:b80f:: with SMTP id v15-v6mr943293ybj.228.1540467372893;
        Thu, 25 Oct 2018 04:36:12 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id p76-v6sm1211971ywe.64.2018.10.25.04.36.10
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 04:36:11 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 131-v6so3512560ybe.12
        for <linux-security-module@vger.kernel.org>; Thu, 25 Oct 2018 04:36:10 -0700 (PDT)
X-Received: by 2002:a25:c6c8:: with SMTP id k191-v6mr887770ybf.171.1540467370384;
 Thu, 25 Oct 2018 04:36:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Thu, 25 Oct 2018 04:36:08
 -0700 (PDT)
In-Reply-To: <20181025111355.GA3725@redhat.com>
References: <76013c9e-0664-ef5e-b6c0-d48f6ce5db3c@i-love.sakura.ne.jp>
 <20181022134634.GA7358@redhat.com> <201810250215.w9P2Fm2M078167@www262.sakura.ne.jp>
 <20181025111355.GA3725@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 25 Oct 2018 12:36:08 +0100
X-Gmail-Original-Message-ID: <CAGXu5jK5c5mf=EarFNBWeq5Gc3LB=Kd8tqDc_a2nc6Xmtu=s6g@mail.gmail.com>
Message-ID: <CAGXu5jK5c5mf=EarFNBWeq5Gc3LB=Kd8tqDc_a2nc6Xmtu=s6g@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in task_is_descendant
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 25, 2018 at 12:13 PM, Oleg Nesterov <oleg@redhat.com> wrote:
> So again, suppose that "child" is already dead. Its task_struct can't be freed,
> but child->real_parent can point to the already freed memory.

I can't find a path for "child" to be released. I see task_lock()
always called on it before it ends up in Yama.

(Well, I can't find the lock for switch_mm(), but I assume that's safe
because it's switching to the task.)

> This means that the 1st walker = rcu_dereference(walker->real_parent) is fine,
> this simply reads the child->real_parent pointer, but on the second iteration
>
>         walker = rcu_dereference(walker->real_parent);
>
> reads the alredy freed memory.

What does rcu_read_lock() protect actually protect here? I thought
none of the task structs would be freed until after all
rcu_read_unlock() finished.

> OK. Lets ignore ptracer_exception_found() for the moment. Why do you think the
> patch below can't help?
>
> Oleg.
>
> --- x/security/yama/yama_lsm.c
> +++ x/security/yama/yama_lsm.c
> @@ -368,7 +368,8 @@ static int yama_ptrace_access_check(stru
>                         break;
>                 case YAMA_SCOPE_RELATIONAL:
>                         rcu_read_lock();
> -                       if (!task_is_descendant(current, child) &&
> +                       if (!pid_alive(child) ||
> +                           !task_is_descendant(current, child) &&
>                             !ptracer_exception_found(current, child) &&
>                             !ns_capable(__task_cred(child)->user_ns, CAP_SYS_PTRACE))
>                                 rc = -EPERM;
>

Hm, documentation there says:
 * If pid_alive fails, then pointers within the task structure
 * can be stale and must not be dereferenced.

What is the safe pattern for checking vs rcu?

-Kees

-- 
Kees Cook
