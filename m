Return-Path: <SRS0=JiNK=SO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319A6C10F0E
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Apr 2019 11:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0789C2083E
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Apr 2019 11:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfDLLJ3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:09:29 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62577 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfDLLJ2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Apr 2019 07:09:28 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3CB9NhL028109;
        Fri, 12 Apr 2019 20:09:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Fri, 12 Apr 2019 20:09:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157095162.bbtec.net [60.157.95.162])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x3CB9MeD028105
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 12 Apr 2019 20:09:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] tomoyo: Change pathname calculation for read-only
 filesystems.
To:     viro@zeniv.linux.org.uk
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org
References: <1551277164-8715-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <alpine.LRH.2.21.1902280724410.7990@namei.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <52027db5-a4e3-fc5e-4149-529d95d251b2@i-love.sakura.ne.jp>
Date:   Fri, 12 Apr 2019 20:09:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1902280724410.7990@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Al, do you have any concerns with this patch?

On 2019/02/28 5:25, James Morris wrote:
> On Wed, 27 Feb 2019, Tetsuo Handa wrote:
> 
>> Commit 5625f2e3266319fd ("TOMOYO: Change pathname for non-rename()able
>> filesystems.") intended to be applied to filesystems where the content is
>> not controllable from the userspace (e.g. proc, sysfs, securityfs), based
>> on an assumption that such filesystems do not support rename() operation.
>>
>> But it turned out that read-only filesystems also do not support rename()
>> operation despite the content is controllable from the userspace, and that
>> commit is annoying TOMOYO users who want to use e.g. squashfs as the root
>> filesystem due to use of local name which does not start with '/'.
>>
>> Therefore, based on an assumption that filesystems which require the
>> device argument upon mount() request is an indication that the content
>> is controllable from the userspace, do not use local name if a filesystem
>> does not support rename() operation but requires the device argument upon
>> mount() request.
> 
> I'd definitely like Al's input on this.
> 
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> ---
>>  security/tomoyo/realpath.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/security/tomoyo/realpath.c b/security/tomoyo/realpath.c
>> index 85e6e31..e7832448 100644
>> --- a/security/tomoyo/realpath.c
>> +++ b/security/tomoyo/realpath.c
>> @@ -295,7 +295,8 @@ char *tomoyo_realpath_from_path(const struct path *path)
>>  		 * or dentry without vfsmount.
>>  		 */
>>  		if (!path->mnt ||
>> -		    (!inode->i_op->rename))
>> +		    (!inode->i_op->rename &&
>> +		     !(sb->s_type->fs_flags & FS_REQUIRES_DEV)))
>>  			pos = tomoyo_get_local_path(path->dentry, buf,
>>  						    buf_len - 1);
>>  		/* Get absolute name for the rest. */
>>
> 

