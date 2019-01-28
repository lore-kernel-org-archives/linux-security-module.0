Return-Path: <SRS0=3eDG=QE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46D8C282C8
	for <linux-security-module@archiver.kernel.org>; Mon, 28 Jan 2019 19:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700D820855
	for <linux-security-module@archiver.kernel.org>; Mon, 28 Jan 2019 19:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LUOfMawF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfA1TrX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:47:23 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35962 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfA1TrW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 28 Jan 2019 14:47:22 -0500
Received: by mail-yb1-f196.google.com with SMTP id 64so2700312ybf.3
        for <linux-security-module@vger.kernel.org>; Mon, 28 Jan 2019 11:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v4QONenGKxKtsykFOvI8df3wSnRCzBp9b/0S5XmbMkc=;
        b=LUOfMawF/Kt8CMTPYBZE0qK860icrQqLE5KVHiY/NeDoAju278M3vVinDVJg2B6oJB
         wYRltKaLR7bzgP5M+QkVTtZbXKlk/4KkhylPJWYUImlJXacz4/q78Y3GIVXwkRZeWJUc
         ffyj2k50tVld7jxfR8mYaDspnU+pD/FSaEIkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v4QONenGKxKtsykFOvI8df3wSnRCzBp9b/0S5XmbMkc=;
        b=tOpFlvdVsav/i0wR+ikBlzyEiT6/VqMiGnF/s3MhqdkmX0XCmY8UMiM3xx2NqOuq5X
         Z/YL3qdroKc4HbN/CJBgDihMDt1fuiXv24L0XqPSC7IwRN2M6axWkqM74ZDDdt6I1zOO
         2maespHVnCFCDzOPsUjNUeID34rtsB2PAMQOkhA0uuxLdJCUkE7gwaUrCuwy0t3UXj3K
         97ODZzHqLMzjI9sDW1BpBzDTt7VZXikCz6SEVk0y686fD5N7k1GzeGRCIv+QNBtyxm0p
         W4aWvRxmsSmVLwvIRbMojIniAxOsUG/grVCOWSPhNDcqLmCoCIjmVhztGGy9oY3xftv8
         9Dyg==
X-Gm-Message-State: AJcUukdJtDLAaNGliCKfM7lD78tHh1Kghns3NOONiBio9aE2conKVllz
        WsZsPNe4fQ3XKmOYDKiHKhk8BzbfDZSfIw29G4z/amyUTEo=
X-Google-Smtp-Source: ALg8bN5DUtKsG/WuW9b16zlQ4ggoyGc8zO/ifqqYgCWsb+plMwfKeXvAKquwvWpsfNxSU53cMNVMCmWh92c6OvpH5fM=
X-Received: by 2002:a5b:385:: with SMTP id k5mr21705403ybp.303.1548704841620;
 Mon, 28 Jan 2019 11:47:21 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5j+V61YOk7oAEw3Fm5rOxQAmy2-3QqOZaOP_FROLBUk2Qg@mail.gmail.com>
 <20190116154606.92331-1-mortonm@chromium.org> <alpine.LRH.2.21.1901260714380.27585@namei.org>
 <CAJ-EccMc3Xz0DZAm_u09VvTzWRzhrf9x0SpJKX=4FR6NYwqkpQ@mail.gmail.com>
In-Reply-To: <CAJ-EccMc3Xz0DZAm_u09VvTzWRzhrf9x0SpJKX=4FR6NYwqkpQ@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Mon, 28 Jan 2019 11:47:10 -0800
Message-ID: <CAJ-EccMAb-OX3R6mk4me0x6dS2bQw=yZrpKmF7JpzHDWSX5e4g@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] LSM: add SafeSetID module that gates setid calls
To:     James Morris <jmorris@namei.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I'm getting the following crash when booting after compiling a kernel
with this LSM enabled, so I'll have to figure out what is going on.
All the "core" functionality of this LSM has been tested thoroughly
(we're already using this LSM on ChromeOS), but looks like there's
some debugging of the initialization that still needs to be done.

[    0.174285] LSM: Security Framework initializing
[    0.175277] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000000
[    0.176272] #PF error: [normal kernel read fault]
[    0.176272] PGD 0 P4D 0
[    0.176272] Oops: 0000 [#1] SMP PTI
[    0.176272] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.0.0-rc3+ #5
[    0.176272] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[    0.176272] RIP: 0010:strcmp+0x4/0x20
[    0.176272] Code: 09 48 83 c2 01 80 3a 00 75 f7 48 83 c6 01 0f b6
4e ff 48 83 c2 01 84 c9 88 4a ff 75 ed f3 c3 0f 1f 80 00 00 00 00 48
83 c7 01 <0f> b6 47 ff 48 83 c6 01 3a 46 ff 75 07 84 c0 75 eb 31 c0 c3
19 c0
[    0.176272] RSP: 0000:ffffffff88a03eb0 EFLAGS: 00010202
[    0.176272] RAX: 00000000ffffffff RBX: ffffffff89079bb0 RCX: 0000000000000000
[    0.176272] RDX: ffffa3f087411ec5 RSI: ffffa3f087411ec0 RDI: 0000000000000001
[    0.176272] RBP: ffffffff88815d93 R08: 000000000000002c R09: ffffa3f087411ec4
[    0.176272] R10: 000000000000002c R11: 00726f6d72617070 R12: ffffa3f087411ec0
[    0.176272] R13: ffffa3f087411ec0 R14: 0000000000000000 R15: 0000000000000000
[    0.176272] FS:  0000000000000000(0000) GS:ffffa3f087800000(0000)
knlGS:0000000000000000
[    0.176272] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.176272] CR2: 0000000000000000 CR3: 0000000005c0e000 CR4: 00000000000006b0
[    0.176272] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.176272] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.176272] Call Trace:
[    0.176272]  ordered_lsm_parse+0x112/0x20b
[    0.176272]  security_init+0x9b/0x3ab
[    0.176272]  start_kernel+0x413/0x479
[    0.176272]  secondary_startup_64+0xa4/0xb0
[    0.176272] Modules linked in:
[    0.176272] CR2: 0000000000000000
[    0.176272] ---[ end trace f2a8342a377681d5 ]---
[    0.176272] RIP: 0010:strcmp+0x4/0x20
[    0.176272] Code: 09 48 83 c2 01 80 3a 00 75 f7 48 83 c6 01 0f b6
4e ff 48 83 c2 01 84 c9 88 4a ff 75 ed f3 c3 0f 1f 80 00 00 00 00 48
83 c7 01 <0f> b6 47 ff 48 83 c6 01 3a 46 ff 75 07 84 c0 75 eb 31 c0 c3
19 c0
[    0.176272] RSP: 0000:ffffffff88a03eb0 EFLAGS: 00010202
[    0.176272] RAX: 00000000ffffffff RBX: ffffffff89079bb0 RCX: 0000000000000000
[    0.176272] RDX: ffffa3f087411ec5 RSI: ffffa3f087411ec0 RDI: 0000000000000001
[    0.176272] RBP: ffffffff88815d93 R08: 000000000000002c R09: ffffa3f087411ec4
[    0.176272] R10: 000000000000002c R11: 00726f6d72617070 R12: ffffa3f087411ec0
[    0.176272] R13: ffffa3f087411ec0 R14: 0000000000000000 R15: 0000000000000000
[    0.176272] FS:  0000000000000000(0000) GS:ffffa3f087800000(0000)
knlGS:0000000000000000
[    0.176272] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.176272] CR2: 0000000000000000 CR3: 0000000005c0e000 CR4: 00000000000006b0
[    0.176272] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.176272] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.176272] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.176272] ---[ end Kernel panic - not syncing: Attempted to kill
the idle task! ]---

On Fri, Jan 25, 2019 at 1:06 PM Micah Morton <mortonm@chromium.org> wrote:
>
> Thanks!
>
> On Fri, Jan 25, 2019 at 12:15 PM James Morris <jmorris@namei.org> wrote:
> >
> > On Wed, 16 Jan 2019, mortonm@chromium.org wrote:
> >
> > > From: Micah Morton <mortonm@chromium.org>
> > >
> > > SafeSetID gates the setid family of syscalls to restrict UID/GID
> > > transitions from a given UID/GID to only those approved by a
> > > system-wide whitelist. These restrictions also prohibit the given
> > > UIDs/GIDs from obtaining auxiliary privileges associated with
> > > CAP_SET{U/G}ID, such as allowing a user to set up user namespace UID
> > > mappings. For now, only gating the set*uid family of syscalls is
> > > supported, with support for set*gid coming in a future patch set.
> > >
> > > Signed-off-by: Micah Morton <mortonm@chromium.org>
> > > Acked-by: Kees Cook <keescook@chromium.org>
> >
> > Both applied to
> > git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
> >
> >
> > --
> > James Morris
> > <jmorris@namei.org>
> >
