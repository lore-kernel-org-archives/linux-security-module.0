Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A13EEB64DC
	for <linux-security-module@archiver.kernel.org>; Mon, 10 Jul 2023 08:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjGJIqd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 10 Jul 2023 04:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGJIqM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 Jul 2023 04:46:12 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBAE1994
        for <linux-security-module@vger.kernel.org>; Mon, 10 Jul 2023 01:45:33 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7472B3F8E5;
        Mon, 10 Jul 2023 08:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688978728;
        bh=KWNn3gy7DbypouC/ACi4hnkPscIyfzBSGcXDOHnMlNU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Dj99woeQfh80vIui9OzkyljVpn0cR7PgBl0fUFeYwGBs/TLkbfQ7U29uAoPAJlUts
         Hml35AgQljhI8xdTr8SwgDccWkeLMlyxKEYAOWnR63mM7YQQtQrYMQaKhj9FblW3bB
         gMY9hH6bOhtLoBM/mEmYc4zOvch+11w2U5Ax4gnuFVRQH4HsJRCxJTRxeo9GQiFvM6
         Eitf7waGCkRgPktNRMANO77c1H7QPoEQ12SbF9T/MEwYqS201XKCGWsHs0gnkugEeO
         tYPMjSyCeekQH7ioo1l/EHBUw+cozZcY8uFOaLhEo7+dx3U0Uih3BWg8i4okmvcw+E
         bWW8wlraYw/4Q==
Message-ID: <0a3930d7-32a6-13d1-b8a0-3dd9fdfa884d@canonical.com>
Date:   Mon, 10 Jul 2023 01:45:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -next 00/11] Fix kernel-doc warnings in apparmor
Content-Language: en-US
To:     Gaosheng Cui <cuigaosheng1@huawei.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
References: <20230625011349.1457810-1-cuigaosheng1@huawei.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230625011349.1457810-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 6/24/23 18:13, Gaosheng Cui wrote:
> Fix kernel-doc warnings in apparmor, thanks very much!
> 
I have pulled these into the private testing repo, at
https://gitlab.com/jjohansen/apparmor-kernel

if there aren't revisions to 5/11 andd 10/11 this week
I will add a patch ontop to do the suggested revision.
If you post new versions I will pull those in and rebase,
before pushing these up to the more public repos.


> Gaosheng Cui (11):
>    apparmor: Fix kernel-doc warnings in apparmor/audit.c
>    apparmor: Fix kernel-doc warnings in apparmor/capability.c
>    apparmor: Fix kernel-doc warnings in apparmor/domain.c
>    apparmor: Fix kernel-doc warnings in apparmor/file.c
>    apparmor: Fix kernel-doc warnings in apparmor/label.c
>    apparmor: Fix kernel-doc warnings in apparmor/lib.c
>    apparmor: Fix kernel-doc warnings in apparmor/match.c
>    apparmor: Fix kernel-doc warnings in apparmor/resource.c
>    apparmor: Fix kernel-doc warnings in apparmor/policy_unpack.c
>    apparmor: Fix kernel-doc warnings in apparmor/policy_compat.c
>    apparmor: Fix kernel-doc warnings in apparmor/policy.c
> 
>   security/apparmor/audit.c         |  1 +
>   security/apparmor/capability.c    |  4 ++--
>   security/apparmor/domain.c        | 10 ++++++----
>   security/apparmor/file.c          |  6 +++---
>   security/apparmor/label.c         | 20 +++++++++++---------
>   security/apparmor/lib.c           |  4 ++--
>   security/apparmor/match.c         |  4 ++--
>   security/apparmor/policy.c        | 17 ++++++++++-------
>   security/apparmor/policy_compat.c |  1 +
>   security/apparmor/policy_unpack.c |  2 +-
>   security/apparmor/resource.c      |  8 ++++----
>   11 files changed, 43 insertions(+), 34 deletions(-)
> 

