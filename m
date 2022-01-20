Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BE4C433F5
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Jan 2022 18:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239254AbiATSU1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 20 Jan 2022 13:20:27 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:40736 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236440AbiATSU1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 20 Jan 2022 13:20:27 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:60404)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nAc2r-00DwFW-Ih; Thu, 20 Jan 2022 11:20:25 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:51394 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nAc2n-000p0K-7p; Thu, 20 Jan 2022 11:20:25 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220120180116.167702-1-flaniel@linux.microsoft.com>
Date:   Thu, 20 Jan 2022 12:20:15 -0600
In-Reply-To: <20220120180116.167702-1-flaniel@linux.microsoft.com> (Francis
        Laniel's message of "Thu, 20 Jan 2022 19:01:14 +0100")
Message-ID: <87wniu2rs0.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nAc2n-000p0K-7p;;;mid=<87wniu2rs0.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19l8e4H5115J6h+/AI1Jy8YvSk3krMZSYo=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC PATCH v3 0/2] Add capabilities file to sysfs
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Francis Laniel <flaniel@linux.microsoft.com> writes:

> Hi.
>
>
> First, I hope you are fine and the same for your relatives.
>
>
> Capabilities are used to check if a thread has the right to perform a given
> action [1].
> For example, a thread with CAP_BPF set can use the bpf() syscall.
>
> Capabilities are used in the container world.
> In terms of code, several projects related to container maintain code where the
> capabilities are written alike include/uapi/linux/capability.h [2][3][4][5].
> For these projects, their codebase should be updated when a new capability is
> added to the kernel.
> Some other projects rely on <sys/capability.h> [6].
> In this case, this header file should reflect the capabilities offered by the
> kernel.
>
> So, in this series, I added a new file to sysfs:
> /sys/kernel/security/capabilities.

Actually that is a file in securityfs.  Which is related but slightly
different.  For sysfs this would be immediately unacceptable as it
breaks the one value per file rule.  I don't know what the rules
are for securityfs but I do know files that contain many many lines
and get very large tend to be problematic in both their kernel
implementation and in userspace parsing speed.

So I am looking for what the advantage of this file that justifies the
cost of maintaining it.

> The goal of this file is to be used by "container world" software to know kernel
> capabilities at run time instead of compile time.

I don't understand the problem you are trying to solve.  If the software
needs to updated what benefit is there for all of the information to be
available at runtime?

>
> The "file" is read-only and its content is the capability number associated with
> the capability name:
> root@vm-amd64:~# cat /sys/kernel/security/capabilities
> 0       CAP_CHOWN
> 1       CAP_DAC_OVERRIDE
> ...
> 40      CAP_CHECKPOINT_RESTORE
>

> The kernel already exposes the last capability number under:
> /proc/sys/kernel/cap_last_cap
> So, I think there should not be any issue exposing all the capabilities it
> offers.
> If there is any, please share it as I do not want to introduce issue with this
> series.

The mapping between capabilities and numbers should never change it is
ABI.  I seem to remember a version number in the file capability so that
if the mappings do change that number can be changed in a way that
existing software is not confused.

What is the advantage in printing all of the mappings?
>
> Also, if you see any way to improve this series please share it as it would
> increase this contribution quality.
>
> Change since v2:
> * Use a char * for cap_string instead of an array, each line of this char *
> contains the capability number and its name.
> * Move the file under /sys/kernel/security instead of /sys/kernel.
>
> Francis Laniel (2):
>   capability: Add cap_string.
>   security/inode.c: Add capabilities file.
>
>  include/uapi/linux/capability.h |  1 +
>  kernel/capability.c             | 45 +++++++++++++++++++++++++++++++++
>  security/inode.c                | 16 ++++++++++++
>  3 files changed, 62 insertions(+)
>
>
> Best regards and thank you in advance for your reviews.
> ---
> [1] man capabilities
> [2] https://github.com/containerd/containerd/blob/1a078e6893d07fec10a4940a5664fab21d6f7d1e/pkg/cap/cap_linux.go#L135
> [3] https://github.com/moby/moby/commit/485cf38d48e7111b3d1f584d5e9eab46a902aabc#diff-2e04625b209932e74c617de96682ed72fbd1bb0d0cb9fb7c709cf47a86b6f9c1
> moby relies on containerd code.
> [4] https://github.com/syndtr/gocapability/blob/42c35b4376354fd554efc7ad35e0b7f94e3a0ffb/capability/enum.go#L47
> [5] https://github.com/opencontainers/runc/blob/00f56786bb220b55b41748231880ba0e6380519a/libcontainer/capabilities/capabilities.go#L12
> runc relies on syndtr package.
> [6] https://github.com/containers/crun/blob/fafb556f09e6ffd4690c452ff51856b880c089f1/src/libcrun/linux.c#L35

Eric
