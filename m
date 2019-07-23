Return-Path: <SRS0=ig/x=VU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F53C7618B
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jul 2019 14:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3216421738
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jul 2019 14:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfGWOGh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Jul 2019 10:06:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48498 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfGWOGh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Jul 2019 10:06:37 -0400
Received: from localhost (unknown [IPv6:2a00:5f00:102:0:3aba:f8ff:fe58:9ca1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smcv)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9FE1928A8AF;
        Tue, 23 Jul 2019 15:06:36 +0100 (BST)
Date:   Tue, 23 Jul 2019 15:06:34 +0100
From:   Simon McVittie <smcv@collabora.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Subject: Re: Preferred subj= with multiple LSMs
Message-ID: <20190723140634.GA30188@horizon>
References: <CAHC9VhTpcnyGg5j3b6Z7Yi0Ob01JETRiBmz1AuLqPWqP9tEAnA@mail.gmail.com>
 <5ea2a25b-364f-3c30-79c6-cfb18515d7ba@schaufler-ca.com>
 <CAHC9VhQ9MSh5zCkhMja4r9j0RT952LwKSaG5dR-BqXzXrtEAUw@mail.gmail.com>
 <e9cf875a-0d0f-a56f-71dd-c22c67bdcc2d@schaufler-ca.com>
 <CAHC9VhQS9We1TNqRfuR_E-kV4aZddx9euaiv5Gzd5B5AkiDAUQ@mail.gmail.com>
 <f375c23c-29e6-dc98-d71c-328db91117bc@schaufler-ca.com>
 <CAHC9VhTf0yYDZBxOtfv2E5=GtrBYonoqr46hyBy7qdNdjVLoVg@mail.gmail.com>
 <alpine.LRH.2.21.1907230649460.18217@namei.org>
 <ca22ea45-3f3b-4f79-8d77-7528877b8b36@schaufler-ca.com>
 <CAHC9VhSbg7BxPSA4NkQV3_1zx6cj3ej25e6fJ2FBWX9fU104rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSbg7BxPSA4NkQV3_1zx6cj3ej25e6fJ2FBWX9fU104rg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 22 Jul 2019 at 18:30:35 -0400, Paul Moore wrote:
> On Mon, Jul 22, 2019 at 6:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > I suggest that if supporting dbus well is assisted by
> > making reasonable restrictions on what constitutes a valid LSM
> > "context" that we have a good reason.
> 
> I continue to believe that restrictions on the label format are a bad
> idea

Does this include the restriction "the label does not include \0",
which is an assumption that dbus is already relying on since I checked
it in the thread around
<https://marc.info/?l=linux-security-module&m=142323508321029&w=2>?
Or is that restriction so fundamental that it's considered OK?

(Other user-space tools like ls -Z and ps -Z also rely on that assumption
by printing security contexts with %s, as far as I know.)

dbus does not require a way to multiplex multiple LSMs' labels in a
printable text string, so from my point of view, multiplexed labels do
not necessarily have to be in what Casey calls the "Hideous" format,
or in any text format at all: anything with documented rules for parsing
(including the unescaping that readers are expected to apply, if there
is any) would be fine. Based on the assumption of no "\0", I previously
suggested a "\0"-delimited encoding similar to /proc/self/cmdline, which
would not need any escaping/unescaping:

    "apparmor\0" <apparmor label> "\0"
    "selinux\0" <SELinux label> "\0"
    ...
    "\0" (or this could be omitted since it's redundant with the length)

which would be fine (indeed, actually easier than the "Hideous" format)
from dbus' point of view.

dbus does not strictly need reading security labels for sockets or
processes to be atomic, either: it would be OK if we can get the complete
list of LSM labels *somehow*, possibly in O(number of LSMs) rather than
O(1) syscalls (although I'd prefer O(1)).

However, the getsockopt() interface only lets the kernel return one thing
per socket option, and I assume the networking maintainers probably don't
want to have to add SO_PEERAPPARMOR, SO_PEERSELINUX... for each LSM -
so this part at least would probably be easier as a single blob in some
text or binary format.

    smcv
