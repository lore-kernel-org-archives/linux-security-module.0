Return-Path: <SRS0=spL8=4W=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C382CC3F2D2
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Mar 2020 23:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FB6207FD
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Mar 2020 23:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q0eAh/OF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgCEXWT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 5 Mar 2020 18:22:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42722 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgCEXWS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Mar 2020 18:22:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id v11so179524wrm.9
        for <linux-security-module@vger.kernel.org>; Thu, 05 Mar 2020 15:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UlJYZnn8gF6EelxRY7x9k7613SCS7XFaITrtE8tR1vQ=;
        b=Q0eAh/OF99KaSC2bJbBgNXpd2QkbUTjmndCby1sHRDc4RDN9PLzt+IU13Y/EcIRT3X
         wECALzFKTcmLuaIiGhTxjNKI+t6/1bm4eI9ziAC1ihdUoFAMxA+YaqzyE3zscFC153kG
         /hOYqdVEr9Qn2KYRL0tkuuHahZW5sWUkMgC34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UlJYZnn8gF6EelxRY7x9k7613SCS7XFaITrtE8tR1vQ=;
        b=YdepqRqSOlD3P06sLK99hDQM5jEShLMOxzUIq8XnmayrklKs8WDyJUBSJwwxyd+gaU
         bur4qObgvtun6rESXCVls0Iw8NrpsBpr6nP7dBJmp1CZOCHPEUutE36rkMyQ/Q0yEwVo
         /rP/Y7CmSRXI9XA8raSsLvJgkbMUxO9oqv4BOSm6qWYtzU/XiYu/Wrs4Z0lT/33gpPNs
         n/YRuYRTrvkULvwIc8jqWYdHcTDoC1VhaHc2boMU02ZrrHNlSTM3SrDEJeOBAFx+r1G9
         plC52b0CW1UmApxdRuuqijj4+kWb8LEnEHdY+69Xx3MBi6RVmZPCbxSXNlMD3IT1u49T
         j9zA==
X-Gm-Message-State: ANhLgQ04F95LUZAr54B5CoD8F2hpMpwHK2DfKnmUEiqDaqErlu85Fjxf
        zdS/ocP9qmQW1fErPfMxed9IpmXqQ+EPLGYfAoOmgM7z1vLWmA==
X-Google-Smtp-Source: ADFU+vtuvKFZ8s0RSzwglFPDiN/FF9/4W9jJ87Uq/hW3kxlvaebx5BVTUTkvJRxM0Q/UeUYHe8Dj5RI0gNK8ohHJwL8=
X-Received: by 2002:adf:ded2:: with SMTP id i18mr271722wrn.173.1583450536966;
 Thu, 05 Mar 2020 15:22:16 -0800 (PST)
MIME-Version: 1.0
References: <20200305220127.29109-1-kpsingh@chromium.org> <92937298-69c1-be6f-3e40-75af1bc72d9e@infradead.org>
 <CAADnVQLjj+eMMLU3H4oNkzwPiSugm1knzd3RfBGb3NcVC785kg@mail.gmail.com>
In-Reply-To: <CAADnVQLjj+eMMLU3H4oNkzwPiSugm1knzd3RfBGb3NcVC785kg@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Fri, 6 Mar 2020 00:22:06 +0100
Message-ID: <CACYkzJ5apfT5F4RGvnZiCZnfMOqi7n8_sypQgeLhZY7J4RdDjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix bpf_prog_test_run_tracing for !CONFIG_NET
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Mar 6, 2020 at 12:16 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 5, 2020 at 3:12 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 3/5/20 2:01 PM, KP Singh wrote:
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > test_run.o is not built when CONFIG_NET is not set and
> > > bpf_prog_test_run_tracing being referenced in bpf_trace.o causes the
> > > linker error:
> > >
> > > ld: kernel/trace/bpf_trace.o:(.rodata+0x38): undefined reference to
> > >  `bpf_prog_test_run_tracing'
> > >
> > > Add a __weak function in bpf_trace.c to handle this.
> > >
> > > Fixes: da00d2f117a0 ("bpf: Add test ops for BPF_PROG_TYPE_TRACING")
> > > Signed-off-by: KP Singh <kpsingh@google.com>
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>

Thanks!

Apologies, I should have added the "Reported-by:" tag.

- KP

> > Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
>
> Since it was at the top of the tree I amended the commit
> with your tags.
> Thanks for reporting and testing.
