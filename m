Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C3CC001DC
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Jul 2023 13:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjGKNGz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Jul 2023 09:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjGKNGy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Jul 2023 09:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D139E49
        for <linux-security-module@vger.kernel.org>; Tue, 11 Jul 2023 06:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689080772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=621jpeg8rXw1HoMqyF3Cr2cXzc4xRe3exawPPb/GBlI=;
        b=Vr7Vl/0KkrB2NbJY2wxJtUnePDcws1WfTK08MakPXvYDCtfU86kCq4FyceuA1oZquZ1JTh
        ZPVUMSf7MuooCWhwxK7EACCfj7jKlrLTfZNzmX/WRtZVH98F5ZLl/iFgUS0dQn3nt/jt9a
        dO055t1Eh6Migw4aqYM22Z7Yv48iTm4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-PasQLjn1NiqXEFwZb3IEfw-1; Tue, 11 Jul 2023 09:06:09 -0400
X-MC-Unique: PasQLjn1NiqXEFwZb3IEfw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7675fc3333eso389786485a.0
        for <linux-security-module@vger.kernel.org>; Tue, 11 Jul 2023 06:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689080769; x=1691672769;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=621jpeg8rXw1HoMqyF3Cr2cXzc4xRe3exawPPb/GBlI=;
        b=S6m4gWc4miubARAQrGlMmBqev/9gsw3d1EmWw10f4eQZT7ttPiDFigjvKV5/mAHSqP
         r2kPISQT94/E/k3569ZUJLfSDcSqZdAbpPd36/XmC6KdETwHFvPVH3JV4RnvZAdbwCeB
         XMILA99d57xWYSLH1RwYPI5c5ypCueeGC1C5Xb42OGqv9MdAUqccgb0IP+IQaVt0+Z41
         qb42WePPUZcTFjWfevIm4beLyrn0X49syKmpRCjwitWxlKVNN8vB2T6zNhfJmVoretPG
         uk7Jdxx2tTSECcMSWj9Lcsnlw3Q95HK+rl/fW0xdOH051BmOpBHS6FpIXEISLbls2F63
         9U8A==
X-Gm-Message-State: ABy/qLYT14/+gwt/azg5qXMFysuZBH0b49NyaZo8nsOq9MDYCfk1ez7F
        QsDiRTI7uUn11JtdVPwKrsM94JyhxKpm4bhf8MTPCpfbjUeleFv+Gt5KmqI+x0xKk4vV4Yu5YrM
        6E8WXTdfecHPKHFkibROHR0cHCigEQFa5eaxM
X-Received: by 2002:a05:620a:2a08:b0:765:734b:1792 with SMTP id o8-20020a05620a2a0800b00765734b1792mr23405414qkp.23.1689080768679;
        Tue, 11 Jul 2023 06:06:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGKsAEoYjCuBe/RLC+s8vVfCSnBTIjmYs9lUXherbrMHdd/xt8k/DuInjKGuiKn/ST+FGm8LA==
X-Received: by 2002:a05:620a:2a08:b0:765:734b:1792 with SMTP id o8-20020a05620a2a0800b00765734b1792mr23405385qkp.23.1689080768414;
        Tue, 11 Jul 2023 06:06:08 -0700 (PDT)
Received: from debian ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id g6-20020ae9e106000000b00767dc4c539bsm970048qkm.44.2023.07.11.06.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 06:06:07 -0700 (PDT)
Date:   Tue, 11 Jul 2023 15:06:00 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        David Ahern <dsahern@kernel.org>, Dmitry Kozlov <xeb@mail.ru>
Subject: [PATCH net-next 0/4] net: Mark the sk parameter of routing functions
 as 'const'.
Message-ID: <cover.1689077819.git.gnault@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The sk_getsecid security hook prevents the use of a const sk pointer in
several routing functions. Since this hook should only read sk data,
make its sk argument const (patch 1), then constify the sk parameter of
various routing functions (patches 2-4).

Build-tested with make allmodconfig.

Guillaume Nault (4):
  security: Constify sk in the sk_getsecid hook.
  ipv4: Constify the sk parameter of ip_route_output_*().
  ipv6: Constify the sk parameter of several helper functions.
  pptp: Constify the po parameter of pptp_route_output().

 drivers/net/ppp/pptp.c        |  4 ++--
 include/linux/icmpv6.h        | 10 ++++------
 include/linux/lsm_hook_defs.h |  2 +-
 include/linux/security.h      |  5 +++--
 include/net/route.h           |  6 +++---
 net/ipv6/datagram.c           |  7 ++++---
 net/ipv6/icmp.c               |  6 ++----
 net/ipv6/mcast.c              |  8 +++-----
 security/security.c           |  2 +-
 security/selinux/hooks.c      |  4 ++--
 10 files changed, 25 insertions(+), 29 deletions(-)

-- 
2.39.2

