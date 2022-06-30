Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B96FC433EF
	for <linux-security-module@archiver.kernel.org>; Thu, 30 Jun 2022 15:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbiF3PbJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 30 Jun 2022 11:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiF3PbI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 30 Jun 2022 11:31:08 -0400
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D1238BEE
        for <linux-security-module@vger.kernel.org>; Thu, 30 Jun 2022 08:31:07 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LYj3G1053zMpxd2;
        Thu, 30 Jun 2022 17:31:06 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4LYj3F5PZGzlrKcG;
        Thu, 30 Jun 2022 17:31:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1656603066;
        bh=6u+J//rgDneFpK3bA03Y6/+nQga6gHdwDFsS2evlKJU=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=qVgL2oozlTQzP4SF7IfIYbtzIa53/Sei+JvMn3lczgQ229O4MzLakHOOTtGl/ChL5
         QL2tXRYA/QDYvK3h3XAPci/Q/geMA4q5/OBw9h6htguCwueicpVYJxpXtBhroziLUr
         HaK+iQEPpCePYp2YV1dSsZigwE4VQFbYDKDxfhZk=
Message-ID: <06847585-8712-5f0c-b7e4-e32745576e16@digikod.net>
Date:   Thu, 30 Jun 2022 17:31:05 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Jeff Xu <jeffxu@google.com>
Cc:     linux-security-module@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>
References: <20220628222941.2642917-1-jeffxu@google.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH] selftests/landlock: skip ptrace_test when YAMA is enabled
In-Reply-To: <20220628222941.2642917-1-jeffxu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 29/06/2022 00:29, Jeff Xu wrote:
> ptrace_test assumes YAMA is disabled, skip it if YAMA is enabled.
> 
> Cc: Jorge Lucangeli Obes <jorgelo@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Mickaël Salaün <mic@digikod.net>
> Tested-by: Jeff Xu <jeffxu@google.com>

I guess we assume that Signed-off-by implies Tested-by, so you can 
remove this Tested-by.

> Signed-off-by: Jeff Xu <jeffxu@google.com>
> Change-Id: I623742ca9f20ec706a38c92f6c0bab755f73578f

Please remove this Change-Id too.
