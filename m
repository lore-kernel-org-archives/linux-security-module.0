Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23D1C6FD1F
	for <linux-security-module@archiver.kernel.org>; Sun, 19 Mar 2023 21:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjCSVBM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 19 Mar 2023 17:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjCSVBE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 19 Mar 2023 17:01:04 -0400
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA181CBEC
        for <linux-security-module@vger.kernel.org>; Sun, 19 Mar 2023 14:00:53 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Pfqym0NnvzMqNB9;
        Sun, 19 Mar 2023 22:00:48 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Pfqyl35WdzMt2r2;
        Sun, 19 Mar 2023 22:00:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1679259647;
        bh=GSRFomXKG4XmQfTID3LHUEPIc0oYcSePbImv46zKEbI=;
        h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
        b=hnuCkFAWE7qPU3zyL3VDTN+l++2skQmvX/fvWyyd8Rp9GfEiH+iDo99Uor05dfBIi
         Md6FtahmUBhyyPLXjmz+EPglBbDQ7+5RMfBhioeka1wXgdUX8CPeIPkSWaOU3lpBoi
         DBTvipQAZdZiPfOYyNO+awyPBZL3VvkT25jbfi20=
Message-ID: <c1c9c688-c64d-adf2-cc96-dc2aaaae5944@digikod.net>
Date:   Sun, 19 Mar 2023 22:00:46 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: Does Landlock not work with eCryptfs?
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
References: <20230319.2139b35f996f@gnoack.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     landlock@lists.linux.dev, Tyler Hicks <code@tyhicks.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20230319.2139b35f996f@gnoack.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Günther,

Thanks for the report, I confirm there is indeed a bug. I tested with a 
Debian distro:

ecryptfs-setup-private --nopwcheck --noautomount
ecryptfs-mount-private
# And then with the kernel's sample/landlock/sandboxer:
LL_FS_RO="/usr" LL_FS_RW="${HOME}/Private" sandboxer ls ~/Private
ls: cannot open directory '/home/user/Private': Permission denied

Actions other than listing a directory (e.g. creating files/directories, 
reading/writing to files) are controlled as expected. The issue might be 
that directories' inodes are not the same when listing the content of a 
directory or when creating new files/directories (which is weird). My 
hypothesis is that Landlock would then deny directory reading because 
the directory's inode doesn't match any rule. It might be related to the 
overlay nature of ecryptfs.

Tyler, do you have some idea?

FYI, I sent a patch fixing hostfs's inode management: 
https://lore.kernel.org/all/20230309165455.175131-2-mic@digikod.net/

Regards,
  Mickaël


On 19/03/2023 16:56, Günther Noack wrote:
> Hello!
> 
> I have a machine where the home directory is encrypted with eCryptfs,
> and it seems that Landlock is not working properly on eCryptfs files
> (but the same program works as expected on other mounts)?
> 
> 
> ## Problem description
> 
> Steps to reproduce:
> 
>    * Create a directory "subdir" in the current directory
>    * Enable Landlock but ask for "subdir" to be readable
>    * os.ReadDir(dir)
> 
> Observed result:
> 
> * os.ReadDir function fails when trying to open the file (verified with strace)
> 
> Expected result:
> 
> * os.ReadDir should work, because we asked for it to work when enabling Landlock
> 
> 
> ## Reproduction code
> 
> I have uploaded a reproduction program in Go to Github,
> which should be understandable also if you are primarily a C user:
> https://github.com/gnoack/llecryptfsrepro/blob/main/repro.go
> 
> To build and run the reproduction code, run:
> 
>    git clone https://github.com/gnoack/llecryptfsrepro
>    cd llecryptfsrepro
>    go build
>    ./llecryptfsrepro  # executes the three steps as above, check source code
> 
> You can invoke this binary in different file system types to see the difference.
> 
> 
> I have admittedly only checked it with a distribution kernel on
> Manjaro Linux: The Linux version is 6.2.2-1-MANJARO.
> 
> This looks like a bug to me?
> Is this a known issue?
> 
> Thanks,
> –Günther
> 
