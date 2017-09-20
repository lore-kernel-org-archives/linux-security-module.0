From: paul@paul-moore.com (Paul Moore)
Date: Wed, 20 Sep 2017 12:09:16 -0400
Subject: [PATCH] selinux: Use kmem_cache for hashtab_node
In-Reply-To: <CAHC9VhTfvOLw-v8ZbEhCkKn3FR9C5SzPS6kdz3w=fWxEGBAF1w@mail.gmail.com>
References: <1504691419-26972-1-git-send-email-kyeongdon.kim@lge.com>
	<CAHC9VhTfvOLw-v8ZbEhCkKn3FR9C5SzPS6kdz3w=fWxEGBAF1w@mail.gmail.com>
Message-ID: <CAHC9VhSowi09zxj6bihnr3qLzt4MEsL3fY7y3Dcj50v8VNc0xg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Sep 7, 2017 at 7:18 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Sep 6, 2017 at 5:50 AM, Kyeongdon Kim <kyeongdon.kim@lge.com> wrote:
>> During random test as own device to check slub account,
>> we found some slack memory from hashtab_node(kmalloc-64).
>> By using kzalloc(), middle of test result like below:
>> allocated size 240768
>> request size 45144
>> slack size 195624
>> allocation count 3762
>>
>> So, we want to use kmem_cache_zalloc() and that
>> can reduce memory size 52byte(slack size/alloc count) per each struct.
>>
>> Signed-off-by: Kyeongdon Kim <kyeongdon.kim@lge.com>
>> ---
>>  security/selinux/ss/hashtab.c  | 17 +++++++++++++++--
>>  security/selinux/ss/hashtab.h  |  4 ++++
>>  security/selinux/ss/services.c |  4 ++++
>>  3 files changed, 23 insertions(+), 2 deletions(-)
>
> This seems reasonale, but I'm going to refrain from merging this until
> after the merge window closes.

I just merged this into selinux/next, thanks for your patience.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
