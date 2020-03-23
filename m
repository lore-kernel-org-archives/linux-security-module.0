Return-Path: <SRS0=YXOF=5I=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B04EC4332B
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Mar 2020 22:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149352070A
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Mar 2020 22:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DEv6f/ar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgCWWNA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 23 Mar 2020 18:13:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41656 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCWWNA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Mar 2020 18:13:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id b1so7926105pgm.8
        for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2020 15:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=92eMcScMHzLsM3YLHA5MQQOWrOz5V0JmQ5WHjN3eFqc=;
        b=DEv6f/arYuAkMXEExc1Zkk2MvoR8IFP/Pml3yN15/cNv/NtsRD735UCDzVUHOIshF+
         VKCD3e4+1VsG4px4lDkaZEq9zVLA9AKGLdqilzHDcK+r2trEpuok365MwyiBLiVR3LoE
         o8yz5zZ/lcQPyPET2MY6aA7d7rG88ugW7Jypw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=92eMcScMHzLsM3YLHA5MQQOWrOz5V0JmQ5WHjN3eFqc=;
        b=q1+JS14c2opMyApQLnzhsYzPBwAG5i+1cKkSlVvY9hIVeibeT0YQ0zRZDoD+HmnYWx
         M3aAstMdEB7nuSr+7ijQOqnWkKt1oYn9E5YptM6SCCHwmedp4h/jneQkN80XdyKpnvQl
         8GKRBwu0oX+TH5IeDNnWl3UoiYAHxr6BfclFL8C48up5JTUm6x5TXBjhKDfwPTMSb/PH
         Ka3GQBPlpNtpw1q/igwF9zEOMhX8xcAGPcDMlzePFOb1QHkfTngGbZX0p3Iuvnr/ec4z
         GyXO7kcdxs309Atfpy+pw38nNqfnRM2lH3IPDTryGDZZs4++8W4FMsxBZ+3vmtTIxux6
         JLYg==
X-Gm-Message-State: ANhLgQ2zsfAWfhczWMOI6mhC4SalugLM7OJd5BkCpneDUfcmOaMi/QQ+
        EFi6qF2JRBMnoqohIJltTA0/nCcX3zQ=
X-Google-Smtp-Source: ADFU+vvvG7L8wykgxA1dgZwA379IqYhpNVhnZeIW4KgDlB23YPdOqJXifQ689QiT4Xq3+ccJK5w9qA==
X-Received: by 2002:a62:fc07:: with SMTP id e7mr27028245pfh.299.1585001579208;
        Mon, 23 Mar 2020 15:12:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n22sm514447pjq.36.2020.03.23.15.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 15:12:58 -0700 (PDT)
Date:   Mon, 23 Mar 2020 15:12:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
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
Message-ID: <202003231505.59A11B06E@keescook>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-6-kpsingh@chromium.org>
 <202003231237.F654B379@keescook>
 <0655d820-4c42-cf9a-23d3-82dc4fdeeceb@schaufler-ca.com>
 <202003231354.1454ED92EC@keescook>
 <a9a7e251-9813-7d37-34d1-c50db2273569@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9a7e251-9813-7d37-34d1-c50db2273569@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Mar 23, 2020 at 02:58:18PM -0700, Casey Schaufler wrote:
> That's not too terrible, I suppose. What would you be thinking for
> the calls that do use call_int_hook()?
> 
> 	rc = call_int_hook(something, something_default, goodnesses);
> 
> or embedded in the macro:
> 
> 	rc = call_int_hook(something, goodnesses);

Oh yes, good point. The hook call already knows the name, so:

#define call_int_hook(FUNC, ...) ({                        \
        int RC = FUNC#_default;                            \
...


-- 
Kees Cook


