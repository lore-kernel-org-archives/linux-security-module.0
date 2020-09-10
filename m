Return-Path: <SRS0=OzCb=CT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60051C433E2
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Sep 2020 20:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0901321D7E
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Sep 2020 20:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/Nbbf4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgIJUr2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgIJU2U (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Sep 2020 16:28:20 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132A0C061756
        for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2020 13:28:03 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id q21so7719749edv.1
        for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2020 13:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dOtT3N7XbGpRxpxc8ChGzc7KDQ9tSEwlVL00HtmCks8=;
        b=C/Nbbf4T5rPk5brkoe050E2pcKCOvUasKnRCCFebyKdoxklwvBx0WXCmqjsDrbtpQV
         jR6WiarrGjbLiEQkOEZuNuB/YvertASUjGXTd4haT9x7o9clqXR3JKVcu0UMmGqYZUmU
         VAsc6ulw4hGipMG2uE+lsgPcKmNCYpytB/IHs6Oxg8HuAoZWBCKBvclBqizD+4L+LwfK
         nsSI43tbcdKmURrSC9zJfS5oLkDHyWRaABxsMPLIICw+pxAgpBCM5dVXdO+OuZg2E//b
         2h5kExRMIJy0tPvpHdEeBK6feABcxtN2G01klGZ6ScnLzyaR3hPS/Of9tc91a739PUWU
         5RXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dOtT3N7XbGpRxpxc8ChGzc7KDQ9tSEwlVL00HtmCks8=;
        b=p1+Aa5Ti2+d3H9NjkKvJ/BYXlwwLObkjdWdRqjh+RJmv17waxkfkqaDVY6yiHJr6QR
         RsFb6OLoh3D3pLdbfVfworfK8FtC6BGTT3xUY5i+sa3SE+WtGdU63h/gxkAIoTaz207k
         eXF8/HfCYsHgzkQe4ZNwqTNLTh3SZz5A9b+IdbFvNmQn8oWs4TUQWDE8pV7l3bCwMG2u
         JOVwDbR+Tyb+jsMeQDEr1GLBGUrIKChCMSrtUY+SLQ2kYZf6ASu/Hf7uHkIpERMNyl11
         IRqZQzS3xC8nw7Eqz/3s69wih6ks9HXM41egQfbjrXCxJ/cnXIFz3uk3d0VzI3mAZ7c2
         zkTA==
X-Gm-Message-State: AOAM533jPNN2+0/Ra7SzNlRbDXhgc715JBnQnZ+ce1eZZcFw8zQnu0pk
        wHZkKtEMaSIqlKKqkvLAUk+tFGkE0JL0uoYxGV2EMg==
X-Google-Smtp-Source: ABdhPJw5R/5Ez4aDdMGu21cR5k0AUCPks8j2VqSHJM0t1OaVkhoHiaB7U2J+4k9K0u43oPA3YLYttkRf9QTiPALFrsk=
X-Received: by 2002:a50:fe98:: with SMTP id d24mr11069998edt.223.1599769681295;
 Thu, 10 Sep 2020 13:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200910202107.3799376-1-keescook@chromium.org> <20200910202107.3799376-4-keescook@chromium.org>
In-Reply-To: <20200910202107.3799376-4-keescook@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 10 Sep 2020 22:27:35 +0200
Message-ID: <CAG48ez3om6tRSjZhq4RBtbRCZaupTPJewEYbtN9Q-NCUzDjkqA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/6] security/fbfam: Use the api to manage statistics
To:     Kees Cook <keescook@chromium.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        John Wood <john.wood@gmx.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 10, 2020 at 10:21 PM Kees Cook <keescook@chromium.org> wrote:
> Use the previous defined api to manage statistics calling it accordingly
> when a task forks, calls execve or exits.

You defined functions that return error codes in the previous patch,
but here you ignore the return values. That's a bad idea.

You should probably check the return value in execve() (and fail the
execution in the case where memory allocation fails), and make it so
that the other functions always succeed.
