From: casey@schaufler-ca.com (Casey Schaufler)
Date: Mon, 30 Apr 2018 12:37:27 -0700
Subject: [PATCH v7 0/6] Safe LSM (un)loading, and immutable hooks
In-Reply-To: <CAMp4zn-qREqj0ewUs7dupLT0C_v6Ctz6Sre9QgTJHceGu7vZpw@mail.gmail.com>
References: <CAMp4zn85hvdT2b0qsKWqxyC-5m=Y414akM1wjVH5qrZpgLE-bw@mail.gmail.com>
	<CAMp4zn-Y333bSX2EX-5M+-Mu1m9EeeAP203v=HJOFLPVmoUpNA@mail.gmail.com>
	<201804272225.DAC82348.OFtSVOJOHLFMQF@I-love.SAKURA.ne.jp>
	<CAMp4zn-9UdDNzJJhz1=kGp1=4kLXk=v8TVwWhpyNQVyyo=Xr6w@mail.gmail.com>
	<a27ccccf-7436-5049-8554-79638d3bdbb2@schaufler-ca.com>
	<201804292049.CJG18734.FJMOOHVOFFQtSL@I-love.SAKURA.ne.jp>
	<0cf314e6-af7d-7e93-4249-944431202327@schaufler-ca.com>
	<CAMp4zn9Mfm6Spq1S+u-ny+Sf8Umn29+SWTWLbOrMm7_PPfXeTw@mail.gmail.com>
	<3638568b-bb10-b0f7-d54f-6f2055db07aa@schaufler-ca.com>
	<CAMp4zn-qREqj0ewUs7dupLT0C_v6Ctz6Sre9QgTJHceGu7vZpw@mail.gmail.com>
Message-ID: <d3fec11d-7143-b8dd-4e91-656056d1bc03@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 4/30/2018 11:25 AM, Sargun Dhillon wrote:
> On Mon, Apr 30, 2018 at 9:46 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 4/30/2018 9:11 AM, Sargun Dhillon wrote:
>>> On Sun, Apr 29, 2018 at 2:23 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 4/29/2018 4:49 AM, Tetsuo Handa wrote:
>>>>> Casey Schaufler wrote:
>>>>>> I think that we're on the verge of having a major merge collision.
>>>>> I think that the reason of major merge collision is that your patchset is
>>>>> too big to review.
>>>> My patch set is large because it has to address all of the
>>>> aspects of multiple modules running on the system before some
>>>> important members of the community will look at it seriously.
>>>>
>>>>>   > That's a lot of overhead. The smaller the patches, the more work
>>>>>   > required to make the patch set. You're right that the current patches
>>>>>   > are too big. Moving forward I will be providing smaller, easier to
>>>>>   > deal with patches. The sheer overhead of rebaseing a large patch set
>>>>>   > has slowed down the development considerably. Minions. What I need are
>>>>>   > minions.
>>>>>
>>>>> You are holding the global lock for patchset which you did not get response.
>>>>> If you agree with breaking into smaller patches, we will be able to solve
>>>>> the major merge collision.
>>>> I will be presenting the set of smaller patches once I finish merging
>>>> them into 4.18. It's a bigger jobs than usual because of the change from
>>>> lists to hlists, the significant changes to AppArmor and the early stages
>>>> of SELinux namespacing. I hope to have it done mid week, but the changes
>>>> need to get tested, and there are lots of configurations involved.
>>>>
>>>> I am perfectly amenable to the patches going in in logical stages.
>>>> In fact, that is what I would recommend.
>>>>
>>> I guess I'm just a little bit frustrated, because, in my mind, some of
>>> my patches provide immediate value, and are ready to be reviewed, and
>>> or respun. Testuo did a good job reviewing 1-5, and I think that if
>>> those are his only issues, then we're good to go.
>>> I've:
>>> 1) Do safe hook loading for sane security modules (those that don't
>>> try to overload major hooks), without compromising the security of
>>> other hooks
>>> 2) Suggested a whitelist of major hooks to prevent insane modules from
>>> being loaded
>>>
>>> If Casey's patches land, we can just not do (2), and we're good to go.
>> I understand your frustration. As much as I would like to
>> avoid having the stacking work take any longer than it already
>> has (I *do* have a boatload of other stuff I want to get done)
>> I suggest that if you can get consensus that the lkm-based
>> security module work should be accepted that you go forward and
>> get it in. I know that I have at least one major round of review
>> before the stacking can really be seriously considered. I knew
>> the job was dangerous when I took it.
>>
>>
> Curious, consensus from whom? I thought you owned this part of the tree.

James Morris owns the security tree in general, while various
other people own the module sub-trees. Consensus would require
at least James, John Johansen (AppArmor), Paul Moore (SELinux,
Audit and Netlabel), Tetsuo Handa (TOMOYO), Kees Cook (Yama, LoadPin),
Serge Hallyn (Capabilities), Mimi Zohar (Integrity), David Howells
(Keys) and Myself (Smack). Beyond that, there will have to be
buy in from many vocal developers, not the least of which is Linus.

I don't own this part of the tree, but I have fixed it up a bit.

>>>>>> ...
>>>
>>
>
> Do you know where Landlock is in terms of getting merged?

Probably behind the general module stacking. :-o
It's a prime example of a major module that would
be used in conjunction with other major modules.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
