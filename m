Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C673FEB64DA
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Jul 2023 12:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbjGNMqP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 14 Jul 2023 08:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjGNMqO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 14 Jul 2023 08:46:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028E9CE
        for <linux-security-module@vger.kernel.org>; Fri, 14 Jul 2023 05:46:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bfae0f532e4so1570963276.2
        for <linux-security-module@vger.kernel.org>; Fri, 14 Jul 2023 05:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689338772; x=1691930772;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40RKItG5BPYJCXJqNnewbESLL8jzHXozLcj+1P4Vhc0=;
        b=159Xw1oW4YyqxAyObvVzBKMEeAHPEbM94ilTpIFWDSXArH6c++P/jGMi3iK60E/Avf
         8pzEtyiBFKJTSAwZP6YvV4RHPGrhH3JBnEHufQ2YCegprl86MSsB5aJwE3LBE9VI/v/+
         zf1LbKctAM+HCqclmZhxo0t7oD4h0SLWOPuaBa3E4h/Ff+igPUAU1iqmY2sCvDddytKw
         NbUyDl1gBOuNvy05ZRfWgrSDP8C82TUNC+CBzqZR+0sTJdF4qaQDB4v3XQiAYveL7tPr
         +dTuVJIVl4axIEzEFLyGX2VbmihqEETLd2k+DjEA3qf7ShtceAvG0GrJYVYO4V/lQbMc
         3z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689338772; x=1691930772;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=40RKItG5BPYJCXJqNnewbESLL8jzHXozLcj+1P4Vhc0=;
        b=c9+ImxsUjQEzy7lRhK9sZFiFmx75jpWhIzSpxpGqF7SU7DmVQ93aHDk/CzZvp/Vepu
         A2tppBQgeGPlQW5v9QRPgK8oUGOdQG4SBZNOmBrE33w7oxfgcuFGs4lIdcM4t/LJgc4h
         JGdNtLEe4JXrNQiGLOWf1NQn4QVScdRJFAnzoD0Ls0ExuBxrrgIDsKfJ4Kty6Wl2HLK4
         fUNkkwF7/VYyCekgPoQeMe0kvNoGsIxPVzWHjQv4ENMThfSgtMfJnXXPpwuTtqjFy1ut
         +BCT94ZLCYtETr7Og1ZEmpjHB5xTigNtZo7yqfTXWk/njWqopSxbaYA0KrT3lSWvfi6n
         ewoQ==
X-Gm-Message-State: ABy/qLbFtSx+rgT26Rv9LU7O6yHu0xBV1gUOoQPBjGAaRlMxFLT5eD25
        5/G5NfYhloACmqpPGrZ9DXKqqVm+brg=
X-Google-Smtp-Source: APBJJlHkXH+iYNHZSYoZjJ7TGS/2x7hRavEGgUSpToHqtEG5NQarqPW/2FkDvnTqkquFlZf6W9/ozjx251g=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:5443:37b2:e56e:1231])
 (user=gnoack job=sendgmr) by 2002:a25:5088:0:b0:c4e:27df:1a0f with SMTP id
 e130-20020a255088000000b00c4e27df1a0fmr24743ybb.13.1689338772172; Fri, 14 Jul
 2023 05:46:12 -0700 (PDT)
Date:   Fri, 14 Jul 2023 14:46:09 +0200
In-Reply-To: <09c6939f-c9e4-d1ed-bef1-3b1f05f81522@digikod.net>
Message-Id: <ZLFDkbyaEBe0fc6e@google.com>
Mime-Version: 1.0
References: <20230502171755.9788-1-gnoack3000@gmail.com> <20230502171755.9788-3-gnoack3000@gmail.com>
 <09c6939f-c9e4-d1ed-bef1-3b1f05f81522@digikod.net>
Subject: Re: [RFC 2/4] landlock: Add LANDLOCK_ACCESS_FS_IOCTL access right
From:   "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To:     "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc:     "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi!

On Mon, Jun 19, 2023 at 04:42:07PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> I'd like a new documentation paragraph explaining the limitation of
> LANDLOCK_ACCESS_FS_IOCTL (not fine-grained; should be careful about
> fscrypt-like features for regular files; compatibility with TTY and other
> common IOCTLs), a way to get more guarantees (e.g. using nodev mount poin=
ts
> when possible), and a sentence explaining that future work will enable a
> more fine-grained access control.

I tried to add this comment but realized that I don't understand it well en=
ough -

Regarding fscrypt:

  If a process is not the fscrypt user space tool itself, in which ways do =
the
  fscrypt ioctls matter for that process?

  I dug up a list of ioctls in tools/include/uapi/linux/fscrypt.h which loo=
k
  related, but these look like they are only needed for the set up of encry=
pted
  files and directories, but not for using these files later from other
  processes?

  Am I misunderstanding that?

  The one thing that seems to stand out with the fscrypt ioctls is that the=
 same
  ioctl numbers are implemented by multiple different file systems.

Regarding nodev mount points:

  I guess this is not relevant any more if we split the IOCTL right into a
  device-only and non-device-only flag?

  (I prefer that solution over nodev mounts as well, because that solution =
works
  unprivileged from the perspective of the process that defines the Landloc=
k
  policy. Re-mounting with different options requires more rights and can o=
ften
  not be influenced by small utilities.)

Thanks,
=E2=80=94G=C3=BCnther

--=20
Sent using Mutt =F0=9F=90=95 Woof Woof
