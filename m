Return-Path: <SRS0=ig/x=VU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA26C76186
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jul 2019 21:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70622253D
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jul 2019 21:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392177AbfGWVrF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:47:05 -0400
Received: from namei.org ([65.99.196.166]:36756 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392173AbfGWVrF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Jul 2019 17:47:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x6NLkwlk017263;
        Tue, 23 Jul 2019 21:46:58 GMT
Date:   Wed, 24 Jul 2019 07:46:58 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Simon McVittie <smcv@collabora.com>
cc:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Subject: Re: Preferred subj= with multiple LSMs
In-Reply-To: <20190723140634.GA30188@horizon>
Message-ID: <alpine.LRH.2.21.1907240746280.16974@namei.org>
References: <CAHC9VhTpcnyGg5j3b6Z7Yi0Ob01JETRiBmz1AuLqPWqP9tEAnA@mail.gmail.com> <5ea2a25b-364f-3c30-79c6-cfb18515d7ba@schaufler-ca.com> <CAHC9VhQ9MSh5zCkhMja4r9j0RT952LwKSaG5dR-BqXzXrtEAUw@mail.gmail.com> <e9cf875a-0d0f-a56f-71dd-c22c67bdcc2d@schaufler-ca.com>
 <CAHC9VhQS9We1TNqRfuR_E-kV4aZddx9euaiv5Gzd5B5AkiDAUQ@mail.gmail.com> <f375c23c-29e6-dc98-d71c-328db91117bc@schaufler-ca.com> <CAHC9VhTf0yYDZBxOtfv2E5=GtrBYonoqr46hyBy7qdNdjVLoVg@mail.gmail.com> <alpine.LRH.2.21.1907230649460.18217@namei.org>
 <ca22ea45-3f3b-4f79-8d77-7528877b8b36@schaufler-ca.com> <CAHC9VhSbg7BxPSA4NkQV3_1zx6cj3ej25e6fJ2FBWX9fU104rg@mail.gmail.com> <20190723140634.GA30188@horizon>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 23 Jul 2019, Simon McVittie wrote:

> On Mon, 22 Jul 2019 at 18:30:35 -0400, Paul Moore wrote:
> > On Mon, Jul 22, 2019 at 6:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > I suggest that if supporting dbus well is assisted by
> > > making reasonable restrictions on what constitutes a valid LSM
> > > "context" that we have a good reason.
> > 
> > I continue to believe that restrictions on the label format are a bad
> > idea
> 
> Does this include the restriction "the label does not include \0",
> which is an assumption that dbus is already relying on since I checked
> it in the thread around
> <https://marc.info/?l=linux-security-module&m=142323508321029&w=2>?
> Or is that restriction so fundamental that it's considered OK?

Security labels are strings, so this is implied.


-- 
James Morris
<jmorris@namei.org>

