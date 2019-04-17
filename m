Return-Path: <SRS0=FWzS=ST=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76AFC282DA
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Apr 2019 12:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5382F2173C
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Apr 2019 12:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DBlJApSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbfDQMPK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:15:10 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44435 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731704AbfDQMPK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Apr 2019 08:15:10 -0400
Received: by mail-io1-f65.google.com with SMTP id u12so20304133iop.11
        for <linux-security-module@vger.kernel.org>; Wed, 17 Apr 2019 05:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ADed5UyeDCfqNNH2UR80A0yKlfBrVrpHn+Z/5EpmyQ=;
        b=DBlJApSRS0PskY3vgoQw2G7oWP+Dt6CZas3ybjY7CbPtNcH5wzLzfKV1vUbBm8R6Gj
         eiHf5cEyR+XHZbDI5u2bL5jwtfZavrKHVsZLZwofVJg4DNA+7ebdAgBvPejDYMIt/dI8
         GauiE5IsLq7iysXxeIf7e+4D6iPUxRqRJfe4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ADed5UyeDCfqNNH2UR80A0yKlfBrVrpHn+Z/5EpmyQ=;
        b=bVHzIxvd3Tcsz/DnvdklhC+NJge4SfGVk4AGh6FMPCIujk23UtIPLcd+6EbC5fJ9LP
         Vzx9vKNVQGJTl8jpM423PIFJUbtGE+3iqGyNoxG0oEIcZ3ltcWwe+IDHPG5CLkwKsHrk
         4eVG+g67wtdLM72fDO//5AJi2hhXMNTP8b1fQjkiu2oqJomLL19piW/dMNixJsTuwsZ6
         uYyRi928qRq18vUFAA6iBQtrr1/WmNZT7uboSTwqw+SpSJnOyY6XXozRslejjdi7ELj6
         ju2c5NC7dpvrDvbZ2kut8TtkugMRezx3HdPHiQ0ttDTTtoaxZHgLdKq2DCHhKcKgorRm
         TSMA==
X-Gm-Message-State: APjAAAWXF07hvEKvlqUExxEqwXg9ww77yk7yaWu0uijXkzMk17XK82X5
        vI6opN0AL62TspFJcC3uJEJnqwGppLFRHOGcvL89Qw==
X-Google-Smtp-Source: APXvYqx2V6Jcx+gytuw1jq8LNVw18ikzfuiqlBg2gyYzbjRtkoAfTKHyb+XFbfyPFgfevV/mxGcegaZrF1nlBP+FtWY=
X-Received: by 2002:a6b:4e17:: with SMTP id c23mr57082446iob.212.1555503309737;
 Wed, 17 Apr 2019 05:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgn=YNj8cJuccx2KqxEVGZy1z3DBVYXrD=Mc7Dc=Je+-w@mail.gmail.com>
 <20190416154513.GB13422@quack2.suse.cz> <CAOQ4uxh66kAozqseiEokqM3wDJws7=cnY-aFXH_0515nvsi2-A@mail.gmail.com>
 <20190417113012.GC26435@quack2.suse.cz>
In-Reply-To: <20190417113012.GC26435@quack2.suse.cz>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 17 Apr 2019 14:14:58 +0200
Message-ID: <CAJfpegsyzYTkUw7rgpQfB0BKqK-LBZh6fBMUO5iq2JHv1youzw@mail.gmail.com>
Subject: Re: fanotify and LSM path hooks
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 17, 2019 at 1:30 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 16-04-19 21:24:44, Amir Goldstein wrote:
> > > I'm not so sure about directory pre-modification hooks. Given the amount of
> > > problems we face with applications using fanotify permission events and
> > > deadlocking the system, I'm not very fond of expanding that API... AFAIU
> > > you want to use such hooks for recording (and persisting) that some change
> > > is going to happen and provide crash-consistency guarantees for such
> > > journal?
> > >
> >
> > That's the general idea.
> > I have two use cases for pre-modification hooks:
> > 1. VFS level snapshots
> > 2. persistent change tracking
> >
> > TBH, I did not consider implementing any of the above in userspace,
> > so I do not have a specific interest in extending the fanotify API.
> > I am actually interested in pre-modify fsnotify hooks (not fanotify),
> > that a snapshot or change tracking subsystem can register with.
> > An in-kernel fsnotify event handler can set a flag in current task
> > struct to circumvent system deadlocks on nested filesystem access.
>
> OK, I'm not opposed to fsnotify pre-modify hooks as such. As long as
> handlers stay within the kernel, I'm fine with that. After all this is what
> LSMs are already doing. Just exposing this to userspace for arbitration is
> what I have a problem with.

There's one more usecase that I'd like to explore: providing coherent
view of host filesystem in virtualized environments.  This requires
that guest is synchronously notified when the host filesystem changes.
  I do agree, however, that adding sync hooks to userspace is
problematic.

One idea would be to use shared memory instead of a procedural
notification.  I.e. application (hypervisor) registers a pointer to a
version number that the kernel associates with the given inode.  When
the inode is changed, then the version number is incremented.  The
guest kernel can then look at the version number when verifying cache
validity.   That way perfect coherency is guaranteed between host and
guest filesystems without allowing a broken guest or even a broken
hypervisor to DoS the host.

Thanks,
Miklos
