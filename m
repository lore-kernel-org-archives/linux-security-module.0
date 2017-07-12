From: bfields@fieldses.org (Bruce Fields)
Date: Wed, 12 Jul 2017 10:35:04 -0400
Subject: [PATCH v2] integrity: track mtime in addition to i_version for
	assessment
In-Reply-To: <1499862021.3904.23.camel@linux.vnet.ibm.com>
References: <20170707140530.30452-1-jlayton@kernel.org>
	<1499446642.4967.3.camel@poochiereds.net>
	<1499448249.3130.143.camel@linux.vnet.ibm.com>
	<1499449777.4852.3.camel@redhat.com>
	<1499457558.3130.173.camel@linux.vnet.ibm.com>
	<1499459718.4852.8.camel@redhat.com>
	<1499688612.6034.111.camel@linux.vnet.ibm.com>
	<1499822252.26839.5.camel@redhat.com>
	<1499862021.3904.23.camel@linux.vnet.ibm.com>
Message-ID: <20170712143504.GB31196@fieldses.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jul 12, 2017 at 08:20:21AM -0400, Mimi Zohar wrote:
> Right, currently the only way of knowing is by looking at the IMA
> measurement list to see if modified files are re-measured or, as you
> said, by looking at the code.

Who's actually using this, and do they do any kind of checks, or
document the filesystem-specific limitations?

--b.

> 
> I started working on adding logging/audit messages, but have not yet
> posted them. ?A very preliminary set of patches is available from
> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.
> git/next-log-iversion-experimental.
> 
> 2745b7be961a ima: indicate possibly missing file measurements or verification
> 0c81a8c56153 security: define new LSM sb_post_new_mount hook
> 
> Mimi
> 
> > 
> > ext4 only provides a working i_version counter when you mount with "-o
> > i_version", so it's trivial to tell there. xfs and btrfs also have
> > functional i_version counter implementations, but there is no such
> > mount option for them (it's always on there). NFSv4 and AFS can provide
> > one too (as they're supplied by the server).
> > 
> > Suppose I want to use IMA on something else (say, ubifs). How do I know
> > whether I'm only going to get "initial file integrity verification and
> > measurement" or whether it'll be updated after being written?
> > 
> > Now, I happen to know that ubifs does _not_ support the i_version
> > counter because I can poke through the kernel sources and tell, but how
> > is Joe Random Linux User to know this?
> > 
> > Does that not matter for some reason? Is there a whitelist of
> > filesystems being maintained in some userland package?
> > 
> > Sorry if it seems like I'm being dense here, but I really just don't
> > understand how we can allow this code to be so cavalier about using the
> > i_version counter without taking steps to ensure that it actually does
> > a damned thing at all.
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
