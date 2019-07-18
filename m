Return-Path: <SRS0=m0b+=VP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA20C76191
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jul 2019 13:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BC020880
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jul 2019 13:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfGRNKi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Jul 2019 09:10:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55006 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfGRNKi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Jul 2019 09:10:38 -0400
Received: from localhost (unknown [IPv6:2a00:5f00:102:0:3aba:f8ff:fe58:9ca1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smcv)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D92DF28A357;
        Thu, 18 Jul 2019 14:10:36 +0100 (BST)
Date:   Thu, 18 Jul 2019 14:10:34 +0100
From:   Simon McVittie <smcv@collabora.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Subject: Re: Preferred subj= with multiple LSMs
Message-ID: <20190718131034.GA12581@horizon>
References: <d1a237d3-4b72-48b0-27d6-fb168354ad31@schaufler-ca.com>
 <CAHC9VhTQLihNQ1iGjJB=LAn=C6BQokFsjsRcj8O_O9AjqQ7HBg@mail.gmail.com>
 <2517266.eHZzEmjMsX@x2>
 <27e2c710-efe6-d9cd-d4f9-bc217df5ede3@schaufler-ca.com>
 <CAHC9VhTpcnyGg5j3b6Z7Yi0Ob01JETRiBmz1AuLqPWqP9tEAnA@mail.gmail.com>
 <5ea2a25b-364f-3c30-79c6-cfb18515d7ba@schaufler-ca.com>
 <CAHC9VhQ9MSh5zCkhMja4r9j0RT952LwKSaG5dR-BqXzXrtEAUw@mail.gmail.com>
 <e9cf875a-0d0f-a56f-71dd-c22c67bdcc2d@schaufler-ca.com>
 <CAHC9VhQS9We1TNqRfuR_E-kV4aZddx9euaiv5Gzd5B5AkiDAUQ@mail.gmail.com>
 <f375c23c-29e6-dc98-d71c-328db91117bc@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f375c23c-29e6-dc98-d71c-328db91117bc@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 17 Jul 2019 at 16:02:16 -0700, Casey Schaufler wrote:
> We've never had to think about having general rules on
> what security modules do before, because with only one
> active each could do whatever it wanted without fear of
> conflict. If there is already a character that none of
> the existing modules use, how would it be wrong to
> reserve it?
> 
> Smack disallows the four characters '"/\ because quoting
> is too important to ignore and the likelyhood that someone
> would confuse labels with paths seemed great. I sniffed
> around a little, but couldn't find the sets for SELinux or
> AppArmor.

It seems we've been here before, when I added LinuxSecurityLabel to
https://dbus.freedesktop.org/doc/dbus-specification.html#bus-messages-get-connection-credentials
in D-Bus.

Recapping the context for those who might have missed it: in D-Bus,
processes communicate in a hub-and-spoke topology via a central message
bus process, which forwards messages between the other processes. Some
other IPC systems would call this a broker. As a result of this
indirection, the message bus is the only process in the overall system
that is in a position to ask the kernel for the identity of the other
processes (credentials(7) and related topics like LSM labels) using
unforgeable kernel-guaranteed socket options like SO_PEERCRED, SO_PEERSEC
and SO_PEERGROUPS. This means that if two processes communicate via D-Bus
and want to know each other's identities, they have to ask the message
bus; so the message bus needs a representation for that information. For
LSM labels, that representation is LinuxSecurityLabel, which is defined
in terms of SO_PEERSEC.

At the time that I defined LinuxSecurityLabel, nobody was willing to
say for sure that the label was guaranteed to be ASCII or UTF-8 (which
is part of the specification for the D-Bus STRING ('s') type), so I
had to encode it as an arbitrary ARRAY of BYTE ('ay') rather than as
a STRING. I was at least told that the label wouldn't contain embedded
'\0', and that if there is a trailing '\0', I can safely canonicalize
the string by removing it.

Also, at the time that I did that, nobody was willing to say for sure
that there was any particular correspondence between the security
label obtained by reading /proc/self/attr/current and the security
label obtained by getting the SO_PEERSEC socket option: in AppArmor,
/proc/self/attr/current is something like "unconfined\n" whereas
SO_PEERSEC is either "unconfined" or "unconfined\0" (I forget which),
but the consensus seemed to be that there is no guarantee that the
presence or absence of a trailing newline wouldn't be significant to
some non-AppArmor LSM.

If LSM stacking is going to lead to syntactic restrictions being imposed
on security labels, please could someone add them to credentials(7)
or some other suitable documentation so user-space developers can know
where we stand, or tell me what the restrictions and guarantees are so
I can propose a documentation patch?

Thanks,
    smcv
