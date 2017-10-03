From: jmorris@namei.org (James Morris)
Date: Tue, 3 Oct 2017 21:51:35 +1100 (AEDT)
Subject: [PATCH 2/7] FS-Cache: fix dereference of NULL user_key_payload
In-Reply-To: <20170928212602.41744-3-ebiggers3@gmail.com>
References: <20170928212602.41744-1-ebiggers3@gmail.com>
	<20170928212602.41744-3-ebiggers3@gmail.com>
Message-ID: <alpine.LRH.2.21.1710032151220.25033@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 28 Sep 2017, Eric Biggers wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> When the file /proc/fs/fscache/objects (available with
> CONFIG_FSCACHE_OBJECT_LIST=y) is opened, we request a user key with
> description "fscache:objlist", then access its payload.  However, a
> revoked key has a NULL payload, and we failed to check for this.
> request_key() *does* skip revoked keys, but there is still a window
> where the key can be revoked before we access its payload.
> 
> Fix it by checking for a NULL payload, treating it like a key which was
> already revoked at the time it was requested.
> 
> Fixes: 4fbf4291aa15 ("FS-Cache: Allow the current state of all objects to be dumped")
> Cc: <stable@vger.kernel.org>    [v2.6.32+]
> Signed-off-by: Eric Biggers <ebiggers@google.com>


Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
