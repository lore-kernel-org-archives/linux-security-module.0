From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 30 Sep 2017 20:33:36 -0500
Subject: [RFC PATCH 3/3] fs: detect that the i_rwsem has already been
	taken exclusively
In-Reply-To: <CA+55aFzZXBBn+HgLD_4C6DgpSiOMAP2WzuGPWRUkEXZJuz+QBQ@mail.gmail.com>
	(Linus Torvalds's message of "Thu, 28 Sep 2017 20:26:15 -0700")
References: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1506602373-4799-4-git-send-email-zohar@linux.vnet.ibm.com>
	<20170928220215.GC15067@dastard>
	<CA+55aFy-kDL5jQb0q2gHkcmhAwMatEf8YPx8Gh=yGp_VMoVxQA@mail.gmail.com>
	<1506643967.5691.46.camel@linux.vnet.ibm.com>
	<CA+55aFxqpTbC=sZXrbJ0x1OD-UA1NkejuR_s5LCazp+7yzvi3Q@mail.gmail.com>
	<1506649980.5691.100.camel@linux.vnet.ibm.com>
	<CA+55aFzZXBBn+HgLD_4C6DgpSiOMAP2WzuGPWRUkEXZJuz+QBQ@mail.gmail.com>
Message-ID: <87mv5blki7.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Sep 28, 2017 at 6:53 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>>
>> The locking issue isn't with validating the file hash, but with the
>> setxattr, chmod, chown syscalls.  Each of these syscalls takes the
>> i_rwsem exclusively before IMA (or EVM) is called.
>
> Read my email again.
>
>> In setxattr, chmod, chown syscalls, IMA (and EVM) are called after the
>> i_rwsem is already taken.  So the locking would be:
>>
>> lock: i_rwsem
>> lock: iint->mutex
>
> No.
>
> Two locks. One inner, one outer. Only the actual ones that calculates
> the hash would take the outer one. Read my email.

That would require a task_work or another kind of work callback so that
the writes of the xattr are not synchronous with the vfs callback
correct?

Eric

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
