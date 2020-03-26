Return-Path: <SRS0=UFfU=5L=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E21C43331
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Mar 2020 19:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342E720719
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Mar 2020 19:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mXue/BH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgCZToF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:44:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50227 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZToF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Mar 2020 15:44:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id d198so8085272wmd.0
        for <linux-security-module@vger.kernel.org>; Thu, 26 Mar 2020 12:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0Bii1s2deigTxksVQn5D4fa3g6KSqWpYF2vfQCrTCkQ=;
        b=mXue/BH8dMK46Q+CxoPuOCAXIhsjfNF4BBz9nY0CKpqWmSNg1EdIyHxC/ObRwwi+4Y
         vrbbv616X1THSsMHpH5lPr0ZnkJbdXDnByiot4haqIrWo6+ag7FMFpksuXbvMVX5B1mz
         KDJ9sjiU9NcbKj1KvyZfGqfFysuI5OEoyFOoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0Bii1s2deigTxksVQn5D4fa3g6KSqWpYF2vfQCrTCkQ=;
        b=BTSmzL3tULu7QPnaKR7YrisK4d40GWoljaxX3/SKB93sgOhrAFpJKirEgORjOujiEL
         t4T1NpaBO2bY5l44cT1W5SDwCC9daB+Hf/qoBSTJKKLFRYJEH2o+lHazcCLxBt6Edj+Q
         B8MB6+WWBO65h0fMfAXaNdmZr4s+D0i+yCVbLcr2xpRGl/RItkWwDIgRYwqmykgoWlxP
         4i1eE/u0xqIoK/FkEKJRtFDr8ASGVHYgADOlGpF+8aTFfrVSWOqH+KSQzyvrSUW7zODv
         whROEyo3omaqiNcN1mSb50V6RrH9f4jxkfGTYDDFRo72GOAOh0i+uOAsmM+PnIGGvadg
         XRQA==
X-Gm-Message-State: ANhLgQ0ZwcRlQBojlZJRYKgFciVB+VQBWC/sS7LLI7yN70AJ0DuYXO9g
        RTqIGsyU8KxvTXb501c2LLnyVA==
X-Google-Smtp-Source: ADFU+vv6oOna9/uYcBsBB+T/TvHqVZPZsv2Q92xO2Srm3mQHiGr5MgeyNE/xuLzjiHifH8JuX6CviQ==
X-Received: by 2002:a05:600c:24c:: with SMTP id 12mr1548359wmj.186.1585251843249;
        Thu, 26 Mar 2020 12:44:03 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id s127sm4869574wmf.28.2020.03.26.12.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 12:44:02 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 26 Mar 2020 20:44:00 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v7 7/8] bpf: lsm: Add selftests for
 BPF_PROG_TYPE_LSM
Message-ID: <20200326194400.GB15273@chromium.org>
References: <20200326142823.26277-1-kpsingh@chromium.org>
 <20200326142823.26277-8-kpsingh@chromium.org>
 <CAEf4BzZRe_kFR4yzhPFGgauvYLKvre1reuGp=5=jq_nvQGAayw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZRe_kFR4yzhPFGgauvYLKvre1reuGp=5=jq_nvQGAayw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 26-Mär 12:24, Andrii Nakryiko wrote:
> On Thu, Mar 26, 2020 at 7:30 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > * Load/attach a BPF program that hooks to file_mprotect (int)
> >   and bprm_committed_creds (void).
> > * Perform an action that triggers the hook.
> > * Verify if the audit event was received using the shared global
> >   variables for the process executed.
> > * Verify if the mprotect returns a -EPERM.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > Reviewed-by: Florent Revest <revest@google.com>
> > Reviewed-by: Thomas Garnier <thgarnie@google.com>
> > ---
> 
> Please fix endlines below. With that:
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
> >  tools/testing/selftests/bpf/config            |  2 +
> >  .../selftests/bpf/prog_tests/test_lsm.c       | 86 +++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/lsm.c       | 48 +++++++++++
> >  3 files changed, 136 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_lsm.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/lsm.c
> >
> 
> [...]
> 
> > +void test_test_lsm(void)
> > +{
> > +       struct lsm *skel = NULL;
> > +       int err, duration = 0;
> > +
> > +       skel = lsm__open_and_load();
> > +       if (CHECK(!skel, "skel_load", "lsm skeleton failed\n"))
> > +               goto close_prog;
> > +
> > +       err = lsm__attach(skel);
> > +       if (CHECK(err, "attach", "lsm attach failed: %d\n", err))
> > +               goto close_prog;
> > +
> > +       err = exec_cmd(&skel->bss->monitored_pid);
> > +       if (CHECK(err < 0, "exec_cmd", "err %d errno %d\n", err, errno))
> > +               goto close_prog;
> > +
> > +       CHECK(skel->bss->bprm_count != 1, "bprm_count", "bprm_count = %d",
> 
> \n is missing

Done.

> 
> > +             skel->bss->bprm_count);
> > +
> > +       skel->bss->monitored_pid = getpid();
> > +
> > +       err = heap_mprotect();
> > +       if (CHECK(errno != EPERM, "heap_mprotect", "want errno=EPERM, got %d\n",
> > +                 errno))
> > +               goto close_prog;
> > +
> > +       CHECK(skel->bss->mprotect_count != 1, "mprotect_count",
> > +             "mprotect_count = %d", skel->bss->mprotect_count);
> 
> \n is missing

Done.

- KP

> 
> > +
> > +close_prog:
> > +       lsm__destroy(skel);
> > +}
> 
> [...]
