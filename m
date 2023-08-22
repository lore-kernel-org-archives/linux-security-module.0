Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77F5EE4996
	for <linux-security-module@archiver.kernel.org>; Tue, 22 Aug 2023 16:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237791AbjHVQaL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 22 Aug 2023 12:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbjHVQaK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 Aug 2023 12:30:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8BB137
        for <linux-security-module@vger.kernel.org>; Tue, 22 Aug 2023 09:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692721772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GFE4JwbJAEfwvheacPafkshB30pxaFOzoBnpl83mRU0=;
        b=I45i/PqOT5h4SrhbYghoCXkUBIzFV3eUlzDoGYzdIlPn5w/QMwMyfnoe6oEAlXqV47UuXT
        dVjBj5UTzp2c81wsjfGsHyJXQCZ8ZXt2rSYbhBiUZhZr2mFbRoLwwjKkG4N/LZUUssE9w4
        c2DtjDM2Weg0bbXxcXZeg93/RWzddNA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-bpJSA2T8Pc6MIBgujx41YA-1; Tue, 22 Aug 2023 12:29:30 -0400
X-MC-Unique: bpJSA2T8Pc6MIBgujx41YA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9B16101A5BD;
        Tue, 22 Aug 2023 16:29:29 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.33.235])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DD6F492C13;
        Tue, 22 Aug 2023 16:29:29 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, audit@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH] audit: add task history record
Date:   Tue, 22 Aug 2023 12:29:28 -0400
Message-ID: <4865772.31r3eYUQgx@x2>
Organization: Red Hat
In-Reply-To: <CAHC9VhSz=3utr_CigGvkMEb6_avJUQq1Ak2smB7neSd76mzjFw@mail.gmail.com>
References: <36b65eb1-ccbf-8b81-468f-b8d88c4be5a3@I-love.SAKURA.ne.jp>
 <b06dbdd8-d2f6-b190-5635-948c0a966103@I-love.SAKURA.ne.jp>
 <CAHC9VhSz=3utr_CigGvkMEb6_avJUQq1Ak2smB7neSd76mzjFw@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wednesday, August 16, 2023 9:53:58 AM EDT Paul Moore wrote:
> On Wed, Aug 16, 2023 at 6:10=E2=80=AFAM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > On 2023/08/16 3:44, Paul Moore wrote:
> > > On Fri, Aug 11, 2023 at 6:58=E2=80=AFAM Tetsuo Handa
> > > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > >> When an unexpected system event occurs, the administrator may want t=
o
> > >> identify which application triggered the event. For example,
> > >> unexpected process termination is still a real concern enough to wri=
te
> > >> articles like https://access.redhat.com/solutions/165993 .
> > >>=20
> > >> This patch adds a record which emits TOMOYO-like task history
> > >> information into the audit logs for better understanding of unexpect=
ed
> > >> system events.
> > >>=20
> > >> type=3DUNKNOWN[1340] msg=3Daudit(1691750738.271:108):
> > >> history=3D"name=3Dswapper/0;pid=3D1;start=3D20230811194329=3D>name=
=3Dinit;pid=3D1;s
> > >> tart=3D20230811194343=3D>name=3Dsystemd;pid=3D1;start=3D202308111944=
39=3D>name=3Dssh
> > >> d;pid=3D3660;start=3D20230811104504=3D>name=3Dsshd;pid=3D3767;start=
=3D202308111045
> > >> 35"
> > >
> > > While I respect your persistence, we've talked about this quite a bit
> > > already in other threads.  What you are trying to do is already
> > > possible with audit
> >=20
> > How?
>=20
> If you configure audit to record exec() and friends you should have a
> proper history of the processes started on the system.

This is not a practical solution. Yes, technically this could be done. But =
it=20
would be a huge burden on the system to keep up with this. And it would bur=
y=20
events you truly wanted to see effectively DoS'ing the audit system.

-Steve


