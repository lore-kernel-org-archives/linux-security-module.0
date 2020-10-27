Return-Path: <SRS0=YDB1=EC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5112DC388F9
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Oct 2020 12:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F06442231B
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Oct 2020 12:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WVLjvL+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbgJ0MwE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Oct 2020 08:52:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34844 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbgJ0MwB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Oct 2020 08:52:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id x16so1640803ljh.2
        for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2020 05:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VdLy/kUakjSURD5xQ/YFBTUhQyiMJ2S037Fpg6j6Zn8=;
        b=WVLjvL+8dqcJznCqZnu75mvjazgE1nMYXHTx7zirRvSptOBgkQ1vHrdTfvB48AmPQb
         LYXyA+izaR+l/1zC5h/2bTn2dkLukQJBb55K/VELvkpSe3MzRuj16dNkX6SKe9aoTnRg
         kdYm2i6MXROyrqVbw2ZFU1y/ca1sepsH0WK7o8N5Ln5R6zdNyAHsl488z5E4YgPgCwoh
         Q+sGKejzoi5/x/3tw5764pxu7ZackNaNEgXIcJCS1qiD1E0/9qK7Dkd81j4y0UWlt2kp
         sJhe0hX9CDFvhkcWyboTxD8r5cS960E1TaF6ETWOf7doZoc9wDKvcwTSrXdd4dfmLu5r
         ok/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VdLy/kUakjSURD5xQ/YFBTUhQyiMJ2S037Fpg6j6Zn8=;
        b=JzKCfS+W1OWI81CpuLL6GwByUkWgSdGIfPVKhRdr8gAvvWaxUKwpMpslJ8t5EKXtVN
         zd/EiCLP0ZG4dwuI0fSi0pneHFMEYbdxfAWP3kDK29PfhpTqOEbvfXTrtEF5zM7Q7Pss
         WMMDon1ZEnm+al7e4VufycJtuAeoAkotX7LNMxiDthujayws6hZDUmYryp8L2RNoSqPe
         nhXio97IENaLpDpiIF6LH2Fx1BdOa2KIj3beVYUNeVxv9Z3JRNXJokpWo3lx6cLvr9Yf
         W4lJjZTJ3jwVbnNlUFB/9r7IWzyQS6/OCKL3Na1I13OX7q3wpMTfxCp2MjzzkQ2iUdFA
         wBQA==
X-Gm-Message-State: AOAM531S+q9l9uM+/cj1YUGgq/ys9XMKtyWLGZuMOsh4bliOiU7cLX2s
        mJ1ofAyF4IY/BXXH7kLhDfomCO+tvzpYAsUy6+K2ZQ==
X-Google-Smtp-Source: ABdhPJz3olMufunQq6vfQc+LmVGcVzAz76YcwmxRuMttF8WGEr/yPG8VUpfphjXft+tYlyjdNUvF7dwhGCr4tMX/q7w=
X-Received: by 2002:a05:651c:1313:: with SMTP id u19mr1028801lja.47.1603803116472;
 Tue, 27 Oct 2020 05:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <7655a573-544f-05a4-36dc-0c84c73ac9ee@gmail.com>
In-Reply-To: <7655a573-544f-05a4-36dc-0c84c73ac9ee@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 27 Oct 2020 13:51:30 +0100
Message-ID: <CAG48ez2W+p2RuAPMyxE+hggNtHsVx3-NHCawk18_F5tonX20LQ@mail.gmail.com>
Subject: Re: Inconsistent capability requirements for prctl_set_mm_exe_file()
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Adrian Reber <areber@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 27, 2020 at 1:11 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> @Nicolas, your commit ebd6de6812387a changed the capability
> requirements for the prctl_set_mm_exe_file() operation from
>
>     ns_capable(CAP_SYS_ADMIN)
>
> to
>
>     ns_capable(CAP_SYS_ADMIN) || ns_capable(CAP_CHECKPOINT_RESTORE).
>
> That's fine I guess, but while looking at that change, I found
> an anomaly.
>
> The same prctl_set_mm_exe_file() functionality is also available
> via the prctl() PR_SET_MM_EXE_FILE operation, which was added
> by Cyrill's commit b32dfe377102ce668. However, there the
> prctl_set_mm_exe_file() operation is guarded by a check
>
>     capable(CAP_SYS_RESOURCE).
>
> There are two things I note:
>
> * The capability requirements are different in the two cases.
> * In one case the checks are with ns_capable(), while in the
>   other case the check is with capable().
>
> In both cases, the inconsistencies predate Nicolas's patch,
> and appear to have been introduced in Kirill Tkhai's commit
> 4d28df6152aa3ff.
>
> I'm not sure what is right, but those inconsistencies seem
> seem odd, and presumably unintended. Similarly, I'm not
> sure what fix, if any, should be applied. However, I thought
> it worth mentioning these details, since the situation is odd
> and surprising.

FWIW, as a bit of context here: I believe that these checks are more
driven by "what capabilitiies do we think a typical caller will have"
than by a proper security design of "what capabilities do we have to
require to establish certain security guarantees". As people have
noted elsewhere, on a system without LSMs, a process can point
/proc/self/exe to almost any executable file of its choice anyway (by
executing that file and then replacing the executable code of the
resulting process).

The properly engineered solution would probably be to let LSMs hook
these APIs (if they care) and then remove the capable()/ns_capable()
checks.
