From: miklos@szeredi.hu (Miklos Szeredi)
Date: Mon, 13 Aug 2018 14:54:02 +0200
Subject: BUG: Mount ignores mount options
In-Reply-To: <20180811015815.GD6515@ZenIV.linux.org.uk>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
	<87d0uqpba5.fsf@xmission.com>
	<20180810151606.GA6515@ZenIV.linux.org.uk>
	<87pnypiufr.fsf@xmission.com>
	<20180811015815.GD6515@ZenIV.linux.org.uk>
Message-ID: <CAJfpegtuf7=sEMJhaiQj8e31uvFzckRSHH4Bf9nTNn4gxV10Ow@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Aug 11, 2018 at 3:58 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:

>  What I'm saying is that the entire superblock-creating
> machinery - all of it - is nothing but library helpers.  With the
> decision of when/how/if they are to be used being down to filesystem
> driver.  Your "first mount"/"additional mount" simply do not map
> to anything universally applicable.

Why so?   (Note: using the "mount" terminology here is fundamentally
broken to start with, mounts have nothing to do with this...
Filesystem instance is better word.)

You bring up NFS as an example, but creating and/or reusing an nfs
client instance connected to a certain server is certainly a clear and
well defined concept.

The question becomes:  does it make  sense to generalize this concept
and export it to userspace with the new API?

You know the Plan 9 fs interface much better, but to me it looks like
there's a separate namespace for filesystem instances, and the mount
command just refers to such an instance.  So there's no comparing of
options or any such horror, just the need to explicitly instantiate a
new instance when necessary.  Doesn't sound very difficult to
implement in the new API.

Thanks,
Miklos
