Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71ABC7EE23
	for <linux-security-module@archiver.kernel.org>; Tue, 30 May 2023 18:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjE3SEA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 30 May 2023 14:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjE3SDt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 May 2023 14:03:49 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C14189
        for <linux-security-module@vger.kernel.org>; Tue, 30 May 2023 11:03:46 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-5556e2bddf9so2400530eaf.1
        for <linux-security-module@vger.kernel.org>; Tue, 30 May 2023 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685469826; x=1688061826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ATVoLozR2BePms8bg22SnJC3NdlK/27RxjAnUqa0huQ=;
        b=T21v+Kc++CJ0iWH1lmCIK4UrxKXvi2gXbYoCp8Abx1NOE95lsJJ09URJhaTCkJv8oB
         srMOos94M6CG5KiW/mMzmjFEM44IoUU+Ff/tD22FNe4N21IyvSJJ4P9i1AiPchlpEelr
         aT1SSWIyfX7wV1XgE3VWcXOufwObcIbepHXIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685469826; x=1688061826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATVoLozR2BePms8bg22SnJC3NdlK/27RxjAnUqa0huQ=;
        b=Pwr+sOpSnuw0BlLcuJzxIAygFnI26zHdMaXQ1gITSN38Wrta/8m0yH3AoREVp7UgpQ
         pZCT1IsDoeSjm5kWPmd6zdYTJZGKlgQp2wXaSkdrwdOz/5yjtRFIQg+IZ3Vt9jBaRGXe
         ftXUgvZuuvX5cWUfuxKcsS2BSq4VgfIOEItr1/vXmd9vF5aPMkk6BBHgL7++9QxZ86eL
         I7Ks7c5mYLJCVWEP28SBSX1YuIWAOWew39fgXAuSw349AOZJzKqsIn2rgCduaCEE3/cs
         dbY3CRokK662cq4b/0jMpLKrdqlBa68zs8waur8FC4MA/OPiePpcFQm6S7FudSlrZ2XR
         qBBw==
X-Gm-Message-State: AC+VfDxcGQr1PEubtEWK6RxXjUTrySkxtIjw6cCSdAEf3IHfwI2pEZQu
        jkEE4CO3AL4/uN75WlkpERiVwuKbx3r7TYNDaRwbxw==
X-Google-Smtp-Source: ACHHUZ62iGx50VsUN76nFo7zEv3lAIi9jLbeY2S3k3Q9ix0Zq5izs3M/cJ6HniZbls7TJQJ3SWqBoTzQ43pPK3QqTvY=
X-Received: by 2002:a4a:4913:0:b0:555:8c22:a169 with SMTP id
 z19-20020a4a4913000000b005558c22a169mr1389099ooa.9.1685469825802; Tue, 30 May
 2023 11:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <20230518204549.3139044-1-enlightened@chromium.org> <a42875a0-d4c5-e2ac-d115-d4222e229f7d@schaufler-ca.com>
 <CAHC9VhTq0RgQ6xj86_BkZuAwy4kGy6eC8NVKFroEASNXP3uBxQ@mail.gmail.com>
 <CABi2SkX0cqOMPeuw8CD28Q6UZihi0Hh7GT=dTmxaG-T_rayPfQ@mail.gmail.com> <7b8688f5-20bc-8130-2341-ff56bb365d5a@schaufler-ca.com>
In-Reply-To: <7b8688f5-20bc-8130-2341-ff56bb365d5a@schaufler-ca.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Tue, 30 May 2023 11:02:00 -0700
Message-ID: <CABi2SkUEUrwZ_HAVqX651iOQfXN6=Sdv4C=ihso5CSohXeo5uA@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Shervin Oloumi <enlightened@chromium.org>, mic@digikod.net,
        linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, allenwebb@chromium.org,
        gnoack3000@gmail.com, areber@redhat.com, criu@openvz.org,
        linux-api@vger.kernel.org, jannh@google.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> >>
> >> As I believe we are in the latter stages of review for the syscall
> >> API, perhaps you could take a look and ensure that the current
> >> proposed API works for what you are envisioning with Landlock?
> >>
> > Which review/patch to look for the proposed API ?
>
> https://lore.kernel.org/lkml/20230428203417.159874-3-casey@schaufler-ca.com/T/
>
>
How easy is it to add a customized LSM with new APIs?
I'm asking because there are some hard-coded constant/macro, i.e.

+#define LSM_ID_LANDLOCK 111
(Do IDs need to be sequential ?)

+ define LSM_CONFIG_COUNT

Today, only security/Kconfig change is needed to add a new LSM, I think ?
