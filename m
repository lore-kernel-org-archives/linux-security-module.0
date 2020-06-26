Return-Path: <SRS0=ekpI=AH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A6FC433E0
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Jun 2020 15:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A570020706
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Jun 2020 15:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SrKvBemi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgFZPhI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgFZPhH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Jun 2020 11:37:07 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960E1C03E97A
        for <linux-security-module@vger.kernel.org>; Fri, 26 Jun 2020 08:37:07 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a14so235681pfi.2
        for <linux-security-module@vger.kernel.org>; Fri, 26 Jun 2020 08:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6C2dkYripoUvFAkhVVBU46RoeX5yKqOT+wsgB4Jgk8E=;
        b=SrKvBemio7EuFZusYOxZ/gtaKjJLh+SpEyc1HJor/6qvsc6RX7kfLlFMNEjQUMswv5
         4mVNtVnj7vIKGo5kYtwB4d0eFniN/JAJMsksHnt/SZ+dNJFZzT3nKFoGrIcwej8696wG
         iUoewk8KYwIkqJ91skI9+gMp9SKe2ZC4UVfyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6C2dkYripoUvFAkhVVBU46RoeX5yKqOT+wsgB4Jgk8E=;
        b=eqlb5VXA3BBgkZwJ5Yf4+K8ZD2SPctcEcnzAzSu1TBDc0gYoeTYF5DYH/CjLws5d4k
         59eUJlWUm+nywVL2nHSNzf6xZxZU8dZAG/KJdnCViuu7JA+E+cVSN3YtSyJkEBrFs/xm
         i9UqkYGi1XERMVhLhOzqD944WMnMGPfm9KrOp4Wwk9K0n9p+dWlrnVlkuziR/Japorkd
         QVWooUY+2+JPZ4PCz4oiMThYbPglIZ+t2kG+VdjDLqQJ66Ad6/D8CKzcI6AWeMX8/ypp
         nbqQpd8OxbN3VEI0l0nmh2CZuU2cXYNroi7WsVpinVzUoSF6Qtyw/evmHYZhKoVOgE3Y
         qiyA==
X-Gm-Message-State: AOAM532B0gMgCn8s100cWRqxrjx5cPw7Vxq5/w5JlJv6HIlMk9U8CmQP
        bZ/jGptniD3sIZOi2SEJjm6FbQ==
X-Google-Smtp-Source: ABdhPJzHo+CobTVdVc+jmkCGAZ9c+NGWMDI+A+QaB2uAWrNIdixaP529YRgNwp0CVxWTojrygH9RNA==
X-Received: by 2002:aa7:98c1:: with SMTP id e1mr3488173pfm.318.1593185827209;
        Fri, 26 Jun 2020 08:37:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 9sm10803045pfh.160.2020.06.26.08.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 08:37:06 -0700 (PDT)
Date:   Fri, 26 Jun 2020 08:37:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 06/14] umd: For clarity rename umh_info umd_info
Message-ID: <202006260836.FB867484@keescook>
References: <20200625095725.GA3303921@kroah.com>
 <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com>
 <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
 <87o8p6f0kw.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8p6f0kw.fsf_-_@x220.int.ebiederm.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 26, 2020 at 07:55:43AM -0500, Eric W. Biederman wrote:
> This structure is only used for user mode drivers so change
> the prefix from umh to umd to make that clear.

Should bpfilter_umh get renamed to bpfilter_umd at some point in this
series too?

-- 
Kees Cook
