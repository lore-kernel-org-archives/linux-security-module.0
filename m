Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B520EE4993
	for <linux-security-module@archiver.kernel.org>; Wed, 23 Aug 2023 15:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbjHWPHY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 23 Aug 2023 11:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbjHWPHX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Aug 2023 11:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2640FB
        for <linux-security-module@vger.kernel.org>; Wed, 23 Aug 2023 08:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692803197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jfnHoc1YmuJxQ4Jew9CvxweDPef8oXDx8JlpyWWJv2k=;
        b=iyZukx4jI27NDltz6hAHXeTQF3hRvNoSLSDSF15foAxPMVoDYZJ7bcIzYX4TCFC1/iIdV8
        qEhDl7l9Nl/9VtVi+ZNDWxNoeb7pGk1LGQjPH2IurOtTnhJWeF74em/UEClzo+MKTRrMB3
        fDUJOIZq3zxtND5h2czzWIlYL4QX59s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-v5A5aynfMZK15X8DcLSlZQ-1; Wed, 23 Aug 2023 11:06:33 -0400
X-MC-Unique: v5A5aynfMZK15X8DcLSlZQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51e535b143fso960075a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 23 Aug 2023 08:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692803193; x=1693407993;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/lAPZvjYKTEK5H7a6XipRBFpGlVfo5m8iaWcgQJHV58=;
        b=MbRESYsVD2rqnsoJ/Hh39ZvfvIso/WKFIdhuafR466mtN8iHX3E2h4YOgQprxyYRaQ
         N2WMJ12TZblkse9PjsWCvLVj5NXIoWbjONVH1wBI0wQ7GVSZ/OxiqyQR39wY21Dpn+Dw
         TonKdnBBrlVrnDv2t/wLP3UPtGbK6DT1bt131XyleThuJnG9JnofgorOzHu+Ao0WTMzf
         j7crMaVStklNuivAYvxsR257Ovea3QeLWcKRIVZigTKX1BNXMCLrcImk/55lKpghQ0lg
         bnvWybk/yCXmoT9dHSr3dCScRgEl//GpD0mUdzS3/vp7/GXo/QGoe0LD3jO6mvYrHres
         XRqQ==
X-Gm-Message-State: AOJu0Yy/FyHE2ycWv46yzlIDiAxfGjMrq0otsp8ihRIbL7aHFdXyBm7i
        2sg08OXNy3/2RBlaix0g5f21oBVLpRgaHGGpwycRdi8aOSBSLunj6EsoIQkNUSfvkC5SxIVtrX8
        Sgy9E5GwPULC6K8KUkEQ0kb+CeZhHulXpg7Jt
X-Received: by 2002:a05:6402:40c8:b0:521:66b4:13b4 with SMTP id z8-20020a05640240c800b0052166b413b4mr10286398edb.0.1692803192798;
        Wed, 23 Aug 2023 08:06:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ262PFlED6zguO002PB4qfFU7R4kySK5Ms7+2GYdbgPlJn3i9//tcInFqSyGs7JFIZxtHzw==
X-Received: by 2002:a05:6402:40c8:b0:521:66b4:13b4 with SMTP id z8-20020a05640240c800b0052166b413b4mr10286381edb.0.1692803192449;
        Wed, 23 Aug 2023 08:06:32 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-4.dyn.eolo.it. [146.241.241.4])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7cf10000000b00521d2f7459fsm9344139edy.49.2023.08.23.08.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 08:06:32 -0700 (PDT)
Message-ID: <7fb26856a6859ecdce8c54ed4ef552fb87d9ffca.camel@redhat.com>
Subject: Re: [PATCH RFC 0/3] security: allow a LSM to specify NO-OP return
 code
From:   Paolo Abeni <pabeni@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        KP Singh <kpsingh@kernel.org>
Date:   Wed, 23 Aug 2023 17:06:30 +0200
In-Reply-To: <c993c896-730e-322e-5e97-7c4804d5192b@schaufler-ca.com>
References: <cover.1691082677.git.pabeni@redhat.com>
         <c993c896-730e-322e-5e97-7c4804d5192b@schaufler-ca.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

On Mon, 2023-08-07 at 11:57 -0700, Casey Schaufler wrote:
> On 8/3/2023 10:12 AM, Paolo Abeni wrote:
> > This is another attempt to solve the current problem with eBPF LSM,
> > already discussed at least in [1].
> >=20
> > The basic idea is to introduce the minimum amount of changes to let
> > the core consider a no-op any LSM hooks returning the
> > LSM_RET_DEFAULT [2].
> >=20
> > AFAICS that is already the case for most int hooks with LSM_RET_DEFAULT
> > equal to 0 due to the current call_int_hook implementation. Even most
> > int hook with non zero LSM_RET_DEFAULT are not problematic. Specificall=
y
> > the hooks [3]:
> >=20
> > fs_context_parse_param
> > dentry_init_security
> > inode_getsecurity
> > inode_setsecurity
> > inode_copy_up_xattr
> > task_prctl
> > security_secid_to_secctx=20
> >=20
> > already have special handling for to basically ignore default return
> > value from the LSMs, while:
> >=20
> > security_getprocattr
> > security_setprocattr
> >=20
> > only operate on the specified LSM.
> >=20
> > The only hooks that need some love are:
> >=20
> > * hooks that have a 0 LSM_RET_DEFAULT, but with no LSM loaded returns a
> >   non zero value to the security_<hook> caller:
> > sb_set_mnt_opts
> > inode_init_security
> > inode_getsecctx
> > socket_getpeersec_stream
> > socket_getpeersec_dgram
> >=20
> > * hooks that have a 0 LSM_RET_DEFAULT, but internally security_<hook>
> >   uses a non zero return value as a selector to perform a default
> >   action:
> > inode_setxattr
> > inode_removexattr
> >=20
> > * hooks the somehow have to reconciliate multiple, non-zero, LSM return
> >   values to take a single decision:
> > vm_enough_memory
> > xfrm_state_pol_flow_match
> >=20
> > This series introduces a new variant of the call_int_hook macro and
> > changes the LSM_RET_DEFAULT for the mentioned hooks, to achieve the
> > goal [2].
> >=20
> > The patches have been split according to the above grouping with the
> > hope to simplify the reviews, but I guess could be squashed in a single
> > one.
> >=20
> > A simple follow-up would be extend the new hook usage to the hooks [3]
> > to reduce the code duplication.
> >=20
> > Sharing as an early RFC (with almost no testing) to try to understand i=
f
> > this path is a no go or instead is somewhat viable.
>=20
> I am not an advocate of adding macros for these special cases.
> The only reason the existing macros are used is that open coding
> every hook with the exact same logic would have created an enormous
> security.c file. Special cases shouldn't be hidden. The reason they
> are special should be documented.
>=20
> Should the stacking patch set ever come in there are going to be
> more and more kinds of special cases. I don't see that adding code
> macros for each of the peculiar behaviors is a good idea.

First things first, thank you for your feedback and I'm sorry for the
very late reply: I have been off for the past few weeks.

I'm unsure how to interpret the above: is that an explicit nack to this
approach, it that almost an ack modulo some needed cleanup or something
in between ?!? ;)

Regarding the new macro introduced in patch 1/3, I think of it more as
a generalization then a special case. In fact it could replace all the
existing:

=09call_int_hook(/* */, 0, ...)

call sites with no functional changes expected (modulo bugs).

I avoided that change to keep the series small, but it could clean-up
the code in the longer run and help isolating which code really needs a
special case.

But I guess there is a certain degree of personal style preferences
with this kind changes.

Any additional feedback more then welcome!

Cheers,

Paolo

