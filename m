Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D12C64ED6
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Feb 2023 11:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjB0LDZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 27 Feb 2023 06:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjB0LCy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Feb 2023 06:02:54 -0500
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979AC20681
        for <linux-security-module@vger.kernel.org>; Mon, 27 Feb 2023 03:02:31 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PQHdd0gyxzMr7Fg;
        Mon, 27 Feb 2023 12:02:29 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PQHdY3jTlzMsSll;
        Mon, 27 Feb 2023 12:02:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1677495748;
        bh=bVIwqOcB8Feb2sYl8JSgdB3nHN1l5NdDbh7Wn239QBM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h0W2PJorapw4TwJv18FOzUG8Dd64rSrUwflL4kprPsYA3agwMRM/4rgVqmpKQrO1v
         10IboLfUn0BbE9X2R1R4MsUMD1a6L1xwQqobvuvskYi0lbExH722Z9zf3vpPhldWcG
         ZnGsYV3pEa/deNAZXzfKnVfuUowDpIr9Urdsof6k=
Message-ID: <796789c7-24bd-f1f1-c402-c88b46253008@digikod.net>
Date:   Mon, 27 Feb 2023 12:02:24 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v4] landlock: Clarify documentation for the
 LANDLOCK_ACCESS_FS_REFER right
Content-Language: en-US
To:     Alex Colomar <alx.manpages@gmail.com>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20230221165205.4231-1-gnoack3000@gmail.com>
 <f46d3b7f-71bf-7a5e-90b5-ab433f7253cd@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <f46d3b7f-71bf-7a5e-90b5-ab433f7253cd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 25/02/2023 00:00, Alex Colomar wrote:
> Hi Günther,
> 
> On 2/21/23 17:52, Günther Noack wrote:
> [...]
> 
> Sorry for taking so much time in looking into this!
> 
>> + *
>> + *   * The reparented file may not gain more access rights in the destination
>> + *     directory than it previously had in the source directory.  If this is
>> + *     attempted, the operation results in an ``EXDEV`` error.
>> + *
>> + *   * When linking or renaming, the ``LANDLOCK_ACCESS_FS_MAKE_*`` right for the
>> + *     respective file type must be granted for the destination directory.
>> + *     Otherwise, the operation results in an ``EACCES`` error.
>> + *
>> + *   * When renaming, the ``LANDLOCK_ACCESS_FS_REMOVE_*`` right for the
>> + *     respective file type must be granted for the source directory.  Otherwise,
>> + *     the operation results in an ``EACCES`` error.
>> + *
>> + *   If multiple requirements are not met, the ``EACCES`` error code takes
>> + *   precedence over ``EXDEV``.
> 
> Is this something worth guaranteeing, or just an implementation detail
> that may easily change?

There is a deliberate effort to keep this error priority to be able to 
know if a rename or link action can be replaced with a file copy, which 
is useful e.g., for `mv`.
