Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAF2C433F5
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Jan 2022 19:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiAYT6B (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 Jan 2022 14:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiAYT57 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Jan 2022 14:57:59 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CCBC06173B
        for <linux-security-module@vger.kernel.org>; Tue, 25 Jan 2022 11:57:58 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u18so50977639edt.6
        for <linux-security-module@vger.kernel.org>; Tue, 25 Jan 2022 11:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nQoWXza/e82rxhB4VgBG8sKc0cG3CA0FZawcd6DTTLU=;
        b=6MAPP++CMNhGfRky7Pdw3Ioyn9QjUJzm6RkTLOx3SptE5cOXw7x/3VQK67BgEDjc40
         3joXrrnet678MISrVRhG+5y6vXIzQ5CCtlpe9zDrXaJYMiC96L0s+KhHNqfvv9enbr3O
         A1KkG/YOO7Bfcx3ckR6pHhHr3N1Q7bTLTXct7opNjyF8SS5TD0oCRb60wj3+140qe8ZD
         SnpKl9k9Zmnoj+ZRmJZ9Sx39IcuPO7zCIxw2CM2HC0CcEpxPoKsiF+5mQmEle+vbf2tu
         RgbVMr8bKnTd/4kpbZtfl2WMomsahTJtrnUa0jpbXqXRd4KMSJP515+QZ/y6C06oZEYL
         G+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nQoWXza/e82rxhB4VgBG8sKc0cG3CA0FZawcd6DTTLU=;
        b=xEyk+Fle3LCoZkC1nHY9bXnKbNP5X15fmqTR8U0Ewt+gYA9yrpY+Q+qr/MYoOsdOjQ
         EZ76uiZUWEOLOIO3l58n+UV/p2zgjHwAKjUz85JXJWlSTdK3U1Y/WR2NJkPvSHc8bWda
         DGfAQBzfoRNmI4c2L4rfVyIPcHHofiuGamyDqsNVNgqhBNOJD8Xst8SMQ+RAkuNIeFnR
         GdNKASd0GpYgTqM6cu/qh8H3W4bcui8nUDvnl4jGY844CZmh+zSUMOoOIrKRwzKCiyIY
         i8Ienn8dOzbltwOYru4uG8OFWWe7Z/b8M/m5+7ODP7pC6Xj1sXW2NHMXtsI3/UvfQdMG
         5YoA==
X-Gm-Message-State: AOAM530uSkB0/OR7GXtmUojhXHGlvpZRsHOf1L7WUWgzvsVXp7+eTkrB
        +XUqI08L048PNacILDyUz7uq6aL+q253zIeUDD8c
X-Google-Smtp-Source: ABdhPJzKgko2HSYRsLaY9gyXSirb/p5DZDPU2V6sYphuf2BSNBtWvXMqnjuYKUgRzvZx0/Kpa9QWGcwxqTKlLepCfII=
X-Received: by 2002:aa7:d407:: with SMTP id z7mr21889495edq.331.1643140677448;
 Tue, 25 Jan 2022 11:57:57 -0800 (PST)
MIME-Version: 1.0
References: <CAM2jsSiHK_++SggmRyRbCxZ58hywxeZsJJMJHpQfbAz-5AfJ0g@mail.gmail.com>
 <CAHC9VhR1efuTR_zLLhmOyS4EHT1oHgA1d_StooKXmFf9WGODyA@mail.gmail.com>
 <a77ca75bfb69f527272291b4e6556fc46c37f9df.camel@kernel.org>
 <20220125111350.t2jgmqdvshgr7doi@wittgenstein> <d5490a7c87b8c435b3c7bdb8d2c8edef2c2a576a.camel@kernel.org>
 <20220125121213.ontt4fide32phuzl@wittgenstein> <ab92b28e953601785467cdf8ca67dd5b0ef55105.camel@kernel.org>
 <YfAdtAaUfz38xtmf@redhat.com> <2f1c3741-df38-1179-5e3f-4cd1c4516e76@schaufler-ca.com>
In-Reply-To: <2f1c3741-df38-1179-5e3f-4cd1c4516e76@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Jan 2022 14:57:46 -0500
Message-ID: <CAHC9VhRgKZDzyNOhd-0nmKxBdnzQW5FHRwg9hHjGrUEPMhqaDg@mail.gmail.com>
Subject: Re: "kernel NULL pointer dereference" crash when attempting a write
To:     Casey Schaufler <casey@schaufler-ca.com>, vgoyal@redhat.com
Cc:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Stephen Muth <smuth4@gmail.com>, ceph-devel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 25, 2022 at 12:09 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 1/25/2022 7:56 AM, Vivek Goyal wrote:
> > On Tue, Jan 25, 2022 at 07:32:19AM -0500, Jeff Layton wrote:
> >> On Tue, 2022-01-25 at 13:12 +0100, Christian Brauner wrote:
> >>> On Tue, Jan 25, 2022 at 06:25:39AM -0500, Jeff Layton wrote:
> >>>> On Tue, 2022-01-25 at 12:13 +0100, Christian Brauner wrote:
> >>>>> On Tue, Jan 25, 2022 at 05:54:57AM -0500, Jeff Layton wrote:
> >>>>>> On Mon, 2022-01-24 at 21:45 -0500, Paul Moore wrote:
> >>>>>>> On Mon, Jan 24, 2022 at 8:51 PM Stephen Muth <smuth4@gmail.com> wrote:

...

> Joining the conversation late. Wish someone had brought me
> in sooner.

For some reason I thought the LSM list was on the To/CC line, my
mistake (fixed now).

Thanks to everyone for all of the further discussion, review on this;
I plucked the original post out of my spam folder as I was shutting
down for the night yesterday and only gave it a quick look.

> > Looks like dentry_init_security() can't handle multiple LSMs. We probably
> > should disallow all other LSMs to register a hook for this and only
> > allow SELinux to register a hook.
>
> Not acceptable. The fix to dentry_init_security() is easy.

Sounds good to me, Vivek did you want to put together a patch for
this?  If not, let me know and I'll put one together.

-- 
paul-moore.com
