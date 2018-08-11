From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 10 Aug 2018 20:32:04 -0500
Subject: BUG: Mount ignores mount options
In-Reply-To: <20180811003852.GA10463@magnolia> (Darrick J. Wong's message of
	"Fri, 10 Aug 2018 17:38:52 -0700")
References: <20180810153902.GH21087@thunk.org> <87d0uqpba5.fsf@xmission.com>
	<153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
	<22361.1533913891@warthog.procyon.org.uk>
	<28045.1533916438@warthog.procyon.org.uk>
	<20180810161400.GA627@thunk.org>
	<CALCETrXC8Z-q+PzzqMC-McA7UdmFubVcs2dVsT0Dt+GbSqjF5A@mail.gmail.com>
	<20180810204639.GI627@thunk.org> <20180810221234.GC4211@magnolia>
	<20180810235447.GK627@thunk.org> <20180811003852.GA10463@magnolia>
Message-ID: <87zhxtg02z.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

"Darrick J. Wong" <darrick.wong@oracle.com> writes:

> On Fri, Aug 10, 2018 at 07:54:47PM -0400, Theodore Y. Ts'o wrote:

>> The reason why I bring this up here is that in container land, there
>> are those who believe that "container root" should be able to mount
>> file systems, and if the "container root" isn't trusted, the fact that
>> the "container root" can crash the host kernel, or worse, corrupt the
>> host kernel and break out of the container as a result, that would be
>> sad.
>> 
>> I was pretty sure most file system developers are on the same page
>> that allowing untrusted "container roots" the ability to mount
>> arbitrary block device file systems is insanity.
>
> Agreed.

For me I am happy with fuse.  That is sufficient to cover any container
use cases people have.   If anyone comes bugging you for more I will be
happy to push back.

The only thing that containers have to do with this is I wind up
touching a lot of the kernel/user boundary so I get to see a lot of it
and sometimes see weird things.

Eric
