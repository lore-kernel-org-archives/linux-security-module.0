From: paul@paul-moore.com (Paul Moore)
Date: Mon, 25 Sep 2017 06:32:53 -0400
Subject: Security updates for v4.15 and beyond
In-Reply-To: <alpine.LRH.2.21.1709251450150.30951@namei.org>
References: <alpine.LRH.2.21.1709241454480.3941@namei.org>
	<5b63c120-5116-1e77-d090-331d2ae3aa8e@schaufler-ca.com>
	<alpine.LRH.2.21.1709251450150.30951@namei.org>
Message-ID: <CAHC9VhQR=-0OLsRkP5Knk8_HLqBfEKjBvdnu6E4idSikJOt7dw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Sep 25, 2017 at 12:59 AM, James Morris <jmorris@namei.org> wrote:
> On Sun, 24 Sep 2017, Casey Schaufler wrote:
>> On 9/23/2017 10:00 PM, James Morris wrote:
>> > <snip>
>> >
>> > I plan on maintaining a separate branch for TPM (and other security
>> > subsystems) from now on.
>>
>> Can you tell us how you expect this to work? I know
>> there was discussion about this at the Security Summit.
>> We need to get whatever needs doing lined up if we're
>> going to make 4.15 happen smoothly.
>
> I'll post a more detailed and general update in a few days when I'm back
> in Sydney, but briefly, send me a pull request against my next-general
> branch, which replaces the 'next' branch.  I'll sync that to -rc2 after
> this email.
>
> I'll fetch your branch into my next-smack branch, which will track
> next-general.
>
> All of these subsystem branches and next-general will be merged into
> next-testing, for use by Stephen Rothwell for linux-next, and any other
> general testing which may be done.
>
> When the merge window opens, I'll merge the subsystem branches into
> next-for-linus for him to pull.  If all is going well, this will be the
> same as next-testing.  If there are problems in any of the branches, they
> can be left out of next-for-linus until they're resolved.
>
> Linus can then pull from that to get everything at once, or pull individual
> branches as he sees fit.
>
> In summary: track my next-general branch instead of 'next', and your
> workflow is otherwise unchanged.
>
> How does that sound?

Considering Linus' comments about him preferring individual branches,
I'm questioning the value in going through the linux-security tree; at
least for the larger, frequently updated LSMs; there is likely still
value in terms of convenience for the smaller, more static pieces
(e.g. capabilities, Yama, etc.).  I know there is the argument about
cross-LSM changes, but I can speak from experience (the SELinux next
branch feeds directly into the linux-next tree) that this tends not to
be a large problem.  I worry more about breakage caused by failed
interactions with the network stack than I do with other LSMs.  Yes,
there is the stacking work, and that will definitely have an impact,
but I think we can all agree that changes like this are going to be
rather rare, and I think we can also agree that the stacking work is
going to require a good deal of cross-LSM coordination regardless of
how the trees are organized.

>From what Linus has said, and done, during the last merge window, I
suspect the "next-for-linus" branch is a waste of time, he would
prefer to pull from the individual branches and if he is pulling from
the individual subsystem branches, why not just pull from the
individual subsystem trees?  Help me understand the value, because
right now all I can see is an extra hop and another place where things
could fail.  As for linux-next, last time I spoke to them about it
(which was admittedly many years ago) they preferred to pull directly
from the subsystem trees; I know SELinux feeds directly into
linux-next, and I believe a few other LSMs do the same.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
