Return-Path: <SRS0=YZ/+=2V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AF7C2D0C3
	for <linux-security-module@archiver.kernel.org>; Tue, 31 Dec 2019 01:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127D720722
	for <linux-security-module@archiver.kernel.org>; Tue, 31 Dec 2019 01:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbfLaBgs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 30 Dec 2019 20:36:48 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:53913 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfLaBgs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 30 Dec 2019 20:36:48 -0500
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xBV1ahYN068779;
        Tue, 31 Dec 2019 10:36:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp);
 Tue, 31 Dec 2019 10:36:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xBV1aaBB068752
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 31 Dec 2019 10:36:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [GIT PULL] tomoyo fixes for 5.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>
References: <8483f2c2-626d-382f-3994-ee29daebff75@i-love.sakura.ne.jp>
 <CAHk-=wgNYqYSdD530KWQ9gtTeEvBd_Frn54Xc45B3D8PPL8ijA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <8e0bf49e-829a-0366-e80e-3ed58e25af73@i-love.sakura.ne.jp>
Date:   Tue, 31 Dec 2019 10:36:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgNYqYSdD530KWQ9gtTeEvBd_Frn54Xc45B3D8PPL8ijA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/12/31 5:14, Linus Torvalds wrote:
> On Mon, Dec 30, 2019 at 3:32 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> This is my first time for sending pull requests. It seems that most people
>> create a tag signed with GPG key but a few people send pull requests on
>> master branch without signing with GPG key. Did I follow necessary steps?
> 
> I do require the gpg signed tag for non-kernel.org pull requests like this.
> 
> I trust the security at kernel.org - it requires 2FA and a gpg key
> just to even push to a git repo there at all - but even there I
> _prefer_ tags. But outside of kernel.org I absolutely do want to see a
> signed tag for a pull request, not just a master branch.

I see. I did the following and got a tag signed with my GPG key. Did I do what you want?

$ git tag -s tomoyo-fixes-for-5.5
$ git push --tags
$ git request-pull tomoyo-fixes-for-5.5 git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git
The following changes since commit 6bd5ce6089b561f5392460bfb654dea89356ab1b:

  tomoyo: Suppress RCU warning at list_for_each_entry_rcu(). (2019-12-16 23:02:27 +0900)

are available in the git repository at:

  git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git tags/tomoyo-fixes-for-5.5

for you to fetch changes up to 6bd5ce6089b561f5392460bfb654dea89356ab1b:

  tomoyo: Suppress RCU warning at list_for_each_entry_rcu(). (2019-12-16 23:02:27 +0900)

----------------------------------------------------------------
Two bugfix patches for 5.5.

  tomoyo: Suppress RCU warning at list_for_each_entry_rcu().
  tomoyo: Don't use nifty names on sockets.

----------------------------------------------------------------

> 
> Side note: I don't actually require the pgp key to be something I have
> a direct path to, and if you can't get big set of signatures on yours,
> that's fine for initial pull requests. The key ends up still being a
> kind of identity, and we can work on getting the proper web of trust
> built up over time.
> 
>            Linus
> 

