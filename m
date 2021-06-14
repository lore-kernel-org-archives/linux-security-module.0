Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3609CC48BE6
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Jun 2021 22:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 167D761350
	for <linux-security-module@archiver.kernel.org>; Mon, 14 Jun 2021 22:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhFNWxL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 14 Jun 2021 18:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhFNWxL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 Jun 2021 18:53:11 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBC4C061574
        for <linux-security-module@vger.kernel.org>; Mon, 14 Jun 2021 15:50:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o88-20020a17090a0a61b029016eeb2adf66so370353pjo.4
        for <linux-security-module@vger.kernel.org>; Mon, 14 Jun 2021 15:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aciRkOzayHTWrTzSJKmVf13JrZoWxtea1Rx5Gqhhjmg=;
        b=nIwp+FZxbhehtXuzhGjb6YSm7hYtx2sK8E76UiJ5RWfCYIPYLLGpUB7odZ3pY6zsSv
         MgZhR/qK5xP1/GaERZvUSbyzt9nXy1Z26iJ6XYs/rswA09QvHCRH1Zm3w8c7Iiwk1CQV
         qLnd5kMTVtgJ7vCLk1aVpVW8+o/q0Sae0xiY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aciRkOzayHTWrTzSJKmVf13JrZoWxtea1Rx5Gqhhjmg=;
        b=iaxhW9CkuLNOuthhc3mZitDD9oWKHZA1QNmPz1+kyKYAFXl7ARmMyfqY0yIN7gnXwS
         gtBcvdzhi7DpFFoLoQGykeZoCFbKg99GXdWEBJzmBuHNHSZL5/TqkY5rnwma5OXdI5Rz
         L+DftDkwSgLT4Gxr4jCirljZ7wmahfIoyHcp2WMyaDWWDgiDkAPAGlxlQCMaUMy19aFk
         l1wvQJoFVyiS3NbjIP8Vc2JRxCUAoDYaZrvp1cxq60TKbnB2DwTi1KnJV8rSmD6omiYy
         vBh1o8cm3z/Vdyr5PHFs92VKeiXPQTfybuYls4Y/QwNUhnWWZM4kazs3MdBH4Pt/T7n/
         n2NA==
X-Gm-Message-State: AOAM5307gPcseDiauNOFeYd0kjeZnuTrA71Uy96TrtNUy9wNOSwLMmOT
        1qmLyR8MQ1uixf3mcUigIkqFIg==
X-Google-Smtp-Source: ABdhPJwpQvuLgIPeiP/70rxgicnMCOhXHbg3vIOZOxpkA7GVBdOBxrKghch1YeGH+GEgoNG2dpP50Q==
X-Received: by 2002:a17:902:c651:b029:118:896f:cead with SMTP id s17-20020a170902c651b0290118896fceadmr1287574pls.29.1623711052271;
        Mon, 14 Jun 2021 15:50:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d8sm13816594pfq.198.2021.06.14.15.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 15:50:51 -0700 (PDT)
Date:   Mon, 14 Jun 2021 15:50:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     youling 257 <youling257@gmail.com>
Cc:     torvalds@linux-foundation.org, christian.brauner@ubuntu.com,
        andrea.righi@canonical.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, regressions@lists.linux.dev,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH] proc: Track /proc/$pid/attr/ opener mm_struct
Message-ID: <202106141503.B3144DFE@keescook>
References: <20210608171221.276899-1-keescook@chromium.org>
 <20210614100234.12077-1-youling257@gmail.com>
 <202106140826.7912F27CD@keescook>
 <202106140941.7CE5AE64@keescook>
 <CAOzgRdZJeN6sQWP=Ou0H3bTrp+7ijKuJikG-f4eer5f1oVjrCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOzgRdZJeN6sQWP=Ou0H3bTrp+7ijKuJikG-f4eer5f1oVjrCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 15, 2021 at 02:46:19AM +0800, youling 257 wrote:
> I test this patch cause "init: cannot setexeccon(u:r:ueventd:s0)
> operation not permitted.
> init ctrl_write_limited.

Thanks for testing!

This appears to come from here:
https://github.com/aosp-mirror/platform_system_core/blob/master/init/service.cpp#L242


In setexeccon(), I see (pid=0, attr="exec"):

        fd = openattr(pid, attr, O_RDWR | O_CLOEXEC);
...
                        ret = write(fd, context2, strlen(context2) + 1);
...
        close(fd);


and openattr() is doing:
...
                rc = asprintf(&path, "/proc/thread-self/attr/%s", attr);
                if (rc < 0)
                        return -1;
                fd = open(path, flags | O_CLOEXEC);
...

I'm not sure how the above could fail. (mm_access() always allows
introspection...)

The only way I can understand the check failing is if a process did:

open, exec, write

But setexeccon() is not doing anything between the open and the write...

I will keep looking...

-Kees

-- 
Kees Cook
