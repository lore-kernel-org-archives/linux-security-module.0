Return-Path: <SRS0=jUwH=5J=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9367C43331
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 17:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953A7206F6
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 17:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A7eeA9ij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgCXR5u (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:57:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44860 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgCXR5u (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Mar 2020 13:57:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id b72so9675585pfb.11
        for <linux-security-module@vger.kernel.org>; Tue, 24 Mar 2020 10:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JOJivn/BftzEZ5IpmOaohAsBUyD+vjO3m8vH92Fp/Bo=;
        b=A7eeA9ijeTau3nSmfOv/vILZI4/00pn6laDCAOb2Arw/2gf6gTqgjGnsrE+FigWfTx
         OfmC8WZBDn6Er2e6pPSl5GPWfxWF040jR6ZWhQCaqfOIY4l38DEKzI2ZTFuuFC2ZqlxH
         C3F1G8U5/B4fUtZn9hTCrn/vYp7NW9LCDRWS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JOJivn/BftzEZ5IpmOaohAsBUyD+vjO3m8vH92Fp/Bo=;
        b=Z2QlwH9a98C+V4MDuVZtYFKcW9I7KLzr2frYrf/2rnLmklGfMtjrDpEO1yx5ncqB20
         uWkiCf0212mVLDj+ydcRlmZ6F2tA1+nwOEehF6epPuXFnQA6slvHDWwnd4RvijBkEtVL
         fM5haiOg5O9C1ixCS85ljQU4aGNFQTRwVSMilWEGCZLtKm6LCf48UWpQ8tmEaWq1dVvS
         AGS3+udDvdxwTyUEWz677nFhgIRsMrmVdlKoLlvhSbIRAiB8k40Tph1jfkGvq6VYp1c1
         LlxF4/moKAMZCUeQi8FZFMallqK57JNPmjw5smntq6bljNHm+47QZ3+qIZ/C1FIHFChg
         joSA==
X-Gm-Message-State: ANhLgQ3nR8klxuxPctPjrQ2m/+ueeCq4L7Faic+q1MLPlmosNA0XgNCE
        S3rbG5eQmQbW48dpa+yfj2zWyw==
X-Google-Smtp-Source: ADFU+vv9SnIrpa1mjpQR944cfODa3gHYd2HMpjrEMhGZiis9W63g/b1w32nWiR9jV4l4/SOz7G0lkQ==
X-Received: by 2002:a63:ce42:: with SMTP id r2mr29908453pgi.106.1585072667397;
        Tue, 24 Mar 2020 10:57:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k3sm15204752pgh.34.2020.03.24.10.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 10:57:46 -0700 (PDT)
Date:   Tue, 24 Mar 2020 10:57:45 -0700
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v5 5/7] bpf: lsm: Initialize the BPF LSM hooks
Message-ID: <202003241056.C28E520@keescook>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-6-kpsingh@chromium.org>
 <6d45de0d-c59d-4ca7-fcc5-3965a48b5997@schaufler-ca.com>
 <20200324015217.GA28487@chromium.org>
 <CAEjxPJ7LCZYDXN1rYMBA2rko0zbTp0UU0THx0bhsAnv0Eg4Ptg@mail.gmail.com>
 <20200324144214.GA1040@chromium.org>
 <CAEjxPJ7GDA2PvYkoFhnE7gjr_n=ADCjy3XOwacfELY7evVJtJw@mail.gmail.com>
 <20200324145155.GB2685@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200324145155.GB2685@chromium.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 24, 2020 at 03:51:55PM +0100, KP Singh wrote:
> On 24-Mär 10:51, Stephen Smalley wrote:
> > On Tue, Mar 24, 2020 at 10:42 AM KP Singh <kpsingh@chromium.org> wrote:
> > >
> > > On 24-Mär 10:37, Stephen Smalley wrote:
> > > > On Mon, Mar 23, 2020 at 9:52 PM KP Singh <kpsingh@chromium.org> wrote:
> > > > >
> > > > > On 23-Mär 18:13, Casey Schaufler wrote:
> > > > > > Have you given up on the "BPF must be last" requirement?
> > > > >
> > > > > Yes, we dropped it for as the BPF programs require CAP_SYS_ADMIN
> > > > > anwyays so the position ~shouldn't~ matter. (based on some of the
> > > > > discussions we had on the BPF_MODIFY_RETURN patches).
> > > > >
> > > > > However, This can be added later (in a separate patch) if really
> > > > > deemed necessary.
> > > >
> > > > It matters for SELinux, as I previously explained.  A process that has
> > > > CAP_SYS_ADMIN is not assumed to be able to circumvent MAC policy.
> > > > And executing prior to SELinux allows the bpf program to access and
> > > > potentially leak to userspace information that wouldn't be visible to
> > > > the
> > > > process itself. However, I thought you were handling the order issue
> > > > by putting it last in the list of lsms?
> > >
> > > We can still do that if it does not work for SELinux.
> > >
> > > Would it be okay to add bpf as LSM_ORDER_LAST?
> > >
> > > LSMs like Landlock can then add LSM_ORDER_UNPRIVILEGED to even end up
> > > after bpf?
> > 
> > I guess the question is whether we need an explicit LSM_ORDER_LAST or
> > can just handle it via the default
> > values for the lsm= parameter, where you are already placing bpf last
> > IIUC?  If someone can mess with the kernel boot
> > parameters, they already have options to mess with SELinux, so it is no worse...
> 
> Yeah, we do add BPF as the last LSM in the default list. So, I will
> avoid adding LSM_ORDER_LAST for now.

FWIW, this is my preference as well. If there ends up being a stronger
need, then we can implement LSM_ORDER_LAST at that time.

-- 
Kees Cook
