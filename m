Return-Path: <SRS0=jUwH=5J=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE8FC41621
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 14:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FC520775
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 14:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tuKVjZX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgCXOuY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:50:24 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41375 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbgCXOuY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Mar 2020 10:50:24 -0400
Received: by mail-ot1-f66.google.com with SMTP id f52so273887otf.8;
        Tue, 24 Mar 2020 07:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vPW3tS8ZdMqCvi7XvsqrZo8CXz6jQvmwEfRH7GXH4C4=;
        b=tuKVjZX/5WKnCjHFD8Z3PwFFqG2Acy1CnjbEMB1kkgc509hAf4q25KWhwp5sWFT9IC
         3l6wPcqGdMkc1pCKLTVjsuKVhkmbbJ1TkKtwhp5kCVwrDu91CmRMnsE5hxf7Rsb8DN7X
         3Z9SRAhha2FvxA0nRxIPy4sJLdvIqy5TGh7zzo4CwKDEo3uzeWtQFH8i377KKb8tnj27
         0LwrEDK2IvdQiMDYaaGd/CT8ux2lVhJbP6z2jCyE4oyfL53BEi9b7wWLmvUgT21pCnBb
         N+90Q+dTTqS2K1PUk1SD09J2S4gHqhxhDKNoxhu82QBoto470UqRSr03PMMTOOoAYePl
         a84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vPW3tS8ZdMqCvi7XvsqrZo8CXz6jQvmwEfRH7GXH4C4=;
        b=mHfMWzO7GA26ml95TkvXcVQCNul3OC5ATecU8kDGgYDDR3jQE4l1nFBcjTWU26gEYT
         GU52GnEZPpR/+gw0SVqupHTXS9lbW8GLyyzLfdPlFWmAqbFG9xhS5+GZzMxfwEiBYH2C
         pkLJqOUn0MOBArh/PX2KM+Qit9cFq6WnzAI92P9NXKMSsrXL6oaxPybxllGVI6KV3MY8
         MI28Z9tULxV/xZ+PnKQHklp43rL0dkeWuk/i7Fhy+2VuP9Vjs1TeZyVgBqU3Orfxr7vF
         zESmsE0x2cd8UB55QieHjXgDlVi4bS0XmwSWF5jI1R0TYCT1uE5qmG7T+WFZR/peaCIK
         ++lw==
X-Gm-Message-State: ANhLgQ39a0ToDQ9/q9bROcceY0TgWpfEhvNg5i8uKwQ3NZyqkOmMQeWI
        Hf4rVF+GaxJXpcj+064JWVJO2KnWz2BHELcNRmU=
X-Google-Smtp-Source: ADFU+vsQLNpAvhv+owsmyh+PvfzJhxLQvctiVrLBt7/M93V57pbNtp6LUg2LrDYgYBhrvwWlbevHKmq07xU4dRxStL0=
X-Received: by 2002:a9d:7dc4:: with SMTP id k4mr21005538otn.89.1585061424075;
 Tue, 24 Mar 2020 07:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200323164415.12943-1-kpsingh@chromium.org> <20200323164415.12943-6-kpsingh@chromium.org>
 <6d45de0d-c59d-4ca7-fcc5-3965a48b5997@schaufler-ca.com> <20200324015217.GA28487@chromium.org>
 <CAEjxPJ7LCZYDXN1rYMBA2rko0zbTp0UU0THx0bhsAnv0Eg4Ptg@mail.gmail.com> <20200324144214.GA1040@chromium.org>
In-Reply-To: <20200324144214.GA1040@chromium.org>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 24 Mar 2020 10:51:32 -0400
Message-ID: <CAEjxPJ7GDA2PvYkoFhnE7gjr_n=ADCjy3XOwacfELY7evVJtJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/7] bpf: lsm: Initialize the BPF LSM hooks
To:     KP Singh <kpsingh@chromium.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 24, 2020 at 10:42 AM KP Singh <kpsingh@chromium.org> wrote:
>
> On 24-M=C3=A4r 10:37, Stephen Smalley wrote:
> > On Mon, Mar 23, 2020 at 9:52 PM KP Singh <kpsingh@chromium.org> wrote:
> > >
> > > On 23-M=C3=A4r 18:13, Casey Schaufler wrote:
> > > > Have you given up on the "BPF must be last" requirement?
> > >
> > > Yes, we dropped it for as the BPF programs require CAP_SYS_ADMIN
> > > anwyays so the position ~shouldn't~ matter. (based on some of the
> > > discussions we had on the BPF_MODIFY_RETURN patches).
> > >
> > > However, This can be added later (in a separate patch) if really
> > > deemed necessary.
> >
> > It matters for SELinux, as I previously explained.  A process that has
> > CAP_SYS_ADMIN is not assumed to be able to circumvent MAC policy.
> > And executing prior to SELinux allows the bpf program to access and
> > potentially leak to userspace information that wouldn't be visible to
> > the
> > process itself. However, I thought you were handling the order issue
> > by putting it last in the list of lsms?
>
> We can still do that if it does not work for SELinux.
>
> Would it be okay to add bpf as LSM_ORDER_LAST?
>
> LSMs like Landlock can then add LSM_ORDER_UNPRIVILEGED to even end up
> after bpf?

I guess the question is whether we need an explicit LSM_ORDER_LAST or
can just handle it via the default
values for the lsm=3D parameter, where you are already placing bpf last
IIUC?  If someone can mess with the kernel boot
parameters, they already have options to mess with SELinux, so it is no wor=
se...
