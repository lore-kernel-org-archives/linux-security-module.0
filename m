Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3FCC04A6A
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Aug 2023 19:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjHGTEP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Aug 2023 15:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjHGTEO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Aug 2023 15:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0B1171E
        for <linux-security-module@vger.kernel.org>; Mon,  7 Aug 2023 12:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691435009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iTMauSdneX4madkewbm8sDwjJ93dcCFrkuHV7obPu9M=;
        b=PNjVubR7T42VTspw6nRtjs/4au2BMBgGKRWWcC5IaC740oganv2v9IupfExKYo+dHU7dQc
        zDNmUUKemF4u5na7SM0ytZrXHemCAkQge7izGo5uAMhZ3KcVBBPtlMFiAZt1VMIRzxyNkL
        vaM2uXWwpQWvO51Sy1Ihj8ETPsPCOHY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-FHP16Y3UNgShpPGFUmKiLg-1; Mon, 07 Aug 2023 15:03:24 -0400
X-MC-Unique: FHP16Y3UNgShpPGFUmKiLg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF9938DC666;
        Mon,  7 Aug 2023 19:03:23 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.17.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 536C42166B25;
        Mon,  7 Aug 2023 19:03:23 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-audit@redhat.com
Cc:     audit@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-audit@redhat.com, Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH v2] TaskTracker : Simplified thread information tracker.
Date:   Mon, 07 Aug 2023 15:03:22 -0400
Message-ID: <2155117.irdbgypaU6@x2>
Organization: Red Hat
In-Reply-To: <CAHC9VhSsDTyfae6f0XvYYcCRH590L1ZEqbHSM4UgUCHRGm7X_g@mail.gmail.com>
References: <41d03271-ff8a-9888-11de-a7f53da47328@I-love.SAKURA.ne.jp>
 <CAHC9VhSsDTyfae6f0XvYYcCRH590L1ZEqbHSM4UgUCHRGm7X_g@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Monday, August 7, 2023 2:53:40 PM EDT Paul Moore wrote:
> On Sun, Aug 6, 2023 at 9:05=E2=80=AFAM Tetsuo Handa
>=20
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > When an unexpected system event occurs, the administrator may want to
> > identify which application triggered the event. For example, unexpected
> > process termination is still a real concern enough to write articles
> > like https://access.redhat.com/solutions/165993 . TaskTracker is a
> > trivial LSM module which emits TOMOYO-like information into the audit
> > logs for better understanding of unexpected system events.
>=20
> Help me understand why all of this information isn't already available
> via some combination of Audit and TOMOYO, or simply audit itself?

Usually when you want this kind of information, you are investigating an=20
incident. You wouldn't place a syscall audit for every execve and then=20
reconstruct the call chain from that. In the case of long running daemons,=
=20
the information could have been rotated away. But typically you want to see=
=20
what the entry point is. A sudden shell from bind would be suspicious while=
 a=20
shell from sshd is not.

-Steve

> In the case of an audit-only design you would likely need to do some
> processing of the audit log to determine the full historical process
> tree of the process being killed, but all of the information should be
> there if you configure audit properly.  I'm less familiar with TOMOYO,
> but your comment about this LSM recording "TOMOYO-like" information
> makes me believe that TOMOYO already records this information.




