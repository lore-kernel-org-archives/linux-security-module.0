Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C94BC7618D
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Mar 2023 16:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCTQYn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Mar 2023 12:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCTQYY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Mar 2023 12:24:24 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5D11557D
        for <linux-security-module@vger.kernel.org>; Mon, 20 Mar 2023 09:17:46 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id p204so2625826ybc.12
        for <linux-security-module@vger.kernel.org>; Mon, 20 Mar 2023 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679329065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mu3q0qWkHZbzQYy+ssNMyHCnAXMki/3wSo/9vrZjZl0=;
        b=J12Cco/dBiTw2EvVZrUx6xjelvX9oPev6yH/XXnRs3UENdJKQA/Ej2y7nHeFzBYa+7
         7+rqVAvwhj/dQ8WxD4gTfGokAOkGVjQM68d4I+OnTdwAQRGyVj+4T8ihihudRNiHRa99
         NdskRO9K7P992UsCecn36OC70OUlB/izHg4jwExzW9yQkeTE7gM9BriTYsrmxeY1/NGn
         ABrDMBQjZkfovyNsWFVQ7PST+6Mppjo17vA6BsZwRntRApXydX8/ikM4LAB8Os9nnjOg
         IxYgTV2NiBa6NL/1hQkZm0xfpH+q+E2fCK6fkWAZHF4PphyO/Hwnb9TWypt9NtaSSBUa
         biCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mu3q0qWkHZbzQYy+ssNMyHCnAXMki/3wSo/9vrZjZl0=;
        b=AuISrO12HAHUc7JKvuv4L3DQQcR/bqOArFNmRBVE/FadrWHJed5uYJFu/qwFFxI6/5
         b0haNqsXb8mxzTO0jEBOd1R+75rgWOgUBd1VsJN8weJQ6y7dY/2MeYnm7W3dklAV13xb
         yWrvqyW7GxkNV46tBHTrLBTraI5kfgcHjqjKrR3Jud+GCewr2SjK6LHhdcFvEec7rpZ+
         cOpin10/HG3L16PwFU5HDjVbmZRGz93dyPYXKvptdFEAJ58K16QRTCn761xQgysC0x/a
         twAzZe1M7q5KejsGRBsBdViFNneNgH3WDP/1SSkdh2bCz1lM4hLMOO8C0nga/gA2ovCD
         LQEw==
X-Gm-Message-State: AO0yUKWEG4R84P/yzSJoIN5naBDr+V01YEqy/TVPXsQ2bm0eAzMeXbQb
        vEx4RFeEFDmk1pb7xXVTQsi7anJzoo//gAkAJh/xs8nV7xTW3Ik=
X-Google-Smtp-Source: AK7set8cpwA2U51TAifGczY6dKrNFq8jZSJ1gkBU62uYvI2X3gg2IwjxPyeB4IWe1FZ3mPfU7ZH38JM8JAEKzzZt6VU=
X-Received: by 2002:a05:6902:708:b0:b6c:f26c:e58d with SMTP id
 k8-20020a056902070800b00b6cf26ce58dmr2119424ybt.3.1679329065125; Mon, 20 Mar
 2023 09:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230317195615.281810-1-paul@paul-moore.com> <da4e7d33-29ab-2dd0-ef46-20f60998bae9@schaufler-ca.com>
In-Reply-To: <da4e7d33-29ab-2dd0-ef46-20f60998bae9@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Mar 2023 12:17:34 -0400
Message-ID: <CAHC9VhRg5kxoYUPCb21iPdM=54JQQJjB6i4PPoiWK+4nJqK9uA@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove the runtime disable functionality
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Mar 17, 2023 at 7:15=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 3/17/2023 12:56 PM, Paul Moore wrote:
> > After working with the larger SELinux-based distros for several
> > years, we're finally at a place where we can disable the SELinux
> > runtime disable functionality.  The existing kernel deprecation
> > notice explains the functionality and why we want to remove it:
> >
> >   The selinuxfs "disable" node allows SELinux to be disabled at
> >   runtime prior to a policy being loaded into the kernel.  If
> >   disabled via this mechanism, SELinux will remain disabled until
> >   the system is rebooted.
> >
> >   The preferred method of disabling SELinux is via the "selinux=3D0"
> >   boot parameter, but the selinuxfs "disable" node was created to
> >   make it easier for systems with primitive bootloaders that did not
> >   allow for easy modification of the kernel command line.
> >   Unfortunately, allowing for SELinux to be disabled at runtime makes
> >   it difficult to secure the kernel's LSM hooks using the
> >   "__ro_after_init" feature.
> >
> > It is that last sentence, mentioning the '__ro_after_init' hardening,
> > which is the real motivation for this change, and if you look at the
> > diffstat you'll see that the impact of this patch reaches across all
> > the different LSMs, helping prevent tampering at the LSM hook level.
> >
> > >From a SELinux perspective, it is important to note that if you
> > continue to disable SELinux via "/etc/selinux/config" it may appear
> > that SELinux is disabled, but it is simply in an uninitialized state.
> > If you load a policy with `load_policy -i`, you will see SELinux
> > come alive just as if you had loaded the policy during early-boot.
> >
> > It is also worth noting that the "/sys/fs/selinux/disable" file is
> > always writable now, regardless of the Kconfig settings, but writing
> > to the file has no effect on the system, other than to display an
> > error on the console if a non-zero/true value is written.
> >
> > Finally, in the several years where we have been working on
> > deprecating this functionality, there has only been one instance of
> > someone mentioning any user visible breakage.  In this particular
> > case it was an individual's kernel test system, and the workaround
> > documented in the deprecation notice ("selinux=3D0" on the kernel
> > command line) resolved the issue without problem.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Except for the Documentation fumble noted below,

Yes, Daniel also pointed that out and it's fixed in my dev branch.

> enthusiastically ...
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> or, if you'd prefer ...
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Generally I prefer 'Reviewed-by' tags as they imply that someone
actually read/reviewed the code, but since this patch does technically
touch the Smack code I think the ACK is probably more appropriate
here.  Regardless, thanks for the review/ACK.

--=20
paul-moore.com
