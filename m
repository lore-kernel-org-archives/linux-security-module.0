Return-Path: <SRS0=SNv9=QO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B550C282C2
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Feb 2019 21:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB4C2175B
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Feb 2019 21:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iTeCLapt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfBGVzI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:55:08 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45219 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGVzI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Feb 2019 16:55:08 -0500
Received: by mail-yb1-f195.google.com with SMTP id e131so583926ybh.12
        for <linux-security-module@vger.kernel.org>; Thu, 07 Feb 2019 13:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5a0BcPDa2Z/6xrr2VhLG4EobKA5L8sCm5fgGxy9bqh4=;
        b=iTeCLaptyR7UF4GGQN4y+r2KS/32utaG+Ix5/S+gcfyYL9JrnJcVihEQxL1W/aPbgG
         9HAvsj9S4mUmsvtiJ1/QcFJeMhSxG3/lU+tHU2xjnNaQZa8mUAVEc+PtvvuhTbVFKjLM
         T4mt4b+ItugCQys0dbOeXWCImxzSGCpitSbHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5a0BcPDa2Z/6xrr2VhLG4EobKA5L8sCm5fgGxy9bqh4=;
        b=cXXW+8QvEO82DaCe1THR0U/zKmtl9KO01HqeCGwYJPaw2JvmERdqDW3TpVgiMWSm2P
         +jsifBHi9NQsM/V36fwDOxtSwXwoNnNHrf9Hk0zmgkXizTt//xzG7+ybrvLhl5p8ixn5
         fwQFJ2nN/K1g2QMLbDB8FTpStmNqQ4foYajcvO7ueODA321XbmoSL/ye7eLpcGKFIbnG
         OOKiLSCyCTc/SuP307YxueLJwGlY85K61G3y7ivL0OQ9jr1+qFjSo+9c55oTjvJAJ+7k
         Yz3RjCi1Jjt3Gu/ocmOtQOG+2gyrE8vp3I8E+jyIskmDaoKDLul5zTr1Yaih69LlX4Ua
         HHCQ==
X-Gm-Message-State: AHQUAuZUYbRoKW5foHvPZSHUPp1DI/FOYmSHXH7Tyvr1nrQl8jV87Str
        WrwoQPWSIX0Gh0JReeJkGCk0UOQBmHzZnmNXE2Hh1A==
X-Google-Smtp-Source: AHgI3IboWi6MpPU654yVVqK5KRDuW9lmea7CnCVqAzQ20sCmQyb8upC2mfcsgMeEVcl1RBTQVffvY6uCfbMbMZ5D/Yc=
X-Received: by 2002:a25:bd5:: with SMTP id 204mr14686019ybl.97.1549576507516;
 Thu, 07 Feb 2019 13:55:07 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5jJX5V9H5uWArV93eM9jFzaCO4s3rQPBa6rN0LbKtMj82Q@mail.gmail.com>
 <20190206190309.247032-1-mortonm@chromium.org> <000101d4be51$d4c07c80$7e417580$@211mainstreet.net>
In-Reply-To: <000101d4be51$d4c07c80$7e417580$@211mainstreet.net>
From:   Micah Morton <mortonm@chromium.org>
Date:   Thu, 7 Feb 2019 13:54:56 -0800
Message-ID: <CAJ-EccNpKa8soywNK1BMJGesOcw=jxo9FvQ6BbZukFkubrnnPQ@mail.gmail.com>
Subject: Re: [PATCH] LSM: SafeSetID: add selftest
To:     Edwin Zimmerman <edwin@211mainstreet.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Yeah, that would be simple, although maybe someone is counting on
those users to exist later. We could create special users on the
system for the purpose of this test that didn't exist before the test
(and delete them afterward), but then there are other setup/cleanup
questions, like:

- Do we unmount securityfs after the test? What if something was
counting on it being mounted or not mounted?
- Do we flush the SafeSetID LSM policies after the test? Note that the
LSM doesn't currently have the functionality to flush individual
policies, so what happens if something was counting on certain
policies (for other users) being configured for the LSM and we flush
those after running our test?

These questions were the reason I was hoping to get more info on the
kind of environment in which these selftests run. If the norm is to
boot up a VM, run one of these tests, then reboot/shutdown, most of
these questions don't need to be answered (we would still probably
want to fix user creation/deletion since that is persistent across
reboots).

On Wed, Feb 6, 2019 at 11:26 AM Edwin Zimmerman <edwin@211mainstreet.net> wrote:
>
> > On Wednesday, February 06, 2019 2:03 PM Micah Morton wrote:
> > > This patch adds a selftest for the SafeSetID LSM. The test requires
> > > mounting securityfs if it isn't mounted, creating test users in
> > > /etc/passwd, and configuring policies for the SafeSetID LSM through
> > > writes to securityfs.
> > >
> > > Signed-off-by: Micah Morton <mortonm@chromium.org>
> > > ---
> > > This test is reasonably robust for demonstrating the functionality of
> > > the LSM, but is no masterpiece by any means. I'm not totally sure how
> > > these tests are used. Are they incorporated into testing frameworks for
> > > the Linux kernel that are run regularly or just PoC binaries that sit in
> > > this directory more or less as documentation? If its the former, this
> > > code probably needs some more cleanup and better organization. Beyond
> > > coding style, the test doesn't bother to clean up users that were added
> > > in /etc/passwd for testing purposes nor flushes policies that were
> > > configured for the LSM relating to those users. Should it?
> >
> > No good reason to leave the users, so I would suggest cleaning them up.
> > All it would take would be several deluser commands
> > in safesetid-test.sh.  Very simple.
>
