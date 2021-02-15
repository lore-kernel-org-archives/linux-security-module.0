Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FC0C433DB
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Feb 2021 19:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F2E864E0F
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Feb 2021 19:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhBOTFP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Feb 2021 14:05:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230175AbhBOTFM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Feb 2021 14:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613415825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yjLa1ePdzOKfH1hFOxUctagsf0SqnjEtoXHUeu2nq70=;
        b=Jg7ymGtSerp97XIAv7aKvJbT/H1QUTS5FXFeW3E63ffHy73LiabqElk93t0ppooA0Lccde
        xaQs/4hI4l6o2iREiywqh6jkbEJGPoVqer0Mujw+jf0SfVO0k2GRE8aijdIbFlwgWJBOK6
        kxDGUDCjFUnm6jp1NgRXktWYv2I1v2c=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-1Hkco0AEP--FOr6Etj0Rug-1; Mon, 15 Feb 2021 14:03:43 -0500
X-MC-Unique: 1Hkco0AEP--FOr6Etj0Rug-1
Received: by mail-yb1-f199.google.com with SMTP id o9so5155386yba.18
        for <linux-security-module@vger.kernel.org>; Mon, 15 Feb 2021 11:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yjLa1ePdzOKfH1hFOxUctagsf0SqnjEtoXHUeu2nq70=;
        b=dYZa/P+O4IC2aeMG7lSrEyPrugaFPfhdLS7jBTPHUigHlKj0oMQyBBegJ/ZaPAAKfB
         JdeQxNUcgex0oV/lBFMZLs6c0I+k9hFY2fl/0XbYpk2Q7B+MbewqQNJdJpSxiSJCEZ05
         tfpqkBwxjvdH0scvEsEagxVHA4YxEpYBiOwjTUOzCov4dpROhIneQYlUv9SmQTcjPHnt
         IhFEVT1X0+iQmEwDHDnG0nKN0+8kSZ2mq/MVHzTjmBB1VGbWVxuDD3ZTiNrppZ8FHwyV
         NFdbN6y8QyIo+YT4FTCqiTdmNfnoOhmQARy42s0FMe2gAVN4eSi73ATaKJfFtaRoP0Ct
         Vw9w==
X-Gm-Message-State: AOAM530kUXAqc+TglDYS711Rax+G1iYUxH8pDBbGd+8JBCUKlGFO2IL+
        hLe9fydVILMpDaoUmxddds0rnbBcoHIcGz3313+ezQPj2807EFnC9K0BoXipww3guJwKxH6hpUX
        2XP16mxrNA4zcUyxZ1T/Vcx4xDPB5RDcrasdMhhnxvZXEUMMx3gJi
X-Received: by 2002:a5b:404:: with SMTP id m4mr24943609ybp.436.1613415822971;
        Mon, 15 Feb 2021 11:03:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxedalHqY8rbPQisLkuArGmVarQZGazs9bCgbyFwBWzr5n/txrW6AMcFAF2u8fzpNzUhxkz8qFAkSuEWt2jT7I=
X-Received: by 2002:a5b:404:: with SMTP id m4mr24943585ybp.436.1613415822772;
 Mon, 15 Feb 2021 11:03:42 -0800 (PST)
MIME-Version: 1.0
References: <20210215181511.2840674-1-mic@digikod.net> <20210215181511.2840674-4-mic@digikod.net>
In-Reply-To: <20210215181511.2840674-4-mic@digikod.net>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 15 Feb 2021 20:03:29 +0100
Message-ID: <CAFqZXNsvqx-pbC+wzHB4aXX6h=buU3csM_a=By-zCOmx0n-xCQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] security: Add LSMs dependencies to CONFIG_LSM
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        linux-kbuild@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 15, 2021 at 7:17 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>
> Thanks to the previous commit, this gives the opportunity to users, when
> running make oldconfig, to update the list of enabled LSMs at boot time
> if an LSM has just been enabled or disabled in the build.  Moreover,
> this list only makes sense if at least one LSM is enabled.
>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20210215181511.2840674-4-mic@digikod.net
> ---
>
> Changes since v1:
> * Add CONFIG_SECURITY as a dependency of CONFIG_LSM.  This prevent an
>   error when building without any LSMs.
> ---
>  security/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/security/Kconfig b/security/Kconfig
> index 7561f6f99f1d..addcc1c04701 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -277,6 +277,10 @@ endchoice
>
>  config LSM
>         string "Ordered list of enabled LSMs"
> +       depends on SECURITY || SECURITY_LOCKDOWN_LSM || SECURITY_YAMA || =
\
> +               SECURITY_LOADPIN || SECURITY_SAFESETID || INTEGRITY || \
> +               SECURITY_SELINUX || SECURITY_SMACK || SECURITY_TOMOYO || =
\
> +               SECURITY_APPARMOR || BPF_LSM

This looks really awkward, since all of these already depend on
SECURITY (if not, it's a bug)... I guarantee you that after some time
someone will come, see that the weird boolean expression is equivalent
to just SECURITY, and simplify it.

I assume the new mechanism wouldn't work as intended if there is just
SECURITY? If not, then maybe you should rather specify this value
dependency via some new  field rather than abusing "depends on" (say,
"value depends on"?). The fact that a seemingly innocent change to the
config definition breaks your mechanism suggests that the design is
flawed.

I do think this would be a useful feature, but IMHO shouldn't be
implemented like this.

>         default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,=
tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
>         default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selin=
ux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
>         default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if=
 DEFAULT_SECURITY_TOMOYO
> --
> 2.30.0
>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

