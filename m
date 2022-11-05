Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46397C4332F
	for <linux-security-module@archiver.kernel.org>; Sat,  5 Nov 2022 04:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiKEEGX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 5 Nov 2022 00:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKEEGV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 5 Nov 2022 00:06:21 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ACA2D1CE
        for <linux-security-module@vger.kernel.org>; Fri,  4 Nov 2022 21:06:18 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2A545jlT077510;
        Sat, 5 Nov 2022 13:05:45 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Sat, 05 Nov 2022 13:05:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2A545ipR077506
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 5 Nov 2022 13:05:44 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5d31873f-f477-ef5a-591f-6f0195f258a8@I-love.SAKURA.ne.jp>
Date:   Sat, 5 Nov 2022 13:05:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 04/10] CaitSith: Add header file.
Content-Language: en-US
To:     "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20221102171025.126961-4-penguin-kernel@I-love.SAKURA.ne.jp>
 <ef5fa206-4e7f-3c23-07d4-8591c4315d20@schaufler-ca.com>
 <20221105024345.GA15957@mail.hallyn.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20221105024345.GA15957@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2022/11/05 11:43, Serge E. Hallyn wrote:
> On Wed, Nov 02, 2022 at 10:57:48AM -0700, Casey Schaufler wrote:
>> On 11/2/2022 10:10 AM, Tetsuo Handa wrote:
>>> The main point of this submission is to demonstrate how an LSM module
>>> which can be loaded using /sbin/insmod can work, and to provide
>>> consideration points for making changes for LSM stacking in a way that
>>> will not lock out LSM modules which can be loaded using /sbin/insmod .
>>
>> CaitSith could readily be done as an in-tree LSM. The implementation
>> of loadable module infrastructure is unnecessary.
> 
> Sorry, I'm getting confused.  But in-tree and loadable are not related,
> right?

Very much related. My goal is to get CaitSith in-tree as a loadable LSM module
which can be loaded using /sbin/insmod .

Lessons I learned from TOMOYO are that:

  Most of Linux users, unlike Linux kernel developers, consider the Linux kernel
  as something black-box program. While the source code is open, they cannot
  afford understanding how updating the Linux kernel via "yum update" or
  "apt dist-upgrade" affects their systems.

  I can't force Linux users to replace their kernel packages in order to
  allow them to use TOMOYO, for replacing the kernel package makes their
  replaced kernel packages incompatible (kABI breakage) with other kernel
  modules (e.g. device drivers provided by hardware vendors) and/or makes
  their kernel completely unsupported. I can support TOMOYO part but I can't
  support the rest of the kernel, which makes it impossible for Linux users
  using supported kernels to try TOMOYO. Being in-tree helps catching up
  the upstream kernel changes, but being in-tree does not help allowing
  Linux distribution users to use TOMOYO.

  Linux distributors cannot afford enabling all LSM modules, due to the
  "enabled" == "supported" spell. There are out-of-tree kernel modules
  which are built as a loadable kernel module (i.e. not included into
  the main kernel package which is supported by Linux distributors), but
  the LSM framework does not legally allow use of LSM modules which are
  not built into the bzImage file.

If the LSM framework legally allows use of LSM modules which are not built
into the bzImage file, we can allow users to use whatever LSM modules they
want (and "support" is provided by the module authors rather than by Linux
distributors).

This submission is to ask LSM framework "please don't make it impossible to
allow users to use whatever LSM modules they want". That is more important
than "complete LSM stacking".

Casey's proposal towards "complete LSM stacking" is making it impossible to
allow users to use whatever LSM modules they want, due to the requirement of
having an LSM id integer value and using fixed sized array.

