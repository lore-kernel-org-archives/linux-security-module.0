Return-Path: <SRS0=IE2G=4V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A45C3F2CD
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 15:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D5A21739
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 15:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FQPR4T3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgCDPYy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:24:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40900 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgCDPYx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Mar 2020 10:24:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id e26so2282277wme.5
        for <linux-security-module@vger.kernel.org>; Wed, 04 Mar 2020 07:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZmLS9qnO1Q66v/wtUwX9VxbxLnQwytCVRya2k8J6vNI=;
        b=FQPR4T3fjY4rOCvwbAQ0z8QbhMr1ZjWh/xFw9Lzc6W6+ZG7u3WI8Ah6jcGVr/7iX06
         PwPe9WEyKHVL3xuyryUBVKXmU47z4QmcSlCbFjOVUp4BD1ILDAbH8mc0KFDN/IyJyIUA
         UCIVqbT+3CO8S6wCXr7gfGksuTKj7jCzv4fV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZmLS9qnO1Q66v/wtUwX9VxbxLnQwytCVRya2k8J6vNI=;
        b=m8tUR1syDUoMqUKuQli3K2+u83Lu3MegYVGFrDDkZ34YeqQGI4pTHIHPdwUPBJKUBf
         N2RNB0AXI8tWl7bSeVOpNIork0dPxbNFbpO/szAkAbRWURszvfYdssyG7zXbLBlJEY94
         qI8cO67Y/zOfgwJ4nqenSMX57/phPm0GjpPF62OivM8UNcwbw0bxJLfBZqjDyuCMMt+J
         /5gaYtAxn/r6SXTFBqsofOJ7V2at1UMCuNmeFEoVRrDUyLCeyjkxK2JFFtrgZ46+ZIi6
         dYJVc4r22U3oU9TbM0YDE1m0jzFa0vZ7UBqM+jNhHhKLW/1t8oxpSTWzvgfMEOrlXdcA
         Tg3Q==
X-Gm-Message-State: ANhLgQ3HTwpkrGSXP1FFGlVn5xlg4IUsOxTDlx6WGgWaBG/kt7rqDRP4
        P3AidRe71hVdl2bgKaRTLkRZVw==
X-Google-Smtp-Source: ADFU+vtzSljSP9Rf+4htWw0ktNMsb3VloEd6kKjoSEQOggRPiPdIX37a5amcCVkEUychGquYG0F2wg==
X-Received: by 2002:a7b:c857:: with SMTP id c23mr4209940wml.68.1583335492265;
        Wed, 04 Mar 2020 07:24:52 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id z10sm4687059wmk.31.2020.03.04.07.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:24:51 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 4 Mar 2020 16:24:50 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        linux-security-module@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next v2 2/7] bpf: JIT helpers for fmod_ret progs
Message-ID: <20200304152450.GA53576@google.com>
References: <20200304015528.29661-1-kpsingh@chromium.org>
 <20200304015528.29661-3-kpsingh@chromium.org>
 <CAEf4Bzah9CpWJ1vLuy+V1K26Ka1ovKvvAnbRuYBJ1GF-xcQbJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzah9CpWJ1vLuy+V1K26Ka1ovKvvAnbRuYBJ1GF-xcQbJQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 03-Mar 20:52, Andrii Nakryiko wrote:
> On Tue, Mar 3, 2020 at 5:56 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > * Split the invoke_bpf program to prepare for special handling of
> >   fmod_ret programs introduced in a subsequent patch.
> > * Move the definition of emit_cond_near_jump and emit_nops as they are
> >   needed for fmod_ret.
> > * Refactor branch target alignment into its own function
> >   align16_branch_target.

I updated this as well, as we changed it to emit_align.

- KP

> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> 
> I trust invoke_bpf_prog logic didn't change, code was just moved around, right?
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
> 
> >  arch/x86/net/bpf_jit_comp.c | 148 +++++++++++++++++++++---------------
> >  1 file changed, 85 insertions(+), 63 deletions(-)
> >
> 
> [...]
