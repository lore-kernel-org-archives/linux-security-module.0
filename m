Return-Path: <SRS0=3Nce=TJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E790C04AAF
	for <linux-security-module@archiver.kernel.org>; Thu,  9 May 2019 03:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA7E20989
	for <linux-security-module@archiver.kernel.org>; Thu,  9 May 2019 03:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfEID4i (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 May 2019 23:56:38 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57330 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfEID4i (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 May 2019 23:56:38 -0400
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x493uX9p035504;
        Thu, 9 May 2019 12:56:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Thu, 09 May 2019 12:56:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x493uSXZ035360
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 9 May 2019 12:56:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: Tomoyo build warnings
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org
References: <alpine.LRH.2.21.1905090854080.14157@namei.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <73f71089-26e1-b19a-ec19-44fd91af729a@i-love.sakura.ne.jp>
Date:   Thu, 9 May 2019 12:56:27 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1905090854080.14157@namei.org>
Content-Type: text/plain; charset=iso-8859-7
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/05/09 7:54, James Morris wrote:
> I'm seeing these during a kernel build in my tree:

Well, it seems that clang-4 and gcc-9 got this new warning, and
Linus Torvalds recently silenced this warning...

  commit 6f303d60534c46aa1a239f29c321f95c83dda748
  Author: Linus Torvalds <torvalds@linux-foundation.org>
  Date:   Wed May 1 11:05:41 2019 -0700

      gcc-9: silence 'address-of-packed-member' warning

      We already did this for clang, but now gcc has that warning too.  Yes,
      yes, the address may be unaligned.  And that's kind of the point.

      Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Since "struct list_head" consists of aligned two pointers, I wonder
how a member next to "struct list_head" can fail to be aligned...

  struct tomoyo_shared_acl_head {
      struct list_head list;
      atomic_t users;
  } __packed;

But since this structure is not visible from userspace, I can accept
dropping __packed and wasting a few bytes if that commit doesn't go upstream.

