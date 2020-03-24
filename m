Return-Path: <SRS0=jUwH=5J=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ADEC54EEB
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 21:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BB62070A
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Mar 2020 21:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585084939;
	bh=X6ebq0WcchKrdaWOlTlc8AvYM4jWLIYlXO6WwrHjwSA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TpgEHguocC9O2lCnYpJL6m0abiiy9yZxMLyqDZLN3yZfUz1vOwHanBcGYplbl6fBJ
	 mGaSJtfQRVxKq7tixYHg0hjKVOgSVt6QNHdq/ZMDYMAZ4ayhLKHlKau/Zn3q6g4dop
	 bvIkVlMCbLyt0B59xI9GcTWjQ4F9KfPySw78sARE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgCXVWS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Mar 2020 17:22:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41837 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgCXVWS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Mar 2020 17:22:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id z23so28311lfh.8
        for <linux-security-module@vger.kernel.org>; Tue, 24 Mar 2020 14:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0AQOrscsNAyPOgnjIz1wdZ8BwbWscK7BvSW7dZFNMU=;
        b=TU+v6vgTqqL8DSRyHNIS3zPA2Au3s8bOdz4RjYVrI59y/xJG37DuCzUkFedo8prEM1
         kEhbDC8RUbuZ44J4woqibSX2DnsCF77IrNvFFBgUdsgFnP87BEfOj65kKyLU5UPa/XiH
         yLDUovevdVM9pFj6antE7mF1/9gnUPays5DSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0AQOrscsNAyPOgnjIz1wdZ8BwbWscK7BvSW7dZFNMU=;
        b=pw5d590Vb6TzjQ+ENUrlF53wosLQsO2Cjhc0NKCpoNUSrLCWDjl0uUKK4mSI8V4Eg7
         9O8APIgZFeyfrjALwez9N9dYGoPOUpbRQ2Gi7DT2CiRuuAB+iTo8cGUkeWq5WJq3NcoI
         QA7DfF/PAcI2V2ie7ZaUbwKZRkAxqpBSYHc+ZNRFEZAsXDRvKLocLEf1NV69SzLcyMCZ
         A16tatNVUSWuiSieEq3OSf6bJsivWlRtPjodlJk03CHBZtToU0znuunVrhaF5sRUQoxK
         VsLBD4obSiFYG1Pn8RLQK+wL44QBcPRmYgkB7LcEHygZLhqZyrbCgRL63tdHlTH6hmi3
         je6A==
X-Gm-Message-State: ANhLgQ16+9F/4BJD1847JQ+ZUjrtd9J/jPwCRlkOioj7vXrONLokxpGc
        DF/DUMFOfhI9YaeNz79GdUk2fP6Qj7w=
X-Google-Smtp-Source: ADFU+vvHtG1124aZDHtbKQv86wRwx6EhWeHTEXc7wQ9zQN+I5NyALTQYgfqh1PjuJ9InlPjhdEUDQQ==
X-Received: by 2002:a05:6512:50e:: with SMTP id o14mr31416lfb.85.1585084936532;
        Tue, 24 Mar 2020 14:22:16 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id i13sm10603926lja.73.2020.03.24.14.22.15
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 14:22:15 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id j15so37727lfk.6
        for <linux-security-module@vger.kernel.org>; Tue, 24 Mar 2020 14:22:15 -0700 (PDT)
X-Received: by 2002:a19:f015:: with SMTP id p21mr60990lfc.10.1585084934903;
 Tue, 24 Mar 2020 14:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200324204449.7263-1-gladkov.alexey@gmail.com> <20200324204449.7263-4-gladkov.alexey@gmail.com>
In-Reply-To: <20200324204449.7263-4-gladkov.alexey@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Mar 2020 14:21:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXbgW7-FYL4Rkaoh8qX+CkS5saVGP2hsJPV0c+EZ6K7A@mail.gmail.com>
Message-ID: <CAHk-=whXbgW7-FYL4Rkaoh8qX+CkS5saVGP2hsJPV0c+EZ6K7A@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 3/8] proc: move hide_pid, pid_gid from
 pid_namespace to proc_fs_info
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 24, 2020 at 1:46 PM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> +/* definitions for hide_pid field */
> +enum {
> +       HIDEPID_OFF       = 0,
> +       HIDEPID_NO_ACCESS = 1,
> +       HIDEPID_INVISIBLE = 2,
> +};

Should this enum be named...

>  struct proc_fs_info {
>         struct pid_namespace *pid_ns;
>         struct dentry *proc_self;        /* For /proc/self */
>         struct dentry *proc_thread_self; /* For /proc/thread-self */
> +       kgid_t pid_gid;
> +       int hide_pid;
>  };

.. and then used here instead of "int"?

Same goes for 'struct proc_fs_context' too, for that matter?

And maybe in the function declarations and definitions too? In things
like 'has_pid_permissions()' (the series adds some other cases later,
like hidepid2str() etc)

Yeah, enums and ints are kind of interchangeable in C, but even if it
wouldn't give us any more typechecking (except perhaps with sparse if
you mark it so), it would be documenting the use.

Or am I missing something?

Anyway, I continue to think the series looks fine, bnut would love to
see it in -next and perhaps comments from Al and Alexey Dobriyan..

            Linus
