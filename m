From: miklos@szeredi.hu (Miklos Szeredi)
Date: Mon, 5 Feb 2018 17:12:38 +0100
Subject: [RFC PATCH] ima: force the re-evaluation of files on untrusted
	file systems
In-Reply-To: <1517845858.3050.13.camel@HansenPartnership.com>
References: <1517838054.3736.49.camel@linux.vnet.ibm.com>
	<1517845858.3050.13.camel@HansenPartnership.com>
Message-ID: <CAJfpegtDqsW1PQ3-jkGbLykL_u1WgsTcKYG4N1Hp__K__H3Pqg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Feb 5, 2018 at 4:50 PM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Mon, 2018-02-05 at 08:40 -0500, Mimi Zohar wrote:
>> On filesystems, such as fuse or remote filesystems, that we can not
>> detect or rely on the filesystem to tell us when a file has changed,
>> always re-measure, re-appraise, and/or re-audit the file.
>
> Using the presence or absence of d_revalidate isn't definitive for
> uncacheable appraisals: all stacked filesystems have to implement
> d_revalidate just in case the underlying has it, but it doesn't mean
> their appraisals can't be cached if they're fully built on top of
> traditional filesystems (like they are in the Docker/OCI use case).  I
> think the original flag approach is better.  The only thing stackable
> filesystems argues for is that for them it should probably be a
> superblock flag so it can be per-mount point (depending on overlay
> composition).
>
> d_revalidate() also strikes me as wrong from the semantic point of
> view: it's about whether the path name to inode cache needs re-
> evaluating not whether the underlying inode could change arbitrarily.
>  These are definitely related but not necessarily equivalent concepts.

True.  A more precise indication is whether cache pages have been
invalidated for a certain inode.   Can we used that?  I.e.
invalidate_inode_pages*() calls down into IMA or sets a flags or
whatever to indicate that the file contents might have changed.

Thanks,
Miklos
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
