Return-Path: <SRS0=jUwH=5J=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B399C2BAEE
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 18:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661672076E
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 18:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X8BpTUsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgCXSe5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:34:57 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55894 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbgCXSe4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Mar 2020 14:34:56 -0400
Received: by mail-pj1-f67.google.com with SMTP id mj6so1972051pjb.5
        for <linux-security-module@vger.kernel.org>; Tue, 24 Mar 2020 11:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mx9h2G9Pa234gVddEgnTViqlM2nzOYE5T6EE2ivPTBA=;
        b=X8BpTUshqVTp5ZrfGENJjA7S8D3PMkC1H9raELqRdSdjLNe5sZB5Y4RMX/nghlzJ8E
         1CsWUkd+SHVMvC1UIUpx6JTnz1l2RNGsNZUks9+wLQ7kIaqQcNp/2bungkmZ4F+++aNv
         F9F+k+zvWPAIpXVP3evPY5DDeIBLOdTEoj2Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mx9h2G9Pa234gVddEgnTViqlM2nzOYE5T6EE2ivPTBA=;
        b=ee+Wh8WolZRIToqZcGTS3kZKYb7kTlW693KEnEqSLMRIv404+rKdeOYQUb+Wq7EalQ
         Kh+hFekG6c7RfHRrIlhsMuJ9EMrXT5xx1sYelbhkZTUVsjPZ5hz/qOES5ENXNvRKMIY8
         i72TnL+boIO8VHWzD+RSDOj8fH261Dv94er6jZraqMkl3QSIe6bjBoxMX+iKQj6IXYpm
         VqJVrCCh3pKMVFRcAc4sVavzBBbUF9zEqu3bb8dPmWyJJ7eobMvzhHDUcSs02mZv8ZmQ
         KDKbvxukDK1ORGUR8TWxc2xHEhq87UWgdVQnEBEaQ/51+CeeP5ndXAUavWJDLj4dQS6F
         Kzaw==
X-Gm-Message-State: ANhLgQ3efQT2mToo5Jrj7g7LHnQmZ04HI8plMWu1Q9Qz9rD9A2mbwPT+
        Toml8E1CgFI45F0f86g91w4V8g==
X-Google-Smtp-Source: ADFU+vuY4HhM8vNaIQSER7/NiwCNGWQLQ6U2UpEtoYs0U+twgNdazhReNufRdZraq2u/dEMlw6NdIQ==
X-Received: by 2002:a17:902:850a:: with SMTP id bj10mr27476778plb.28.1585074894587;
        Tue, 24 Mar 2020 11:34:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x135sm15801559pgx.41.2020.03.24.11.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:34:53 -0700 (PDT)
Date:   Tue, 24 Mar 2020 11:34:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH bpf-next v5 4/7] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <202003241133.16C02BE5B@keescook>
References: <CAEjxPJ4MukexdmAD=py0r7vkE6vnn6T1LVcybP_GSJYsAdRuxA@mail.gmail.com>
 <20200324145003.GA2685@chromium.org>
 <CAEjxPJ4YnCCeQUTK36Ao550AWProHrkrW1a6K5RKuKYcPcfhyA@mail.gmail.com>
 <d578d19f-1d3b-f60d-f803-2fcb46721a4a@schaufler-ca.com>
 <CAEjxPJ59wijpB=wa4ZhPyX_PRXrRAX2+PO6e8+f25wrb9xndRA@mail.gmail.com>
 <202003241100.279457EF@keescook>
 <20200324180652.GA11855@chromium.org>
 <CAEjxPJ7ebh1FHBjfuoWquFLJi0TguipfRq5ozaSepLVt8+qaMQ@mail.gmail.com>
 <20200324182759.GA5557@chromium.org>
 <20200324183130.GA6784@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200324183130.GA6784@chromium.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 24, 2020 at 07:31:30PM +0100, KP Singh wrote:
> On 24-Mär 19:27, KP Singh wrote:
> > We do not have a specific capable check for BPF_PROG_TYPE_LSM programs
> > now. There is a general check which requires CAP_SYS_ADMIN when
> > unprivileged BPF is disabled:
> > 
> > in kernel/bpf/sycall.c:
> > 
> >         if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
> > 	        return -EPERM;
> > 
> > AFAIK, Most distros disable unprivileged eBPF.
> > 
> > Now that I look at this, I think we might need a CAP_MAC_ADMIN check
> > though as unprivileged BPF being enabled will result in an
> > unprivileged user being able to load MAC policies.
> 
> Actually we do have an extra check for loading BPF programs:
> 
> 
> in kernel/bpf/syscall.c:bpf_prog_load
> 
> 	if (type != BPF_PROG_TYPE_SOCKET_FILTER &&
> 	    type != BPF_PROG_TYPE_CGROUP_SKB &&
> 	    !capable(CAP_SYS_ADMIN))
> 		return -EPERM;
> 
> Do you think we still need a CAP_MAC_ADMIN check for LSM programs?

IMO, these are distinct privileges on the non-SELinux system. I think
your patch is fine as-is.

-- 
Kees Cook
