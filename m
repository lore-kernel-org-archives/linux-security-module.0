Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF26DC77B75
	for <linux-security-module@archiver.kernel.org>; Mon, 22 May 2023 16:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjEVQea (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 May 2023 12:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjEVQea (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 May 2023 12:34:30 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2681106
        for <linux-security-module@vger.kernel.org>; Mon, 22 May 2023 09:34:22 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-55db055b412so55265437b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 22 May 2023 09:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684773262; x=1687365262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQxFhpHx6I0+NXRiQDL7QeHOOpSYkCZcpOTf4CJd/eE=;
        b=Mc/18C0ZhbH6zOIPCbPmyfvgWnC6DPxK3qEes0BQHXPlwN8XNkE2DZAqgDITf7A4SX
         TymINzp8t65sLb7EfANlLLvq/lpT4iH9o4QZiaZ9hp9sCYR7Qaow9UYs7b9cIl1Gs5Zm
         hzc80FCSQxPMQKfs9FtBLRWLdEnilu/9qBfGYP7Z0Mveeu/abDZ9+Krl6BYvWJnWp76I
         uFHzOSVpU1x+jmRqAoVL8uFGeMrN38zquMMfTNTa4kk0wxSXCjF7qudtcLq+D1YJrSwV
         +h2XcHmyhpTj6/w4cY8D+wnxGL0gUW43RazMoZGVySe02IwTz7isWp9Oh5U67Gex8/ki
         vqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773262; x=1687365262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQxFhpHx6I0+NXRiQDL7QeHOOpSYkCZcpOTf4CJd/eE=;
        b=TyVxX7sgkBbm3iKJyvIdH0vOVNSIcL0M1izlnKNJiJiKSJCm29JQW0aLEdqDqh+dti
         Hb/dIih7zXpeeei8L0/6QMxpJqMeDxYSvPtUrwBKlStsN01RMUoOmxt/PotBpEWLoGwG
         2N6x/p9Pc3aHXsCqzGS1kneX0yARz6YLmmG2y292PT+6TB10mgGFVH1G3l5m9sOesxWp
         InvB9LOh9L3X92JOpeD29o8+X5YWxFi+QSlVr1bc0EKjaCjsndhUkjW0eVbYdf+O8ERq
         yDE3g0OmLXvnwyVqDDz8LKBExsmZua0MNSBUEy6A5w8PkfsEXGBSYYfN3vJqhuQzDlAr
         WS6Q==
X-Gm-Message-State: AC+VfDw3+VthuQAeIZljiYxA1ksM7yg+wfuWblpKNrggKFaIChmkNQbC
        Nt4As7CZC4bfqE17P2ds3iw0HUSynYoML+Q6zsKhgS7tWTlyvKU=
X-Google-Smtp-Source: ACHHUZ4KzySqI9vqvP0p9EBX0DCnlDZjI6YgyHo+/1obhNjzN59ndfDfQcbvecPB8mOFn6a0rei0LunulqoN3sfed1M=
X-Received: by 2002:a81:984e:0:b0:55d:ebd7:2944 with SMTP id
 p75-20020a81984e000000b0055debd72944mr12915911ywg.2.1684773261853; Mon, 22
 May 2023 09:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRPvkdk6t1zkx+Y-QVP_vJRSxp+wuOO0YjyppNDLTNg7g@mail.gmail.com>
 <ZGuTVAj1AJOdTtLF@sashalap>
In-Reply-To: <ZGuTVAj1AJOdTtLF@sashalap>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 May 2023 12:34:11 -0400
Message-ID: <CAHC9VhQ3MmvP9Av9F6mKA03oE-Cima5LMKZbzj6FOZXxtNAYLw@mail.gmail.com>
Subject: Re: Stable backport of de3004c874e7 ("ocfs2: Switch to security_inode_init_security()")
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, May 22, 2023 at 12:07=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
> On Fri, May 19, 2023 at 05:51:59PM -0400, Paul Moore wrote:
> >Hello,
> >
> >I would like to request the backport of the commit below to address a
> >kernel panic in ocfs2 that was identified by Valentin Vidi=C4=87 in this
> >thread:
> >
> >https://lore.kernel.org/linux-security-module/20230401214151.1243189-1-v=
vidic@valentin-vidic.from.hr
> >
> >While Valentin provides his own patch in the original message, the
> >preferred patch is one that went up to Linus during the last merge
> >window; Valentin has tested the patch and confirmed that it resolved
> >the reported problem.
>
> How far should this patch be backported?

The problem is only present when the BPF LSM is enabled, which I
believe was merged upstream in the v5.7 release, so anything v5.7 or
later should be affected and thus a good backport target.

--=20
paul-moore.com
