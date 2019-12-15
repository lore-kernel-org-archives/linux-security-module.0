Return-Path: <SRS0=H1aQ=2F=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48A2C43603
	for <linux-security-module@archiver.kernel.org>; Sun, 15 Dec 2019 15:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD6C2253D
	for <linux-security-module@archiver.kernel.org>; Sun, 15 Dec 2019 15:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brkukWbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfLOPnZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 15 Dec 2019 10:43:25 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43283 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfLOPnY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 15 Dec 2019 10:43:24 -0500
Received: by mail-ed1-f66.google.com with SMTP id dc19so2973475edb.10
        for <linux-security-module@vger.kernel.org>; Sun, 15 Dec 2019 07:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=/wWyyDw15GkE7UwKL96KUA/7gQa6SV59lh2fmM6CWcM=;
        b=brkukWbLtTHUVZIpOLT9fGY8HtdASX4AqCK9/MvP8ML02VN1rcS/dPBkKsDm8tJTnY
         2XR4i0iAiffK0Vj4AlaRWhwoDsl+H267JoL6u2ZSTtFdKFE7VCeL5oKvx9Fn7f299v9/
         Xeu4i//QtabBuYaInPGrFeJ+h3o6l1GnY+li9Xa+f/mDyqwDu58I3aOY8jcvule1n68P
         O8ALCsTw28V/DUlf2FYxItZ6uQgBHU55hdpcMltrBj2y/GxXcE2ErB19jUIRO6rhsHPk
         AFhAkDsshvReTX36q9laQI1qHcoKWQXoqHkOI7NAG7pNCaC0sIOVW7sgvvdI2hChgrEO
         JrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=/wWyyDw15GkE7UwKL96KUA/7gQa6SV59lh2fmM6CWcM=;
        b=Jtogcb2Fvv/1yL1m5tnCRs5lJ/cK+IJR7Em4QQSfG1VbX4IhwmVxHywmYIPSaxe+Pj
         GwmRcuCuAvBBxQREj4A0PztBTS2hiwtdcXm/gNNPUyKAlfi10RLoi5esczBNO2hmol8O
         VKDTbksWM3QxP8I+g2d+qXSEVg7BwSDrjDhw3f1/mVYn9d3g0VviPTVUypiRWAa2X5k7
         Ar6otYHySOI/Qjw1MlXyfSmZRGCqNy6CDbs6lGuyVysFLr7Rj3J9n75or9O20XA7JY07
         2pj8Ex/w2oF45m/eUbhdzpXryIDcrTfWVjeCuCwK7TtO5l7c78OXfXN31cOk1+wxmS7Z
         QBEA==
X-Gm-Message-State: APjAAAXUWqUN4ezHsx8v4ajuRzqN3Lqp54LnJe3Gt1Khp4Q5kXit6HuU
        waVV2BnX6AEY2mHjBfgEaN8xB+XROf6CHgfvQ+Q=
X-Google-Smtp-Source: APXvYqz3yE862N7kXKMR2RWG8QUBKwLdcwbaLW2/L7gzxe/569RfQJav+doLEdCsgigKUCKva7HG7D/RKpJ0ut4roms=
X-Received: by 2002:a17:906:3cea:: with SMTP id d10mr28701887ejh.32.1576424602755;
 Sun, 15 Dec 2019 07:43:22 -0800 (PST)
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Sun, 15 Dec 2019 16:43:11 +0100
Message-ID: <CAKgNAkiyAkZy=oLrpJvHYU9Tq1dunNJLOJdtr508_w3vrdPWcQ@mail.gmail.com>
Subject: Anomalous output from getpcaps(1) for process with all capabilities
To:     Andrew Morgan <morgan@kernel.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>, ksrot@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Andrew,

Once upon a time (I don't remember exactly when things changed but let
us say 5 years ago), when one examined the capabilities of a process
with all capabilities, one saw something like the following nicely
compact output:

$ getpcaps 1
Capabilities for `1': =ep

Nowadays, one rather sees this (as also noticed by others [1]):

$ getpcaps 1
Capabilities for `1': =
cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner,
cap_fsetid,cap_kill,cap_setgid,cap_setuid,cap_setpcap,
cap_linux_immutable,cap_net_bind_service,cap_net_broadcast,
cap_net_admin,cap_net_raw,cap_ipc_lock,cap_ipc_owner,
cap_sys_module,cap_sys_rawio,cap_sys_chroot,cap_sys_ptrace,
cap_sys_pacct,cap_sys_admin,cap_sys_boot,cap_sys_nice,
cap_sys_resource,cap_sys_time,cap_sys_tty_config,cap_mknod,
cap_lease,cap_audit_write,cap_audit_control,cap_setfcap,
cap_mac_override,cap_mac_admin,cap_syslog,cap_wake_alarm,
cap_block_suspend,cap_audit_read+ep

The latter of course is much harder to read.

This all the more perplexing when compared to the folowing:

$ setcap =ep myprog
$ getcap myprog
prog =ep

Looking more closely, there is a difference in the respective
capability sets. For the process show above, the effective and
permitted capability have precisely the 38 current capabilities
available. By contrast, inspecting the security.capability attribute
of 'myprog' show a permitted set that has all 64 bits sets. So this
explains why there is a difference in the output of getpcaps and
getcap above.

I'm not sure where the behavior change originated. cap_to_text() has
seen no change between 2008 and 2017, AFAIK, but surely it is there
that some bit parsing logic needs to be fixed. Do you have any
thoughts?

Thanks,

Michael

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1432878
-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
