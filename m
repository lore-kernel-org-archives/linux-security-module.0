Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BABC433EF
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Jul 2022 14:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbiGGOZh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 Jul 2022 10:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbiGGOZg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Jul 2022 10:25:36 -0400
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF3C27CEC
        for <linux-security-module@vger.kernel.org>; Thu,  7 Jul 2022 07:25:35 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LdzGN4H0RzMqMX6;
        Thu,  7 Jul 2022 16:25:32 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4LdzGN0Hn9zlnbvx;
        Thu,  7 Jul 2022 16:25:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1657203932;
        bh=cjTJFkoujo/aEd3Ux35TX3Nv0MpybSO4ti/cKp496Hw=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=VOmuMTJIiK5ctMd08TCgQXyaySkahnDUDrQQYLjjwCIDOYyUBnAFvKEiMdUyhh5lV
         2Ry2Xb7X44EH49fl9qzdQDLoGlYUoaWz8y11utYbVbeuLH3Bc8e+GUQKkTaYihpFKR
         Fr4fIZ9lFPu99/1PHNS2wjL3Qzi8OBtz2nPqj6pA=
Message-ID: <0abdd920-b5cc-2fa9-7494-104c9c67480d@digikod.net>
Date:   Thu, 7 Jul 2022 16:25:31 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Jeff Xu <jeffxu@google.com>
Cc:     linux-security-module@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>
References: <20220628222941.2642917-1-jeffxu@google.com>
 <06847585-8712-5f0c-b7e4-e32745576e16@digikod.net>
 <CALmYWFtn97HpsTK02Sn7riD7yJ3zdbGob+Yz8PHa_Yx0tgfchQ@mail.gmail.com>
 <CALmYWFvcSn_wks0bXo3_DUyYGtVW_MHrrO1dRoYcxY4uiB1KEA@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH] selftests/landlock: skip ptrace_test when YAMA is enabled
In-Reply-To: <CALmYWFvcSn_wks0bXo3_DUyYGtVW_MHrrO1dRoYcxY4uiB1KEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 07/07/2022 01:35, Jeff Xu wrote:
> a correction:
> 
>     =====================================
>     case 0 - classic ptrace permissions: a process can PTRACE_ATTACH to
>     any other
>          process running under the same uid, as long as it is dumpable (i.e.
>          did not transition uids, start privileged, or have called
>          prctl(PR_SET_DUMPABLE...) already). Similarly, PTRACE_TRACEME is
>          unchanged.
> 
>     Test: All passing
> 
> // Base_test: 7/7 pass.
> // Fs_test 46/48 pass
> //.   not ok 47 layout2_overlay.no_restriction
> //.   not ok 48 layout2_overlay.same_content_different_file
> //  Ptrace 8/8 pass

Hmm, well, it is not related to Yama then. Could it be linked to other 
Chromium OS non-upstream patches?
