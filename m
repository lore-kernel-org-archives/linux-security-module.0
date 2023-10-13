Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834A7CDB47E
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Oct 2023 21:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjJMVzT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 Oct 2023 17:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjJMVzS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Oct 2023 17:55:18 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65B0BF
        for <linux-security-module@vger.kernel.org>; Fri, 13 Oct 2023 14:55:16 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9ac45092e7so2660062276.2
        for <linux-security-module@vger.kernel.org>; Fri, 13 Oct 2023 14:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697234116; x=1697838916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKGSCOVLbkYhGYoq+rtlt3uTKCf4verh3lWQ8sV6E5A=;
        b=P1WAcFezEm1NvXvZtbYJCwmZeudvXGnk1C4nrNAWPQcchDGRu8o60gX93BCGMUyyDr
         2Ond7dftnmvBmmi/F9j7w3wldMUXfyfTgCEPQQynYKtGlUgXjfddnSJZ5Ljqp6NMXf5T
         aM2WULrobajmf22xevmho4VZMv4M8CKUkmaMqqKbrO9TJ5rCvQ8xnM7hPg8aRdRZsR9r
         si4OMsMCJqZxkKQj89zQwXwK3Z/sRmnU/MYMJv8/BnvznnU5WX3Q9VO1+rd1McsJawQ9
         52HjduOd1/tKPfr+cO9bQ0L8UO2Tml/spW6B51s/nqVsgctgqPtYwPs8nW5Q8znIv154
         lJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697234116; x=1697838916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKGSCOVLbkYhGYoq+rtlt3uTKCf4verh3lWQ8sV6E5A=;
        b=EiPeK0tXM2e+C6D6kBIr/Kh13r1+UAC21BND8MmNbqSYxsAKaE3EfjdSRXzzexhUd8
         WOG7wroDjl/PxhK+SI5asF9VKzZeSSZCr6/NWZ7P9pabdA0oseF8Mnl1MUOotfvENTZb
         DDJqAej+IuP6oE5aQqvaZ0tb5GdRjHwpbcT9dLMVcbSKACNVqRQ0/UflcYzwSpaIDWkI
         HDECF3cdDw+YmzUpQA5ifTg6ymFFzZYFGu3f1udK/20sQiLTYG0TSK5UOQwHwB3c5juN
         DjPctNhZE21yyZGhhyVSaes7NYOj/iwjZ0VH+QjPmYbnNAL1A9SgsTttDsS7tqp/EqUp
         mOXQ==
X-Gm-Message-State: AOJu0YywigrYAeZdAt4Mk2RuMQwrjt3m2T/Fmp3qplWTBB7tShC+/20X
        uDaeWb+DD5KPuA/S0RukcEpWgkGId3UJcavpPW6i
X-Google-Smtp-Source: AGHT+IG7mv21RwUbd4s8yApgHo1oFDE2XPy+OCLcTrQN0/TOGlzUdlKn7So/TOy+xlC76NBVGDCjNC3AbSNbPwuT8pc=
X-Received: by 2002:a25:ae8b:0:b0:d9a:d20d:7d5a with SMTP id
 b11-20020a25ae8b000000b00d9ad20d7d5amr6426451ybj.1.1697234115842; Fri, 13 Oct
 2023 14:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230912205658.3432-1-casey.ref@schaufler-ca.com>
 <20230912205658.3432-1-casey@schaufler-ca.com> <CAHC9VhRcbp3iWQwL7FTUrcU1C3OsZ413Nbq+17oTwW7hZ7XvBw@mail.gmail.com>
In-Reply-To: <CAHC9VhRcbp3iWQwL7FTUrcU1C3OsZ413Nbq+17oTwW7hZ7XvBw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 13 Oct 2023 17:55:04 -0400
Message-ID: <CAHC9VhSqY5+DR-jXprrftb1=CzDvhTh0Ep66A16RMd4L7W7TYw@mail.gmail.com>
Subject: Re: [PATCH v15 00/11] LSM: Three basic syscalls
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 12, 2023 at 6:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Sep 12, 2023 at 4:57=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> >
> > Add three system calls for the Linux Security Module ABI ...
>
> First off, a big thank you to Casey who took it upon himself to turn
> my pseudo-code syscall suggestion into a proper patchset and saw it
> through 15 revisions.  Thanks also go out to everyone that has helped
> review and comment on this effort; I know everyone is busy, but these
> reviews are important.
>
> I'm happy to say that I think we're in a good place with this revision
> of the LSM syscall patchset.  I only see two outstanding issues, and
> neither of those are bugs/showstoppers that affect the API, they are
> simply areas where the implementation could be improved.  With the
> understanding that Casey is busy for the rest of the month, and my
> desire to make sure this patchset gets a full dev cycle in linux-next,
> I'm going to suggest merging this into the lsm/next-queue branch soon
> (likely tomorrow) in preparation for merging it into lsm/next once the
> upcoming merge window closes.  Those who want to help improve the
> implementation, as suggested in the feedback on this revision or
> otherwise, are welcome to submit patches against the lsm/next-queue
> branch and I will merge them into that branch once they pass review.
>
> If I don't hear any objections I'll plan on merging this patchset
> tomorrow, I'll send a follow-up reply to this email when it's done.

Since it's been *almost* a full 24 hours and no objections I went
ahead and merged this patchset into lsm/next-queue with the intention
of bringing them into lsm/next after the upcoming merge window closes.
For those of you who have suggested changes, please feel free to
submit patches against the lsm/next-queue branch and we can get them
queued up along with these patches.

Thanks everyone!

--=20
paul-moore.com
