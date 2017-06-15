From: rdunlap@infradead.org (Randy Dunlap)
Date: Wed, 14 Jun 2017 18:53:21 -0700
Subject: Updated docs
In-Reply-To: <11943.1497481089@warthog.procyon.org.uk>
References: <1cafb81d-7e72-bc1c-56fa-7ca171dca578@infradead.org>
	<149745330648.10897.9605870130502083184.stgit@warthog.procyon.org.uk>
	<149745339478.10897.13154531822843514976.stgit@warthog.procyon.org.uk>
	<11943.1497481089@warthog.procyon.org.uk>
Message-ID: <ea73b244-bb11-f95e-78ff-d6abeda50f16@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Thanks for the update.  I have 2 more things for you to consider.

a.  In multiple places, there is something like "return 0 when no error
and return a negative error code otherwise."

I would say "or return a negative error code otherwise."

b. (below)

> ===========================
> FILESYSTEM CONTEXT SECURITY
> ===========================
> 
> The filesystem context contains a security pointer that the LSMs can use for
> building up a security context for the superblock to be mounted.  There are a
> number of operations used by the new mount code for this purpose:
> 
>  (*) int security_fs_context_alloc(struct fs_context *fc,
> 				   struct super_block *src_sb);
> 
>      Called to initialise fc->security (which is preset to NULL) and allocate
>      any resources needed.  It should return 0 on success and a negative error
>      code on failure.
> 
>      src_sb is non-NULL in the case of a remount (FS_CONTEXT_FOR_REMOUNT) in
>      which case it indicates the superblock to be remounted or in the case of a
>      submount (FS_CONTEXT_FOR_SUBMOUNT) in which case it indicates the parent
>      superblock.
> 

-ETOOMANYCASES

Maybe:
	For a remount (FS_CONTEXT_FOR_REMOUNT), src_sb is non-NULL and indicates
	the superblock to be remounted.  For a submount (FS_CONTEXT_FOR_SUBMOUNT),
	src_sb is also non-NULL and represents the parent superblock.


cheers.

-- 
~Randy
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
