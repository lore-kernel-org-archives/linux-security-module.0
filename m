Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DA9C7EE22
	for <linux-security-module@archiver.kernel.org>; Thu, 11 May 2023 21:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbjEKVzK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 May 2023 17:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbjEKVzJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 May 2023 17:55:09 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C33F3A93
        for <linux-security-module@vger.kernel.org>; Thu, 11 May 2023 14:55:07 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-643b60855c8so7124425b3a.2
        for <linux-security-module@vger.kernel.org>; Thu, 11 May 2023 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683842106; x=1686434106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wYm5zbUoXvdWIIZXy8x+n7jNjexrKMjFs8iZueww7nk=;
        b=oXs2eM/yvZexnnpdmxfsrd7zRsaq3g2sJh2MHT1oELeZFpkKjkBEJIkOJR/jDAePzC
         9fHDcwvGL0LoPfoexCswVshOQpWmlVqekET0XPyMhlHP/duuOOuBDgXwALhf2SjKEzpx
         jDBoIlxvTPtHLtaMU2EMRkiDNW3SlWHc6guPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683842106; x=1686434106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYm5zbUoXvdWIIZXy8x+n7jNjexrKMjFs8iZueww7nk=;
        b=T2nJEk6WQDb9w+Vtr1HkpBZgkBbtnsJp5QVZyvx/KF183orkNliB8FFMn9736Dq68b
         fZjdWqSdN/Q8bNJiR6MHQWJQxIMxljVLG24BINUywXom0cq7SD1PcQygAC/mHmkhDWGj
         ObpcPk252DmDrIdLhzb8G+d0nH7HiMyFdqcYq+cDyAPP9ch3Bwtd4oJcwtABSf0hPC6V
         0WqkPp6nnZt1P4nDY7O85jomEUHHlSZNkcyP2hIIQdgQ2nTH5ZP86OUC8VNyth0XTos2
         RWPkp+pj/ZX2fXXTl3IBtl8Od2lYh5K7Cx+gDX/bdacULzwpizkh8F+r5h9brgJARTNd
         TfuQ==
X-Gm-Message-State: AC+VfDwXR6M1rXKArA1t8+2n/WjyF4syAjkx3ymzdFR0NiOYLPlztMQv
        Ndj2SvmDDQCNAISDFMM6oEjcQg==
X-Google-Smtp-Source: ACHHUZ5VnBXv0IpdLguOXUNVfu9OdAeXFEuVvxq29s+dS+1xyrg5TY3p75gjO9lG9WeyS9PiHyRwjg==
X-Received: by 2002:a05:6a00:218a:b0:637:aea0:b23d with SMTP id h10-20020a056a00218a00b00637aea0b23dmr31347173pfi.10.1683842106648;
        Thu, 11 May 2023 14:55:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f3-20020aa78b03000000b0064385a057dfsm5754939pfd.181.2023.05.11.14.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 14:55:06 -0700 (PDT)
Date:   Thu, 11 May 2023 14:55:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] apparmor: aa_buffer: Convert 1-element array to flexible
 array
Message-ID: <202305111453.082DC179@keescook>
References: <20230511213441.never.401-kees@kernel.org>
 <7085879d-4d21-b90a-c08d-60450d1c7d38@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7085879d-4d21-b90a-c08d-60450d1c7d38@canonical.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 11, 2023 at 02:48:29PM -0700, John Johansen wrote:
> On 5/11/23 14:34, Kees Cook wrote:
> > In the ongoing effort to convert all fake flexible arrays to proper
> > flexible arrays, replace aa_buffer's 1-element "buffer" member with a
> > flexible array.
> > 
> > Cc: John Johansen <john.johansen@canonical.com>
> > Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: apparmor@lists.ubuntu.com
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Acked-by: John Johansen <john.johansen@canonical.com>
> 
> I have pulled this into my tree.

Thanks!

> 
> > ---
> > One thing I notice here is that it may be rare for "buffer" to ever change
> > for a given kernel. Could this just be made PATH_MAX * 2 directly and
> > remove the module parameter, etc, etc?
> 
> possibly. Currently the only use case I know of is for some stress testing
> where we drop the buffer size down really small to try and break things.
> This isn't part of the regular regression runs and could be handle with a
> config/compile time to a buffer size constant.

Okay, cool. I figured the conversion to fixed-size is sort of nice, but
it probably won't be of much use as-is since it's the buffer, not the
aa_buffer, is passed around. The compiler would still not have any idea
what the bounds are. :)

-- 
Kees Cook
