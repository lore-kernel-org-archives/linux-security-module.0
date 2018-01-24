From: serge@hallyn.com (Serge E. Hallyn)
Date: Wed, 24 Jan 2018 11:53:14 -0600
Subject: [RFC PATCH v3 2/2] ima: force re-appraisal on filesystems with
	FS_IMA_NO_CACHE
In-Reply-To: <20180122222422.GB18882@ubuntu-xps13>
References: <20180122162452.8756-1-alban@kinvolk.io>
	<20180122162452.8756-3-alban@kinvolk.io>
	<20180122222422.GB18882@ubuntu-xps13>
Message-ID: <20180124175314.GB29811@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Seth Forshee (seth.forshee at canonical.com):
> On Mon, Jan 22, 2018 at 05:24:52PM +0100, Alban Crequy wrote:
> > From: Alban Crequy <alban@kinvolk.io>
> > 
> > This patch forces files to be re-measured, re-appraised and re-audited
> > on file systems with the feature flag FS_IMA_NO_CACHE. In that way,
> > cached integrity results won't be used.
> > 
> > How to test this:
> > 
> > The test I did was using a patched version of the memfs FUSE driver
> > [1][2] and two very simple "hello-world" programs [4] (prog1 prints
> > "hello world: 1" and prog2 prints "hello world: 2").
> > 
> > I copy prog1 and prog2 in the fuse-memfs mount point, execute them and
> > check the sha1 hash in
> > "/sys/kernel/security/ima/ascii_runtime_measurements".
> > 
> > My patch on the memfs FUSE driver added a backdoor command to serve
> > prog1 when the kernel asks for prog2 or vice-versa. In this way, I can
> > exec prog1 and get it to print "hello world: 2" without ever replacing
> > the file via the VFS, so the kernel is not aware of the change.
> > 
> > The test was done using the branch "alban/fuse-flag-ima-nocache-v3" [3].
> > 
> > Step by step test procedure:
> > 
> > 1. Mount the memfs FUSE using [2]:
> > rm -f  /tmp/memfs-switch* ; memfs -L DEBUG  /mnt/memfs
> > 
> > 2. Copy prog1 and prog2 using [4]
> > cp prog1 /mnt/memfs/prog1
> > cp prog2 /mnt/memfs/prog2
> > 
> > 3. Lookup the files and let the FUSE driver to keep the handles open:
> > dd if=/mnt/memfs/prog1 bs=1 | (read -n 1 x ; sleep 3600 ) &
> > dd if=/mnt/memfs/prog2 bs=1 | (read -n 1 x ; sleep 3600 ) &
> > 
> > 4. Check the 2 programs work correctly:
> > $ /mnt/memfs/prog1
> > hello world: 1
> > $ /mnt/memfs/prog2
> > hello world: 2
> > 
> > 5. Check the measurements for prog1 and prog2:
> > $ sudo cat /sys/kernel/security/ima/ascii_runtime_measurements \
> >                 | grep /mnt/memfs/prog
> > 10 [...] ima-ng sha1:ac14c9268cd2[...] /mnt/memfs/prog1
> > 10 [...] ima-ng sha1:799cb5d1e06d[...] /mnt/memfs/prog2
> > 
> > 6. Use the backdoor command in my patched memfs to redirect file
> > operations on file handle 3 to file handle 2:
> > rm -f  /tmp/memfs-switch* ; touch /tmp/memfs-switch-3-2
> > 
> > 7. Check how the FUSE driver serves different content for the files:
> > $ /mnt/memfs/prog1
> > hello world: 2
> > $ /mnt/memfs/prog2
> > hello world: 2
> > 
> > 8. Check the measurements:
> > sudo cat /sys/kernel/security/ima/ascii_runtime_measurements \
> >                 | grep /mnt/memfs/prog
> > 
> > Without the patch, there are no new measurements, despite the FUSE
> > driver having served different executables.
> > 
> > With the patch, I can see additional measurements for prog1 and prog2
> > with the hashes reversed when the FUSE driver served the alternative
> > content.
> > 
> > [1] https://github.com/bbengfort/memfs
> > [2] https://github.com/kinvolk/memfs/commits/alban/switch-files
> > [3] https://github.com/kinvolk/linux/commits/alban/fuse-flag-ima-nocache-v3
> > [4] https://github.com/kinvolk/fuse-userns-patches/commit/cf1f5750cab0
> > 
> > Cc: linux-kernel at vger.kernel.org
> > Cc: linux-integrity at vger.kernel.org
> > Cc: linux-security-module at vger.kernel.org
> > Cc: linux-fsdevel at vger.kernel.org
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> > Cc: James Morris <james.l.morris@oracle.com>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: Seth Forshee <seth.forshee@canonical.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Tested-by: Dongsu Park <dongsu@kinvolk.io>
> > Signed-off-by: Alban Crequy <alban@kinvolk.io>
> 
> I like this approach as it doesn't require any IMA policy changes to be
> effective. I'm not sure about the flag name (in my mind it would
> describe the fs property and not be specifically giving instructions to
> IMA), but if others are happy with it I won't complain.

Purely internal name at least, so if we come up with a better name
we can trivially change it.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
