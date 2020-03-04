Return-Path: <SRS0=IE2G=4V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAD7C3F2CD
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 15:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1525F20848
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 15:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AwWGHCjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgCDPLL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:11:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45123 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgCDPLL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Mar 2020 10:11:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id v2so2803151wrp.12
        for <linux-security-module@vger.kernel.org>; Wed, 04 Mar 2020 07:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yT7XeoSwUdQk121SDMf3G5g+/PJMGsICwgeNmRY4RQs=;
        b=AwWGHCjdbOoLCZNfTjqCPibGkm2uREaDzZapM7b/n3n7Nwkrs1hqcGWlxuLlrw2muO
         1j29uSfwHFQVcOeMU9krUtHsG7P+kDz5jRFL8cWEYsyVC2DqWybq30o9KuKutALdHKfz
         LlPQoJFSTux9e0xsm51R7QkJlMMo5Zd6C6708=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yT7XeoSwUdQk121SDMf3G5g+/PJMGsICwgeNmRY4RQs=;
        b=UDj8VEtbMu1R5sWaDWSeYqh95KalTO/gPj3J94Bvq7VphQZMiR2yJqI0otDa4XU6G+
         pQQya2fs7Y6hyext9perdsws/tQYQy36NoRP+u5VlOJKpVW08vXiy5w1jN9hTL/9YJBl
         SXHqDslJXQcotyPrOW2qCVABGX0BCd4tvztiorCi4wLilQ2eq145U/5X8BCN4f8nHGlF
         wUgfCnuqPW1XLZYh7P+8AeU2Lj5bCBNTQA9hhO0R9z5ksqjxERStm/A3bO7B6Go1LSB9
         kkyuGKYKW5yCVGjBD+SbZiSOxnXKXySEIxYT3CZJHqHKGnhWte2iY9HecsYOPVWRvLjf
         Qe7w==
X-Gm-Message-State: ANhLgQ1RbouqsCrLxjP4KQskEFvkYPhn1MDGLAzEz2ydDHDEmJq0A4G4
        c8caB9Yjl9glqwFECNBkYvvXuA==
X-Google-Smtp-Source: ADFU+vto2Y4+7brCgQ56OnMcDSr46ZwMvvFzkph4qgpP4LS5CH2zpn81VmjOJ0tB9uRs5I9cRSNrVA==
X-Received: by 2002:a5d:6986:: with SMTP id g6mr4555742wru.421.1583334669504;
        Wed, 04 Mar 2020 07:11:09 -0800 (PST)
Received: from chromium.org ([2a00:79e1:abc:308:8ca0:6f80:af01:b24])
        by smtp.gmail.com with ESMTPSA id v8sm4971969wma.28.2020.03.04.07.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:11:08 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 4 Mar 2020 16:11:07 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next v2 1/7] bpf: Refactor trampoline update code
Message-ID: <20200304151107.GA9984@chromium.org>
References: <20200304015528.29661-1-kpsingh@chromium.org>
 <20200304015528.29661-2-kpsingh@chromium.org>
 <CAEf4BzZ58iymCdqqCe=p-7BSF_kt+Dd19taEjTJBEt_ZBZz0=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ58iymCdqqCe=p-7BSF_kt+Dd19taEjTJBEt_ZBZz0=Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 03-Mär 20:49, Andrii Nakryiko wrote:
> On Tue, Mar 3, 2020 at 5:56 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > As we need to introduce a third type of attachment for trampolines, the
> > flattened signature of arch_prepare_bpf_trampoline gets even more
> > complicated.
> >
> > Refactor the prog and count argument to arch_prepare_bpf_trampoline to
> > use bpf_tramp_progs to simplify the addition and accounting for new
> > attachment types.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> 
> See note about const-ification of trampoline and naming suggestion,
> but looks good overall:
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
> > +static struct bpf_tramp_progs *
> > +bpf_trampoline_update_progs(struct bpf_trampoline *tr, int *total)
> 
> reading the code again, seems like bpf_trampoline_update_progs is
> really more like bpf_trampoline_get_progs, no? It doesn't modify
> trampoline itself, so might as well mark tr as const pointer.

Makes sense. I will send a v3 with these some minor fixes by EOD ZRH.

- KP

> 
> 
> > +{
> > +       struct bpf_tramp_progs *tprogs;
> > +       struct bpf_prog **progs;
> > +       struct bpf_prog_aux *aux;
> > +       int kind;
> > +
> 
> [...]
