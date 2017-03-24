From: casey@schaufler-ca.com (Casey Schaufler)
Date: Fri, 24 Mar 2017 08:35:00 -0700
Subject: [PATCH 1/2] LSM: Initialize security_hook_heads upon registration.
In-Reply-To: <alpine.LRH.2.20.1703241453530.26984@namei.org>
References: <1490179580-7065-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<alpine.LRH.2.20.1703241453530.26984@namei.org>
Message-ID: <dbaf35cb-f6d9-2837-4e30-17e33d8449e8@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 3/23/2017 8:54 PM, James Morris wrote:
> On Wed, 22 Mar 2017, Tetsuo Handa wrote:
>
>> "struct security_hook_heads" is an array of "struct list_head"
>> where elements can be initialized just before registration.
>>
>> We might introduce different "struct security_hook_heads" for built-in
>> LSM modules and dynamically loadable LSM modules when we start allowing
>> dynamically loadable LSM modules. But even if we decide to use different
>> lists, there is no need to waste 350+ lines for initialization. Let's
>> initialize "struct security_hook_heads" just before registration.
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Nice cleanup, applied to
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next
>
> with edited changelog.

Sigh. All that beautiful keyboard work for naught. ;)

I hope we don't start getting complaints from automatic
code checkers and kernel newbees because of the assumption
that a struct with a bunch of the same elements is the
same as an array. Or worse, the compiler for some quirky
architecture. I suppose if that happens we can always
put it back.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
