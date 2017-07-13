From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 13 Jul 2017 16:12:37 -0500
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <20170713194842.GB4895@mail.hallyn.com> (Serge E. Hallyn's
	message of "Thu, 13 Jul 2017 14:48:42 -0500")
References: <87mv89iy7q.fsf@xmission.com>
	<20170712170346.GA17974@mail.hallyn.com> <877ezdgsey.fsf@xmission.com>
	<74664cc8-bc3e-75d6-5892-f8934404349f@linux.vnet.ibm.com>
	<20170713011554.xwmrgkzfwnibvgcu@thunk.org>
	<87y3rscz9j.fsf@xmission.com>
	<20170713164012.brj2flnkaaks2oci@thunk.org>
	<87k23cb6os.fsf@xmission.com>
	<847ccb2a-30c0-a94c-df6f-091c8901eaa0@linux.vnet.ibm.com>
	<87bmoo8bxb.fsf@xmission.com> <20170713194842.GB4895@mail.hallyn.com>
Message-ID: <87mv886ny2.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

"Serge E. Hallyn" <serge@hallyn.com> writes:

> Quoting Eric W. Biederman (ebiederm at xmission.com):
>> Stefan Berger <stefanb@linux.vnet.ibm.com> writes:
>> 
>> > On 07/13/2017 01:14 PM, Eric W. Biederman wrote:
>> >> Theodore Ts'o <tytso@mit.edu> writes:
>> >>
>> >>> On Thu, Jul 13, 2017 at 07:11:36AM -0500, Eric W. Biederman wrote:
>> >>>> The concise summary:
>> >>>>
>> >>>> Today we have the xattr security.capable that holds a set of
>> >>>> capabilities that an application gains when executed.  AKA setuid root exec
>> >>>> without actually being setuid root.
>> >>>>
>> >>>> User namespaces have the concept of capabilities that are not global but
>> >>>> are limited to their user namespace.  We do not currently have
>> >>>> filesystem support for this concept.
>> >>> So correct me if I am wrong; in general, there will only be one
>> >>> variant of the form:
>> >>>
>> >>>     security.foo at uid=15000
>> >>>
>> >>> It's not like there will be:
>> >>>
>> >>>     security.foo at uid=1000
>> >>>     security.foo at uid=2000
>> >>>
>> >>> Except.... if you have an Distribution root directory which is shared
>> >>> by many containers, you would need to put the xattrs in the overlay
>> >>> inodes.  Worse, each time you launch a new container, with a new
>> >>> subuid allocation, you will have to iterate over all files with
>> >>> capabilities and do a copy-up operations on the xattrs in overlayfs.
>> >>> So that's actually a bit of a disaster.
>> >>>
>> >>> So for distribution overlays, you will need to do things a different
>> >>> way, which is to map the distro subdirectory so you know that the
>> >>> capability with the global uid 0 should be used for the container
>> >>> "root" uid, right?
>> >>>
>> >>> So this hack of using security.foo at uid=1000 is *only* useful when the
>> >>> subcontainer root wants to create the privileged executable.  You
>> >>> still have to do things the other way.
>> >>>
>> >>> So can we make perhaps the assertion that *either*:
>> >>>
>> >>>     security.foo
>> >>>
>> >>> exists, *or*
>> >>>
>> >>>     security.foo at uid=BAR
>> >>>
>> >>> exists, but never both?  And there BAR is exclusive to only one
>> >>> instances?
>> >>>
>> >>> Otherwise, I suspect that the architecture is going to turn around and
>> >>> bite us in the *ss eventually, because someone will want to do
>> >>> something crazy and the solution will not be scalable.
>> >> Yep.  That is what it looks like from here.
>> >>
>> >> Which is why I asked the question about scalability of the xattr
>> >> implementations.  It looks like trying to accomodate the general
>> >> case just gets us in trouble, and sets unrealistic expectations.
>> >>
>> >> Which strongly suggests that Serge's previous version that
>> >> just reved the format of security.capable so that a uid field could
>> >> be added is likely to be the better approach.
>> >>
>> >> I want to see what Serge and Stefan have to say but the case looks
>> >> pretty clear cut at the moment.
>
> I'm fine with that.  Now, we'll be doing the enforcement at xattr
> write time, meaning someone *can* come up with an fs image with >1
> such xattrs.  Which is *fine*, I believe, it won't break anything
> security-wise, and our goal is only to stop users from thinking it
> is legitimate two write multiple such xattrs, so that they don't later
> bug the fs folks like Ted saying "hey why can't I write 1000 of these,
> I think that's a bug."
>
> So at xattr write time,
>
> 	1. if there is already an xattr, and it is either the global
> 	non-namespaced xattr, or it has kuid=X where X is the kuid
> 	mapped to root in a parent of the container, then we refuse
> 	the write
> 	2. if there is already an xattr, and it is for a kuid=X where
> 	X is mapped into the container, then we overwrite the existing
> 	xattr.
>
> At read/use time, we use the rules we have now.
>
> Does that seem reasonable?

That sounds like it would keep us to one xattr of any given type so yes.

It occurs to me while I am writing this that this is also important
for ima/evm.  There is an xattr that has a hash of all of the other
security relevant xattrs.   Without a limit on the number of xattrs
calculating that security xattr could become time prohibitive.


Eric

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
