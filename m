Return-Path: <SRS0=jUwH=5J=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D55CC10DCE
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 01:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA673206F8
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 01:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="COC8ebrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgCXBxM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 23 Mar 2020 21:53:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37321 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgCXBxM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Mar 2020 21:53:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so19608793wrm.4
        for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2020 18:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JYmZbOGIiVsldO4I5du4t71vc9EkrrIvswa6uMRtHCY=;
        b=COC8ebrj/l5ZJcyLCdJUYHjZrxwLjZwDMfjtqsfpeePDvqsTbYI0BfRB8HZ/RX2v5/
         C+DAJ/Wd796qIPgDSXvDW1Ry1PdW8DIiOh1oEjx4l2f/EG+0mP1r0hIcao4/inGTejUL
         mvAtmweJ3ymCw6plmIyZppvwYr/DHw/QRBoVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JYmZbOGIiVsldO4I5du4t71vc9EkrrIvswa6uMRtHCY=;
        b=AqdsLsk4vBtjM2Lo2pDqQIHGR/xjfLy7Bi+gbMJ7wvGX6LekDhtVQfEP6k5+4GqL4e
         zyWReyU6PAxo/Q3BMSnApjM0+l2DUaFa9QVVkk8rZRoviBSckVAJDlC04A3cXw3fN4bi
         LYDFLOymgk2pIK9qbRyqlN5nu2TmxnNxaY8okw+Wea1t8NPIZXVnHMjmGLxhp1n0+qwl
         0aDS3kD8v4yPHU5eMxw9JJ17UoGvyZKk9p7DRHIb6ED1vDahQkyJ5JZiyTKeU7RdzAcR
         tGGTaiOrHzzn45GAsLzZeuzhAEUE4xy1Fjq88oENny1R21zntVPtnlrEVSTq6Nh6fguz
         vS2g==
X-Gm-Message-State: ANhLgQ3qyjsrVsVX9XXwI6tMqybMStw3Whvn6QDSY8AK8QD/JczsE9/L
        zkfTFCkkqP3n1xbye5TCwzGUsA==
X-Google-Smtp-Source: ADFU+vvi+CssYVE+QEdrWmvNtR0jrIL4mYFmB5jt1PYf7sjnOF2d7L8zCKeJMWH4of/XjwScMV2Efw==
X-Received: by 2002:adf:b307:: with SMTP id j7mr34750161wrd.128.1585014788959;
        Mon, 23 Mar 2020 18:53:08 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id f9sm27097170wro.47.2020.03.23.18.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 18:53:08 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 24 Mar 2020 02:53:06 +0100
To:     Kees Cook <keescook@chromium.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v5 5/7] bpf: lsm: Initialize the BPF LSM hooks
Message-ID: <20200324015306.GB28487@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-6-kpsingh@chromium.org>
 <202003231237.F654B379@keescook>
 <0655d820-4c42-cf9a-23d3-82dc4fdeeceb@schaufler-ca.com>
 <202003231354.1454ED92EC@keescook>
 <a9a7e251-9813-7d37-34d1-c50db2273569@schaufler-ca.com>
 <202003231505.59A11B06E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202003231505.59A11B06E@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 23-Mär 15:12, Kees Cook wrote:
> On Mon, Mar 23, 2020 at 02:58:18PM -0700, Casey Schaufler wrote:
> > That's not too terrible, I suppose. What would you be thinking for
> > the calls that do use call_int_hook()?
> > 
> > 	rc = call_int_hook(something, something_default, goodnesses);
> > 
> > or embedded in the macro:
> > 
> > 	rc = call_int_hook(something, goodnesses);
> 
> Oh yes, good point. The hook call already knows the name, so:
> 
> #define call_int_hook(FUNC, ...) ({                        \
>         int RC = FUNC#_default;                            \

Excellent ideas, I will spin up the next revision with these changes.

- KP

> ...
> 
> 
> -- 
> Kees Cook
> 
> 
