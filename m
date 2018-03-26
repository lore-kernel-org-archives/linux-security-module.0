From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Mon, 26 Mar 2018 12:18:24 +0300
Subject: [PATCH] security: convert security hooks to use hlist
In-Reply-To: <CAMp4zn8vB8zzh9cc7h2-=t6OyCzOfgGOrQz4y+FuC0Mmnp7ksw@mail.gmail.com>
References: <6f9d93bdf8122230ea53823a07a9d79f0c3fdafe.1521972503.git.sargun@sargun.me>
	<39e2dfa9-8063-1aa5-cd69-5a57d4b8a231@schaufler-ca.com>
	<CAMp4zn8vB8zzh9cc7h2-=t6OyCzOfgGOrQz4y+FuC0Mmnp7ksw@mail.gmail.com>
Message-ID: <288b8438-3931-616c-2955-0d06b3a23517@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 25/03/18 23:02, Sargun Dhillon wrote:
> 
> 
> On Sun, Mar 25, 2018 at 10:12 AM, Casey Schaufler
> <casey at schaufler-ca.com <mailto:casey@schaufler-ca.com>> wrote:
> 
>     On 3/25/2018 3:08 AM, Sargun Dhillon wrote:
>     > This changes security_hook_heads to use hlist_heads instead of
>     > the circular doubly-linked list heads. This should cut down
>     > the size of the struct by about half.
> 
>     My only concern is with the possibility of making
>     security modules dynamically loadable and unloadable.
>     I know that Tetsuo is still hoping to have that, and
>     I have worked to make sure that we don't do anything
>     to preclude it. If he has no objection, I don't either.

I couldn't really object, even if I wanted to :-)
I'm still working to try to get pmalloc accepted, but assuming that it
eventually succeedes, what would be the approach to make the unloading
possible?

The idea of pmalloc vs hooks was to write protect the hooks, to avoid
sidestepping any security module, by wiping away its registered handle.

If the hook is write protected, how does the unloading work?

Is it going to be mutually exclusive? Like: write protect for increased
robustness or allow unloading for other cases (ex: development).

Initially I understood that there was an interest in loading *in a later
phase* additional modules, for example as result of modification to the
command line or maybe as result of modprobe from userspace, and then
protecting the whole thing.

But that seems to me very different from unloading.

--
igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
