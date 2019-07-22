Return-Path: <SRS0=Cnd7=VT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ABEC7618F
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Jul 2019 20:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9768D21900
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Jul 2019 20:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfGVUum (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Jul 2019 16:50:42 -0400
Received: from namei.org ([65.99.196.166]:36578 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbfGVUul (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Jul 2019 16:50:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x6MKoZxs021586;
        Mon, 22 Jul 2019 20:50:35 GMT
Date:   Tue, 23 Jul 2019 06:50:35 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Paul Moore <paul@paul-moore.com>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Subject: Re: Preferred subj= with multiple LSMs
In-Reply-To: <CAHC9VhTf0yYDZBxOtfv2E5=GtrBYonoqr46hyBy7qdNdjVLoVg@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1907230649460.18217@namei.org>
References: <f824828c-5c9d-b91e-5cec-70ee7a45e760@schaufler-ca.com> <d1a237d3-4b72-48b0-27d6-fb168354ad31@schaufler-ca.com> <CAHC9VhTQLihNQ1iGjJB=LAn=C6BQokFsjsRcj8O_O9AjqQ7HBg@mail.gmail.com> <2517266.eHZzEmjMsX@x2> <27e2c710-efe6-d9cd-d4f9-bc217df5ede3@schaufler-ca.com>
 <CAHC9VhTpcnyGg5j3b6Z7Yi0Ob01JETRiBmz1AuLqPWqP9tEAnA@mail.gmail.com> <5ea2a25b-364f-3c30-79c6-cfb18515d7ba@schaufler-ca.com> <CAHC9VhQ9MSh5zCkhMja4r9j0RT952LwKSaG5dR-BqXzXrtEAUw@mail.gmail.com> <e9cf875a-0d0f-a56f-71dd-c22c67bdcc2d@schaufler-ca.com>
 <CAHC9VhQS9We1TNqRfuR_E-kV4aZddx9euaiv5Gzd5B5AkiDAUQ@mail.gmail.com> <f375c23c-29e6-dc98-d71c-328db91117bc@schaufler-ca.com> <CAHC9VhTf0yYDZBxOtfv2E5=GtrBYonoqr46hyBy7qdNdjVLoVg@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 19 Jul 2019, Paul Moore wrote:

> > We've never had to think about having general rules on
> > what security modules do before, because with only one
> > active each could do whatever it wanted without fear of
> > conflict. If there is already a character that none of
> > the existing modules use, how would it be wrong to
> > reserve it?
> 
> "We've never had to think about having general rules on what security
> modules do before..."
> 
> We famously haven't imposed restrictions on the label format before
> now, and this seems like a pretty poor reason to start.

Agreed.


-- 
James Morris
<jmorris@namei.org>

