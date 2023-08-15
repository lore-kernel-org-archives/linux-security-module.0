Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10165C001B0
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Aug 2023 18:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbjHOSqE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 15 Aug 2023 14:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239378AbjHOSpd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Aug 2023 14:45:33 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B1835AC
        for <linux-security-module@vger.kernel.org>; Tue, 15 Aug 2023 11:44:57 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-589e0eef06dso26062387b3.2
        for <linux-security-module@vger.kernel.org>; Tue, 15 Aug 2023 11:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692125094; x=1692729894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZps84ysRP0NeVlJT28XZWO+nki5NsVjjdBZ2Y0DhN0=;
        b=JY8njen4h1XecFvkkWfBdWvexIzjMjfJBUd0Zsm3/1rmCvMVr0VlWBR09W0sZS/621
         D2DqREf+g/I7hWRrGBE99r7qwAm43Zti/84EqT6lkHbRZNJDREKWO8Xwao0bwRfzDpo/
         mUc5WH72/XGjrOinL86MH2fiSF47A0Q2YqInm/Vts647Kc5iqGvXkl4lbxnLlCIMxHKC
         ghmATK/7J+M2FgAEqRZxRNpX3f+eWz+PulVpM3eIUma5PsxeyzaxZBXJ/fDCE2e0gWWq
         DvJkEMwbPalbZS4QMkhjQvgiNmXd8tM6Rbnjhj/0sO6jc577WzN7ziWQghnwszAGTvA+
         QbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692125094; x=1692729894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZps84ysRP0NeVlJT28XZWO+nki5NsVjjdBZ2Y0DhN0=;
        b=TPxRGhBZRFpz5t2NdASp150OYXCCgitWxrZdF1V3nus+ODYTf/OhVZRYeXgLsQjHaY
         ken/xRpTai2ei7DLMsiHlj2MESDA9yefot+tq5wQbt41e4u+Kx1ZuFFvrHrOv6Uxtt6u
         sQOtXkGdEPX2DY3YcwbGk1P5GKeTxmvGILAjlgXFbSHjaDFupFt9GrdgelOFmHS+Md9p
         jrdTrXH60+cQPAJHL8uqt8SKImYhkjVY9Ce5mn6KGDJlFQtpz8dUgHtvCTI9KfBR0p7r
         Q0a8OplH8ifFOoHKTvyPoZjeKeG9yqTnVpaIi1o56hnB357sc6rlmaEWmdqumtZl65Mh
         aqrg==
X-Gm-Message-State: AOJu0Yw1Q2mxgUxL9HvgFr34J03xP5eHhk1tvpMx84E4V1EDYu9tEAX5
        bjuRuhyOITw1UCaMsGrmB6/itHQX3qqHXnbnfggY
X-Google-Smtp-Source: AGHT+IHx8o0tREZgd80T1D1EvXrYw6lYsELJicHooOd7UFD+IsRuzuHRtwAOfNqacGvlfkvvf80IxXfCwrgpjqTabic=
X-Received: by 2002:a0d:ca8d:0:b0:589:eeb6:b503 with SMTP id
 m135-20020a0dca8d000000b00589eeb6b503mr5786073ywd.35.1692125094192; Tue, 15
 Aug 2023 11:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <36b65eb1-ccbf-8b81-468f-b8d88c4be5a3@I-love.SAKURA.ne.jp>
In-Reply-To: <36b65eb1-ccbf-8b81-468f-b8d88c4be5a3@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Aug 2023 14:44:43 -0400
Message-ID: <CAHC9VhTLQjjQ0QMfBDHYCz9LOAuO=rJWSDEUqPsFE+dowFbN=Q@mail.gmail.com>
Subject: Re: [PATCH] audit: add task history record
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-audit@redhat.com, audit@vger.kernel.org,
        Steve Grubb <sgrubb@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Aug 11, 2023 at 6:58=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> When an unexpected system event occurs, the administrator may want to
> identify which application triggered the event. For example, unexpected
> process termination is still a real concern enough to write articles
> like https://access.redhat.com/solutions/165993 .
>
> This patch adds a record which emits TOMOYO-like task history information
> into the audit logs for better understanding of unexpected system events.
>
>   type=3DUNKNOWN[1340] msg=3Daudit(1691750738.271:108): history=3D"name=
=3Dswapper/0;pid=3D1;start=3D20230811194329=3D>name=3Dinit;pid=3D1;start=3D=
20230811194343=3D>name=3Dsystemd;pid=3D1;start=3D20230811194439=3D>name=3Ds=
shd;pid=3D3660;start=3D20230811104504=3D>name=3Dsshd;pid=3D3767;start=3D202=
30811104535"

While I respect your persistence, we've talked about this quite a bit
already in other threads.  What you are trying to do is already
possible with audit and/or TOMOYO enabled and configured so I see no
reason why we want to merge this.  I understand your frustration that
TOMOYO is not enabled by your prefered distribution, but adding
additional (and arguably redundant code) code to the upstream kernel
is not a solution I am willing to support and maintain long term.

> To be able to avoid bloating audit log files due to this information, thi=
s
> patch uses audit_history=3D kernel command line parameter that controls m=
ax
> length of history in bytes (default is 1024, and setting to 0 disables
> recording and emitting).
>
> Unlike execve()'s argv record, records in this history information is
> emitted as one string in order to reduce bloat of the audit log files.
> This information can be split into an array using =3D> as the tokenizer.
> But don't expect that you can compare array elements throughout the whole
> audit logs by splitting into an array, for old records get removed from
> history when history became too long to append the newest record. This
> history information is meant to be interpreted by humans rather than be
> analyzed by programs.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  fs/exec.c                  |   1 +
>  include/linux/audit.h      |   5 ++
>  include/linux/sched.h      |   1 +
>  include/uapi/linux/audit.h |   1 +
>  init/init_task.c           |   7 +++
>  kernel/audit.c             |   1 +
>  kernel/auditsc.c           | 108 +++++++++++++++++++++++++++++++++++++
>  7 files changed, 124 insertions(+)

--=20
paul-moore.com
