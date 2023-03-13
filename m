Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A685CC74A4B
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Mar 2023 20:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjCMU2m (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Mar 2023 16:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCMU2k (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Mar 2023 16:28:40 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4738C50B
        for <linux-security-module@vger.kernel.org>; Mon, 13 Mar 2023 13:27:55 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id c200so3222601ybf.3
        for <linux-security-module@vger.kernel.org>; Mon, 13 Mar 2023 13:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678739273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFnxh6ChwFpFm5r6DaepAUcIfT7/Tx7g2a94eMxrXFM=;
        b=gixUeT4Ubigv+gUryvD1n8kXhVuY6FIFBf8gg4I7hdEB5cz0ej/6HVI4XQXVUFbqHu
         Md2v534oXJ5kUonyMVSwW6G+UiHQZ1l7WWkB3FcnpcFUpWlqV9Lz9GQAcPW6rHI06dqv
         5guJ9aHDXhUq3vcvdWKETFKP1Uk0rDckcCR3prsdIEwRB6QjCVCvDp08XZQ0TAGZAxdc
         ry3KXn9w9lG+tv8gAMQf3hrLraK4M1naV8n8Zw99xYqLrfvAOECHLge7mUSMBUHft02A
         m4I1Lzb+1yrEewh0+XQmcUlesZDHUvdtoDKSymWhsEzW6lR4dx+a3cm5r1rlwZoDrPKf
         CE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678739273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFnxh6ChwFpFm5r6DaepAUcIfT7/Tx7g2a94eMxrXFM=;
        b=toVOUEwAHch55o/8rnBPrZ2bb3Y8UCQ9aJHKh/xoRRtOHTdJyIDXCkLk5PBzxWezZB
         gocHhFdw39J3JnZiHuFEsmYF2N77szL9xyTQT303k0U70IQxnOxflSEFSeckEPRMeATg
         JnoT+5IOaoEvYBzEjFm3tq9wDUpkWczM8BlmZ4o3Fq54tRvLgWDdhmg4aLlkOT2z+/1f
         QP9Clwa7aYRqTiUqxFIYLi7MRq3Y3J5hsosVgB1HRfZ7NxFswuZp8sST5KUZybehIy5i
         X9MDbLK+42tOgcCdNiNt3J75MVbyJXpLT7cjVj9j+cbofJ+kFtCKUOIVAB2NAr7drgww
         vgdA==
X-Gm-Message-State: AO0yUKUYw6+eZwDXGJ8zDCDqBVgLdFTdmTQ+52R4balpfWEx+V0pXqFa
        7h8rn5XmTzHEI3lt7Qad7FLrWP4TrcF6Xa8KWfps
X-Google-Smtp-Source: AK7set/I0y9ItLKYj2Yw/npMPux8FEEhdrk4Zeo1yP8Tu8wlBFXVCN12SYX3+ZYI4S6xcsXkyCtr2vJKznbvJX29hYU=
X-Received: by 2002:a5b:40e:0:b0:ac2:ffe:9cc9 with SMTP id m14-20020a5b040e000000b00ac20ffe9cc9mr22178487ybp.3.1678739273093;
 Mon, 13 Mar 2023 13:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230310192614.GA528@domac.alu.hr> <CAHC9VhSzppHevG_Td+hKU4KRSDgV_NYf2RSeKA06PR-rD+dJLw@mail.gmail.com>
 <c1c1cbcc-10b6-de3f-81e8-78e6b173d46f@alu.unizg.hr> <CAHC9VhRFQtqTZku==BkW0uz1oZgG63j15GoQD1iexW4aPoAPcA@mail.gmail.com>
 <ZA7tyrscjwavzY3a@smile.fi.intel.com>
In-Reply-To: <ZA7tyrscjwavzY3a@smile.fi.intel.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Mar 2023 16:27:42 -0400
Message-ID: <CAHC9VhTMoCAFhaa36Bq7_jiKGiaeMbYTuWv7tTQP1OHpY0EUsg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add destructor hook to LSM modules
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Frederick Lawler <fred@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Mar 13, 2023 at 5:33=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Sat, Mar 11, 2023 at 09:59:17AM -0500, Paul Moore wrote:
> > On Fri, Mar 10, 2023 at 5:53=E2=80=AFPM Mirsad Goran Todorovac
> > <mirsad.todorovac@alu.unizg.hr> wrote:
>
> ...
>
> > With that out of the way, I wanted to make a quick comment on the
> > patch itself.  Currently LSMs do not support unloading, or dynamic
> > loading for that matter.  There are several reasons for this, but
> > perhaps the most important is that in order to help meet the security
> > goals for several of the LSMs they need to be present in the kernel
> > from the very beginning and remain until the very end.  Adding a
> > proper "release" method to a LSM is going to be far more complicated
> > than what you've done with this patchset, involving a lot of
> > discussion both for the LSM layer itself and all of the currently
> > supported LSMs, and ultimately I don't believe it is something we will
> > want to support.
> >
> > I appreciate your desire to help, and I want to thank you for your
> > patch and the effort behind it, but I don't believe the kobject memory
> > leak you saw at kernel shutdown was a real issue (it was only "leaked"
> > because the system was shutting down) and I'm not sure the current
> > behavior is something we want to change in the near future.
>
> Currently the security module so secure that even adds an unneeded noise =
to
> the debugging output.
>
> At very least it would be nice to add a stub and put a big comment
> (on your taste) explaining why we do not do anything there.
>
> Agree?

No.  At least not without a lot of additional work beyond what was
presented in this patchset.  What about all of the other kobject
caches created by other LSMs, this is more than just the IMA
iint_cache.  I'm also skeptical that this patchset was ever tested and
verified as the newly added release() method was never actually called
from anywhere that I could see.

I think we would need to see a proper, verified fix before I could say
for certain.  If you want to discuss potential designs, we can do that
too, but please remember the constraints that were already mentioned
about intentionally not allowing the LSMs to be unloaded (prior to
system shutdown).

I don't know the answer to this, but I'm guessing the LSMs aren't the
only kernel subsystems to "leak" memory on system shutdown; working on
the assumption that this is the case, how are those "leaked"
allocations handled?

--
paul-moore.com
