Return-Path: <SRS0=sGvM=2B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257E3C43603
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Dec 2019 11:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0002A214AF
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Dec 2019 11:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfLKLUj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:20:39 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:57205 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfLKLUj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Dec 2019 06:20:39 -0500
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xBBBKNTS044985;
        Wed, 11 Dec 2019 20:20:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav305.sakura.ne.jp);
 Wed, 11 Dec 2019 20:20:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav305.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xBBBJjbk044540
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 11 Dec 2019 20:20:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] tomoyo: Don't check open/getattr permission on
 sockets.
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     James Morris <jmorris@namei.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-security-module@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <0000000000004f43fa058a97f4d3@google.com>
 <bc146372-764d-93a9-af27-666d73ed3af5@i-love.sakura.ne.jp>
 <alpine.LRH.2.21.1907061944050.2662@namei.org>
 <alpine.LRH.2.21.1907061949040.2662@namei.org>
 <289ebc65-8444-37e3-e54e-21b55d2c9192@i-love.sakura.ne.jp>
 <a28f2680-bafc-5e23-4eea-6b432f561cd4@i-love.sakura.ne.jp>
 <A9CE5147-4047-4C42-B772-F0ED510FA283@canb.auug.org.au>
 <36906718-d2ae-3514-c6b2-371037c98da5@i-love.sakura.ne.jp>
 <20191003082543.5e1e25dd@canb.auug.org.au>
 <b175f451-4e76-84aa-48fa-e3ee9490c579@i-love.sakura.ne.jp>
 <d5cbd24b-531d-e9d0-f784-e6447129741d@i-love.sakura.ne.jp>
 <alpine.LRH.2.21.1911211818320.3625@namei.org>
 <cba33548-91dc-42b4-ef96-43642ebc3427@i-love.sakura.ne.jp>
 <b7263da2-d56d-0f27-a7e5-03541ff8a0c1@i-love.sakura.ne.jp>
 <579b10bb-990f-ae4c-8098-b39e56a4c475@i-love.sakura.ne.jp>
 <alpine.LRH.2.21.1912100837160.4379@namei.org>
 <457927e7-2cec-3933-3e5c-67ebd29d8a52@i-love.sakura.ne.jp>
 <20191211100215.2c0aec54@canb.auug.org.au>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b4594e06-197d-630b-c2da-923ec1c512b9@i-love.sakura.ne.jp>
Date:   Wed, 11 Dec 2019 20:19:39 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191211100215.2c0aec54@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello, Stephen Rothwell.

Thank you for the command line.

I was wondering why "git push -f" does not work. But I finally found
there is denyNonFastforwards option, and I was able to clean up.

$ git format-patch -1
0001-tomoyo-Don-t-use-nifty-names-on-sockets.patch
$ git reset --hard v5.5-rc1
$ git push -f origin master
$ git pull upstream master
$ git am 0001-tomoyo-Don-t-use-nifty-names-on-sockets.patch
$ git push origin master

On 2019/12/11 8:02, Stephen Rothwell wrote:
> Having done that, you should just do this (and forget the cleanups
> above):
> 
> $ git checkout master
> $ git remote update upstream
> $ git reset --hard upstream/master
> $ git cherry-pick a5f9bda81cb4
> $ git push -f origin master
> 
> After that you will have a nice clean tree (based on Linus' tree) to
> continue development on that just contains the one patch "tomoyo: Don't
> check open/getattr permission on sockets."

Now the history looks like below.

6f7c41374b62 (HEAD -> master, origin/master) tomoyo: Don't use nifty names on sockets.
6794862a16ef (upstream/master) Merge tag 'for-5.5-rc1-kconfig-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
184b8f7f91ca Merge tag 'printk-for-5.5-pr-warning-removal' of git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk
316eaf170252 Merge tag 'thermal-5.5-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux
78f926f72e43 btrfs: add Kconfig dependency for BLAKE2B
e42617b825f8 (tag: v5.5-rc1) Linux 5.5-rc1

> 
> If, however, you intend to only send patche via James tree, then you
> should be using his tree
> (git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
> branch next-testing) as your upstream tree, not Linus' tree.  Then you
> can ask him to merge your tree before the merge window opens during
> each cycle.  You may want to rebase your tree on top of James tree
> after he applies your patch from above.
> 

I was previously using linux-security.git . But after experiencing confusion of
linux-security.git management, LSM users (including me) were suggested to have
their own git tree and were suggested to directly send patches to Linus.
And I am currently experiencing confusion of my tree management (because I have
never maintained a tree for "git push" purpose)...

Next step is how to create a pull request. If I recall correctly, I need a
GPG key for signing my request? I have a GPG key but I have never attended
key signing party.

