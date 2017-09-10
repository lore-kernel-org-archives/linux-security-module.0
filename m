From: tytso@mit.edu (Theodore Ts'o)
Date: Sun, 10 Sep 2017 08:17:19 -0400
Subject: [GIT PULL] Security subsystem updates for 4.14
In-Reply-To: <1505027603.3224.56.camel@linux.vnet.ibm.com>
References: <alpine.LRH.2.21.1709041959220.27950@namei.org>
	<CA+55aFw8wgA+jhBOhnY-TSdbPgiYcrFiipCV=rsS1=GQEN+JgQ@mail.gmail.com>
	<alpine.LRH.2.21.1709081448090.7880@namei.org>
	<20170908223806.7yv6eohtsispwgas@thunk.org>
	<1505027603.3224.56.camel@linux.vnet.ibm.com>
Message-ID: <20170910121719.lurdadausg5bbqkd@thunk.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Sep 10, 2017 at 03:13:23AM -0400, Mimi Zohar wrote:
> 
> From a file integrity perspective this would be interesting, but that
> only addresses IMA-appraisal, not IMA-integrity or IMA-audit. ?We
> would still need to calculate the file hash to be included in the
> measurement list and used for auditing.
> 
> Have you done any work on protecting the directory information itself
> (eg. file names) using Merkle trees?

I have not, because the problem that I was trying to address was
primarily concerned with immutable files.  I did do some brainstorming
about adding the filename into the data integrity header to prevent
someone who had direct access to the flash exchanging the inode
numbers for "rm" and "ls", such that if you had a policy which
required that all ELF executables be signed, that a trickster couldn't
cause the user to run "rm" when they meant to run, say, "ls", just for
the lulz.  :-)

But that would break various symlink or hardlinks that are
legitimately present (e.g., /sbin/mkfs.ext[234] being a link to
/sbin/mke2fs), and if the adversary can carry out a chip-off attack
against your root file system, (a) it's not clear how much this would
help, and (b) this is really what dm-verity is for.

The main security problem I was looking at is one where the system
image is already protected using dm-verity, but you might have (for
example) some APK files which are downloaded once and stored in some
shared-user directory hierarchy (so file-based encryption can't even
provide pretend integrity protection), integrity checked at download
time, and never checked again.  Adding some kind of per-file Merkle
tree might be useful in that particular use case.

Cheers,

						- Ted

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
