From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 01 Oct 2017 17:06:16 -0500
Subject: [RFC PATCH 3/3] fs: detect that the i_rwsem has already been
	taken exclusively
In-Reply-To: <CA+55aFx726wT4VprN-sHm6s8Q_PV_VjhTBC4goEbMcerYU1Tig@mail.gmail.com>
	(Linus Torvalds's message of "Sat, 30 Sep 2017 18:56:59 -0700")
References: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1506602373-4799-4-git-send-email-zohar@linux.vnet.ibm.com>
	<20170928220215.GC15067@dastard>
	<CA+55aFy-kDL5jQb0q2gHkcmhAwMatEf8YPx8Gh=yGp_VMoVxQA@mail.gmail.com>
	<1506643967.5691.46.camel@linux.vnet.ibm.com>
	<CA+55aFxqpTbC=sZXrbJ0x1OD-UA1NkejuR_s5LCazp+7yzvi3Q@mail.gmail.com>
	<1506649980.5691.100.camel@linux.vnet.ibm.com>
	<CA+55aFzZXBBn+HgLD_4C6DgpSiOMAP2WzuGPWRUkEXZJuz+QBQ@mail.gmail.com>
	<87mv5blki7.fsf@xmission.com>
	<CA+55aFx726wT4VprN-sHm6s8Q_PV_VjhTBC4goEbMcerYU1Tig@mail.gmail.com>
Message-ID: <87shf2jzfr.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sep 30, 2017 18:33, "Eric W. Biederman" <ebiederm@xmission.com> wrote:.
>
>  That would require a task_work or another kind of work callback so that
>  the writes of the xattr are not synchronous with the vfs callback
>  correct?
>
> No, why?
>
> You should just invalidate the IMA on xattr write or other operations that make the measurement invalid. You only need the inner
> lock.
>
> Why are you guys making up all these things just to make it complicated?

I am not trying to make things complicated I am just trying to
understand the conversation.

Unless I misread something it was being pointed out there are some vfs
operations today on which ima writes an ima xattr as a side effect.  And
those operations hold the i_sem.  So perhaps I am misunderstanding
things or writing the ima xattr needs to happen at some point.  Which
implies something like queued work.

But perhaps I a misunderstanding the conversation and ima.  I frequenly
misunderstand ima.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
