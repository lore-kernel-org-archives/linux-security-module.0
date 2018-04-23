From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Mon, 23 Apr 2018 09:25:09 -0400
Subject: [PATCH 04/24] VFS: Add LSM hooks for filesystem context [ver #7]
In-Reply-To: <3232.1524238511@warthog.procyon.org.uk>
References: <CAHC9VhQhaBNBFwAXJ4TxKO56UTcwb_LcT2G8LwNxdxOD96tTvA@mail.gmail.com>
	<152414466005.23902.12967974041384198114.stgit@warthog.procyon.org.uk>
	<152414469006.23902.8132059438921850399.stgit@warthog.procyon.org.uk>
	<3232.1524238511@warthog.procyon.org.uk>
Message-ID: <aca7e68c-022b-47ac-c249-59e042d431e8@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 04/20/2018 11:35 AM, David Howells wrote:
> Paul Moore <paul@paul-moore.com> wrote:
> 
>> Adding the SELinux mailing list to the CC line; in the future please
>> include the SELinux mailing list on patches like this.  It would also
>> be very helpful to include "selinux" somewhere in the subject line
>> when the patch is predominately SELinux related (much like you did for
>> the other LSMs in this patchset).
> 
> I should probably evict the SELinux bits into their own patch since the point
> of this patch is the LSM hooks, not specifically SELinux's implementation
> thereof.
> 
>> I can't say I've digested all of this yet, but what SELinux testing
>> have you done with this patchset?
> 
> Using the fsopen()/fsmount() syscalls, these hooks will be made use of, say
> for NFS (which I haven't included in this list).  Even sys_mount() will make
> use of them a bit, so just booting the system does that.
> 
> Note that for SELinux these hooks don't change very much except how the
> parameters are handled.  It doesn't actually change the checks that are made -
> at least, not yet.  There are some additional syscalls under consideration
> (such as the ability to pick a live mounted filesystem into a context) that
> might require additional permits.

Neither fsopen() nor fscontext_fs_write() appear to perform any kind of up-front
permission checking (DAC or MAC), although some security hooks may be ultimately called
to allocate structures, parse security options, etc.  Is there a reason not apply a may_mount()
or similar check up front?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
