Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1429BC4332F
	for <linux-security-module@archiver.kernel.org>; Sun,  6 Nov 2022 00:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiKFA4v (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 5 Nov 2022 20:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiKFA4u (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 5 Nov 2022 20:56:50 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4B91147F
        for <linux-security-module@vger.kernel.org>; Sat,  5 Nov 2022 17:56:49 -0700 (PDT)
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2A60uR23026164;
        Sun, 6 Nov 2022 09:56:27 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Sun, 06 Nov 2022 09:56:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2A60uRlK026159
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 6 Nov 2022 09:56:27 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <52fdbbe4-cad5-6cd0-9574-2e5efb88a478@I-love.SAKURA.ne.jp>
Date:   Sun, 6 Nov 2022 09:56:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 04/10] CaitSith: Add header file.
Content-Language: en-US
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20221102171025.126961-4-penguin-kernel@I-love.SAKURA.ne.jp>
 <ef5fa206-4e7f-3c23-07d4-8591c4315d20@schaufler-ca.com>
 <20221105024345.GA15957@mail.hallyn.com>
 <5d31873f-f477-ef5a-591f-6f0195f258a8@I-love.SAKURA.ne.jp>
 <20221105234614.GA23523@mail.hallyn.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20221105234614.GA23523@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2022/11/06 8:46, Serge E. Hallyn wrote:
> On Sat, Nov 05, 2022 at 01:05:44PM +0900, Tetsuo Handa wrote:
>> On 2022/11/05 11:43, Serge E. Hallyn wrote:
>>> On Wed, Nov 02, 2022 at 10:57:48AM -0700, Casey Schaufler wrote:
>>>> On 11/2/2022 10:10 AM, Tetsuo Handa wrote:
>>>>> The main point of this submission is to demonstrate how an LSM module
>>>>> which can be loaded using /sbin/insmod can work, and to provide
>>>>> consideration points for making changes for LSM stacking in a way that
>>>>> will not lock out LSM modules which can be loaded using /sbin/insmod .
>>>>
>>>> CaitSith could readily be done as an in-tree LSM. The implementation
>>>> of loadable module infrastructure is unnecessary.
>>>
>>> Sorry, I'm getting confused.  But in-tree and loadable are not related,
>>> right?
>>
>> Very much related. My goal is to get CaitSith in-tree as a loadable LSM module
>> which can be loaded using /sbin/insmod .
> 
> Great.  I support that.  But the sentence

Thank you.

> 
>>>> CaitSith could readily be done as an in-tree LSM. The implementation
>>>> of loadable module infrastructure is unnecessary.
> 
> suggests that because CaitSith could be done in-tree, it doesn't need
> to be loadable.  I'm saying that is a non sequitur.  It sounded like
> that setence was meant to say "Because CaitSith could be in-tree, it
> doesn't need to be =m.  Only out of tree modules need to be loadable."

Unfortunately, I don't think that my intended Linux distributor (namely, Red Hat)
will support LSMs other than SELinux.

  https://bugzilla.redhat.com/show_bug.cgi?id=542986

Therefore, not only out of tree modules but also in-tree modules which cannot be
enabled by Linux distributors need to be implemented as loadable kernel modules.

