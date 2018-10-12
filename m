Return-Path: <SRS0=03NR=MY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A354BC71122
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Oct 2018 20:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61ECB20865
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Oct 2018 20:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PZeRNXeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61ECB20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeJMDmB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:42:01 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45411 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbeJMDmA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Oct 2018 23:42:00 -0400
Received: by mail-yw1-f68.google.com with SMTP id v198-v6so5402077ywg.12
        for <linux-security-module@vger.kernel.org>; Fri, 12 Oct 2018 13:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VsdDRCUqon7Z23teRbW7qQSFBgJ8uBghNMLixUZDntI=;
        b=PZeRNXeMAVVsgiVBD1qq1ljaOyjh4ctxO0IwL3jxwPK1WsLQStqkNZYOk5pJ9V2HmE
         alu3s50W5LLOmkg2QRwy6PLMA74sH54A2Le7RUJWMgOP/eKlhobOaUfrEzkQ9uZXaaN+
         65V7z+ugsyVB5LabpURmSuLhRjGy8KE33/G1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VsdDRCUqon7Z23teRbW7qQSFBgJ8uBghNMLixUZDntI=;
        b=O3IJ30bf3PylntlsPl8QoESckld/KKu6AmoA07yZXRDHUzmWTTen/jq8wag5XjQ2sZ
         vUq5aR0Ws7KasaqmVK6pD3NT2jI07nNrFbiW8OIjXp7j4M6VJxNMvpfR6CIBYZEeBJ7W
         3xNQJEhTcTh0U58HRnzfgN2tk+sDQTYsIDxYKhqPs1ptEQH04AIAEds3RvfTk542uVAL
         4f2S7zlScQBRcgznvD0KdY59cJhMDmMhpJHAGKdzYYr6Q+4KRSxqqNZ5wMA3A+L72Is2
         wQ6N3RHp1olAx1CKMX00G3UUGv5vcuPueChwVCq58dSKzCCKUlXtI1JSEg6a+lvIp7Vd
         uidg==
X-Gm-Message-State: ABuFfoi/0tJrtSQuDJKRMh+iZsNjS3IFtH58hkgmjRt7L3b06XKN59BI
        5BX32vxE07czn6Ptl3byD5ci0x1i3RI=
X-Google-Smtp-Source: ACcGV605bXn+Sqd0w5uMLhhM6oPz6r7u4rHOwnFnBc6/56eXEY/C5oSCW3anIpAMqZcqi/x6p4CL3w==
X-Received: by 2002:a81:5f86:: with SMTP id t128-v6mr4408379ywb.84.1539374871826;
        Fri, 12 Oct 2018 13:07:51 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id v34-v6sm770370ywh.45.2018.10.12.13.07.48
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 13:07:48 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id y76-v6so5420671ywd.2
        for <linux-security-module@vger.kernel.org>; Fri, 12 Oct 2018 13:07:48 -0700 (PDT)
X-Received: by 2002:a0d:d302:: with SMTP id v2-v6mr4531436ywd.124.1539374867898;
 Fri, 12 Oct 2018 13:07:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 13:07:46
 -0700 (PDT)
In-Reply-To: <CAGXu5j+XTMcqdPQK=E6KV3-oMCFA+UkiGsfHN2T6CCfAA7X9Qw@mail.gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <8010a7d0-c6a0-b327-d5dd-6857d6d42561@schaufler-ca.com> <CAGXu5j+XTMcqdPQK=E6KV3-oMCFA+UkiGsfHN2T6CCfAA7X9Qw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 12 Oct 2018 13:07:46 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+31_T8ctncUrjkvWNKRD78TdRihm26hk=GD4Rva8TPBw@mail.gmail.com>
Message-ID: <CAGXu5j+31_T8ctncUrjkvWNKRD78TdRihm26hk=GD4Rva8TPBw@mail.gmail.com>
Subject: Re: [PATCH 21/19] LSM: Cleanup and fixes from Tetsuo Handa
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 1, 2018 at 2:48 PM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Sep 26, 2018 at 2:57 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> lsm_early_cred()/lsm_early_task() are called from only __init functions.
>>
>> lsm_cred_alloc()/lsm_file_alloc() are called from only security/security.c .
>>
>> lsm_early_inode() should be avoided because it is not appropriate to
>> call panic() when lsm_early_inode() is called after __init phase.
>>
>> Since all free hooks are called when one of init hooks failed, each
>> free hook needs to check whether init hook was called.
>>
>> The original changes are from Tetsuo Handa. I have made minor
>> changes in some places, but this is mostly his code.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/lsm_hooks.h         |  6 ++----
>>  security/security.c               | 27 ++++-----------------------
>>  security/selinux/hooks.c          |  5 ++++-
>>  security/selinux/include/objsec.h |  2 ++
>>  security/smack/smack_lsm.c        |  8 +++++++-
>>  5 files changed, 19 insertions(+), 29 deletions(-)
>
> I've split this across the various commits they touch:
>
> Infrastructure management of the cred security blob
> LSM: Infrastructure management of the file security
> LSM: Infrastructure management of the inode security
> LSM: Infrastructure management of the task security
> LSM: Blob sharing support for S.A.R.A and LandLock
>
> Based on these changes, I've uploaded the "v4.1", or "Casey is on
> vacation", tree here:
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=lsm/blob-sharing-v4.1
>
> I'm going to work on a merged series for the "arbitrary ordering" and
> "blob-sharing" trees next...

Here is my v6 (v5 plus small fix I noticed) with my refactoring of
Casey's blob-sharing series on top:

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=lsm/ordering-v6-blob-sharing

procfs: add smack subdir to attrs
Smack: Abstract use of cred security blob
SELinux: Abstract use of cred security blob
SELinux: Remove cred security blob poisoning
SELinux: Remove unused selinux_is_enabled
AppArmor: Abstract use of cred security blob
TOMOYO: Abstract use of cred security blob
Infrastructure management of the cred security blob
SELinux: Abstract use of file security blob
Smack: Abstract use of file security blob
LSM: Infrastructure management of the file security
SELinux: Abstract use of inode security blob
Smack: Abstract use of inode security blob
LSM: Infrastructure management of the inode security
LSM: Infrastructure management of the task security
SELinux: Abstract use of ipc security blobs
Smack: Abstract use of ipc security blobs
LSM: Infrastructure management of the ipc security blob
TOMOYO: Update LSM flags to no longer be exclusive

Notably, the last patch from Casey's series is entirely removed.
Additionally all the per-LSM initialization changes were removed since
the blob size calculations now stay internal to security.c, done
during the "prepare" phase.

-Kees

-- 
Kees Cook
Pixel Security
