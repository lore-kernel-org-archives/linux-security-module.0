Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AD1C4167D
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Nov 2023 04:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjKMEHY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 12 Nov 2023 23:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbjKMEHX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 12 Nov 2023 23:07:23 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40091729
        for <linux-security-module@vger.kernel.org>; Sun, 12 Nov 2023 20:07:19 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9c66e70ebdso3891552276.2
        for <linux-security-module@vger.kernel.org>; Sun, 12 Nov 2023 20:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699848438; x=1700453238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlKWMNmqKqQg2CpijRIn4IqNVg9ZXn04XHUyH28+sa8=;
        b=IDGMlsziV7rWsLxkiK46yrCFC1440sNq9BwbrSxWUgsiAhOAWcsPAFvVGys3BBxPgG
         6gxgVxRS0F7WNv26g38T/D5/wA9kVruPW1/sbDm4EqsVmxIWmqF84r9ZRsbQiZmNWlq3
         ezyBGX05yMdCUXY/L8XFKVDBz4fPl87gjRlP5DC/JRdC6X+Eyc/hQQywRLmEqtXmn4tA
         Tg8f8wgSs77Gc3mEdY3R5tXdqYwRE2vXQeRqpWuWAiNKX6+AUBMg8ozKb7a3obCN+I4F
         8X5xCbmv/FRxf8oDmiYUbJuBO/tZEWnueS++0Oxp/GTvP5JftZegnoEHAcRXH3kDN/8Z
         yTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848439; x=1700453239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlKWMNmqKqQg2CpijRIn4IqNVg9ZXn04XHUyH28+sa8=;
        b=eQEyEaN3dU8kO2aT3ZJEOYY6V7pQpaNEZqhq6XybbRqbgFny10lmstGEzsqHjZmkVg
         1pIPqCRAd5UU2O7doCcihIwSGhmHLeTm15guXtnNbmi0lhC7qjjei+wV0LDR3DUI9pAZ
         Vn04PuMwlMCDaKSWj0fc2/+IA0yiD3W2bJ2q6B1YYPRQTaY74usE8jDm8wD9Dswu8YEI
         NUbuuFKh2h5fr0YDLeotokJKe8hSiHNKyGv/YpAgXL0241qjV7sDGc20n5yMYked3KlH
         +SA4jbLWS4jtNu+XrnQzXoV7ccYPYlvi61kw92HwnGs5b19w4AO+Cxu31HLT/2KpYeu0
         DOFA==
X-Gm-Message-State: AOJu0YwsA4kLre5LtzDN7j2ZlJhMPR5YZL0gD/vjcmeGkAdh56pUvaRm
        ijeUshKJDPT7Kz066Th0qbP3xWILtEX7TPbiEP0B8mublh+62TI=
X-Google-Smtp-Source: AGHT+IF/j7Tqaps4y/hdfO/N9xzGQuEXV+A/L8AG8eSFc+i50rEykkEU0t7lMJEsJJqSzOYeLS28XY298gXyDunhFbs=
X-Received: by 2002:a25:41d0:0:b0:da0:d0be:ef06 with SMTP id
 o199-20020a2541d0000000b00da0d0beef06mr4547717yba.51.1699848438676; Sun, 12
 Nov 2023 20:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20231024213525.361332-4-paul@paul-moore.com>
In-Reply-To: <20231024213525.361332-4-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 12 Nov 2023 23:07:08 -0500
Message-ID: <CAHC9VhT7DRUZO1RPDwXKXXJ-xsNL6pcMxEgLPsc7JTtBruzLBw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] LSM syscall tweaks
To:     linux-security-module@vger.kernel.org
Cc:     selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 24, 2023 at 5:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Three rather small LSM patches to address some minor issues found during
> the review of the latest LSM syscall patchset that now lives in the
> lsm/next-queue tree.
>
> I'm marking these as RFC patches as they have yet to be properly tested,
> but I'm building a kernel now to do that and I'll report back when testin=
g
> has completed.  In the meantime, reviews and ACKs are appreciated.

These have been merged into lsm/dev.

--=20
paul-moore.com
