Return-Path: <SRS0=WmJh=SS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BBEC10F14
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Apr 2019 18:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33542087C
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Apr 2019 18:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZVuY+F0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbfDPSY6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:24:58 -0400
Received: from mail-yw1-f50.google.com ([209.85.161.50]:33864 "EHLO
        mail-yw1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730339AbfDPSY5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Apr 2019 14:24:57 -0400
Received: by mail-yw1-f50.google.com with SMTP id x129so7679471ywc.1;
        Tue, 16 Apr 2019 11:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ylo6ndlafgoWLAul6i+LD5kUsYi0UZHiKFoMHawnUsU=;
        b=hZVuY+F0eBFStWVOxeEHTVpFG/qJQKug5WlZYVHyTGQMhDyT0KxpJlYCfws77jZ0P7
         4aFfYyUBkXZ/WbOsO3V8FXYfGQKvu5oIrMTL/U8IR0dxihXmFseaYm4N6biYPN64kD2O
         /l+21gDiJMvynhc6bcJPhriGnNXaUCHj8gml69+Bmdh7TAPLHGwvdZEtWU4JBbfFhUj8
         S2PrF7YjpHCj8SiVdPcIaVKYbF2USIFPryKtuHPGKOzSxZwIXfj+IqC8ONDQqM2V4oNe
         DR04D1/v1hc/pVVH7vFry0IcEGdSGmbeVtFAFcg/KOUpcMet3zBsvgbjuREcIrbFqnL7
         8J4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ylo6ndlafgoWLAul6i+LD5kUsYi0UZHiKFoMHawnUsU=;
        b=o2+rwJo2Ss3ppS8nGYB6p/yuLb8LWy6I9YTTKBVS12m+9dZj6TWLut4KN4/v79cOwr
         L2xofkKzXqdKVVJwS5iFHZXtBoDmB29s8yAX6/uGx3obhxeUerGSH4tuBU1CaUJCL2eR
         T0GRkrlfpaHbs3JEwFkX+vmCr/Cw1LudzO9BrRbkOSJ7wtXVghyZW0nFzRTi8NrbOiW0
         Bh7U7ej+S8BjhhWPxJO48EDWxsEMDJVQGeM7qxwlcF7KUZwHH0+0z/7a26AXonQhPUBl
         J7yNAwJqVvDvwtYG7mlvz4B5RXuo6UOfIsYRPeEPLNHXxFRCz+IzeiB477ttcv1Vkval
         9w+Q==
X-Gm-Message-State: APjAAAXZXOgfcZDdFlU2Xm7mNAOcUEM5cFWkdTySc/pcqypejxcjGVJi
        3/pCNM5fBXUokjPtkiN2o4prVhi3wJ4KoWbqMaA=
X-Google-Smtp-Source: APXvYqwrAakRtNuhXwmvVL4xdAyyNZTFt0Otcr4Ua/vCR99Gd4q4tMDe/v80s/zMMiG8W4MZqa8wq1VWa10CF3Im0RU=
X-Received: by 2002:a81:1383:: with SMTP id 125mr66340548ywt.265.1555439096587;
 Tue, 16 Apr 2019 11:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgn=YNj8cJuccx2KqxEVGZy1z3DBVYXrD=Mc7Dc=Je+-w@mail.gmail.com>
 <20190416154513.GB13422@quack2.suse.cz>
In-Reply-To: <20190416154513.GB13422@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 16 Apr 2019 21:24:44 +0300
Message-ID: <CAOQ4uxh66kAozqseiEokqM3wDJws7=cnY-aFXH_0515nvsi2-A@mail.gmail.com>
Subject: Re: fanotify and LSM path hooks
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Apr 16, 2019 at 6:45 PM Jan Kara <jack@suse.cz> wrote:
>
> Hi Amir!
>
> On Sun 14-04-19 19:04:14, Amir Goldstein wrote:
> > I started to look at directory pre-modification "permission" hooks
> > that were discussed on last year's LSFMM:
> > https://lwn.net/Articles/755277/
> >
> > The two existing fanotify_perm() hooks are called
> > from security_file_permission() and security_file_open()
> > and depend on build time CONFIG_SECURITY.
> > If you look at how the fsnotify_perm() hooks are planted inside the
> > generic security hooks, one might wonder, why are fanotify permission
> > hooks getting a special treatment and are not registering as LSM hooks?
> >
> > One benefit from an fanotify LSM, besides more generic code, would be
> > that fanotify permission hooks could be disabled with boot parameters.
> >
> > I only bring this up because security hooks seems like the most natural
> > place to add pre-modify fanotify events for the purpose of maintaining
> > a filesystem change journal. It would be ugly to spray more fsnotify hooks
> > inside security hooks instead of registering an fanotify LSM, but maybe
> > there are downsides of registering fanotify as LSM that I am not aware of?
>
> I kind of like the idea of generating fanotify permission events from
> special LSM hooks.
>

Cool, I think that all we really need to do is call security_add_hooks().
[reducing LSM CC list]

> I'm not so sure about directory pre-modification hooks. Given the amount of
> problems we face with applications using fanotify permission events and
> deadlocking the system, I'm not very fond of expanding that API... AFAIU
> you want to use such hooks for recording (and persisting) that some change
> is going to happen and provide crash-consistency guarantees for such
> journal?
>

That's the general idea.
I have two use cases for pre-modification hooks:
1. VFS level snapshots
2. persistent change tracking

TBH, I did not consider implementing any of the above in userspace,
so I do not have a specific interest in extending the fanotify API.
I am actually interested in pre-modify fsnotify hooks (not fanotify),
that a snapshot or change tracking subsystem can register with.
An in-kernel fsnotify event handler can set a flag in current task
struct to circumvent system deadlocks on nested filesystem access.

My current implementation of overlayfs snapshots [1] uses a stackable
filesystem (a.k.a. snapshot fs) as a means for pre-modify hooks.
This approach has some advantages and some disadvantages
compared to fsnotify pre-modify hooks.

With fsnotify pre-modify hooks it would be possible to protect
the underlying filesystem from un-monitored changes even when
filesystem is accessed from another mount point or another namespace.

As a matter of fact, the protection to underlying filesystem changes
needed for overlayfs snapshots is also useful for standard overlayfs -
Modification to underlying overlayfs layers are strongly discouraged,
but there is nothing preventing the user from making such modifications.
If overlayfs were to register for fsnotify pre-modify hooks on underlying
filesystem, it could prevent users from modifying underlying layers.

And not only that - because security_inode_rename() hook is called
with s_vfs_rename_mutex held, it is safe to use d_ancestor() to
prevent renames in and out of overlay layer subtrees.
With that protection in place, it is safe (?) to use is_subdir() in other
hooks to check if an object is under an overlayfs layer subtree,
because the entire ancestry below the layers roots is stable.

Will see if I can sketch a POC.

Thanks,
Amir.

[1] https://github.com/amir73il/overlayfs/wiki/Overlayfs-snapshots
