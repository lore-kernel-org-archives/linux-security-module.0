Return-Path: <SRS0=IE2G=4V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E32CC3F2CD
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 15:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D893320848
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 15:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LK9qIEqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgCDPLt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:11:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42956 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgCDPLt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Mar 2020 10:11:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id v11so870795wrm.9
        for <linux-security-module@vger.kernel.org>; Wed, 04 Mar 2020 07:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VOLjflFVC/lWbN0oTsQoOMlRo2O6lU0WwAevEZ9SEdI=;
        b=LK9qIEqAos8I+5PbVxeMUNEQowsGtb2yvZBfKLIL9byiCFb2lM/Z1VX1MUVZ2vTsq4
         uUKx54WRPsWHJ9c28c79a62LXsGPnzf2yJKMxPLnsTDVKJWC7TdavhOj0h5vL2NN2CbN
         v7K/pyiwWMEWyHrPwkv0ylf6chj5d2kI0PN6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VOLjflFVC/lWbN0oTsQoOMlRo2O6lU0WwAevEZ9SEdI=;
        b=XHISFA9GHRYcQj1P02aAnW1+P7VnmMjy0eW3ZQJKqpzp9hjRo7Pev3za12gD4HTc48
         PUpgTRewCdbuTNI3QbKygA7h84gUtVipRYTQkuxZAgA3f/cG6U76R2BmvDet7bxHPl5Y
         YY+aajpYYsVxPpr2ZeIOGtUx9eyb7putdno/rMznuS/0UgdBzqnfPzPfQymwUQB11PLQ
         CpHpZV0XmFCVnKobH1hmEeW2c0SZ/hNqnJkZeRzgTjNPgK29zi+j/6mz+BcLdCU8CTbn
         7yj9nFWhH9A9HV816Jq3ZZZz2yd+6RbUL8tYDzrDlZIkeuQFfNAXng05FtnI6HuvW09r
         UszA==
X-Gm-Message-State: ANhLgQ1lmkSvmnjRvmHSrIVbK4jNpLzDrn8y7yCirQNmrnXEB0HFs+yx
        ZQt85z+cbZENqYyGDkwt2KAkxA==
X-Google-Smtp-Source: ADFU+vvmwLJVhHP8ankCTyjBG5OOGXMaCLj3M653APMUHZ2b0hi7BJdsXPK8oA0X1aSIXr+EIHZPIw==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr4443265wrk.407.1583334707456;
        Wed, 04 Mar 2020 07:11:47 -0800 (PST)
Received: from chromium.org ([2a00:79e1:abc:308:8ca0:6f80:af01:b24])
        by smtp.gmail.com with ESMTPSA id z16sm38642092wrp.33.2020.03.04.07.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:11:46 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 4 Mar 2020 16:11:45 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next v2 2/7] bpf: JIT helpers for fmod_ret progs
Message-ID: <20200304151145.GB9984@chromium.org>
References: <20200304015528.29661-1-kpsingh@chromium.org>
 <20200304015528.29661-3-kpsingh@chromium.org>
 <CAEf4Bzah9CpWJ1vLuy+V1K26Ka1ovKvvAnbRuYBJ1GF-xcQbJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzah9CpWJ1vLuy+V1K26Ka1ovKvvAnbRuYBJ1GF-xcQbJQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 03-Mär 20:52, Andrii Nakryiko wrote:
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
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> 
> I trust invoke_bpf_prog logic didn't change, code was just moved around, right?

Yes, that's correct.

- KP

> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
> 
> >  arch/x86/net/bpf_jit_comp.c | 148 +++++++++++++++++++++---------------
> >  1 file changed, 85 insertions(+), 63 deletions(-)
> >
> 
> [...]
