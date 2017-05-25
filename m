From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 25 May 2017 11:18:22 -0700
Subject: [PATCH 3/5] Add the ability to lock down access to the running
	kernel image
In-Reply-To: <19783.1495695202@warthog.procyon.org.uk>
References: <80bdc6c9-004b-800f-ffd0-4b5ebf8cdeba@schaufler-ca.com>
	<149563711758.9419.11406612723056598045.stgit@warthog.procyon.org.uk>
	<149563714531.9419.16811189348445249219.stgit@warthog.procyon.org.uk>
	<19783.1495695202@warthog.procyon.org.uk>
Message-ID: <fa6647c3-baff-d9e9-8ffe-89042b2a553d@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 5/24/2017 11:53 PM, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>>> +#ifdef CONFIG_LOCK_DOWN_KERNEL
>>> +extern bool kernel_is_locked_down(void);
>>> +#else
>>> +static inline bool kernel_is_locked_down(void)
>> Should this be a bool or an int? I can imagine that someone is going to want
>> various different degrees of lock down for kernels. As an int you could
>> return a bitmap indicating which features were locked. This would allow
>> additional things to be locked down without changing the interface.
> At the moment it makes no difference, since the return value is only ever
> passed directly to an if-statement.
>
> Also, do you have an idea as to how is should be divided up?

You called out five distinct features in 0/5, so how about
a bit for each of those?

Actually, I don't care which way you go. The current code works
for me. I am just concerned that the granularity fiends might come
around later.


>
> There aren't so many cases, at least not yet, that they can't be fixed up,
> perhaps with a coccinelle script.
>
> David
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
