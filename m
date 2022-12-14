Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876CFC001B2
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Dec 2022 04:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbiLNEHi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Dec 2022 23:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbiLNEG6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Dec 2022 23:06:58 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EDF27B05
        for <linux-security-module@vger.kernel.org>; Tue, 13 Dec 2022 20:06:57 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id v3so1210877pgh.4
        for <linux-security-module@vger.kernel.org>; Tue, 13 Dec 2022 20:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8rKEV9W9fSxR0xRR3DSmLMtebWk2YTiMQPBl9c/07mg=;
        b=JUiHhh9U/ve+vlJsWZf7ZOpMUM4syjPZb4nbKg2MzXiIWlXZiUPAaNjul/0MQBPViO
         rLPF5uUfmLfksFpudg2ZTn1bZ7RsrJl4+UuZpbCHeENZTxOP0kohNFFJQClyqwxAjIME
         RNOqlmy8zOow1j9BiCDP81jWWATVny8BRH9O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rKEV9W9fSxR0xRR3DSmLMtebWk2YTiMQPBl9c/07mg=;
        b=DR8k3/ZXWkSwLjaDoOr+I+/stgbaUEwfZ7M7mADDw3bVzlXTL3shgPoCypr/std8QA
         biFn0huh1EQwM/H89DJ8ZyjPqdyZeGyz1CExSC9X/JQ1REPO48xojJO/ss53KHjNEEMu
         Nf6h8EYNZ8wiMzZxZ6wO2LhJGRR+LWKg5dXIXRsjxaD0lgqkfrGoaYnTYObf3sgawygf
         0bJRXinL4s3KA2obkiYfgBbHHjh64iCzrrQS7on+RQSLMqT9imGpe1EWQUyFpUCj0fpI
         kdGdd4FyMxpjP/P5H0xDIzn8gPBwzMXvA2xCf13DREW5VMcFzeW8wzPf7RuMh7uxMJxY
         hrGA==
X-Gm-Message-State: ANoB5pkrf43ehaEcVErcsxVBmcodxDUShsI+LDGXge/W4d+saueZxUd/
        ks3oTkCUq5bEbdFbAhTog99fHg==
X-Google-Smtp-Source: AA0mqf5ory1OhG7Na5zVVXjcLYy36xrTIivlxVIKKQi8e4DGPo71Kz5Rawog/uBIvlTrVtV6PN9Yag==
X-Received: by 2002:aa7:9243:0:b0:56b:fa67:1f7f with SMTP id 3-20020aa79243000000b0056bfa671f7fmr22439011pfp.19.1670990816786;
        Tue, 13 Dec 2022 20:06:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l6-20020a622506000000b00576e75e753asm8378718pfl.27.2022.12.13.20.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 20:06:56 -0800 (PST)
Date:   Tue, 13 Dec 2022 20:06:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] LoadPin: Ignore the "contents" argument of the LSM hooks
Message-ID: <202212132006.F29BB81A@keescook>
References: <20221209195453.never.494-kees@kernel.org>
 <20221212211319.GA15511@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212211319.GA15511@mail.hallyn.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 12, 2022 at 03:13:19PM -0600, Serge E. Hallyn wrote:
> On Fri, Dec 09, 2022 at 11:54:57AM -0800, Kees Cook wrote:
> > LoadPin only enforces the read-only origin of kernel file reads. Whether
> > or not it was a partial read isn't important. Remove the overly
> > conservative checks so that things like partial firmware reads will
> > succeed (i.e. reading a firmware header).
> > 
> > Fixes: 2039bda1fa8d ("LSM: Add "contents" flag to kernel_read_file hook")
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> 
> Acked-by: Serge Hallyn <serge@hallyn.com>
> 
> Seems reasonable.

Thanks!

> So the patch which introduced this was
> 2039bda1f: LSM: Add "contents" flag to kernel_read_file hook
> It sounds like the usage of @contents which it added to ima still
> makes sense.  But what about the selinux_kernel_read_file() one?

I think those continue to make sense since those LSM may be sensitive to
the _content_ (rather than the _origin_) of the file.

-Kees

-- 
Kees Cook
