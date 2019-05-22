Return-Path: <SRS0=vdt1=TW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E70C282CE
	for <linux-security-module@archiver.kernel.org>; Wed, 22 May 2019 16:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3953220862
	for <linux-security-module@archiver.kernel.org>; Wed, 22 May 2019 16:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/aYGmU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbfEVQtF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 22 May 2019 12:49:05 -0400
Received: from mail-it1-f175.google.com ([209.85.166.175]:51452 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbfEVQtF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 22 May 2019 12:49:05 -0400
Received: by mail-it1-f175.google.com with SMTP id m3so4701986itl.1
        for <linux-security-module@vger.kernel.org>; Wed, 22 May 2019 09:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yXHwKRBaxNZUqH116t+JoeDJ1ugnuKx/lu7qvYOcfvA=;
        b=L/aYGmU8ZKf2hWToIHwxxXaDfR/JGv6e+gE3X0402R7BWItbU86h0f1fs99z/VrC6X
         W7FwuMvSNsqL807Yf2RSOq/Nv/7iyjsCSJnk0dAgkpktRS2LYmQVxlj0FvHbCT9t0CFO
         1I+Ri+8y8+10X7bxkKVVRzgOPZKnMdABq4eD+cyGPS9SqeD2UuIv4+sk4cH/qDtfvBrS
         v+HXxlotFwyLw7meHG0wkaDfpXNRsjD3yXZHBtQF7iShFDT3EbZCT8Q6p1KNDTj6AM8m
         sd5gY2G0xu2opHQoBRP4S+JOHrf/lIasQkNfLHnwf+iGjQTC4Y9nG3IRxUfO9t8sbLyc
         rovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yXHwKRBaxNZUqH116t+JoeDJ1ugnuKx/lu7qvYOcfvA=;
        b=JZwDVBc5aMNzcgCjwiRwXAF4/EPfHiyGCjj0x9VK6A3Myq5qWhMfy6dB4G00oqgK3f
         9WNYuvB4lcsQq+llWIEv15MIlcMn1JPKPk8Fg/PxWRt8H+SE3igBIla+2ZRpIwZD9KKr
         VGfqqgSRRi4DfEBrIpReaonL0aAe+/7zYYp6RQ/cEjXzUA2Lulf3BxXqIY8EpfyfT4m4
         SVJQE05ijNXY5qJhRuEPZFD0XfHW79+ARgWU3As/PPWUS+2CYOuDagBtSqgM3fHVileM
         vwBzcQq5nynK4WDFrfPk9+ncKUJ3B2kB+nh35yPe/0L8UQc9053gqcahq9AY2Ff9M4fC
         vP4g==
X-Gm-Message-State: APjAAAU3KDUSEgKvCyj38twdhmIAErN3CipDknZXA5sJNy2jeTrr9/bm
        je+3/mSG8sEa816qJgj70xONfFxTjN6Gf3DrJpP1EQ==
X-Google-Smtp-Source: APXvYqx979Re4l+BscFyslcBECPYgnFbyyVgk69PzAWenrhlVcn1OmEIR+W5zqCRv6z+q/2iy0HGvPRlVdRjrlkgUv4=
X-Received: by 2002:a24:a943:: with SMTP id x3mr6102296iti.64.1558543744085;
 Wed, 22 May 2019 09:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190521224013.3782-1-matthewgarrett@google.com> <alpine.LRH.2.21.1905221203070.3967@namei.org>
In-Reply-To: <alpine.LRH.2.21.1905221203070.3967@namei.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 22 May 2019 09:48:52 -0700
Message-ID: <CACdnJuuTR=Ut4giPKC=kdxgY9yPv8+3PZyEzuxvON3Jr_92XnQ@mail.gmail.com>
Subject: Re: [RFC] Turn lockdown into an LSM
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, May 21, 2019 at 7:40 PM James Morris <jmorris@namei.org> wrote:
> An LSM could also potentially implement its own policy for the hook.

That was my plan. Right now the hook just gets an ASCII description of
the reason for the lockdown - that seems suboptimal for cases like
SELinux. What information would you want? My initial thinking was to
just have a stable enum of lockdown reasons that's in the UAPI headers
and then let other LSM tooling consume that, but I haven't spent
enough time with the internals of SELinux to know if there'd be a more
attractive solution.
