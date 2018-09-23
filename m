From: keescook@chromium.org (Kees Cook)
Date: Sat, 22 Sep 2018 19:43:36 -0700
Subject: [PATCH v4 00/19] LSM: Module stacking for SARA and Landlock
In-Reply-To: <680e6e16-0890-8304-0e8e-6c58966813b5@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
	<CAGXu5jK=+FuL+JiSxcHy0i9Ppha=BQYdJW5zvbm1Redbo12wmw@mail.gmail.com>
	<680e6e16-0890-8304-0e8e-6c58966813b5@schaufler-ca.com>
Message-ID: <CAGXu5j+7FpFDNuOowdHzJ5RXgfETQMv=Fe-EU1gWo+nWK+goZA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Sep 22, 2018 at 9:38 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/21/2018 8:02 PM, Kees Cook wrote:
>> On Fri, Sep 21, 2018 at 4:59 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> v4: Finer granularity in the patches and other
>>>     cleanups suggested by Kees Cook.
>>>     Removed dead code created by the removal of SELinux
>>>     credential blob poisoning.
>> Thanks for the splitting, this really does make it easier to review
>> (at least for me). I think this looks really good, though obviously
>> I'd like to refactor it slightly on top of my series. :)
>
> Whichever goes on top is fine with me. What's one
> more patch set merge, after all?
>
>> One additional thought I had was about the blobs allocations: some are
>> separate kmem caches, and some are kmalloc. I'm thinking it might make
>> sense to use separate kmem caches for two reasons:
>
> I had seriously considered doing that. I can't see any reason
> not to. It's something that could be done at any time, and with
> all the other things that had to change it just didn't get in.

Yup; that is an easy future change. Not needed now!

>
>> - they're going to always be the same size and are regularly
>> allocated/freed, so it may offer a performance benefit.
>>
>> - they're explicitly not supposed to be exposed to userspace, so
>> hardened usercopy would protect them if they were not kmalloc()ed.
>>
>> I'm excited about getting this landed!
>
> Soon. Real soon. I hope. I would very much like for
> someone from the SELinux camp to chime in, especially on
> the selinux_is_enabled() removal.

Agreed.

> On a somewhat related note, I will be out for the first three
> weeks of October, returning just in time for the Linux Security
> Summit in Edinburgh. My connectivity will be severely limited.
> I don't expect to accomplish anything while I'm out.

If you're okay with it, I can help with changes while you're out -- I
want to try to rebase it on my tree and see how it looks anyway. :)

-Kees

-- 
Kees Cook
Pixel Security
