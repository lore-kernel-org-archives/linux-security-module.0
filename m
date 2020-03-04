Return-Path: <SRS0=IE2G=4V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2735C3F2CD
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 04:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB1A21556
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 04:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ip5FzACi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgCDExI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 3 Mar 2020 23:53:08 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39561 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgCDExI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Mar 2020 23:53:08 -0500
Received: by mail-qv1-f65.google.com with SMTP id fc12so244704qvb.6;
        Tue, 03 Mar 2020 20:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=elQiMiSIlwsVZFc7wIV+2p0BrWOjGT79bn2K8KP98PA=;
        b=ip5FzACiuBD4caplknRMheN+SbqwHFezKX9FMqRtXbikvzvokFZQWThWXYpWCyE42/
         pbJcpQ1somye53DkfATARc8fx0KXqzOeQe4uzs1NK/OhS+2GwowWntFIO8AKOh3xXdq0
         EInrY8VtLbqpZEbSCTTGQ7cavuzqkW4InMg2j++KoP6CyLPRdyxgg4O0i1Z/qTvzJJ/l
         9kijTr3FAwdxfQnOlSQW2XEkI0NRrENuSh+PtspNILlyx4VkRWEWYKMezpH8MCLljmsi
         bIWqrcdoY18hZqkt3eodRElzimKr8+muafGlAvClBH3WK1SwqPt1/Y6CVVMr9fbi4dXU
         jojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=elQiMiSIlwsVZFc7wIV+2p0BrWOjGT79bn2K8KP98PA=;
        b=uX7aSePFWln3CbX6hWtMJaBQ7ZccZ1RN58H5EqXQj9ntNlagtPCi2DwwccQM+WZuHp
         8mvXXZzeW0kWPRFuV6Lkj6eV43bdrAFKHg7c9eL/zqke743pSOX+7syZ33i8mEFTqtgv
         SR2wm2CPlRXRejW3yyVvzhVu9yLGskF2D1Qahyxaa7GiGY2AtHgEDljJBCXrPGgY/ouI
         vEcCW8/4xaZ10SxGLGPxFvvYDti5etViid+fdCNQV/lro3wf3DFIyKTBvr8NN2l2GQ5K
         CAKWWoVWMF8GX86XMjka2WMV/QBf2xmDug24L7cN4IMEaEVc04INjTYsfdV5QuOerleD
         bBTA==
X-Gm-Message-State: ANhLgQ2Yg9ELnNIrq3uluLAFstY+rZXlb0gO5Es9L5P2Xm21j7AifHse
        OM6xgUPU/ubJRr9UQQ49n+d4Q2xQFFVQamiAdwE=
X-Google-Smtp-Source: ADFU+vuEID0Vfwh4SFKBuFq/SM5FVb1SNrtIAkJoBWaDxVBwrJOlAMDzjLph/tff7MTjQpQjwPgJYyOjKXwkaZ5ezTU=
X-Received: by 2002:ad4:480f:: with SMTP id g15mr684381qvy.247.1583297585797;
 Tue, 03 Mar 2020 20:53:05 -0800 (PST)
MIME-Version: 1.0
References: <20200304015528.29661-1-kpsingh@chromium.org> <20200304015528.29661-3-kpsingh@chromium.org>
In-Reply-To: <20200304015528.29661-3-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Mar 2020 20:52:53 -0800
Message-ID: <CAEf4Bzah9CpWJ1vLuy+V1K26Ka1ovKvvAnbRuYBJ1GF-xcQbJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/7] bpf: JIT helpers for fmod_ret progs
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-security-module@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 3, 2020 at 5:56 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> * Split the invoke_bpf program to prepare for special handling of
>   fmod_ret programs introduced in a subsequent patch.
> * Move the definition of emit_cond_near_jump and emit_nops as they are
>   needed for fmod_ret.
> * Refactor branch target alignment into its own function
>   align16_branch_target.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---

I trust invoke_bpf_prog logic didn't change, code was just moved around, right?

Acked-by: Andrii Nakryiko <andriin@fb.com>


>  arch/x86/net/bpf_jit_comp.c | 148 +++++++++++++++++++++---------------
>  1 file changed, 85 insertions(+), 63 deletions(-)
>

[...]
