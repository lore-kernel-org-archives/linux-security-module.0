Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C04C32789
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Aug 2022 18:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiHWSje (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Aug 2022 14:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiHWSjL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Aug 2022 14:39:11 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160211151C9
        for <linux-security-module@vger.kernel.org>; Tue, 23 Aug 2022 10:02:34 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id v125so16785089oie.0
        for <linux-security-module@vger.kernel.org>; Tue, 23 Aug 2022 10:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=NGK9SJL+jbcJ+81jw1EQdQeIyg8FgfHLJJZwNUv48rA=;
        b=yMYBIle+g6JQATabokr1qmPm7dB1NceXKHg1qSJ5mVkoCQVYkYZ4hVMkQI79lRSrbM
         UgzU23MM2hR74US26qOSr7XfbWiecTCCWcfLRSQSZITmmjAX4bDBXL5UOJ9XVcpkVH3X
         wBbXBZWE4oQYgc7La98gH9Pl3GLjL1MoT9GvIo/AIt3DgFRGO83kCX0/qvvKVDc7sNeL
         yAxIJO33R6IRH+o41c/P36Om9BtL7bpMd9l8g2TGv0HGArcC83+3tzk1vAodic3OnmnL
         kid9cx5Xdbz5o6MF5LSVSoVL6WfLxCbUbC9okv8NmnK+kpsSxBbDpWjEIt9HHr1anyNe
         RE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NGK9SJL+jbcJ+81jw1EQdQeIyg8FgfHLJJZwNUv48rA=;
        b=6k1gsnhcKIxNYVILE/Cm2XxZT8XD8iY43lJaMR8XLKVeUH1wClt5y2fyvElM6JtGHK
         Q5Dom0X6DzLlWxlYxNpIRmvTuyRjy0xzAWRvVp1JOChOrkOF7nmNIMnGiM1+H2SdeMHD
         /gKa023sjpvh5AumyMh9CCm/uVLbglK/+OVNDTnkuEog9pEXmBkqDO2cjy0zwPxEhUye
         3kV2y0rO6qp+QeUtj7+ie0NTKvAEx6KnsO2U4Uz7m7YboatjLqVMv52kbbuLzD4sWfvo
         U1bHFRQNUj2mg/CwKLr+181emo5IK6dIv6sQ5ESlV5Ow96joeiuynnETowY/JLJr4aqo
         wGLg==
X-Gm-Message-State: ACgBeo1Dq260tzM0yvx20Lhzq/hGJ1SnzuB3dCFSaedSek04IaPzL+mu
        m55vqRkhP4WzSCZ/biyCHK32dU32sgB5hGWfdcV5agT1NVfS
X-Google-Smtp-Source: AA6agR53O11aV/ezRM7BbFUHuJcDs3a0pSzF9hsHKGQhOx8rTVzKkK7KIbQ/aKwEaca9cTWClNVOcM6dTYZLjdSjdCs=
X-Received: by 2002:aca:b7d5:0:b0:343:c478:91c6 with SMTP id
 h204-20020acab7d5000000b00343c47891c6mr1714816oif.136.1661274139335; Tue, 23
 Aug 2022 10:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <166120321387.369593.7400426327771894334.stgit@olly>
 <166120327984.369593.8371751426301540450.stgit@olly> <YwR5HBazPxWjcYci@kroah.com>
In-Reply-To: <YwR5HBazPxWjcYci@kroah.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 Aug 2022 13:02:08 -0400
Message-ID: <CAHC9VhQOSr_CnLmy0pwgUETPh565951DdejQtgkfNk7=tj+BNA@mail.gmail.com>
Subject: Re: [PATCH 3/3] /dev/null: add IORING_OP_URING_CMD support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        io-uring@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 23, 2022 at 2:52 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Aug 22, 2022 at 05:21:19PM -0400, Paul Moore wrote:
> > This patch adds support for the io_uring command pass through, aka
> > IORING_OP_URING_CMD, to the /dev/null driver.  As with all of the
> > /dev/null functionality, the implementation is just a simple sink
> > where commands go to die, but it should be useful for developers who
> > need a simple IORING_OP_URING_CMD test device that doesn't require
> > any special hardware.
>
> Also, shouldn't you document this somewhere?
>
> At least in the code itself saying "this is here so that /dev/null works
> as a io_uring sink" or something like that?  Otherwise it just looks
> like it does nothing at all.

What about read_null() and write_null()?  I can definitely add a
comment (there is no /dev/null documentation in the kernel source tree
that I can see), but there is clearly precedence for /dev/null having
"do nothing" file_operations functions.  If nothing else, it's pretty
much in the *name*; we're adding the "uring_cmd_null()" member
function to the "null_fops" struct for the "null" device ... come on
Greg :)

-- 
paul-moore.com
