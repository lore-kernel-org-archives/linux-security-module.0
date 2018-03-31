From: keescook@chromium.org (Kees Cook)
Date: Sat, 31 Mar 2018 07:38:54 -0700
Subject: [PATCH v3 1/1] security: Add mechanism to safely (un)load LSMs
	after boot time
In-Reply-To: <CAMp4zn96Maw8LrdOrdv-fCEZUdPi+kYQVROURcSxOQfiUUyCNA@mail.gmail.com>
References: <cover.1522357211.git.sargun@sargun.me>
	<5240a81494bbe5be5651379cd9828bda34d764e2.1522357211.git.sargun@sargun.me>
	<3292bbb3-7c9d-f18d-05f3-9b69b3cac922@schaufler-ca.com>
	<20180330023331.GA10833@ircssh-2.c.rugged-nimbus-611.internal>
	<8b015e9e-dccb-aefd-f5b2-c66eed3c6815@schaufler-ca.com>
	<CAMp4zn96Maw8LrdOrdv-fCEZUdPi+kYQVROURcSxOQfiUUyCNA@mail.gmail.com>
Message-ID: <CAGXu5jLn6c=mr5VC=fUP4LUD18EuPAYyDkYTrv_rpxSuxAz--A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Mar 30, 2018 at 11:16 PM, Sargun Dhillon <sargun@sargun.me> wrote:
> On Fri, Mar 30, 2018 at 2:39 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>  static struct security_hook_list     null_hooks[SECURITY_HOOK_COUNT];
>>> -#define HAS_FUNC(SHL, FUNC)  (SHL->hook.FUNC)
>>> +DEFINE_STATIC_SRCU(security_hook_srcu);
>>> +
>>> +static inline bool is_null_hook(struct security_hook_list *shl)
>>> +{
>>> +     union {
>>> +             void *cb_ptr;
>>> +             union security_list_options slo;
>>> +     } hook_options;
>>> +
>>> +     hook_options.slo = shl->hook;
>>> +     return !hook_options.cb_ptr;
>>> +}
>>
>> I like the HAS_FUNC() approach better.
>
>  Just curious, why? I personally prefer small static inline functions
> over macros, if possible.

Generally speaking, small static inline functions are better since
they provide type-checking. In this case, though, it looks like you're
just doing a cast, but with a union. Why isn't this just:

return !!((uintptr_t)shl->hook)

?

Though the security_list_options union exists for callback type
checking, so really, having HAS_FUNC() with the explicit function
you're interested in creates a bit of self-documenting code (even if
it always resolves to the above test).

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
