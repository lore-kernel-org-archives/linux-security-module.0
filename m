From: tytso@mit.edu (Theodore Ts'o)
Date: Fri, 8 Sep 2017 18:38:06 -0400
Subject: [GIT PULL] Security subsystem updates for 4.14
In-Reply-To: <alpine.LRH.2.21.1709081448090.7880@namei.org>
References: <alpine.LRH.2.21.1709041959220.27950@namei.org>
	<CA+55aFw8wgA+jhBOhnY-TSdbPgiYcrFiipCV=rsS1=GQEN+JgQ@mail.gmail.com>
	<alpine.LRH.2.21.1709081448090.7880@namei.org>
Message-ID: <20170908223806.7yv6eohtsispwgas@thunk.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Sep 08, 2017 at 02:48:51PM +1000, James Morris wrote:
> 
> Mimi and Christoph worked together on this over several iterations -- I'll 
> let them respond.

Mimi --- we should chat next week in LA.  I've been working on a
design internally at work which proposes a generic VFS-layer library
(ala how fscrypt in fs/crypto works) which provides data integrity
using per-file Merkle trees.

The goals of this design:

   * Simplicity; for ease in security review and upstream review and
     acceptance
   * Useful for multiple use cases.  It is *not* Android/APK specific,
     and indeed can be used for other things
      * A better way of providing Linux IMA/EVM support for immutable
        files by moving the verification from time-of-open to
        time-of-readpage.  (This significantly reduces the performance
	impact, since we don't need to lock down the file while the kernel
	needs to run SHA1 on potentially gigabytes worth of file data.)
      * Most use cases for file-level checksums are for files that
        don?t change over time (e.g., for Video, Audio, Backup files,
        etc.)  This allows us to provide a cheap and efficient way to
        provide checksum protect against storage-level corruption
        fairly easily.  So by supporting both SHA and CRC-32, we can
	make this feature useful for more than just the security heads.  :-)
   * Like the encryption/fscrypt feature, most of the code to this
     feature can be in a VFS-level library, with minimal hooks needed
     to those file systems (ext4, f2fs) that wish to provide this
     functionality.

					- Ted
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
