Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC758C00140
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Aug 2022 11:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbiHRL0x (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Aug 2022 07:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiHRL0w (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Aug 2022 07:26:52 -0400
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392FC5E55C
        for <linux-security-module@vger.kernel.org>; Thu, 18 Aug 2022 04:26:49 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4M7jJk3ZH9zMpwdY;
        Thu, 18 Aug 2022 13:26:46 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4M7jJj3NDLzlqwsf;
        Thu, 18 Aug 2022 13:26:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1660822006;
        bh=rhb91i9KWKOzYZfR3oDwvTl9+4014LzoFCzFIQlEPYQ=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=qHoGsEq+z4Qqq0YjO6mUVv2I0jG1O0h0iwWg1x7S+bD+PdwF8q/YgB1e8Vovi7Sob
         Aeu7VkX0+Q+wY4rro3EOcA3ShKq+Ohrvthj0LJAWz4cE8eooR2c/Gi5ZGN0+qkI6LI
         WvfMDB3qjv9pwcPoaXVjTkuoH0Zghoj6uQahN/jI=
Message-ID: <997489b1-12e1-5eb0-a531-efe6bf62bbc9@digikod.net>
Date:   Thu, 18 Aug 2022 13:26:44 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
References: <20220814192603.7387-1-gnoack3000@gmail.com>
 <20220814192603.7387-3-gnoack3000@gmail.com>
 <6ed7d884-89cb-546f-db0a-1c16209f1c29@digikod.net> <Yv0ssfnx8BcUf0Lp@nuc>
 <Yv1C/bAD5b5fMgVg@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v4 2/4] selftests/landlock: Selftests for file truncation
 support
In-Reply-To: <Yv1C/bAD5b5fMgVg@nuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 17/08/2022 21:35, Günther Noack wrote:
> On Wed, Aug 17, 2022 at 08:00:17PM +0200, Günther Noack wrote:
>> On Tue, Aug 16, 2022 at 07:08:20PM +0200, Mickaël Salaün wrote:
>>> On 14/08/2022 21:26, Günther Noack wrote:
>>>> +/*
>>>> + * Opens the file and invokes ftruncate(2).
>>>> + *
>>>> + * Returns the errno of ftruncate if ftruncate() fails.
>>>> + * Returns EBADFD if open() or close() fail (should not happen).
>>>> + * Returns 0 if ftruncate(), open() and close() were successful.
>>>> + */
>>>> +static int test_ftruncate(struct __test_metadata *const _metadata,
>>>
>>> _metadata is no longer needed. Same for test_creat().
>>
>> Thanks, well spotted!
>>
>>>
>>>
>>>> +			  const char *const path, int flags)
>>>> +{
>>>> +	int res, err, fd;
>>>> +
>>>> +	fd = open(path, flags | O_CLOEXEC);
>>>> +	if (fd < 0)
>>>> +		return EBADFD;
>>>
>>> Instead of EBADFD, which is a valid open(2) error, you can use ENOSYS and
>>> add a comment explaining that we are not interested by this open(2) error
>>> code but only the ftruncate(2) one because we are sure opening such path is
>>> allowed or because open(2) is already tested before calls to
>>> test_ftruncate().
>>
>> Changed to ENOSYS and added a comment in the code and as function documentation.
>>
>> The explanation follows the reasoning that callers must guarantee that
>> open() and close() will work, in order to test ftruncate() correctly.
>> If open() or close() fail, we return ENOSYS.
>>
>> Technically EBADFD does not get returned by open(2) according to the
>> man page, but I changed it to ENOSYS anyway (EBADF and EBADFD are easy
>> to mix up).
> 
> The more I think about it, the more I feel that test_ftruncate() in its current
> form was a mistake:
> 
>    * In reality, we just care about the ftruncate() result, not about open().
>    * The tests became slightly confusing and asymmetric because some
>      places could call test_ftruncate() while others would call test_open()
>    * Trying open(..., O_RDONLY) + ftruncate() is also confusing in tests,
>      because that never works anyway (ftruncate() only works on writable fds)
> 
> So: I'm contemplating to use a different approach instead:
> 
>    * Open a writable FD for each file *before enforcing Landlock*.
>    * *Then* enforce Landlock (now some of these files can't be opened any more)
>    * Then try ftruncate() with the previously opened file descriptor.
> 
> As a result,
> 
>    * we have some new repetitive but simple code for opening file descriptors
>    * we remove the long version of test_ftruncate() with all its error case
>      complication and replace it with a trivial one that takes an already-opened
>      file descriptor.
> 
> This way, each block in the test now checks the following things:
> 
>    * check truncate(file)
>    * check ftruncate(file_fd) <--- passing the FD!
>    * check open(file, O_RDONLY|O_TRUNC)
>    * check open(file, O_WRONLY|O_TRUNC)
> 
> It's now easy to see in the tests that the result from truncate() and
> ftruncate() is always the same. The complication of worrying whether open()
> works before ftruncate() is also gone (so no more special open() checks needed
> before checking ftruncate()). I removed the testing of ftruncate() on read-only
> file descriptors, because that is forbidden in the ftruncate() manpage anyway
> and always returns EINVAL independent of Landlock.
> 
> I feel that this helps clarify the tests, even if it undoes some of your
> comments about expecting open() to work before ftruncate().
> 
> Does that approach look reasonable to you?
> 
> I might just send you a patch version with that variant I think - this might be
> clearer in code than in my textual description here. :)

The FD from the pre-landlocked state is the right approach, thanks!
