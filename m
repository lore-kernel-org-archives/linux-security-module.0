Return-Path: <SRS0=UFfU=5L=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BC0C43331
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Mar 2020 13:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84E620737
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Mar 2020 13:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aX7Amg/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgCZNg0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:36:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38012 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgCZNg0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Mar 2020 09:36:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id s1so7827181wrv.5
        for <linux-security-module@vger.kernel.org>; Thu, 26 Mar 2020 06:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ovCKN6r26UhRylA1vm+kwz+TJf7uPDzl6lowndnjD70=;
        b=aX7Amg/46758K2hIawHd5YOPoDrIwsKkKCmkQGPWJLgpI5bZnube9C0/LCQnSGvwUP
         iV0QhWaOjaN7p9ZMwc8S8wSy9SSSu7TLsY4Zvtr09q7OeW0wtfFfAw0U+ZvFSyVA8SP0
         da49F5jmKwK9hxv9Vjyrxo69UW1Zb58H1Roiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ovCKN6r26UhRylA1vm+kwz+TJf7uPDzl6lowndnjD70=;
        b=I4P4+Y03iXXTORuYpXFyi8mbEZs/tQUWt5VYowLsK90JCgLLUPF9eXXkUqxJ7GOoiB
         CNp4gCzN+9ps7RORY81QRGR/JMDJ42H9LdxU/2Il5LGrEtT1Wkok1eKvSPPlKtF7MvQ1
         K8lzMN1Oa1gTeKsdagYUJJvfSmk3EB43gGC6Wey0Foss8FjWcTPJNJJ+afYRD2kggX3X
         67Mjpm+DYIpRak42UZUQKUbP4cYc8oaFVkfd9C7OjHQtsDuaqBNi+tKJDLVxvuXjZtwi
         MemLdUpzNy8fL+c961Sd8dwwa5CO6qJjugOLNkO0XA56btnMHnoSff55w2bNRj+Qz/oE
         aQjA==
X-Gm-Message-State: ANhLgQ0wUg1e7XDDHGde/snEqv+awnGPUIsg8g/s64AOUvm3ijLdUHWx
        J6PEf4ookLi0Pb9kxqEcivV5Lw==
X-Google-Smtp-Source: ADFU+vsKWkKMYKPUzplU34IsZwsOqLykAHrTxJTpYTlmSJ4JSei5CHjs0/8o+xQyrIai7gjjyFDcQg==
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr9499607wro.415.1585229784324;
        Thu, 26 Mar 2020 06:36:24 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id a186sm3499256wmh.33.2020.03.26.06.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 06:36:23 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 26 Mar 2020 14:36:17 +0100
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
Subject: Re: [PATCH bpf-next v6 7/8] bpf: lsm: Add selftests for
 BPF_PROG_TYPE_LSM
Message-ID: <20200326133617.GC8575@chromium.org>
References: <20200325152629.6904-1-kpsingh@chromium.org>
 <20200325152629.6904-8-kpsingh@chromium.org>
 <CAEf4BzbzfbTT9x3tfLrqhYgozcvxvHvKSVkvyuNqji=aNgvmZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbzfbTT9x3tfLrqhYgozcvxvHvKSVkvyuNqji=aNgvmZg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 25-Mär 19:01, Andrii Nakryiko wrote:
> On Wed, Mar 25, 2020 at 8:27 AM KP Singh <kpsingh@chromium.org> wrote:
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
> >  tools/testing/selftests/bpf/config            |  2 +
> >  .../selftests/bpf/prog_tests/test_lsm.c       | 84 +++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/lsm.c       | 48 +++++++++++
> >  3 files changed, 134 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_lsm.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/lsm.c
> >
> 
> [...]
> 
> > +
> > +int exec_cmd(int *monitored_pid)
> > +{
> > +       int child_pid;
> > +
> > +       child_pid = fork();
> > +       if (child_pid == 0) {
> > +               *monitored_pid = getpid();
> > +               execvp(CMD_ARGS[0], CMD_ARGS);
> > +               return -EINVAL;
> > +       } else if (child_pid > 0)
> 
> This test is part of test_progs, so let's be a good citizen and wait
> for your specific child. I'd rather not hunt for elusive bugs later,
> so please use waitpid() instead.

Good idea. Done.

- KP

> 
> Otherwise looks good and clean, thanks!
> 
> > +               return wait(NULL);
> > +
> > +       return -EINVAL;
> > +}
> > +
> 
> [...]
