Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773A4CD37B6
	for <linux-security-module@archiver.kernel.org>; Sat, 16 Sep 2023 08:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjIPIHT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 16 Sep 2023 04:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjIPIHN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 16 Sep 2023 04:07:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F99B19A8
        for <linux-security-module@vger.kernel.org>; Sat, 16 Sep 2023 01:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694851581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RcJhU9yrJlYW0JwS0jBHn6K5F5PsCG42wfINjuYLJv4=;
        b=K2Cffu5LmzXGAUz6sbt2Xb/oin1mIxnN4IYIjxzsXwrkATA+/vJ9v4zQG5Mxs0D41DuGJD
        6X9GWZsHpDbg6m/SEduLheucbupjKoKWyEPtQ4jfUBQa9S/q3yg8UMNtqhrbHDEYFOmP4Q
        COfj4nK5+apmcNbx5iHS3OHKSiOQWFo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-Z_3OYBykPOKOPa3-GEPTRQ-1; Sat, 16 Sep 2023 04:06:20 -0400
X-MC-Unique: Z_3OYBykPOKOPa3-GEPTRQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-404f8ccee4bso1200965e9.1
        for <linux-security-module@vger.kernel.org>; Sat, 16 Sep 2023 01:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694851579; x=1695456379;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RcJhU9yrJlYW0JwS0jBHn6K5F5PsCG42wfINjuYLJv4=;
        b=C5811uU10SmuIi1f68KxAmO6oqWATOHB1vWlUx3/tr93SG0xT+/wyT7tZgq0So94l9
         Me69pl/WoslUMOPT6kYE3JwHEH/O6vyKYdrY+5NMYSZCjRsiZWCS0bzUoOfUELNowf/1
         dQX9MMVS+x51FxJop8YsI/ojmbWu5ArKpeWuRRwbjKDK2M7hZznzLw5YCFIITQIJ6kwR
         qQbs82D1ZiuhfoF29dYTae3a6HvdPe5Jj4A8J0KWgz/p2wJPE3+V7gJ27RJMKQuBb7iu
         whMUIkwHjcBgxMpFFBUUIUAgTQIHRvjwJ6ZvuUXGPQMgLEjWaO8o/WejIcUkR2QzXrOY
         dhRA==
X-Gm-Message-State: AOJu0Yyn4ICvtjlGu69YCpzJpiQmHmysYP89z8ZowymmAORwzloEl356
        Itxqs5z/ATwPSI/JTBM/EQf+Lukis5PjZfkCspy1B4H9wEcE2WD1q9Y2iw5Z2pyxb/Vm5jA0xYi
        iWIEXK2bMgyC2bBHokG3u7dGnpDCo7Z7QZ1oV
X-Received: by 2002:a5d:484a:0:b0:31a:ea18:c516 with SMTP id n10-20020a5d484a000000b0031aea18c516mr3147680wrs.3.1694851578979;
        Sat, 16 Sep 2023 01:06:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYkkZ6CMVhyAAiIEGRVoXQz3vuRoMHD4ya1yYkGxrjzwQNYpC4iSPnOTwMZM/ai1A1Yyxuvg==
X-Received: by 2002:a5d:484a:0:b0:31a:ea18:c516 with SMTP id n10-20020a5d484a000000b0031aea18c516mr3147663wrs.3.1694851578612;
        Sat, 16 Sep 2023 01:06:18 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-149.dyn.eolo.it. [146.241.247.149])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d5008000000b0031f8be5b41bsm6485441wrt.5.2023.09.16.01.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 01:06:18 -0700 (PDT)
Message-ID: <e7185c2f7f84f5f88c08bec2a986afb5851c2d4e.camel@redhat.com>
Subject: Re: [PATCH bpf-next 0/4] Reduce overhead of LSMs with static calls
From:   Paolo Abeni <pabeni@redhat.com>
To:     KP Singh <kpsingh@kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, casey@schaufler-ca.com, song@kernel.org,
        revest@chromium.org
Date:   Sat, 16 Sep 2023 10:06:16 +0200
In-Reply-To: <CACYkzJ5_zK4Y71G8eNBtDdJ+nNQ0VoMEtaR960Metb4t9QWsqg@mail.gmail.com>
References: <20230119231033.1307221-1-kpsingh@kernel.org>
         <CAHC9VhRpsXME9Wht_RuSACuU97k359dihye4hW15nWwSQpxtng@mail.gmail.com>
         <63e525a8.170a0220.e8217.2fdb@mx.google.com>
         <CAHC9VhTCiCNjfQBZOq2DM7QteeiE1eRBxW77eVguj4=y7kS+eQ@mail.gmail.com>
         <CACYkzJ4w3BKNaogHdgW8AKmS2O+wJuVZSpCVVTCKj5j5PPK-Vg@mail.gmail.com>
         <CAHC9VhSqGtZFXn-HW5pfUub4TmU7cqFWWKekL1M+Ko+f5qgi1Q@mail.gmail.com>
         <a9b4571021004affc10cb5e01a985636bd3e71f1.camel@redhat.com>
         <CACYkzJ5_zK4Y71G8eNBtDdJ+nNQ0VoMEtaR960Metb4t9QWsqg@mail.gmail.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

I'm sorry for the duplicate, I did a quick reply via the gmail UI and
that unintentionally inserted html. Retrying with a real email client.

On Sat, 2023-09-16 at 02:57 +0200, KP Singh wrote:
> On Wed, Jul 26, 2023 at 1:07=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> > Looking at patch 4/4 from this series, it *think* it's doable to
> > extract it from the series and make it work standalone. If so, would
> > that approach be ok from a LSM point of view?
>=20
> I will rev up the series again. I think it's worth fixing both issues
> (performance and this side-effect). There are more users who have been
> asking me for performance improvements for LSMs

FTR, I'm also very interested in the performance side of the thing.

My understanding is that Paul asks the 'side-effect' issue being
addressed before/separately.

To that extent I shared a slightly different approach here:

https://lore.kernel.org/linux-security-module/cover.1691082677.git.pabeni@r=
edhat.com/

with the hope it could be 'cleaner' and allow building the indirect
call avoidance on top.

I would appreciate it if you could take a look there, too!

Thanks,

Paolo


