Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965FEC433DB
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Jan 2021 20:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4A864DE7
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Jan 2021 20:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhA1UjZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Jan 2021 15:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhA1UjY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Jan 2021 15:39:24 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B66CC06178A
        for <linux-security-module@vger.kernel.org>; Thu, 28 Jan 2021 12:38:12 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id n18so3710526vsa.12
        for <linux-security-module@vger.kernel.org>; Thu, 28 Jan 2021 12:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8KPgt9hBeVcEo5Nho0Ik1gkLx7dER9AD9O3f4dkEfDM=;
        b=LCM7oE/eDXhBiFGmQ+Q7GUkb33VZwMTOs6c+QMmmtTshjoGqrJch7qKjp3VgVrjLGo
         0DGsKGDL+zECFRWW9m76RiQ+77fnJjO9wvDhlugmouvNCUj/jpz0PzDOHDUnQJYgTNsN
         8fMlfmaw0EuBzGRkL6Ta+ZNUJKnBJBofqcJyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KPgt9hBeVcEo5Nho0Ik1gkLx7dER9AD9O3f4dkEfDM=;
        b=rm0nwxADH1YFNUXirc+liTFk6NLr8+MIt9sK0vPLyBTwglHN8iLvxPy2+EA9pOsiiF
         qXN43xxVefyFeD61ip5DIH2lMjWwZBtXWx3epz+93zom/iQdGNwJ1jNOiiNVSkOIgNpT
         HKyMqaOf0+e5uWU5fhxrSALnyX1l6ZNb5X8xPizGqtVATKl4ffnLGBe9W4dXViia2Hcj
         P5PM2euVJk+lU20tygxWap2gM92RYQ7BWLpV/bZ+dhtLcObGaHugsYxKfhlVJ2Ch3txZ
         AE6NRu/h55rYiAcFAhF49uFn8BioAokXqmNklZTWhn8nlVJabO3RS/S3yWeXjj6JAXw7
         rLdA==
X-Gm-Message-State: AOAM531L7dhDG4oNIIA7ZYDq2gBYt+Y6dmzElHTRkotah1AvTw6FHgRv
        xUtCosXpcau4OFX134zFHDx5f+M8y4392/MMbUwbfA==
X-Google-Smtp-Source: ABdhPJzX/gZhVjy5xbZXs4+sI7wH7G5vQ7HSsfArwt+AUTKX6c8cJkmXmX6BOemJlLH0uq/Hd1IX4Q3wYAZvMD4Uwqo=
X-Received: by 2002:a67:c992:: with SMTP id y18mr896831vsk.7.1611866291533;
 Thu, 28 Jan 2021 12:38:11 -0800 (PST)
MIME-Version: 1.0
References: <20210119162204.2081137-1-mszeredi@redhat.com> <20210119162204.2081137-3-mszeredi@redhat.com>
 <8735yw8k7a.fsf@x220.int.ebiederm.org> <20210128165852.GA20974@mail.hallyn.com>
 <87o8h8x1a6.fsf@x220.int.ebiederm.org>
In-Reply-To: <87o8h8x1a6.fsf@x220.int.ebiederm.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 28 Jan 2021 21:38:00 +0100
Message-ID: <CAJfpegv8e5+xn2X8-QrNnu0QJbe=CoK-DWNOdTV9EdrHrJvtEg@mail.gmail.com>
Subject: Re: [PATCH 2/2] security.capability: fix conversions on getxattr
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jan 28, 2021 at 9:24 PM Eric W. Biederman <ebiederm@xmission.com> wrote:

> <aside>
> From our previous discussions I would also argue it would be good
> if there was a bypass that skipped all conversions if the reader
> and the filesystem are in the same user namespace.
> </aside>

That's however just an optimization (AFAICS) that only makes sense if
it helps a read world workload.   I'm not convinced that that's the
case.

Thanks,
Miklos
