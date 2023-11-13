Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6731C4332F
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Nov 2023 04:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjKMEKD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 12 Nov 2023 23:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbjKMEKC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 12 Nov 2023 23:10:02 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C87A111
        for <linux-security-module@vger.kernel.org>; Sun, 12 Nov 2023 20:09:59 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d865854ef96so4065751276.2
        for <linux-security-module@vger.kernel.org>; Sun, 12 Nov 2023 20:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699848598; x=1700453398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B80U9iNVhyxwgMMrWvpx28iEriO9T/gz7cTFZ1nECsc=;
        b=ajhoLxcW4U+RZCvurwtzX3Mph89hWzwG/8as6Ra/afBt/AqTAo0X2V9UvwF12gaKm7
         Chnmo6wxHsOqJXTF4FqxeyB4yM1+U2MPQ3z20BX4m1FGvv1g1wstCjPAUX/vVfSjuN/u
         IdRDIJzJSpvQu9u4IgZe2HLiYleoi+Ujh6TQKBI5/boQ1eDUDxyY9PNzi3gv24++q7g1
         VIEHdyCqFSN+wElDz9G9QIZPOMP7jhQIhdX5Pv0ZPPfHyYD/jt1jwigjRtYmzPIIas0r
         Gkr1+IpJmsvNBLIhbgKQL6G1w3bVov3e50jt5r39+4+2JzKP1+2lrorlOtVhAbr2yByv
         NFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848598; x=1700453398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B80U9iNVhyxwgMMrWvpx28iEriO9T/gz7cTFZ1nECsc=;
        b=lo9gd2Bw6tpvE0tQ5NgVVqoPN14rSe3snuFzMoXJ2Jpjo7gf0EbWB2Djc5MOQMyQ+o
         L9Kxhj7XwT59UygIDQfa3d3wL87cP77GJuAuG7KCTrGu+Rhzb0/bzLzjAbrrvYPmOWux
         71fGmB7YLfInVYcLWxICmBHA8mS4u9gKoYYXKSL0l44jdHzNxgfM87Jj5divhQNYIWn0
         4w2kb0FZj0KM5KxsZDZIHCdBLX9PJjdj9jqKcH0/d/S1tD+gGWIuBwijKrSUPBgaqkIG
         W3IREFGZnqz+pKBDaqr27KBZq4areyTz6pyPiGMSWFoXYtAcvKzbk5kXGJT066emD/qv
         SvZw==
X-Gm-Message-State: AOJu0YzEM8tlAWnNAVqqZxwG0f28C7LGjWa+qu9faAUD+AoEdtrRCwZZ
        neYRpVjVx3ocC+30NIgDx05RuMD6xGRIpikkN7s3jTeUOhVqrTc=
X-Google-Smtp-Source: AGHT+IEJhkSH0xOMnqC0iuH3W8T41HiweGsWJeqiJt4O3m/Kus8um4K8NIWQHySUv8NkArJggFfc1mAAy6yf6CFDsyE=
X-Received: by 2002:a25:30d4:0:b0:da0:3938:7ac6 with SMTP id
 w203-20020a2530d4000000b00da039387ac6mr5364860ybw.15.1699848598330; Sun, 12
 Nov 2023 20:09:58 -0800 (PST)
MIME-Version: 1.0
References: <20231110173427.79275-2-paul@paul-moore.com> <b32a3279-5c2f-4ddb-b400-09681276cf1d@schaufler-ca.com>
 <CAHC9VhSdC-=vDK8ezhMe=ymL4vjNB1NPxi2pCAG5Uo1P0Z5fjA@mail.gmail.com>
In-Reply-To: <CAHC9VhSdC-=vDK8ezhMe=ymL4vjNB1NPxi2pCAG5Uo1P0Z5fjA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 12 Nov 2023 23:09:47 -0500
Message-ID: <CAHC9VhRqVyJRaiUseJjFUYP_UFn_S+rDHNNNzcv2VbO0=9SJ4g@mail.gmail.com>
Subject: Re: [PATCH] lsm: mark the lsm_id variables are marked as static
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Nov 10, 2023 at 4:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Nov 10, 2023 at 3:23=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> >
> > On 11/10/2023 9:34 AM, Paul Moore wrote:
> > > As the kernel test robot helpfully reminded us, all of the lsm_id
> > > instances defined inside the various LSMs should be marked as static.
> > > The one exception is Landlock which uses its lsm_id variable across
> > > multiple source files with an extern declaration in a header file.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Suggested-by: Casey Schaufler <casey@schaufler-ca.com>
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
>
> Thanks Casey, I've gone ahead and merge this into lsm/dev-staging.

Merged into lsm/dev.

--=20
paul-moore.com
