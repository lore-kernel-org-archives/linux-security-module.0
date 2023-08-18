Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DDEC71148
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Aug 2023 13:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350580AbjHRNjy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 18 Aug 2023 09:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377211AbjHRNj2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 18 Aug 2023 09:39:28 -0400
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B28430F5
        for <linux-security-module@vger.kernel.org>; Fri, 18 Aug 2023 06:39:26 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RS2zJ5fxXzMq65p;
        Fri, 18 Aug 2023 13:39:24 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RS2zJ1F9Vz3W;
        Fri, 18 Aug 2023 15:39:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1692365964;
        bh=UWIxdFLVfrHT7rkE+syTuIU+IUhfKVPgorQTBQrhIlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S3fSl59xevy+7I4RkWjXq7KYI+4RATl/xWaB8PHzYgzsa0n49BngWU0UdU2aVY6tg
         VTt1Ne5gyQridX8p5evxsy/ReKN1mXrMt5zT93jBb1/zyomzuYN4m1hkt3gJ5PzIfR
         EEyBHVb+AnR/ORZ7hC65ho7Q1nsH8FvSxNbKsBg8=
Date:   Fri, 18 Aug 2023 15:39:19 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc:     linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Landlock: IOCTL support
Message-ID: <20230818.iechoCh0eew0@digikod.net>
References: <20230814172816.3907299-1-gnoack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230814172816.3907299-1-gnoack@google.com>
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 14, 2023 at 07:28:11PM +0200, Günther Noack wrote:
> Hello!
> 
> These patches add simple ioctl(2) support to Landlock.
> 

[...]

> How we arrived at the list of always-permitted IOCTL commands
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> To decide which IOCTL commands should be blanket-permitted I went through the
> list of IOCTL commands mentioned in fs/ioctl.c and looked at them individually
> to understand what they are about.  The following list is my conclusion from
> that.
> 
> We should always allow the following IOCTL commands:
> 
>  * FIOCLEX, FIONCLEX - these work on the file descriptor and manipulate the
>    close-on-exec flag
>  * FIONBIO, FIOASYNC - these work on the struct file and enable nonblocking-IO
>    and async flags
>  * FIONREAD - get the number of bytes available for reading (the implementation
>    is defined per file type)

I think we should treat FIOQSIZE like FIONREAD, i.e. check for
LANDLOCK_ACCESS_FS_READ_FILE as explain in my previous message.
Tests should then rely on something else.

[...]

> Changes
> ~~~~~~~
> 
> V3:
>  * always permit the IOCTL commands FIOCLEX, FIONCLEX, FIONBIO, FIOASYNC and
>    FIONREAD, independent of LANDLOCK_ACCESS_FS_IOCTL
>  * increment ABI version in the same commit where the feature is introduced
>  * testing changes
>    * use FIOQSIZE instead of TTY IOCTL commands
>      (FIOQSIZE works with regular files, directories and memfds)
>    * run the memfd test with both Landlock enabled and disabled
>    * add a test for the always-permitted IOCTL commands
