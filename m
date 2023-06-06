Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA21C7EE24
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Jun 2023 16:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjFFQpP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 6 Jun 2023 12:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237770AbjFFQpO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 6 Jun 2023 12:45:14 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78E310EB
        for <linux-security-module@vger.kernel.org>; Tue,  6 Jun 2023 09:45:12 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bad05c6b389so7858340276.2
        for <linux-security-module@vger.kernel.org>; Tue, 06 Jun 2023 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686069911; x=1688661911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMWbmsvDdp6iq9RUXlYKvqFegC2cKlPpAbpd2+OqowY=;
        b=FQYrfd1EcvWG1GCeVG656zyHDTlShdaieYYpKe+/l6Aehh+n2AmLUOgF+Ll7MImYrl
         MZsCpyPiDggrosRsFYQhILfblG8mhk1AoQ+40asFh8gKRJRBkW029anExzI8+pvj4eLG
         b6+qTvmoVlzOoZJxkOZCMr4TqcFletykuad6UZVkMDBqcfseyHcgRX8wIX7T+iArP7uV
         AjwZqCgLhXACwFlDtDus48C7/qe5s5BKE4xsJKdBjL2KTQNxkOM1itGhULn1XmfFBeLL
         pgQRSZuLHw2eqd+MKG5gMyRP1mtNxHj2ykjp6cpt0f++zCLa0JcEjNZDSuyWCs7xfvYj
         H2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686069911; x=1688661911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMWbmsvDdp6iq9RUXlYKvqFegC2cKlPpAbpd2+OqowY=;
        b=cL2FnBnQPinuTHV2vYopCgSbngoa+ua9M99UH6/e1Yzkec+Ye0dcy0kpZ8QUYHCr6N
         k83et9jQrHjg57pBGNyPaZWc6uzAUk7UT+R4hsf4o4VM8Jk+E5ryF1p6kHCW/lHnfBwk
         fp2AqZdiiJg3SQYLDh+Kt1h3etmeTejRMTpwF2kPs8nU4gdhhIERK7pHVoNfR7R4Vxqn
         E6Cd3I5EkuCadpoNpSc4wwzIbjcWLspc+Lr9O2eh9yGMfbzYag+siXEVaz/JsPm9rtEV
         d2geGQEjo8sNv185EmDQ9sUqaTt3B/dCqIGpbOiD3yPzgJviVjiSULzyvVfz5k1kLJDx
         jlSA==
X-Gm-Message-State: AC+VfDzg00aCpsm0YTXEvvDe+l156qyhd3ZHZTgYtjWrybyPHON2d8c4
        DaX9CC06+Ox8j+poRLmKSPCZhTBY7Eog8Idi0ugl
X-Google-Smtp-Source: ACHHUZ4L5Xl6f7wlNvBLaoqH7P/WZmYFqZv0qJvx8f5RIJaiTp3gZOgpRiPaCaNFH1JigQ8aUHcxAOvAg8rkJlB0azI=
X-Received: by 2002:a81:6a87:0:b0:568:fe3a:46b3 with SMTP id
 f129-20020a816a87000000b00568fe3a46b3mr2984174ywc.28.1686069911506; Tue, 06
 Jun 2023 09:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230602054527.290696-1-gongruiqi@huaweicloud.com> <20230606032844.GA628899@mail.hallyn.com>
In-Reply-To: <20230606032844.GA628899@mail.hallyn.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 6 Jun 2023 12:45:00 -0400
Message-ID: <CAHC9VhT8k87SdD4_JQFwXShwJeBb3KU7C+R5ABAOhDGvvC0X+w@mail.gmail.com>
Subject: Re: [PATCH] capability: erase checker warnings about struct __user_cap_data_struct
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 5, 2023 at 11:29=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
> On Fri, Jun 02, 2023 at 01:45:27PM +0800, GONG, Ruiqi wrote:
> > Currently Sparse warns the following when compiling kernel/capability.c=
:
> >
> > kernel/capability.c:191:35: warning: incorrect type in argument 2 (diff=
erent address spaces)
> > kernel/capability.c:191:35:    expected void const *from
> > kernel/capability.c:191:35:    got struct __user_cap_data_struct [noder=
ef] __user *
> > kernel/capability.c:168:14: warning: dereference of noderef expression
> > ...... (multiple noderef warnings on different locations)
> > kernel/capability.c:244:29: warning: incorrect type in argument 1 (diff=
erent address spaces)
> > kernel/capability.c:244:29:    expected void *to
> > kernel/capability.c:244:29:    got struct __user_cap_data_struct [noder=
ef] __user ( * )[2]
> > kernel/capability.c:247:42: warning: dereference of noderef expression
> > ...... (multiple noderef warnings on different locations)
> >
> > It seems that defining `struct __user_cap_data_struct` together with
> > `cap_user_data_t` make Sparse believe that the struct is `noderef` as
> > well. Separate their definitions to clarify their respective attributes=
.
> >
> > Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
>
> Seems ok.
>
> There's still so much noise in the make C=3D2 output even just for
> kernel/capability.c that I'm not sure it's worth it, but no
> objection.
>
> Acked-by: Serge Hallyn <serge@hallyn.com>

I'm guessing you would prefer if I pulled this via the LSM tree Serge?

FWIW, if that is ever the case for future patches, just add a note
when you ACK something and I'll pick it up.

--=20
paul-moore.com
