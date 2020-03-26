Return-Path: <SRS0=UFfU=5L=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC7CC43331
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Mar 2020 13:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D792076A
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Mar 2020 13:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SBr6DW5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgCZNMG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:12:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45710 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgCZNMG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Mar 2020 09:12:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id t7so7654168wrw.12
        for <linux-security-module@vger.kernel.org>; Thu, 26 Mar 2020 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fYD1onDikuCT88dA5DWTTI0UuhLtnw/htdevMIVPd9s=;
        b=SBr6DW5T+1V0x5iQLwqAaWSO25Rdxc8tXhULBX/bVijGFSDxmpoXqFVFnH5TrL2kG0
         u3v0fs+akUJTQ2RGHrLQGMzCWoi8tpcrJn0prdInLINCiMuritNDPDf7FqpSYQGe2xWe
         hPI2gQ6d+etxyoc1nowSU5Oq+RYuE3OIjyPH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fYD1onDikuCT88dA5DWTTI0UuhLtnw/htdevMIVPd9s=;
        b=fv079G8G8TyJIDR4cegpbU1YJ0Ver0pPwkH2Vmx2r9xqxQ3rb/ocRXrbfCLJy+li7+
         1PdXYhs9OlHg7qmXuAKGK+xIdU9NahXmK5OJ48Id6PEZq3z2xjlQgyrrOMAPOJecAES6
         6wWYO6glV2KxuX+PMjDY8utALXrXB0NfNvC8ztW8GW6XRQrzfHIICoCkz/+2T4szPyhR
         Kl+S6ykyKpwOF2yhD1VHyxquPdVsXIbwu2BlNaqLmfe2bzpQebFWnYYeuVgkXTeDhAq9
         Yl4GbZlHPRU6Uw8hhhCcqJEBfNKwK79W9PuJ3gN7CZ1h2jSx8UlJz84sGjKGExIh9ATh
         O2dQ==
X-Gm-Message-State: ANhLgQ2ABO0+t7smEGzGQJZQAftSX0hW01NRlg4mkCWlhkVGJ1nuOuw9
        8MafKAuhkmJE+8qx2x7tsrKIDg==
X-Google-Smtp-Source: ADFU+vsgpQLD/kDSgky4dJcwopfiL6zM9Z6fEVRTGk4Y2ZMQ2fUbqvWhoxQPHg238aypcNRoFGZS/w==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr8872802wrp.23.1585228324428;
        Thu, 26 Mar 2020 06:12:04 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id 195sm3563080wmb.8.2020.03.26.06.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 06:12:03 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 26 Mar 2020 14:11:58 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v6 1/8] bpf: Introduce BPF_PROG_TYPE_LSM
Message-ID: <20200326131158.GA8575@chromium.org>
References: <20200325152629.6904-1-kpsingh@chromium.org>
 <20200325152629.6904-2-kpsingh@chromium.org>
 <CAEf4BzYomSccqbO2AGbejQV2R2z0jz5GhEFZxuf7SGwtju+e8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYomSccqbO2AGbejQV2R2z0jz5GhEFZxuf7SGwtju+e8w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 25-Mär 18:51, Andrii Nakryiko wrote:
> On Wed, Mar 25, 2020 at 8:27 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > Introduce types and configs for bpf programs that can be attached to
> > LSM hooks. The programs can be enabled by the config option
> > CONFIG_BPF_LSM.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > Reviewed-by: Florent Revest <revest@google.com>
> > Reviewed-by: Thomas Garnier <thgarnie@google.com>
> > Acked-by: Yonghong Song <yhs@fb.com>
> > ---
> 
> Looks good to me, so please add by ack, but I think it would be easier
> to review if this was combined with patch #4, which adds verifier
> support and kernel/bpf/syscall.c support. On its own this patch just
> adds random unused stuff.

The ordering becomes tricky as we are using the CONFIG_BPF_LSM in
"bpf: lsm: provide attachment points for BPF LSM
programs". If it's not too much trouble, I would appreciate if we can
keep the order.

> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Added your ack Thanks :)

- KP

> 
> >  MAINTAINERS                    |  1 +
> >  include/linux/bpf.h            |  3 +++
> >  include/linux/bpf_types.h      |  4 ++++
> >  include/uapi/linux/bpf.h       |  2 ++
> >  init/Kconfig                   | 12 ++++++++++++
> >  kernel/bpf/Makefile            |  1 +
> >  kernel/bpf/bpf_lsm.c           | 17 +++++++++++++++++
> >  kernel/trace/bpf_trace.c       | 12 ++++++------
> >  tools/include/uapi/linux/bpf.h |  2 ++
> >  tools/lib/bpf/libbpf_probes.c  |  1 +
> >  10 files changed, 49 insertions(+), 6 deletions(-)
> >  create mode 100644 kernel/bpf/bpf_lsm.c
> >
> 
> [...]
