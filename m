Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322B4C678D5
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Mar 2023 18:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjCHSho (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Mar 2023 13:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCHShn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Mar 2023 13:37:43 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B0DC88BA
        for <linux-security-module@vger.kernel.org>; Wed,  8 Mar 2023 10:37:42 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y11so18586776plg.1
        for <linux-security-module@vger.kernel.org>; Wed, 08 Mar 2023 10:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678300661;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICalJ8m3c7Hb1HCCFvkchlVxA8iUX7cOCXs7eLBJcv0=;
        b=QJx8dCIYfsjqA5UQEUewp/ZTUlt1ZEMhKApHkHCvfDOmMK19iPKpiBf0ZUI7H7z6fD
         N1KIe/kmq+qu8tZ+WesO6wPU/V4Q1X+ccmLgN8mR4OWqYsv7Ow4FZwNlFLXzDEKpuEin
         bhngC0IJnaLimLX92LQkMinq5X6xPA3eNF6kbqFkNbjLyD9FQjWI+rRCXRZyDrjTBhqH
         pUUgHzkqHG0M/IizYhml4oakBGIYU0PDsudbEe0EWTQmPvAyG73rd4mBeGpT19o/I6gE
         lkjwHaouyfYOYCsama3pHe3FCUsNzSnno1L2VvvqKJnWanuvLKdTogHkrk/USQ7wa7Bn
         DDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678300661;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICalJ8m3c7Hb1HCCFvkchlVxA8iUX7cOCXs7eLBJcv0=;
        b=utdU7hs3iXLHZXsEMe1Gf9JkJgsI01aTNRh090Q9kASDhOPPstNP6VO/9KDPvatcK4
         A6CsFvmAmXUPUfFuQy85Pzkgu4353KVTlmbRJZAISTjkwGeo0ihcRbZ3XlEpaaGYYqWb
         Up42Iprr0MjblZwFBnphysdsVWFn7wVfhALEXzkeQz4jYyaxSItLNS7Lod8YffkSPV0g
         UV6OBJ2jjUhySGURSoRWdpEWcRvYbHmhc1zxU0JqJAbqWm3mZlbp2YGfQ4MfwGj9sqzn
         LzXkZE03hUBKBYLZlHiGcA6HDJxl6DLbI6rWdET3ACDDCnhUT3A4D10U0UB0XDFIgXjQ
         EfAA==
X-Gm-Message-State: AO0yUKXcpO8uM7UNtrRWP2lM6FkBhFAqzMYXvnD3CII+486P74nmGjjR
        x/PT7bRFAsDxHgcJ7HEjmWwyf2PQxIxDu0bAuPPMt7g3r68nQw0=
X-Google-Smtp-Source: AK7set9+h+Qb6LQBl/MJ/3FJcozXm+0z9uBuR/eArtkp5ZY5mWw+wofR+1YS32fbxWIssT4zQzxjXeTK2JDMAaHpq2g=
X-Received: by 2002:a17:902:ed82:b0:19a:e3d4:216e with SMTP id
 e2-20020a170902ed8200b0019ae3d4216emr7219263plj.7.1678300661153; Wed, 08 Mar
 2023 10:37:41 -0800 (PST)
MIME-Version: 1.0
References: <20230308183139.201496-1-paul@paul-moore.com>
In-Reply-To: <20230308183139.201496-1-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Mar 2023 13:37:30 -0500
Message-ID: <CAHC9VhSc8Ski4i2tqZQLxsDZKQm_-qVbuoT9nYKcbsSE3s4J9w@mail.gmail.com>
Subject: Re: [PATCH] lsm: fix a badly named parameter in security_get_getsecurity()
To:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 8, 2023 at 1:31=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> There is no good reason for why the "_buffer" parameter needs an
> underscore, get rid of it.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/lsm_hook_defs.h |  2 +-
>  security/security.c           | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)

Similar to the other patch, I've just merged this into lsm/next.

--=20
paul-moore.com
