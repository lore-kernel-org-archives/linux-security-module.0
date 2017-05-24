From: john.johansen@canonical.com (John Johansen)
Date: Wed, 24 May 2017 13:14:19 -0700
Subject: [PATCH 3/3] apparmor: virtualize the policy/ directory
In-Reply-To: <CAGXu5j+zjx5WKC62eEj1zDpQ4Lpq4g8GnqAA5MNP+B6DZL0UHg@mail.gmail.com>
References: <20170511024625.13887-1-john.johansen@canonical.com>
	<20170511024625.13887-4-john.johansen@canonical.com>
	<CAGXu5j+zjx5WKC62eEj1zDpQ4Lpq4g8GnqAA5MNP+B6DZL0UHg@mail.gmail.com>
Message-ID: <a44a00cd-4a29-7766-9b86-187dd28ecc24@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 05/24/2017 12:38 PM, Kees Cook wrote:
> On Wed, May 10, 2017 at 7:46 PM, John Johansen
> <john.johansen@canonical.com> wrote:
>> virtualize the apparmor policy/ directory so that the current namespace
>> affects what part of policy is seen. This is done by
>>
>>  * creating a new apparmorfs filesystem
>>  * creating a magic symlink from securityfs to the correct apparmorfs
>>    file in the tree (similar to nsfs use).
>>
>> apparmor fs data and fns also get renamed some to help indicate where
>> they are used
>>
>>   aafs - special magic apparmorfs
>>   aa_sfs - for fns/data that go into securityfs
>>   aa_fs - for fns/data that may be used in the either of aafs or securityfs
>>
>> Signed-off-by: John Johansen <john.johansen@canonical.com>
>> Reviewed-by: Seth Arnold <seth.arnold@canonical.com>
> 
> This all looks fine to me. If you do a v2 of these patches, it might
> make sense to split up some of the logical changes here. For example,
> have one patch that does the renamings but no code changes. Then add
> the new fs, and finally integrate the new fs. That might make it
> easier to review. Regardless:
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
Okay, thanks will do.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
