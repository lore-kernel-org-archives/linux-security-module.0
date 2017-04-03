From: paul@paul-moore.com (Paul Moore)
Date: Mon, 3 Apr 2017 17:45:54 -0400
Subject: [PATCH] selinux: Fix an uninitialized variable bug
In-Reply-To: <alpine.LRH.2.20.1704031054080.27757@namei.org>
References: <20170331152118.GA8141@mwanda>
	<1490975541.31110.12.camel@tycho.nsa.gov>
	<CAHC9VhT7njoVyHgyiTQhCcvZEYrTE_XZRLxT4+JJPiH3W88AUw@mail.gmail.com>
	<alpine.LRH.2.20.1704031054080.27757@namei.org>
Message-ID: <CAHC9VhQHabPm08bjXgw+nx6X7c6bsBeOc1ZXLFM58nVrWzsh7g@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Apr 2, 2017 at 9:10 PM, James Morris <jmorris@namei.org> wrote:
> On Fri, 31 Mar 2017, Paul Moore wrote:
>
>> On Fri, Mar 31, 2017 at 11:52 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> > On Fri, 2017-03-31 at 18:21 +0300, Dan Carpenter wrote:
>> >> We removed this initialization as a cleanup but it is probably
>> >> required.
>> >>
>> >> The concern is that "nel" can be zero.  I'm not an expert on SELinux
>> >> code but I think it looks possible to write an SELinux policy which
>> >> triggers this bug.  GCC doesn't catch this, but my static checker
>> >> does.
>> >>
>> >> Fixes: 9c312e79d6af ("selinux: Delete an unnecessary variable
>> >> initialisation in range_read()")
>> >> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> >
>> > Nice catch, thanks!
>> >
>> > Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>>
>> Yes, indeed.  Thanks Dan, I should have caught this when merging Markus' patch.
>>
>
> I'd like to reiterate that I generally don't want to accept cleanup
> patches into the security tree from Markus (or indeed from others who
> only do cleanup/whitespace work).
>
> See https://lkml.org/lkml/2017/1/29/172, and please click through and read
> Dan's comments.
>
> All patches carry risks of introducing new bugs, and kernel "cleanup:
> patches generally offer a pretty high cost/benefit ratio.  If such patches
> come from core developers of that code, or from kernel developers with
> experience in *analyzing and fixing* bugs, that's very different.
>
> Paul, please review all of these patches very carefully before sending
> your pull request.

James, I know you don't track SELinux development very closely so I'm
going to give you the benefit of the doubt and assume you haven't
already seen my responses to Markus in his 46 patch thread.  If you
did follow the thread you would have noticed that I rejected several
of his patches as only adding noise/churn, and several more due to
personal preference; those that I did merge, I did review.  I review
every patch that I merge, even the patches from Stephen.  Most of the
patches I merged either fixed up some sizeof(...) calculations, made
better use of the various kmalloc(...) variants, or fixed some
checkpatch.pl reported problem.  The first two types of patches, while
technically noise, do bring value to the kernel by making the code a
bit more robust, and the third, while much less valuable, does bring
some consistency.  I did tell Markus I was merging the checkpatch.pl
fixes begrudgingly and I didn't particularly appreciate those patches;
like Julia in the comments you linked, I tried to suggest Markus find
a more productive way of contributing.

That said, am I disappointed with myself that I didn't catch the bug
Dan found?  Of course I am.  Am I annoyed that the regression was
associated with a stupid, low-value patch?  Of course I am.  I'm very
grateful to Dan that he caught the mistake (thanks again Dan!).

While I understand Dan's move to ban Markus, from a maintainer's
perspective it is easier that way, but I think the better approach is
to encourage Markus to contribute more meaningful patches.  I'm not
going to reject patches simply because of their author, but I do
reject patches that provide little value.  We all started somewhere,
and I bet some of us started with small patches, some of which were
rejected; let's try to remember that when dealing with people like
Markus.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
