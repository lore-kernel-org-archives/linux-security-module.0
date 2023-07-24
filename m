Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59452C0015E
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Jul 2023 16:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGXQ3l (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjGXQ3e (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Jul 2023 12:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548221B8
        for <linux-security-module@vger.kernel.org>; Mon, 24 Jul 2023 09:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690216123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VPc6LfzoRjjMU729bz7XR4bzpQ4gehtU1LQqpTZbFIM=;
        b=KKD/TdWGgDJi/Z8Zwdi/GTiff240lW4boJ+i4Ve6t/589QxBfHbD0c5nU0CrAdL0hWvkf9
        bGbBIMBjuFRG4BpNRNSzslCe9ylWhgZBD+jdzIQly2fsIM1qfuFrMkIxNBsB2FHGsq3yN9
        Jo5gBzW5NDK2ZCDjw5sxMg3s5ut7swI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-7XmJda7-O-SjkVE16w__Wg-1; Mon, 24 Jul 2023 12:28:39 -0400
X-MC-Unique: 7XmJda7-O-SjkVE16w__Wg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-405512b12f5so6797791cf.0
        for <linux-security-module@vger.kernel.org>; Mon, 24 Jul 2023 09:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216118; x=1690820918;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VPc6LfzoRjjMU729bz7XR4bzpQ4gehtU1LQqpTZbFIM=;
        b=jjrABw012/V8h9P2HMPRWaqHipLTCmr3GTy05nWnzWzMcsPO62keDE+qZMeTIbGEuM
         SmpjLlgeoT7DYLogqBWOpdFp4+fq10pf4KTHKY7X05qajAaznqYzdo+iJRzzczqyGqJU
         jLfTWmouuxtAwCmDXoKXjd2+1WldLtgfonEI745hV42YSuxK64kGdb2Q/0VAyeZY8nqC
         xQ5yNykmKT7AvtWplWrg/DaG6pmLnBNkWPHRvwfYSD4BFwMkJgaSHYD/dAD9lFqxLneF
         bcZJ+t4Z7D98j10mkjFCvMr71WQD3RiHTJjYM/ud/i4cVdgHtLzg7tVN6WLqvHDUF1Gu
         0T2Q==
X-Gm-Message-State: ABy/qLZJ54xYh3LF6zZjKeUNtd1DQgjKM6YOZBZq35FDpHOlgkLEiQhn
        xUp3/ViaHmY3Wps2edytbmPODcPhhj3DrQffLgBWEQz4KVrmYI57b+FOtACPDWw4Xhl1azr4tyl
        6VMgTvPCcqCJnw+5ZM33xQrT3IS/eWPtlZzNz
X-Received: by 2002:a05:622a:1b9f:b0:400:a9a4:8517 with SMTP id bp31-20020a05622a1b9f00b00400a9a48517mr12402957qtb.4.1690216118770;
        Mon, 24 Jul 2023 09:28:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEYe2r1e44ymBAW9LBiJ+Iz0wbFf4q2jQ3Fp4Qsce6fbppjpC0MEicv/dPVwjkV1zWzRFj2Rg==
X-Received: by 2002:a05:622a:1b9f:b0:400:a9a4:8517 with SMTP id bp31-20020a05622a1b9f00b00400a9a48517mr12402937qtb.4.1690216118483;
        Mon, 24 Jul 2023 09:28:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id e6-20020ac84b46000000b004052f71f79bsm3409071qts.74.2023.07.24.09.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 09:28:38 -0700 (PDT)
Message-ID: <7b11a20a9ea302d1e719ce7e65b668ce2a3c8c63.camel@redhat.com>
Subject: Re: [RFC PATCH] selinux: introduce and use ad_init_net*() helpers
From:   Paolo Abeni <pabeni@redhat.com>
To:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-security-module@vger.kernel.org
Date:   Mon, 24 Jul 2023 18:28:35 +0200
In-Reply-To: <CAHC9VhTRkWL_R0xdnrYChwmbp3FvXKMjQYpdBn9OvCH23mW=bA@mail.gmail.com>
References: <73a810980a8452f0cb98d25698c4ae83285b7393.1689604030.git.pabeni@redhat.com>
         <679840421f2e7794bb69962b97e0cee1a4e0f0f6.camel@redhat.com>
         <CAHC9VhTRkWL_R0xdnrYChwmbp3FvXKMjQYpdBn9OvCH23mW=bA@mail.gmail.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

On Fri, 2023-07-21 at 12:11 -0400, Paul Moore wrote:
> There have been updated patchsets posted, but the original link
> (below) contains my comments:
> https://lore.kernel.org/linux-security-module/20230119231033.1307221-1-kp=
singh@kernel.org/

Thanks for the reference. Interestingly there are both similarities and
differences between my approach and the above. I'll try to study the
above a little bit more and then possibly I'll share what I have, just
for reference.

Cheers,

Paolo

