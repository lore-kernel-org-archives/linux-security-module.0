Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC992C433FE
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Nov 2022 02:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiKJCWk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 9 Nov 2022 21:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiKJCWJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Nov 2022 21:22:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D08D23BF9
        for <linux-security-module@vger.kernel.org>; Wed,  9 Nov 2022 18:22:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA480B8205A
        for <linux-security-module@vger.kernel.org>; Thu, 10 Nov 2022 02:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C82C433B5;
        Thu, 10 Nov 2022 02:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668046926;
        bh=o8xm1CjLcRVR9h1geVorPKMVCHrBiVQJ4TsI0ltjezE=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=OWPobBndVNSeRFQ44bC5ifeHG9Ol040oE0kSbFOpj5ow7ILDiHeAgjARiyVTi7mvo
         UCD7/HOHTIZupQcqSuiReMI+/5gVhful0GQOFVfqLHoXJ1OYN9JSubtXEDVn3LZ1n1
         Ccs1f0UDjvQptbsJa0eMgtLOBiD0Dm/+2XsGAezhVN1/nkEoMVh7P4x6vyeBIQkxxG
         RATDPWU1ddBfSiESavLZSTpZhN6y917p/tpsjEG51SX8z6xm0LOVr03/XSPQ9YtHbG
         RMlRMsvF+FKferJNnKCK1JAgL2kOOQ9eRTpyvjLlWrJvyTo+gWkDD99/PYvxqiS61c
         GMpGejxC8VaOA==
Date:   Wed, 09 Nov 2022 18:22:05 -0800
From:   Kees Cook <kees@kernel.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Paul Moore <paul@paul-moore.com>
CC:     Casey Schaufler <casey@schaufler-ca.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 04/10] CaitSith: Add header file.
User-Agent: K-9 Mail for Android
In-Reply-To: <82e46552-54da-6df5-c451-485991dcb5c3@I-love.SAKURA.ne.jp>
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp> <20221102171025.126961-4-penguin-kernel@I-love.SAKURA.ne.jp> <ef5fa206-4e7f-3c23-07d4-8591c4315d20@schaufler-ca.com> <20221105024345.GA15957@mail.hallyn.com> <5d31873f-f477-ef5a-591f-6f0195f258a8@I-love.SAKURA.ne.jp> <20221105234614.GA23523@mail.hallyn.com> <52fdbbe4-cad5-6cd0-9574-2e5efb88a478@I-love.SAKURA.ne.jp> <4ead148f-1629-22ec-91f3-44c71f70fce4@schaufler-ca.com> <133ffb84-551e-866d-5597-e62a5a39bc05@I-love.SAKURA.ne.jp> <CAHC9VhS9RQdeCipSpSH3_LZyFfb-BDry=EsSmkt4OLVk=OZnEg@mail.gmail.com> <f52e6e9f-5e95-8843-c2f5-c50bba48e5e4@I-love.SAKURA.ne.jp> <CAHC9VhS=0Ts8E647JJiJ6dwPmnuLuYTyOS0QEYJO_EmAb3yFcw@mail.gmail.com> <82e46552-54da-6df5-c451-485991dcb5c3@I-love.SAKURA.ne.jp>
Message-ID: <7CED07F5-A6FC-46AD-8F9D-ECFC28FE23C9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On November 9, 2022 3:57:06 PM PST, Tetsuo Handa <penguin-kernel@I-love=2ES=
AKURA=2Ene=2Ejp> wrote:
>On 2022/11/09 23:48, Paul Moore wrote:
>>                                             If there is a significant
>> change, e=2Eg=2E the overall kernel policy towards out-of-tree code, we
>> can reconsider this policy but as of right now only upstream LSMs will
>> have LSM ID tokens assigned to them; in-development LSMs are free to
>> temporarily assign themselves an ID token (which may change when the
>> LSM is merged upstream), and out-of-tree LSMs are free to do whatever
>> they like with respect to their code, just as they do now=2E
>
>If in-development LSMs and out-of-tree LSMs cannot get a stable ID token,
>developers cannot write and publish userspace tools which make use of ID
>token=2E If ID collision happens by use of temporarily ID token, this tok=
en
>is no longer an identifier=2E That is a pointless and needless constraint
>for getting LSM modules created / tested / used=2E

You have to let this go=2E You aren't hearing us: this ID reservation proc=
ess is not a problem for anyone but you=2E It is the same for all the sysca=
lls that get added, and all the prctls, etc etc=2E This isn't a problem for=
 userspace tools using those, and there won't be a problem here either=2E

We will not support out of tree code, so needing ID stability for out-of-t=
ree LSMs isn't a valid argument=2E

Additionally, not having an LSM built into a distro kernel is a distro ker=
nel problem=2E Open a bug with them and get it fixed=2E E=2Eg=2E Ubuntu has=
 no problem with multiple LSMs:

$ grep 'CONFIG_SECURITY_[^_]*[ =3D]' /boot/config-$(
uname -r)
=2E=2E=2E
CONFIG_SECURITY_SELINUX=3Dy
CONFIG_SECURITY_SMACK=3Dy
CONFIG_SECURITY_TOMOYO=3Dy
CONFIG_SECURITY_APPARMOR=3Dy
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=3Dy
CONFIG_SECURITY_SAFESETID=3Dy
CONFIG_SECURITY_LANDLOCK=3Dy

And they just leave the "exclusive"s disabled at runtime:
CONFIG_LSM=3D"landlock,lockdown,yama,integrity,apparmor"

-Kees


--=20
Kees Cook
