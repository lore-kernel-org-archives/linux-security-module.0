Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BB8C433ED
	for <linux-security-module@archiver.kernel.org>; Wed, 12 May 2021 17:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E02613E9
	for <linux-security-module@archiver.kernel.org>; Wed, 12 May 2021 17:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbhELRIG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 May 2021 13:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244517AbhELQuk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 May 2021 12:50:40 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A965FC022A8E
        for <linux-security-module@vger.kernel.org>; Wed, 12 May 2021 09:23:48 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n2so35862128ejy.7
        for <linux-security-module@vger.kernel.org>; Wed, 12 May 2021 09:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPhA/5oxp7tvZCmXw/waTJLyyY6raAYfgYxrBgAmwyM=;
        b=SYoFDx/Zzixg1Z4D0jeH1vTMiEe+P69opHbSwG8ECggk/vHidyrKZ9K2E4m0b+i3i1
         K83HryhQJQQwyKJD2wDav1FQRNkauXOu/e2wPsrp8hps5qNCRyxUi+JtvCuo1w5DpHM5
         3B6+LRj1a92CVU1h2YidjPJ2DJSGjKhcn7UqFRPOLTObGYJ/WxCUgH72f6Yvw0uiGs5n
         Txd5KN2fMIdiYQNP7BEVnNiFOOWqyodtFLagVJKZ6T7jIYstslYAvw3ualmCWqdYKfCt
         RL+Xw+9+hqfnmQMJJNjbVGfkmYMyoJyIkDMJLexvX85Mkohyu/NVfsV5hc+WjMwpeN5n
         anjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPhA/5oxp7tvZCmXw/waTJLyyY6raAYfgYxrBgAmwyM=;
        b=YJ7+KnFUK8HRZ8vjk0//wbyB7gS8BLSVR2yRS3N7bfMtQ88T6phHInHV1gffMAxMJw
         c8VIc9OIFdC0PajynRYnMsNt/HkrVmMr9UgI17PYsVf122U3TqnJArv4fIIcwJlTZJ/q
         XglFkJ4RNnX/DV7gh6CrOTBjiwRl5I7+t/ek+XAOixGkF1LdT16/G24VZf9XEs433cQA
         fLHup1gYN69iJ7BOVmMLAvL6n7WGt5I6RlYvung18K+3DZ8FUU/NpVtuyZokhefcsXDs
         E0WrfkIBHjdtWhZ7P3Qqvgnvqk4ViNSMhbChsKmQlZk6umy0dZ7qxU6KtFh2IF5fba2r
         rqsA==
X-Gm-Message-State: AOAM533zG/cUeljANhw0UlXW+IDHjeA5nYo2/AeTWbZRc7HQ8N9ftVSL
        xzeQKsmDbOSdhF+0Ps6y1qkUUj9GxnA7qlxDbA4r
X-Google-Smtp-Source: ABdhPJxzTvz4e3IxBmnaK3WmYXJZbzN5Zq06UuaBzHtcPCb3mZVtS8qUf8gHkah92LuUo/6uuvWFQnDEFJKIFg48vRY=
X-Received: by 2002:a17:907:10d8:: with SMTP id rv24mr38393600ejb.542.1620836627295;
 Wed, 12 May 2021 09:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAA-qYXi-znXVt_8KuMwEpbqmeWVQJZX9ixnOLs22fPM7HKmmtA@mail.gmail.com>
In-Reply-To: <CAA-qYXi-znXVt_8KuMwEpbqmeWVQJZX9ixnOLs22fPM7HKmmtA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 May 2021 12:23:36 -0400
Message-ID: <CAHC9VhRo0y+3_VmWKpiw9h-p4ci6JVNJ9ZzQ2yXTOXtUf-XEyA@mail.gmail.com>
Subject: Re: A missing check bug in __sys_accept4_file()
To:     Jinmeng Zhou <jjjinmeng.zhou@gmail.com>
Cc:     axboe@kernel.dk, Jakub Kicinski <kuba@kernel.org>,
        davem@davemloft.net, James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>, shenwenbosmile@gmail.com,
        netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 12, 2021 at 3:43 AM Jinmeng Zhou <jjjinmeng.zhou@gmail.com> wrote:
> Dear maintainers,
>
> hi, our team has found and reported a missing check bug on Linux
> kernel v5.10.7 using static analysis.
> We are looking forward to having more experts' eyes on this. Thank you!

Creating a new socket, not associated with a connection (e.g. via
sock_create_lite()), is a different operation than creating a new
socket in response to an incoming connection as is done in
__sys_accept4_file().  This is why the sock_create_lite() uses the
security_socket_create() LSM hook and __sys_accept4_file() uses the
security_socket_accept() LSM hook.

> > On Fri, May 7, 2021 at 1:59 AM Jakub Kicinski <kuba@kernel.org> wrote:
> > > On Thu, 6 May 2021 15:44:36 +0800 Jinmeng Zhou wrote:
> > > hi, our team has found a missing check bug on Linux kernel v5.10.7 using static analysis. There is a path calls sock_alloc() after checking LSM function security_socket_create(), while another path calls it without checking.
> > > We think there is a missing check bug in __sys_accept4_file() before calling sock_alloc().
> >
> > Perhaps the semantics for listening sockets is that only the parent
> > sockets get the LSM check. Could you please circulate the report more
> > widely? I'd be good to have LSM experts' eyes on this at least.
> > CCing the mailing list should help get more opinions. Thank you!
> >
> > > Function sock_create_lite() uses security_socket_create() to check.
> > > 1.    // check security_socket_create() ///////////////////////
> > > 2.    int sock_create_lite(int family, int type, int protocol, struct socket **res)
> > > 3.    {
> > > 4.      int err;
> > > 5.      struct socket *sock = NULL;
> > > 6.      err = security_socket_create(family, type, protocol, 1);
> > > 7.      if (err)
> > > 8.        goto out;
> > > 9.      sock = sock_alloc();
> > > 10.   ...
> > > 11.   }
> > >
> > > However, __sys_accept4_file() directly calls sock_alloc() without the security check.
> > > 1.    // no check ////////////////////////////////////
> > > 2.    int __sys_accept4_file(struct file *file, unsigned file_flags,
> > > 3.          struct sockaddr __user *upeer_sockaddr,
> > > 4.          int __user *upeer_addrlen, int flags,
> > > 5.          unsigned long nofile)
> > > 6.    {
> > > 7.      struct socket *sock, *newsock;
> > > 8.      struct file *newfile;
> > > 9.      int err, len, newfd;
> > > 10.     struct sockaddr_storage address;
> > > 11.     if (flags & ~(SOCK_CLOEXEC | SOCK_NONBLOCK))
> > > 12.       return -EINVAL;
> > > 13.     if (SOCK_NONBLOCK != O_NONBLOCK && (flags & SOCK_NONBLOCK))
> > > 14.       flags = (flags & ~SOCK_NONBLOCK) | O_NONBLOCK;
> > > 15.     sock = sock_from_file(file, &err);
> > > 16.     if (!sock)
> > > 17.       goto out;
> > > 18.     err = -ENFILE;
> > > 19.     newsock = sock_alloc();
> > > 20.   ...
> > > 21.   }
> > >
> > > This no-check function can be reached through syscall.
> > > syscall => __sys_accept4 => __sys_accept4_file
> > >
> > > SYSCALL_DEFINE4(accept4, int, fd, struct sockaddr __user *, upeer_sockaddr,
> > > int __user *, upeer_addrlen, int, flags)
> > > {
> > > return __sys_accept4(fd, upeer_sockaddr, upeer_addrlen, flags);
> > > }

-- 
paul moore
www.paul-moore.com
