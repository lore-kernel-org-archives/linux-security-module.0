Return-Path: <SRS0=JRQQ=Z3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B7DC2BD09
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Dec 2019 10:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B1D24656
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Dec 2019 10:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrjqAl0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfLEKN0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:13:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22086 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729295AbfLEKN0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Dec 2019 05:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575540805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dLjLck9Pm/snpxos2FeKTPLyXDOV4MbjcH5G/gXnZeo=;
        b=UrjqAl0FdTx1DR8II4SItSOlGSaV0zYAIeT3P/cdj/b/s/gfViXXoV2xNJ0RLZmdjU6cu/
        4KkfTSYf+GJf2ciZm6bDahr2A/wf9HqN4Mlt25JTIiiatJD4ES0ba0cBW180jJzJnulzny
        hZ6p2Oxf2aBUKy28i3TAT+CG9DJG3MI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-sqpaFdMINAaZIfALwAWdEA-1; Thu, 05 Dec 2019 05:13:23 -0500
Received: by mail-wr1-f70.google.com with SMTP id z10so1296610wrt.21
        for <linux-security-module@vger.kernel.org>; Thu, 05 Dec 2019 02:13:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K5MgG/FvOKZSKbQY6hPWHA5W+WMbjReooYZ5I81Xsns=;
        b=ZdH4DUuXmRmh9iDQVAczhE7ELR0Nog5TahZrBSLPVu0e1cl+YgDv0IGaWfH+YaZPpn
         eKvrZ3NV8u0Puiw6Qh1SH/WbUf3P2qM3nEcJ3hCH8byFllHw+oIT+dxuHe+VDkAtDoE0
         7Oz32cA3wCST+8uIibAsftk9fYxc0PtRyczxQIJaM9kL5U14kkfqS2YhEYpDdmX6F00K
         fatKHusx8iXGQbsQItJh4hPLmzbl6JeJ6ujBtBhUCm8EZcyeHx3TDj7l8Rw3iiKxoVG2
         5PK8EhB95YCapYAzD379idHmlrucmJvRhTXB3QIAFTcyRaP+z5GwHvRaPkWST4NluWHw
         DA1w==
X-Gm-Message-State: APjAAAVB5wWDINwdoJbphMUJFjahVXmIB2fXtx4515EQ3uwWeC74Rvzw
        MLewnKjckxM3eckGQxHlXp46k0kpK7D9QywiyBanMH6mJn8mDvQAlwSesBU/bBNPA9IqwDBVKkq
        gKyUOxmYA57eErC9yqsX+se3A/sYjIX1ESevp
X-Received: by 2002:adf:ee88:: with SMTP id b8mr9668749wro.249.1575540802662;
        Thu, 05 Dec 2019 02:13:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqy1I4G0ttOXF/rUkkrOfkbFkbQZCtitZoVCfOg6HbWgiUhViQ9mKyA8AXZI2yuHHuDJRNzr4g==
X-Received: by 2002:adf:ee88:: with SMTP id b8mr9668720wro.249.1575540802410;
        Thu, 05 Dec 2019 02:13:22 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:541f:a977:4b60:6802? ([2001:b07:6468:f312:541f:a977:4b60:6802])
        by smtp.gmail.com with ESMTPSA id b10sm11809139wrt.90.2019.12.05.02.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 02:13:21 -0800 (PST)
Subject: Re: KASAN: slab-out-of-bounds Read in fbcon_get_font
To:     syzbot <syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com>,
        aryabinin@virtuozzo.com, b.zolnierkie@samsung.com,
        daniel.thompson@linaro.org, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, dvyukov@google.com,
        ghalat@redhat.com, gleb@kernel.org, gwshan@linux.vnet.ibm.com,
        hpa@zytor.com, jmorris@namei.org, kasan-dev@googlegroups.com,
        kvm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mingo@redhat.com,
        mpe@ellerman.id.au, penguin-kernel@i-love.sakura.ne.jp,
        ruscur@russell.cc, sam@ravnborg.org, serge@hallyn.com,
        stewart@linux.vnet.ibm.com, syzkaller-bugs@googlegroups.com,
        takedakn@nttdata.co.jp, tglx@linutronix.de, x86@kernel.org
References: <0000000000003e640e0598e7abc3@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <41c082f5-5d22-d398-3bdd-3f4bf69d7ea3@redhat.com>
Date:   Thu, 5 Dec 2019 11:13:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <0000000000003e640e0598e7abc3@google.com>
Content-Language: en-US
X-MC-Unique: sqpaFdMINAaZIfALwAWdEA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 04/12/19 22:41, syzbot wrote:
> syzbot has bisected this bug to:
>=20
> commit 2de50e9674fc4ca3c6174b04477f69eb26b4ee31
> Author: Russell Currey <ruscur@russell.cc>
> Date:=C2=A0=C2=A0 Mon Feb 8 04:08:20 2016 +0000
>=20
> =C2=A0=C2=A0=C2=A0 powerpc/powernv: Remove support for p5ioc2
>=20
> bisection log:=C2=A0 https://syzkaller.appspot.com/x/bisect.txt?x=3D127a0=
42ae00000
> start commit:=C2=A0=C2=A0 76bb8b05 Merge tag 'kbuild-v5.5' of
> git://git.kernel.org/p..
> git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upstream
> final crash:=C2=A0=C2=A0=C2=A0 https://syzkaller.appspot.com/x/report.txt=
?x=3D117a042ae00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D167a042ae0000=
0
> kernel config:=C2=A0 https://syzkaller.appspot.com/x/.config?x=3Ddd226651=
cb0f364b
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3D4455ca3b3291de891abc
> syz repro:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://syzkaller.appspot.com/x/=
repro.syz?x=3D11181edae00000
> C reproducer:=C2=A0=C2=A0 https://syzkaller.appspot.com/x/repro.c?x=3D105=
cbb7ae00000
>=20
> Reported-by: syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com
> Fixes: 2de50e9674fc ("powerpc/powernv: Remove support for p5ioc2")
>=20
> For information about bisection process see:
> https://goo.gl/tpsmEJ#bisection
>=20

Why is everybody being CC'd, even if the bug has nothing to do with the
person's subsystem?

Thanks,

Paolo

