Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B31C001B0
	for <linux-security-module@archiver.kernel.org>; Wed, 26 Jul 2023 11:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjGZLIF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 26 Jul 2023 07:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjGZLH6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 26 Jul 2023 07:07:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FB7132
        for <linux-security-module@vger.kernel.org>; Wed, 26 Jul 2023 04:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690369631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2RhAASZDa4qR7wxJ12uUhhLwWeU47PEkDN4ojyr2iK0=;
        b=F6+ynRoso5YDQS0o3hbqxegp6UQXHEL9qYAvSQyVJFtgGJD7ZIeVrZoAfge91yXUOrESgq
        YtiA+pZBdYiO6KQQJxugbz5Usv8hKfSdLmTG4B4zLVRbyu+D+BfVKqSGfqzIixm60enxTf
        KAm3M0Tyk4kMopRbNQ0W65pmanETyq0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-QdBqVFEmM6ydN-ZNoDNAeQ-1; Wed, 26 Jul 2023 07:07:10 -0400
X-MC-Unique: QdBqVFEmM6ydN-ZNoDNAeQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-40631b647cfso9790311cf.1
        for <linux-security-module@vger.kernel.org>; Wed, 26 Jul 2023 04:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690369630; x=1690974430;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RhAASZDa4qR7wxJ12uUhhLwWeU47PEkDN4ojyr2iK0=;
        b=jGNR5+Fy9T3qmPi4euO/nhfyvD0Sqv+q2sLTrXqvcaTmVakfigcOL77cS3FfcnZC2x
         pEV5cHUpJAu1FeiCKaQVeylGoZEuUZapd0ebDDahdMmvpQvTZ9snharPPXDVfUW1VZH3
         Dsd0IoXVDqdl2qx0USzHzgBnQSAyYIz2KfkPGS0cbhkjc4SSn1giZ5053/l9U8eRqwrO
         swvx688dBpDTJxM4uG2Tw0r9ykeDKkJbpnfhMmkHs0ozo+5HtwZgbq7/4ZJUfE+lGqCm
         Z8VTVULFr9qSJzk6y9aIClkUzJPgC57VNjTwbiE1pQq7/Ch3OhHQOAg6INy4Sb4sjh3s
         S14w==
X-Gm-Message-State: ABy/qLanD1MDlhR2JpMrBvvGW4h0+PTBErI6Cae78gzJg2+2sRaKKAkl
        UGcVPRhuD/EjltpJgW8XiumfEUVmGusqPdd45C3as7TRqmwOHAIn5l2pQNJYGJnUDUyR8SbpiL/
        xJWDa4iykI1WJsqsaUxXuMGQZsKCNxIVAxkDl
X-Received: by 2002:a05:620a:4007:b0:763:a1d3:196d with SMTP id h7-20020a05620a400700b00763a1d3196dmr2275645qko.0.1690369629874;
        Wed, 26 Jul 2023 04:07:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG7QqDnzpUB/dwYHGsT9KH02d9NGuFZpNXp+ZhNitR8Wn10FxTtx+Vjhi+ZWJYa1GU4+YNjiw==
X-Received: by 2002:a05:620a:4007:b0:763:a1d3:196d with SMTP id h7-20020a05620a400700b00763a1d3196dmr2275618qko.0.1690369629594;
        Wed, 26 Jul 2023 04:07:09 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-81.dyn.eolo.it. [146.241.225.81])
        by smtp.gmail.com with ESMTPSA id dc8-20020a05620a520800b00767c76b2c38sm4268489qkb.83.2023.07.26.04.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 04:07:09 -0700 (PDT)
Message-ID: <a9b4571021004affc10cb5e01a985636bd3e71f1.camel@redhat.com>
Subject: Re: [PATCH bpf-next 0/4] Reduce overhead of LSMs with static calls
From:   Paolo Abeni <pabeni@redhat.com>
To:     Paul Moore <paul@paul-moore.com>, KP Singh <kpsingh@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, casey@schaufler-ca.com, song@kernel.org,
        revest@chromium.org
Date:   Wed, 26 Jul 2023 13:07:05 +0200
In-Reply-To: <CAHC9VhSqGtZFXn-HW5pfUub4TmU7cqFWWKekL1M+Ko+f5qgi1Q@mail.gmail.com>
References: <20230119231033.1307221-1-kpsingh@kernel.org>
         <CAHC9VhRpsXME9Wht_RuSACuU97k359dihye4hW15nWwSQpxtng@mail.gmail.com>
         <63e525a8.170a0220.e8217.2fdb@mx.google.com>
         <CAHC9VhTCiCNjfQBZOq2DM7QteeiE1eRBxW77eVguj4=y7kS+eQ@mail.gmail.com>
         <CACYkzJ4w3BKNaogHdgW8AKmS2O+wJuVZSpCVVTCKj5j5PPK-Vg@mail.gmail.com>
         <CAHC9VhSqGtZFXn-HW5pfUub4TmU7cqFWWKekL1M+Ko+f5qgi1Q@mail.gmail.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi all,

On Tue, 2023-06-20 at 19:40 -0400, Paul Moore wrote:
> On Tue, Jun 13, 2023 at 6:03=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> > I tried proposing an idea in
> > https://patchwork.kernel.org/project/netdevbpf/patch/20220609234601.202=
6362-1-kpsingh@kernel.org/
> >  as an LSM_HOOK_NO_EFFECT but that did not seemed to have stuck.
>=20
> It looks like this was posted about a month before I became
> responsible for the LSM layer as a whole, and likely was lost (at
> least on the LSM side of things) as a result.
>=20
> I would much rather see a standalone fix to address the unintended LSM
> interactions, then the static call performance improvements in a
> separate patchset.

Please allow me to revive this old thread. I learned about this effort
only recently and I'm interested into it.

Looking at patch 4/4 from this series, it *think* it's doable to
extract it from the series and make it work standalone. If so, would
that approach be ok from a LSM point of view?

One thing that I personally don't understand in said patch is how the
'__ro_after_init' annotation for the bpf_lsm_hooks fits the run-time
'default_state' changes?!?

Cheers,

Paolo

