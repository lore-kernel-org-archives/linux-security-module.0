Return-Path: <SRS0=jUed=4K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A423C35671
	for <linux-security-module@archiver.kernel.org>; Sat, 22 Feb 2020 04:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C6B208C4
	for <linux-security-module@archiver.kernel.org>; Sat, 22 Feb 2020 04:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HC6tB5/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgBVE0H (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Feb 2020 23:26:07 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45984 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgBVE0H (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Feb 2020 23:26:07 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so1992591pgk.12
        for <linux-security-module@vger.kernel.org>; Fri, 21 Feb 2020 20:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S04MpDY/ruT9R3530Z87j5UAy18sgkgPvdS5rq+kd3k=;
        b=HC6tB5/n3jprjIUAPVp7s8TE+lw3DArPemCjTLFf6SZTq8rdljmvjDQKfwnpDCqu9M
         McuEh8+mx8FGgpNOPUbP/5TCKlQV1w1VEu4/HSjSNXVsfPT9ASGqbZKiIFvVJAlUrr86
         aZuMUWYfnYI9yYDHnbwRw6bEQzeTrErT1JXZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S04MpDY/ruT9R3530Z87j5UAy18sgkgPvdS5rq+kd3k=;
        b=QT6csZ3yO/0F7jO2n9Ln+7WIU6q/cv0NbJXguBtzhFWqeRBzlUk2vv+9oYpToC62+r
         umZwOAFd5Nk3uCwZV9iQyA1yvgyoPh6wbuc6q4xyJmrsl3IitmfA3Zqf+0XCyKUI3Vqz
         TYzWEGcKIXrVfjEm8x8+fS3brOL9brxu45IEdjp7BfjI2PO8KOGoqkPUa7o/411vZUU0
         SV78dRyJ4onwwiB6cHDcD75Nvu3eeRl1L7Rs9mHCl2JKzA27T2s1bxW5kKYJx/1DyusJ
         bbaH3Y21SP6bQW9ICvN/eBlKpw0dvqQZV32ay8NeFw7Z8goLxBQ+9WChEPxTIgUanICd
         W1lw==
X-Gm-Message-State: APjAAAXpuTVFwQN8IQlVXh0gT7KcQ2QDtrFy4TQXWsIOg4WvRmGQVvmy
        v8OKBf1J//fsENjRUekVHnNUXw==
X-Google-Smtp-Source: APXvYqynLpaT1SHFc7hteRLE/Am8rkGvVcqos0AxtZQFh6Ok/U/TQctt8ObsfFGGlRMXV0KtzIJk4Q==
X-Received: by 2002:a62:1548:: with SMTP id 69mr41986772pfv.239.1582345566578;
        Fri, 21 Feb 2020 20:26:06 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c15sm4342928pfo.137.2020.02.21.20.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 20:26:05 -0800 (PST)
Date:   Fri, 21 Feb 2020 20:26:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v4 4/8] bpf: lsm: Add support for
 enabling/disabling BPF hooks
Message-ID: <202002212023.1712A8AB@keescook>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <20200220175250.10795-5-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220175250.10795-5-kpsingh@chromium.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Feb 20, 2020 at 06:52:46PM +0100, KP Singh wrote:
> index aa111392a700..569cc07d5e34 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -804,6 +804,13 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
>  			break;
>  		}
>  	}
> +#ifdef CONFIG_BPF_LSM
> +	if (HAS_BPF_LSM_PROG(vm_enough_memory)) {
> +		rc = bpf_lsm_vm_enough_memory(mm, pages);
> +		if (rc <= 0)
> +			cap_sys_admin = 0;
> +	}
> +#endif

This pattern of using #ifdef in code is not considered best practice.
Using in-code IS_ENABLED(CONFIG_BPF_LSM) is preferred. But since this
pattern always uses HAS_BPF_LSM_PROG(), you could fold the
IS_ENABLED() into the definition of HAS_BPF_LSM_PROG itself -- or more
likely, have the macro defined as:

#ifdef CONFIG_BPF_LSM
# define HAS_BPF_LSM_PROG(x)    ....existing implementation....
#else
# define HAS_BPF_LSM_PROG(x)	false
#endif

Then none of these ifdefs are needed.

-- 
Kees Cook
