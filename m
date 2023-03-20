Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4135EC6FD1C
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Mar 2023 20:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjCTUhJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Mar 2023 16:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjCTUhH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Mar 2023 16:37:07 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2931D31E02
        for <linux-security-module@vger.kernel.org>; Mon, 20 Mar 2023 13:36:31 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54184571389so245599427b3.4
        for <linux-security-module@vger.kernel.org>; Mon, 20 Mar 2023 13:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679344588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jcwVgWp6rfoC0/GaaROHRblpVXejRUhgYiC01hsS6E=;
        b=PanEWokaHTp6VKFrQHul5gz/RzkssbTNUOAsGtWGcU+G7zLQV5++ZEIy9CQEYEavmr
         a8IinxoOGO44+jFOoAyq0jbm5qI970ct4izsbnEps+1VE0ERpESPOc8KU0GR8zpeLArn
         3SIWUXQGS8Z0SthYS6lhvpWF1r/4ZpIy7zk6IKIWZ6bQ87qtYlBzpTuYJdmsBMfJRRsy
         bGqNioMn4E5YZ4tGgIZuGKRPuPH/96GTil78McDEUpOakOLSa8YHdvoVxbQwVMk46TOJ
         fnlkvjs3IXxOypah9sR1v3+9LBrx8kghTnDsQyo0Sf+rNFM5026CPm6B/T+U5YGJuLod
         OCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679344588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jcwVgWp6rfoC0/GaaROHRblpVXejRUhgYiC01hsS6E=;
        b=NTIdoN7ndqkFNotEhteOo7BjoOhHyouX+zWdbnvd5O3/+NSc8EflsP/iZGBbxEJHLU
         nP/1nsVhrwZ3UXSbk1rzIrsnEchRs87pNfvH6O/UJINnYCN/a6+K6E/xZ/X8/dc9OGdG
         My9UT7hAio6PQEqgdFilkfbLwMHl/npqUl3YXY/MOpgnAuEHJN4hQmcz3ZisGn0trWkz
         VfEsxtIJjxp8nBiTwsxO9pSDyQNDImZ1t2nJ4xaAWMtXCvkIIkkhGFrvSpWGKbMRciD8
         8gKi/x/ufoWv/RcZNO+BwnSz0sx9bCQsqHPfRWODzfJOHvbOAjlBZLw9fuFAE6SVNxcl
         XA0A==
X-Gm-Message-State: AO0yUKWhSbS10qc0U7LI1n9Q5c5vSWTxnvSP7VoeCGGZduaTCowlEe1s
        E5r89SCm4ti3YXgJ8djF4M8A38UAuXYnLt3uUDEV
X-Google-Smtp-Source: AK7set/yxqB/2Y74OHKeqp+xZ7JJ77pnUlK5mutd1xzmnsiZBxUi/tePPP9IJgzljWHgyt2qq7QZmWJ55hbj1QNFFV8=
X-Received: by 2002:a81:d13:0:b0:521:daa4:d687 with SMTP id
 19-20020a810d13000000b00521daa4d687mr8914678ywn.0.1679344588320; Mon, 20 Mar
 2023 13:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+Z-9KCgKwkktvdJwNJZxxeA1f74zkP7KD6c=OmKXxXfjw@mail.gmail.com>
In-Reply-To: <CACT4Y+Z-9KCgKwkktvdJwNJZxxeA1f74zkP7KD6c=OmKXxXfjw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Mar 2023 16:36:17 -0400
Message-ID: <CAHC9VhTNcDRfMwtKg2xLcwKHN_pkiKd9wSovMiYkfnx_erTEow@mail.gmail.com>
Subject: Re: LOCK_DOWN_FORCE_INTEGRITY_FOR_FUZZING?
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     jmorris@namei.org, mjg59@srcf.ucam.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        nathanl@linux.ibm.com, syzkaller <syzkaller@googlegroups.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 14, 2023 at 6:02=E2=80=AFAM Dmitry Vyukov <dvyukov@google.com> =
wrote:
>
> Hi Lockdown maintainers,
>
> We don't enable Lockdown integrity mode on syzbot during fuzzing, but
> we would like to. The main problem is the restriction of debugfs,
> which we need for fuzzing. But we do duplicate some of its
> restrictions (e.g. DEVKMEM=3Dn).
>
> It come up again recently in the context of discussion of memory
> corruptions when a mounted blocked device is being written to by root:
> https://lore.kernel.org/all/CACT4Y+b1vGfe0Uvp6YmKahK4GfCfvdBLCh0SAQzGgWN1=
s6A+0Q@mail.gmail.com/
> It looks like this restriction of writing to mounted block devices
> should be part of integrity lockdown (but I am not an expert).

The first question I would ask is are there legitimate reasons to
write directly to a block device that would not impact the integrity
of the device?  Of course the first thing I think of when I think of
block devices is a storage device with a filesystem on top, but I'm
not comfortable enough with my block device knowledge to know what
other classes of block devices might exist and how one might normally
interact with them.

If storage devices are the only instances of block devices that we
support, we would also need to be careful that any calls to
security_locked_down() happen only when userspace is attempting a
direct write; we wouldn't want to bump into a lockdown access denial
when the filesystem attempts to write to the block device.

> What do you think about the addition of a new level that is integrity
> but with debug fs access?
> LOCKDOWN_RTAS_ERROR_INJECTION also looks like it's in the same bucket
> of "fine for testing".

It's been a little while, and I can't say I fully understood the
ppc/pseries RTAS stuff at the time (or now for that matter), but I
didn't think that the RTAS error injection mechanism was strictly for
testing, is it?

Regardless of RTAS, if the goal is testing lockdown with syzbot, which
requires debugfs, why not test a lockdown level that still allows
debugfs?

> At least for us it is OK if it can be enabled only via kernel config
> (no cmd line) and named accordingly
> (TEST_ONLY_DONT_ENABLE_IN_PRODUCTION).
>
> If we have it, we could restrict writing to mounted devices in
> integrity mode and enable this mode on syzbot.

Regardless of what we decide wrt to a new level, I think we want it to
always be present and not dependent on a config knob, either runtime
or buildtime.

--=20
paul-moore.com
