Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22599C48BCD
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Jun 2021 02:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B4C6101A
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Jun 2021 02:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbhFICru (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Jun 2021 22:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhFICrt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Jun 2021 22:47:49 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE68BC061574
        for <linux-security-module@vger.kernel.org>; Tue,  8 Jun 2021 19:45:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id he7so16501351ejc.13
        for <linux-security-module@vger.kernel.org>; Tue, 08 Jun 2021 19:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dMJAIATDxck3lPc2v/vOyqYIyHEjWVevdw28uBnRll8=;
        b=vJCu8FkaI6OA/S5WUg8dM66mAya65Fay5hA/eiMY3Lre1NFLuBR0GAu7PbHt8SbNuJ
         3YxhvjAdYnFhw3cd6RDn4UKhXeuZzOKQfLKns9hAAtwpeDi3dt518h/j2QA7MZh7MYCi
         vwgUF+67Jw+sjHIq0nD6k7r7cSn48p3v2T3HFi/z6QgtAUEyMPZtkav5Wy80oAsGLE2O
         PqFJsyaViE7igCLWDnI6QZn7CKnYPtKIF0UpZAGwaHYcuD7wWL6x/HpU0U7WGvfkeOsL
         OJftkhEHQH1/uRA5GDUWCh9MO6LuUVLaWWbhUiCd702ZrvrmQYQuxElBUN2sztqmw+RA
         3+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dMJAIATDxck3lPc2v/vOyqYIyHEjWVevdw28uBnRll8=;
        b=pypiCEYCTXotJYYLhLf9IAzY1ox2ypcU5zrUCSMwicysZeelX0ortc4ufkFv6YI4rf
         SeotYW9aRRlgP6pNNaJgiWqYM0ScNtipLdzEvitkMZX/yEDingblHpjglP/AsrkLF71y
         DeSa+55ypwjz9n63nZcxNAmOaqOlxqjw9GsInXppd+kwjO/hfWnQcYpFUVIOviXfpcnl
         FGEXgJJ8fylSgmtwmfxeW4y9qCuBjgK07EiNBAzm22q1WsENPDDRo6VhOs4iqazGKNJk
         mqEGq88uQPkJmj7uX6B1k+V72Mi5UMvWfc2MVZshorHSOJKZpGVReW/29qK7V3ToM3qb
         D3qQ==
X-Gm-Message-State: AOAM530m7KkPyhGL6QINoK54zDKkOK/2MWfamhS/fcE7n8VDBpo4thWr
        2BHYZYQguJCGRCiWHF7GEaqaiDM3h89qzk/34POU
X-Google-Smtp-Source: ABdhPJzL9fIDlYNo3jdwZcRjedeaqhqbGqBRlphCAKBf6dCq1NoGxNou4DjDXOr7lSmB1qXBkGhxlEz2kFZPkYJnhXQ=
X-Received: by 2002:a17:906:4111:: with SMTP id j17mr25998733ejk.488.1623206738453;
 Tue, 08 Jun 2021 19:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTr_hw_RBPf5yGD16j-qV2tbjjPJkimMNNQZBHtrJDbuQ@mail.gmail.com>
 <3a2903574a4d03f73230047866112b2dad9b4a9e.1622467740.git.rgb@redhat.com>
 <CAHC9VhRa9dvCfPf5WHKYofrvQrGff7Lh+H4HMAhi_z3nK_rtoA@mail.gmail.com> <20210608125504.GA2268484@madcap2.tricolour.ca>
In-Reply-To: <20210608125504.GA2268484@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 8 Jun 2021 22:45:27 -0400
Message-ID: <CAHC9VhQg5WBF72UUyb32s9zB+9G41=DfdouPnudY+vL1g9bAjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] audit: add filtering for io_uring records, addendum
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 8, 2021 at 8:55 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> I should have been more explicit.  The intent was to have the fixes
> incorporated directly into your patches since they aren't committed in
> any public tree yet, exactly for bisect reasons ...

No worries, thanks for the clarification Richard.  I just wanted to
make sure since the contribution format was a bit unusual given the
context :)

Regardless, thanks again for the feedback, I'll get this incorporated.

-- 
paul moore
www.paul-moore.com
