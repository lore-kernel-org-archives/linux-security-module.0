From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Sun, 01 Oct 2017 08:08:11 -0400
Subject: [RFC PATCH 3/3] fs: detect that the i_rwsem has already been
	taken exclusively
In-Reply-To: <CA+55aFx726wT4VprN-sHm6s8Q_PV_VjhTBC4goEbMcerYU1Tig@mail.gmail.com>
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
Message-ID: <1506859691.5691.211.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 2017-09-30 at 18:56 -0700, Linus Torvalds wrote:
> On Sep 30, 2017 18:33, "Eric W. Biederman" <ebiederm@xmission.com> wrote:.
> 
> 
> That would require a task_work or another kind of work callback so that
> the writes of the xattr are not synchronous with the vfs callback
> correct?
> 
> 
> No, why?
> 
> You should just invalidate the IMA on xattr write or other operations that
> make the measurement invalid. You only need the inner lock.

Right, re-introducing the iint->mutex and a new i_generation field in
the iint struct with a separate set of locks should work. ?It will be
reset if the file metadata changes (eg. setxattr, chown, chmod).

(We need i_generation for namespacing IMA as well.)

thanks,

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
