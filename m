Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386B9C54EAA
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Jan 2023 18:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjA0SAY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 27 Jan 2023 13:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjA0SAX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 27 Jan 2023 13:00:23 -0500
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E507D2BA
        for <linux-security-module@vger.kernel.org>; Fri, 27 Jan 2023 10:00:21 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4P3QN22ZTCzMqVVl;
        Fri, 27 Jan 2023 19:00:18 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4P3QN14hwRzMqYBj;
        Fri, 27 Jan 2023 19:00:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1674842418;
        bh=qhBk6jvZ7Mk85VgcLoOIsmt0TVT6kp9bqPtO5rSqj7k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pVsM8Xfjm1mAxXDbhBGxTZO2aqsBlK3fimy/IeWcPYXDZRBOP2gPVRlcT67IECq6q
         jz1WPXpD9y4Ui2D/XJYa5XqtpYsZMfG7mbH1t+GTp0seyn9UA+ypWHRK+LEyu0/EU+
         pSY5lr4IiWCy34KoUWXutnIM/k++g+dynCm+CW/8=
Message-ID: <bf4f1810-86a3-0b3d-2cb6-3431861d03c9@digikod.net>
Date:   Fri, 27 Jan 2023 19:00:16 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v6 0/1] selftests/landlock: fix ptrace_test
Content-Language: en-US
To:     jeffxu@chromium.org
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
References: <20230114020306.1407195-1-jeffxu@google.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230114020306.1407195-1-jeffxu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thanks, it will soon be in -next: 
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next

On 14/01/2023 03:03, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> Landlock ptrace failed because YAMA is enabled.
> This patch check YAMA value and skip related tests.
> 
> V6:
> - Squash change from Mickaël Salaün
> - Link: https://lore.kernel.org/r/20230113175308.50900-1-mic@digikod.net
> - Add can_read_child and can_read_parent
> - Remove SKIP(), add log for incomplete test.
> 
> V5:
> - https://lore.kernel.org/all/20230113050755.1277736-1-jeffxu@google.com/
> - address comments from groeck@google.com
> 
> V4:
> - https://lore.kernel.org/all/20230103190314.3882177-1-jeffxu@google.com
> - apply can_trace_parent and can_trace_child to smaller scope.
> 
> V3:
> https://lore.kernel.org/all/20221227140244.1041292-1-jeffxu@google.com
> - add can_trace_parent and can_trace_child to handle yama value.
> 
> V2:
> https://lore.kernel.org/all/20221213185816.3942853-1-jeffxu@chromium.org
> - update from code review comments.
> 
> V1:
> https://lore.kernel.org/all/20221213185816.3942853-1-jeffxu@chromium.org
> - skip specific testcase according to YAMA value
> 
> V0:
> https://lore.kernel.org/r/20220628222941.2642917-1-jeffxu@google.com
> - skip entire ptrace when YAMA is not 0.
> 
> Jeff Xu (1):
>    selftests/landlock: skip ptrace_test according to YAMA
> 
>   .../testing/selftests/landlock/ptrace_test.c  | 112 +++++++++++++++---
>   1 file changed, 94 insertions(+), 18 deletions(-)
> 
> 
> base-commit: 963a70bee5880640d0fd83ed29dc1e7ec0d2bd4a
