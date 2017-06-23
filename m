From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 23 Jun 2017 12:37:43 -0500
Subject: [PATCH 0/3] Enable namespaced file capabilities
In-Reply-To: <1498176787.7636.11.camel@HansenPartnership.com> (James
	Bottomley's message of "Thu, 22 Jun 2017 17:13:07 -0700")
References: <1498157989-11814-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1498174161.7636.4.camel@HansenPartnership.com>
	<20170622233619.GC2894@mail.hallyn.com>
	<1498176787.7636.11.camel@HansenPartnership.com>
Message-ID: <87efuaip08.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> On Thu, 2017-06-22 at 18:36 -0500, Serge E. Hallyn wrote:
>> Quoting James Bottomley (James.Bottomley at HansenPartnership.com):
>> > On Thu, 2017-06-22 at 14:59 -0400, Stefan Berger wrote:
>> > > This series of patches primary goal is to enable file 
>> > > capabilities in user namespaces without affecting the file 
>> > > capabilities that are effective on the host. This is to prevent 
>> > > that any unprivileged user on the host maps his own uid to root 
>> > > in a private namespace, writes the xattr, and executes the file
>> > > with privilege on the host.
>> > > 
>> > > We achieve this goal by writing extended attributes with a 
>> > > different name when a user namespace is used. If for example the 
>> > > root user in a user namespace writes the security.capability 
>> > > xattr, the name of the xattr that is actually written is encoded 
>> > > as security.capability at uid=1000 for root mapped to uid 1000 on 
>> > > the host. When listing the xattrs on the host, the existing
>> > > security.capability as well as the security.capability at uid=1000 
>> > > will be shown. Inside the namespace only 'security.capability', 
>> > > with the value of security.capability at uid=1000, is visible.
>> > 
>> > I'm a bit bothered by the @uid=1000 suffix.  What if I want to use 
>> > this capability but am dynamically mapping the namespaces (i.e. I 
>> > know I want unprivileged root, but I'm going to dynamically select 
>> > the range to map based on what's currently available on the 
>> > orchestration system).  If we stick with the @uid=X suffix, then 
>> > dynamic mapping won't work because X is potentially different each 
>> > time and there'll be a name mismatch in my xattrs.  Why not just 
>> > make the suffix @uid, which means if root is mapped to any 
>> > unprivileged uid then we pick this up otherwise we go with the
>> > unsuffixed property?
>> > 
>> > As far as I can see there's no real advantage to discriminating 
>> > userns specific xattrs based on where root is mapped to, unless 
>> > there's a use case I'm missing?
>> 
>> Yes, the use case is: to allow root in the container to set the
>> privilege itself, without endangering any resources not owned by
>> that root.
>
> OK, so you envisage the same filesystem being mounted in different user
> namespaces and being able to see their own value for the xattr.  It
> still seems a bit weird that they'd be able to change file contents and
> have that seen by the other userns but not xattrs.

When you dynamically talk about selecting a range based what is
currently available in an orchestration system I don't know exactly what
you mean.  If it is something like what adduser does, assigning a
container a persistent association with uids and gids, that makes sense
to me.  If it is picking an association just for the lifetime of the
conainer processes it makes me nervous.

Fundamentally storage is persistent and writing data into it is
persistent.

Which means that when dealing with storage we need to make things safe
by default and not depend upon an assumption that the container tools
carefully keeps files separate from each other.

>From previous conversations I am happy with and generally expect only a
capability xattr per file.

Even with one xattr of any type there is something appealing about
putting the logic that limits that xattr to a namespace in the name.  As
that is trivially backwards compatible.  As that does not require reving
the on disk file format based upon containers.

>> As you say a @uid to say "any unprivileged userns" might be useful.
>> The implication is that root on the host doesn't trust the image
>> enough to write a real global file capability, but trusts it enough
>> to 'endanger' all containers on the host.  If that's the case, I have
>> no objection to adding this as a feature.
>
> Yes, precisely.  The filesystem is certified as permitted to override
> the xattr whatever unprivileged mapping for root is in place.
>
> How would we effect the switch?  I suppose some global flag because I
> can't see we'd be mixing use cases in a physical system.

Mixing use cases in a filesystem almost always happens.  At least if we
are talking an ordinary multi-user system.  Multi-user systems are rarer
than they once were because machines are cheap, and security is hard,
but that should be what we are designing for.  Anything else is just
asking for trouble.

James when you talk about a global flag and mixing use cases in a
physical system it sounds a lot like you are talking about a base
filesystem for shiftfs.

My gut feel is that if this gets down to something like the shiftfs use
case.  I would assume either everything is shifted slightly so that all
uids are say shifted by 100,000 even the capability names of the
capability xattrs.  So that shiftfs or some part of the vfs would need
to shift the names of the xattrs as well.

Certainly I expect filesystems that are mounted with s_user_ns !=
&init_user_ns to be shifting the names of the security xattrs when
queried from &init_user_ns if we go with general design.

Eric

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
