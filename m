Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0F1C433EF
	for <linux-security-module@archiver.kernel.org>; Sun, 24 Jul 2022 04:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiGXECv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 24 Jul 2022 00:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiGXECt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 24 Jul 2022 00:02:49 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE2EE0DA;
        Sat, 23 Jul 2022 21:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658635334; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=FKgmmK4qST/lw4r8NbvBMwkC47maL+Vn68jcKSRRTr9yN5eVH4djyiPYot/BeAWI7wD+EDBi9zGwVl/SkkKMoqlVSAguglKUp6BsMNpx5QM/DI2mApiid5zHu5I+T1MLb8QTXwTMQ1SoFBbLyKb0/EB/4gF4ywkRVjOmCMBQWuU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1658635334; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ZsIO24j3JVV1dGHrjewZL3uR5Q3eQ+kXFdkNGODCBfw=; 
        b=A59IBYy8EidnQCVDDH7KxoNqOBZ9Q+XVz8nTwAhv90pXatlvgF+kE4wvy+CQ1Rsas5pKchSzux0yU4vcY3nHW2XjhtaUf84fCLONRthl/TUI7839DZfPqFOdaBH2kEh59xjt5vx0+T0m0cWtGvLXFcJVuHFyV93l5kR3qcit1Qw=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658635334;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=ZsIO24j3JVV1dGHrjewZL3uR5Q3eQ+kXFdkNGODCBfw=;
        b=ByFyVWEXVlIkXz4FEwz3wvsZXLYNGsn1uC9hrdpSw2a7Bnw0Gwvy5h3jGPDjGQs0
        AYebS12UWXLtXXZJB2Qv2PiSPDnIODcoFj8g/KtpZ81TMsYFDZEmOSQ2AG6oJxQ4tEy
        0RbilO/qxVyAlqRZN7ZdzUrIuIVIewzV0MxahS74=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1658635323452803.7680563486452; Sun, 24 Jul 2022 09:32:03 +0530 (IST)
Date:   Sun, 24 Jul 2022 09:32:03 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Khalid Masum" <khalid.masum.92@gmail.com>
Cc:     "Greg KH" <gregkh@linuxfoundation.org>,
        "syzbot+c70d87ac1d001f29a058" 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "David Howells" <dhowells@redhat.com>,
        "Eric Dumazet" <edumazet@google.com>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Message-ID: <1822e5e8826.6da46246626262.8013427986163664185@siddh.me>
In-Reply-To: <CAABMjtEHCy=YcfqYfsQdqt9pWHHRoOLYHiRCsj8HjZVfAOB+6A@mail.gmail.com>
References: <20220723135447.199557-1-code@siddh.me> <Ytv/tUrdK1ZTn4Uk@kroah.com>
 <1822b76775c.69c52873236056.4849193904753307696@siddh.me> <CAABMjtEHCy=YcfqYfsQdqt9pWHHRoOLYHiRCsj8HjZVfAOB+6A@mail.gmail.com>
Subject: Re: [PATCH] kernel/watch_queue: Make pipe NULL while clearing
 watch_queue
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, 24 Jul 2022 09:15:27 +0530  Khalid Masum <khalid.masum.92@gmail.com> wrote:
> On Sat, Jul 23, 2022 at 8:29 PM Siddh Raman Pant via
> Linux-kernel-mentees <linux-kernel-mentees@lists.linuxfoundation.org>
> wrote:
> >
> > On Sat, 23 Jul 2022 19:33:33 +0530  Greg KH <gregkh@linuxfoundation.org> wrote:
> > > You should not use #ifdef in .c files, it's unmaintainable over time.
> > >
> > > thanks,
> > >
> > > greg k-h
> > >
> >
> > I used it because it is used in the same way in fs/pipe.c too (please check the
> > stated line number).
> >
> > That, in turn, is because `watch_queue` member in the `pipe_inode_info` struct
> > is defined that way (see line 80 of include/linux/pipe_fs_i.h), so I am forced
> > to use the ifdef guard.
> >
> Maybe, we can use the IS_ENABLED macro here to avoid ifdef in the .c file as
> suggested here:
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html#conditional-compilation
> 
> if(IS_ENABLED(CONFIG_WATCH_QUEUE)){
>      ...
> }
> 
> > Thanks,
> > Siddh
> 
> Thanks,
>   -- Khalid Masum
 
I have looked at it again. The guard is superfluous in watch_queue.c (don't
need it since we are already in watch queue), hence I am sending v2 with it
removed.

Thanks,
Siddh
