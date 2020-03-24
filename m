Return-Path: <SRS0=jUwH=5J=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E07C41621
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 18:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04F1206F6
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 18:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T7DJhDYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgCXSdG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:33:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39925 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgCXSdF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Mar 2020 14:33:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id m1so7760825pll.6
        for <linux-security-module@vger.kernel.org>; Tue, 24 Mar 2020 11:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2LDhmPGgksoORBYsVldX+awgJg6yM4TQVCLJOVvQyz4=;
        b=T7DJhDYuMjXgKVhvaR13cI7YtMJw36RfORxHbnpmHSJHf+FJ4mzurw9+9eu3aG1hey
         wcvVsWV+FhtMo6rF4IpFMCkwmg6T5aQU7rUmzCkMn+ucj+iWDSF9DiizOoNKLp+4WZzt
         s+A5BBhj6yVmMsM1i4ia46rL5rNp+KTYOgDis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2LDhmPGgksoORBYsVldX+awgJg6yM4TQVCLJOVvQyz4=;
        b=bU8QEb28hoaNjEIDyZJbPXqZEU5AmuJLvoJ+WIE1WFVVD0dyjZJd2w7LkZvD6SRcn/
         EA4u3qRXSmIYI1umrYWa2JuOZcxTQE0/q3n8mDFirzY45GMoy82QdkY+I9wzFd1Tws79
         2BDWPwMAqhVTmxz17N/cWmjQqCpyCXB/T68K7tk5G/Hvq9g14eP/NZvV4R+tOYO0ipkH
         bdcJMm0YkqxiCjD9Dx8dcz+idHvOC+BHbSvUjo67Gs5QgZllUv9DjohJCGsP8U4grlBP
         4bRfYsMzxU1sKj3Lkzkmgj14oKNKDg81Ax15PetjT2ryEiWqCYHwnAobVAWkwmtG13NO
         gyFQ==
X-Gm-Message-State: ANhLgQ2m8J4epuxSlicP9Dl7s3IO945Ksihwxm2MW2auLz6FC1NKgwBe
        152Jpim6j0CwujcE2mHlk2X7JQ==
X-Google-Smtp-Source: ADFU+vvgbcz6Wt/SKJaFRiL+RAA8RKi7rgtSKvXONvciu9Bb1JJtlU3ttRoKj0XWQ2BwU+GwGGqB7Q==
X-Received: by 2002:a17:90b:3d1:: with SMTP id go17mr6230921pjb.99.1585074784269;
        Tue, 24 Mar 2020 11:33:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o20sm1095681pjr.35.2020.03.24.11.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:33:03 -0700 (PDT)
Date:   Tue, 24 Mar 2020 11:33:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>,
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
Message-ID: <202003241132.8F46BC0A@keescook>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-5-kpsingh@chromium.org>
 <CAEjxPJ4MukexdmAD=py0r7vkE6vnn6T1LVcybP_GSJYsAdRuxA@mail.gmail.com>
 <20200324145003.GA2685@chromium.org>
 <CAEjxPJ4YnCCeQUTK36Ao550AWProHrkrW1a6K5RKuKYcPcfhyA@mail.gmail.com>
 <d578d19f-1d3b-f60d-f803-2fcb46721a4a@schaufler-ca.com>
 <CAEjxPJ59wijpB=wa4ZhPyX_PRXrRAX2+PO6e8+f25wrb9xndRA@mail.gmail.com>
 <202003241100.279457EF@keescook>
 <20200324180652.GA11855@chromium.org>
 <CAEjxPJ7ebh1FHBjfuoWquFLJi0TguipfRq5ozaSepLVt8+qaMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEjxPJ7ebh1FHBjfuoWquFLJi0TguipfRq5ozaSepLVt8+qaMQ@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 24, 2020 at 02:21:30PM -0400, Stephen Smalley wrote:
> On Tue, Mar 24, 2020 at 2:06 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > On 24-Mär 11:01, Kees Cook wrote:
> > > Doesn't the existing int (*bpf_prog)(struct bpf_prog *prog); cover
> > > SELinux's need here? I.e. it can already examine that a hook is being
> > > created for the LSM (since it has a distinct type, etc)?
> >
> > I was about to say the same, specifically for the BPF use-case, we do
> > have the "bpf_prog" i.e. :
> >
> > "Do a check when the kernel generate and return a file descriptor for
> > eBPF programs."
> >
> > SELinux can implement its policy logic for BPF_PROG_TYPE_LSM by
> > providing a callback for this hook.
> 
> Ok.  In that case do we really need the capable() check here at all?

IMO, this is for systems without SELinux, where they're using the
capabilities as the basic policy for MAC management.

-- 
Kees Cook
