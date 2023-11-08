Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28999C4332F
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Nov 2023 09:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjKHJb1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Nov 2023 04:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjKHJb1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Nov 2023 04:31:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3A11B3
        for <linux-security-module@vger.kernel.org>; Wed,  8 Nov 2023 01:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699435838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rIJ9Sp4WDXeLHrAHmgcW3eORTPdG2Gg4lSkUwSA3Tro=;
        b=Mt1dXD+zqKrYLEgdt33A1vK/He9oQ2KrmqQR8s9og0vtpg0H5NsLa0EMATH8zxqXz/RT8e
        FUWGi+WJNqV4RpC/Dc0WrOr1j3zK+ubmCpjNigg1+I92qQJB0X53S9KiV5XTlWPrui5Pzj
        l1Bchkl1XRKnAmKLPFrm4hJjEpDa17o=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-U5pim71hPQyUXLdp2QgCIQ-1; Wed, 08 Nov 2023 04:30:37 -0500
X-MC-Unique: U5pim71hPQyUXLdp2QgCIQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2803256bc44so5101040a91.1
        for <linux-security-module@vger.kernel.org>; Wed, 08 Nov 2023 01:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699435836; x=1700040636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIJ9Sp4WDXeLHrAHmgcW3eORTPdG2Gg4lSkUwSA3Tro=;
        b=kwh3da8PkoQgKXJnFLbz6Tfv5wVUdINJstqxvXlV+JVrXdMqWtjyNhvSdP80Ar8VVs
         fhq6DtmvPX0pz4NyIPWI3URGm3TYK3tMageJhSFsipgVGVB8wiIB0nmey/LP6CLHUuQo
         Qh5FlTXL63PqxAg9hmvy563eaON+cDPxuwOzSo+JdK29m9lijx/1zB8oMsw7/qp5BXwG
         MJSgS+iFEiG8yktv5anS77RJHGBcppRnLNBpeIMX+TtIDBaS+QSpTwrRJotX5bubNqQc
         vHQyjc7cwDOoJR0EKo4/Z5pDP8pNgaE3XvDINmzJOD1VDKA1317CUATZO7WPUY2jN++V
         tnDQ==
X-Gm-Message-State: AOJu0YygLoVHjpFnHEOQHeKLGP1x72oFgC8jnIbx4V0IckwnshD2vr6b
        cHxl1tCEZaVYfGDTEJbhVSq9MgWE5Y1jaZhH90NqCVa08AvADaZuRl3pFIuAuLpLVobjj8h+4rT
        kyIySIUP+TYmUj3faWQ5w6I/gdECc1TPolTM1UnBgiZvX4xNCtgpV
X-Received: by 2002:a17:90b:1d8b:b0:280:9074:eb3d with SMTP id pf11-20020a17090b1d8b00b002809074eb3dmr1121683pjb.22.1699435835975;
        Wed, 08 Nov 2023 01:30:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9bZILe3c2bhpCe4q7fc/KlUogt9ffT/7VG+Gw1ANZMxAhcGHfxel/wE9IvMJsNgengT/52pMt+83K3i+PiE4=
X-Received: by 2002:a17:90b:1d8b:b0:280:9074:eb3d with SMTP id
 pf11-20020a17090b1d8b00b002809074eb3dmr1121671pjb.22.1699435835705; Wed, 08
 Nov 2023 01:30:35 -0800 (PST)
MIME-Version: 1.0
References: <20231031123207.758655-1-omosnace@redhat.com> <CAHC9VhRo2GzW0jSqmm0Sv3z_-q9PTsvScV5oQwF5uNh+ZcWreA@mail.gmail.com>
In-Reply-To: <CAHC9VhRo2GzW0jSqmm0Sv3z_-q9PTsvScV5oQwF5uNh+ZcWreA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 8 Nov 2023 10:30:24 +0100
Message-ID: <CAFqZXNtFfZ3FEoVAfM5r_a-mTqphz7qw=F3_Em87dRz6ca4EaQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] lsm: fix default return values for some hooks
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 8, 2023 at 4:12=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Tue, Oct 31, 2023 at 8:32=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> >
> > Some of the default return values listed in <linux/lsm_hook_defs.h>
> > don't match the actual no-op value and can be trivially fixed.
> >
> > Ondrej Mosnacek (2):
> >   lsm: fix default return value for vm_enough_memory
> >   lsm: fix default return value for inode_getsecctx
> >
> >  include/linux/lsm_hook_defs.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> These both look like reasonable -stable candidates to me, what do you thi=
nk?

Yes, that would be my assessment as well.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

