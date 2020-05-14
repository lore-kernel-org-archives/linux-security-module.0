Return-Path: <SRS0=SKQR=64=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA22FC433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 14 May 2020 15:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F1920657
	for <linux-security-module@archiver.kernel.org>; Thu, 14 May 2020 15:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PiA5t1EC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgENPtA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 14 May 2020 11:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgENPs7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 May 2020 11:48:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA50C05BD43
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2020 08:48:59 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t40so12615082pjb.3
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2020 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xc0xMz/yvwFH4+2sZUX9Mzn97it6v0pR0LQRUSS/E70=;
        b=PiA5t1ECMRuuR+HXKMfA3cTte/yc0Jb2wZpjTuONoyQT8+eOxJ6lAv6xWFVheYAPQX
         mop7QRaUoUv6SEjqXRjbU5K99Kz3EUrsQLuoTiltzApmHSCKH5G+nrxw8ti9nhdb7fqe
         jWfLI5KiJD47MHevRL9KAaQDdLmDrDUpw7Tiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xc0xMz/yvwFH4+2sZUX9Mzn97it6v0pR0LQRUSS/E70=;
        b=BocTACM6ubBpd9PcDUmMoufazO4dAw3kz6nnmRbmpJwArFJiSel6PHPKDoPcCyfVl9
         sukN1R167reya9Hd21L+O8jXeCqaIjipYQ5i5i3i6e3P3ijoOg3X6mxdKN63ZMjOmLsu
         YuDr1Uo4Qe5yjFnCjOc0cj9nJwcfeiwkd6ICvrTPl2H4h0UP0cZVwbNXYxxr2roGrjGq
         lU7WPVOb7joYjrqZKmRHucgDS2ORDZ4eiRWDtyrSaYRW3koabyP4Ig755bqajqJu/w/z
         ngb6q9aMn187qWcPqxgKIj0IgSaGfITD30B2jPr8cCyE4ikPzaDvvWPum0NljqLyVLZw
         qtwg==
X-Gm-Message-State: AGi0PuahtxDeo8ZFeo8TdQCyQCnY5N2T162YE489/4nPCIAMA0r0Ma+/
        V3+Rm88CB1BTHYmwjPwu7blGyA==
X-Google-Smtp-Source: APiQypLdE3XgkOQdsZ7skOwgbr0+jpPDHHkYRGIHpuO9kIkbSs8cT1F1ifdldVqKmAC4ik2usLfWlA==
X-Received: by 2002:a17:90a:f995:: with SMTP id cq21mr39335143pjb.56.1589471339202;
        Thu, 14 May 2020 08:48:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cx11sm2467105pjb.36.2020.05.14.08.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 08:48:58 -0700 (PDT)
Date:   Thu, 14 May 2020 08:48:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Lev R. Oshvang ." <levonshe@gmail.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] fs: Add a MAY_EXECMOUNT flag to infer the noexec
 mount property
Message-ID: <202005140845.16F1CDC@keescook>
References: <20200505153156.925111-1-mic@digikod.net>
 <20200505153156.925111-3-mic@digikod.net>
 <202005121407.A339D31A@keescook>
 <CAP22eLEWW+KjD5rHosZV8vSuBB4YBLh0BQ=4-=kJQt9o=Fx1ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP22eLEWW+KjD5rHosZV8vSuBB4YBLh0BQ=4-=kJQt9o=Fx1ig@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 14, 2020 at 11:14:04AM +0300, Lev R. Oshvang . wrote:
> New sysctl is indeed required to allow userspace that places scripts
> or libs under noexec mounts.

But since this is a not-uncommon environment, we must have the sysctl
otherwise this change would break those systems.

> fs.mnt_noexec_strict =0 (allow, e) , 1 (deny any file with --x
> permission), 2 (deny when O_MAYEXEC absent), for any file with ---x
> permissions)

I don't think we want another mount option -- this is already fully
expressed with noexec and the system-wide sysctl.

-- 
Kees Cook
