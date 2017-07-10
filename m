From: paul@paul-moore.com (Paul Moore)
Date: Mon, 10 Jul 2017 18:25:15 -0400
Subject: [PATCH] selinux: Assign proper class to PF_UNIX/SOCK_RAW sockets
In-Reply-To: <CAHC9VhQMFw9BAimnnwM9Zv1Vp28Edm7FSdFCiOEpXUX4go8gWQ@mail.gmail.com>
References: <20170619213348.2970-1-aranea@aixah.de>
	<CAHC9VhQsVa+0LgqFyguqq0bhXOz7mrbJfXy-+rJjY53xnCkixg@mail.gmail.com>
	<1497989063.12069.18.camel@tycho.nsa.gov>
	<CAHC9VhTz2uFMAcYBCph1=XVtib1owCuSi+c1stQsxkymDt_BJQ@mail.gmail.com>
	<20170621114812.6aa3f62e@vega.skynet.aixah.de>
	<CAHC9VhQMFw9BAimnnwM9Zv1Vp28Edm7FSdFCiOEpXUX4go8gWQ@mail.gmail.com>
Message-ID: <CAHC9VhRs-yiuM=O4r6P9uHo0YFZ6QLjr50vHo1h0wsF_P5oD1A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jun 21, 2017 at 3:04 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Jun 21, 2017 at 5:48 AM, Luis Ressel <aranea@aixah.de> wrote:
>> On Tue, 20 Jun 2017 17:43:38 -0400
>> Paul Moore <paul@paul-moore.com> wrote:
>>
>>> Considering where we are at with respect to the merge window, let's
>>> shelve this for now and I'll merge it after the next merge window
>>> closes.  In all likelihood I'll be sending selinux/next up to James
>>> later this week and I'd like this to sit in linux-next for longer than
>>> a few days.
>>
>> That means the change will land in 4.14 at the earliest, right? (Just
>> out of curiosity.)
>
> That's correct.  We are currently working towards a v4.12 release in
> Linus' tree, the upcoming merge window will be for v4.13, and things
> merged into selinux/next after that merge window will be for v4.14.
>
>> By the way, refpolicy only grants "socket" permissions to a handful of
>> domains, all of which also have the corresponding "unix_dgram_socket"
>> permissions. The fedora policy does the same (according to Stephen);
>> this only leaves custom policies to be potentially affected by this
>> change.
>
> While custom policies are definitely in the minority, we still need to
> do out best not to break them without warning.
>
>> Given that the SOCK_RAW->SOCK_DGRAM translation is obscure enough not to
>> be documented anywhere outside the kernel sources, I doubt there are
>> many users of it, anyway.
>
> You very well may be right, I just felt that such a change requires
> more than a week in the selinux/next tree.
>
> Thank you for your patch, it's in the queue and I'll be merging it
> into the selinux/next branch in a few weeks.

With all of the SELinux things for v4.13 upstream, I went ahead and
merged this patch into selinux/next.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
