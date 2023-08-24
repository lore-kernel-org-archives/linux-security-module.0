Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E71C71153
	for <linux-security-module@archiver.kernel.org>; Thu, 24 Aug 2023 15:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240711AbjHXP4w (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 24 Aug 2023 11:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242226AbjHXP4U (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 Aug 2023 11:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F391991
        for <linux-security-module@vger.kernel.org>; Thu, 24 Aug 2023 08:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692892537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iN+msxJLYAhHzgNEChbcMrQDy0nc4V54WNgJK5hj8/s=;
        b=DDr1nTfUxcIOfEeT2/Wxv8xNUSgOjCx7sr9KNa3CHBlULx3CxIeX69FDjjBYV7dzI//ZTR
        /D8BL4F9wmPCvDqbM96nmKLnqcB0SgPP5cBisMw55/lo+rrLatdC/zHhFFxgU9zmjpl1yF
        eGN3UYf8GNt8UeKulE6CBaR3gQICzHU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-sGCe4PP9PkCro3oaAVeSyQ-1; Thu, 24 Aug 2023 11:55:33 -0400
X-MC-Unique: sGCe4PP9PkCro3oaAVeSyQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD00038117F2;
        Thu, 24 Aug 2023 15:55:32 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.18.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EB58492C13;
        Thu, 24 Aug 2023 15:55:32 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, audit@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] audit: add task history record
Date:   Thu, 24 Aug 2023 11:55:31 -0400
Message-ID: <5966626.lOV4Wx5bFT@x2>
Organization: Red Hat
In-Reply-To: <CAHC9VhTZE2BinivPRLJ9S_21YcmXA6tMdDtAm5w3nk0dbZ0j1w@mail.gmail.com>
References: <36b65eb1-ccbf-8b81-468f-b8d88c4be5a3@I-love.SAKURA.ne.jp>
 <d2557f88-0cda-b0bf-5c76-7c18912798c9@I-love.SAKURA.ne.jp>
 <CAHC9VhTZE2BinivPRLJ9S_21YcmXA6tMdDtAm5w3nk0dbZ0j1w@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Paul,

On Thursday, August 24, 2023 9:30:10 AM EDT Paul Moore wrote:
> On Thu, Aug 24, 2023 at 9:21=E2=80=AFAM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > On 2023/08/23 23:48, Paul Moore wrote:
> > > We've already discussed this both from a kernel load perspective (it
> > > should be able to handle the load, if not that is a separate problem
> > > to address) as well as the human perspective (if you want auditing,
> > > you need to be able to handle auditing).
> >=20
> > No. You haven't shown us audit rules that can satisfy requirements show=
n
> > below.>=20
> >   (1) Catch _all_ process creations (both via fork()/clone() system cal=
ls
> >   and kthread_create() from the kernel), and duplicate the history upon
> >   process creation.
>=20
> Create an audit filter rule to record the syscalls you are interested
> in logging.
>=20
> >   (2) Catch _all_ execve(), and update the history upon successful
> >   execve().
>=20
> Create an audit filter rule to record the syscalls you are interested
> in logging.
>=20
> >   (3) Catch _all_ process terminations (both exit()/exit_group()/kill()
> >   system  calls and internal reasons such as OOM killer), and erase the
> >   history upon process termination.
>=20
> Create an audit filter rule to record the events you are interested in
> logging, if there is an event which isn't being recorded feel free to
> submit a patch to generate an audit record.

I'm not for or against this or a similar patch. The information Tetsuo is=
=20
looking for cannot be recreated from logs. What if it were a daemon that's=
=20
been running for a year? With the amount of data you are suggesting to log,=
=20
it would have rotated away months ago. To log all of the system calls you=
=20
mention would be abusive of the audit system, hurt performance, wear out SS=
D=20
drives, and ultimately fail.

There may be other reasons you don't like the patch and that's fine. But=20
saying it can be done from user space after the fact is not helpful.

-Steve


