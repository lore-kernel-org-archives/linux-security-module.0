From: rob@landley.net (Rob Landley)
Date: Wed, 7 Mar 2018 10:51:36 -0600
Subject: [PATCH v3 15/15] selinux: delay sid population for rootfs till
	init is complete
In-Reply-To: <1519152994.14218.15.camel@tycho.nsa.gov>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
	<1518813234-5874-19-git-send-email-takondra@cisco.com>
	<1519152994.14218.15.camel@tycho.nsa.gov>
Message-ID: <d23913a5-2a18-4d2a-60ae-bfa1ba8aaa0c@landley.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 02/20/2018 12:56 PM, Stephen Smalley wrote:
> On Fri, 2018-02-16 at 20:33 +0000, Taras Kondratiuk wrote:
>> From: Victor Kamensky <kamensky@cisco.com>
>>
>> With initramfs cpio format that supports extended attributes
>> we need to skip sid population on sys_lsetxattr call from
>> initramfs for rootfs if security server is not initialized yet.
>>
>> Otherwise callback in selinux_inode_post_setxattr will try to
>> translate give security.selinux label into sid context and since
>> security server is not available yet inode will receive default
>> sid (typically kernel_t). Note that in the same time proper
>> label will be stored in inode xattrs. Later, since inode sid
>> would be already populated system will never look back at
>> actual xattrs. But if we skip sid population for rootfs and
>> we have policy that direct use of xattrs for rootfs, proper
>> sid will be filled in from extended attributes one node is
>> accessed and server is initialized.
>>
>> Note new DELAYAFTERINIT_MNT super block flag is introduced
>> to only mark rootfs for such behavior. For other types of
>> tmpfs original logic is still used.
> 
> (cc selinux maintainers)
> 
> Wondering if we shouldn't just do this always, for all filesystem
> types.  Also, I think this should likely also be done in
> selinux_inode_setsecurity() for consistency.

I don't understand what selinux thinks it's doing here.

Initramfs is special because it's populated early, ideally early enough drivers
can load their firmware out of it. This is guaranteed to be before any processes
have launched, before any other filesystems have been mounted. I'm surprised
selinux is trying to do anything this early because A) what is there for it to
do, B) where did it get a ruleset?

This isn't really a mount flag, this is a "the selinux subsystem isn't
functionally initialized yet" flag. We haven't launched init. In a modular
system the module probably isn't loaded. There are no processes, and the only
files anywhere are the ones we're in the process of extracting. What's there
fore selinux to do?

When a filesystem is mounted, none of these cached selinux "we already looked at
the xattrs" inode fields are populated yet, correct? It can figure that out when
something accesses the file and do it then, so the point is _not_ doing this now
and thus not cacheing the wrong info. That's what the mount flag is doing,
telling selinux "not yet". So why does selinux not already _know_ "not yet"?

Why doesn't load_policy flush the cache of the old default contexts? What
happens if you mount an ext2 root and then init reads a dozen files before it
gets to the load_policy? Do those doesn't files have bad default contexts
forever now?

Where does the selinux ruleset come from during the cpio extract? Was it
hardwired into the driver? It certainly didn't come out of a file, and it wasn't
a process that loaded it. Why is selinux trying to evaluate and cache the
security context of files before it has any rules? (It has xattr annotations,
but they have no _meaning_ without rules...?

Confused,

Rob
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
