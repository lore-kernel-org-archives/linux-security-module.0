Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03A3C41513
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Aug 2023 20:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjHGUN3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Aug 2023 16:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGUN3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Aug 2023 16:13:29 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2926810D2
        for <linux-security-module@vger.kernel.org>; Mon,  7 Aug 2023 13:13:28 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-583f036d50bso56444487b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 07 Aug 2023 13:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691439207; x=1692044007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BSiKRKC9HfnpxyZNhhglUB5KhJQ++JbCDmWfWXMqA0=;
        b=Yd3T1cyFKB76NT3ybzQRxhENL0jr27KzwcFkMfwAtiZiC68kXVxZ5Fwpn4X1EnTWg2
         /+gLge7p+HgOul8wU0o7+9Fe0S+LI1ILR6bU4MDpFfOQJw/LfLLPL7r7R7Wcam9LDIe+
         rDb2fXWewd0XQqGrY8GCCZrfBJkCcGN9sk5h/D35Qbqvt9lsbc8LDP7F3fH/v35ifSF/
         FeBCYmK6KhkeED+p7uOdPu07QLG/yNEx3rdS7mrNLLswLolBJYa75Nl/8LNqUsbS0hGU
         e+bn6GY5umBASGWTXb8fN6hL3lpqhJjTeu48fsQ+nQM7Ohsz/vmqiuvn3VSFvuNGATnU
         RgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691439207; x=1692044007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BSiKRKC9HfnpxyZNhhglUB5KhJQ++JbCDmWfWXMqA0=;
        b=Gh6gj6Fciod/jUwpebXAuo0XJwWEtCG0uMMehNuefKOaD57VwSG+uU8TKfPgW6X6WS
         Grch2sEQKpOeMp82m7lg7IrpmrhORXkg9ZH2hMz3d2n1mUQvtHt7wnFMeigerx4Q2X65
         yjx5zrGtTvbax+3/5UdC8cOVvr9/JzeRhNYPkDtwEJnGRv38spJqCZZ9foQK7BPfaaa1
         PtSDHaMZDHZpJgAlCr3TVH8nniGl9YvpRl3ojC7No1yPvd9DD7hEsiEFuKapFOK/KdPP
         1C5OYEkANcUJ7EEfa9j6W9DKpjLePYZnPFlJ1eTwtgazWRmfNBlKXaFVV18vabBtZTKX
         rOAw==
X-Gm-Message-State: AOJu0YwtJJ3h3ftg8HMeP5ENipvVl6sNznfLqxxiwBiau8iDGEt3ZwJh
        DgSjaY2CNMYwuzu0/2qLFD+CIBAOpQl1o8m61+sA
X-Google-Smtp-Source: AGHT+IEDEy77xCD9qkQ07ozj1FNjsVU9wqnTnVkAMARkmSMMoED2HhOM4oxaUbEi/gP5JDTBkKCj1fGsjl7m7EssEJI=
X-Received: by 2002:a0d:ff84:0:b0:573:30c8:6e1d with SMTP id
 p126-20020a0dff84000000b0057330c86e1dmr12665460ywf.44.1691439207362; Mon, 07
 Aug 2023 13:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <41d03271-ff8a-9888-11de-a7f53da47328@I-love.SAKURA.ne.jp>
 <CAHC9VhSsDTyfae6f0XvYYcCRH590L1ZEqbHSM4UgUCHRGm7X_g@mail.gmail.com> <2155117.irdbgypaU6@x2>
In-Reply-To: <2155117.irdbgypaU6@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Aug 2023 16:13:16 -0400
Message-ID: <CAHC9VhRG2aX-_ye7ZRWpZkR7rq8Op7RUVS3cMtxhF8t1bdw5oQ@mail.gmail.com>
Subject: Re: [PATCH v2] TaskTracker : Simplified thread information tracker.
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-audit@redhat.com, audit@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 7, 2023 at 3:03=E2=80=AFPM Steve Grubb <sgrubb@redhat.com> wrot=
e:
> On Monday, August 7, 2023 2:53:40 PM EDT Paul Moore wrote:
> > On Sun, Aug 6, 2023 at 9:05=E2=80=AFAM Tetsuo Handa
> >
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > > When an unexpected system event occurs, the administrator may want to
> > > identify which application triggered the event. For example, unexpect=
ed
> > > process termination is still a real concern enough to write articles
> > > like https://access.redhat.com/solutions/165993 . TaskTracker is a
> > > trivial LSM module which emits TOMOYO-like information into the audit
> > > logs for better understanding of unexpected system events.
> >
> > Help me understand why all of this information isn't already available
> > via some combination of Audit and TOMOYO, or simply audit itself?
>
> Usually when you want this kind of information, you are investigating an
> incident. You wouldn't place a syscall audit for every execve and then
> reconstruct the call chain from that. In the case of long running daemons=
,
> the information could have been rotated away. But typically you want to s=
ee
> what the entry point is. A sudden shell from bind would be suspicious whi=
le a
> shell from sshd is not.

Once again, why not use the existing audit and/or TOMOYO capabilities.

--=20
paul-moore.com
