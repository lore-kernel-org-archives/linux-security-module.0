From: keescook@chromium.org (Kees Cook)
Date: Mon, 27 Nov 2017 15:04:32 -0800
Subject: [PATCH v5 next 0/5] Improve Module autoloading infrastructure
In-Reply-To: <alpine.LFD.2.20.1711280924350.11830@localhost>
References: <1511803118-2552-1-git-send-email-tixxdz@gmail.com>
	<CA+55aFwFEzEU9ci=mFZprjzrhG0P0XgXgqhBSWSv7vFWEAw6rQ@mail.gmail.com>
	<20171128.041426.801732093971324601.davem@davemloft.net>
	<alpine.LFD.2.20.1711280924350.11830@localhost>
Message-ID: <CAGXu5j+YPMZk=TuioD216F5kiqfWTNZcNzpjwOiZRnAfbimhpg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Nov 27, 2017 at 2:31 PM, James Morris <james.l.morris@oracle.com> wrote:
> On Tue, 28 Nov 2017, David Miller wrote:
>
>> From: Linus Torvalds <torvalds@linux-foundation.org>
>> Date: Mon, 27 Nov 2017 10:41:30 -0800
>>
>> > What are the real life use-cases for normal users having modules
>> > auto-load?
>>
>> User opens SCTP socket, SCTP protocol module loads.
>>
>> People build test cases via namespaces, and in that namespaces normal
>> users can setup virtual tunnel devices themselves, and those configure
>> operations can bring the tunnel module in.
>
> What about implementing a white list of modules which are able to be
> loaded by unprivileged users?
>
> Then, Linus' solution would look something like:
>
>         va_start(args, fmt);
>         ret = vsnprintf(module_name, MODULE_NAME_LEN, fmt, args);
>         va_end(args);
>
>         if (WARN_ON_ONCE(!capable(CAP_SYS_MODULE) ||
>                          !capable(CAP_SYS_ADMIN) ||
>                          !capable(CAP_NET_ADMIN) ||
>                          !unprivileged_autoload(module_name)))
>                 return -EPERM;

We have some of this already with the module prefixes. Doing this
per-module would need to be exported to userspace, I think. It'd be
way too fragile sitting in the kernel.

To control this via modprobe, we'd need to expand modprobe to include
the user that is trying to load the module (so it can reason about who
is doing it), and then teach modprobe about that so the policy could
be exported to userspace.

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
