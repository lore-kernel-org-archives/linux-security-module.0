From: jmorris@namei.org (James Morris)
Date: Tue, 3 Oct 2017 22:03:46 +1100 (AEDT)
Subject: [PATCH 6/7] ecryptfs: fix out-of-bounds read of key payload
In-Reply-To: <20170928212602.41744-7-ebiggers3@gmail.com>
References: <20170928212602.41744-1-ebiggers3@gmail.com>
	<20170928212602.41744-7-ebiggers3@gmail.com>
Message-ID: <alpine.LRH.2.21.1710032201430.25033@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 28 Sep 2017, Eric Biggers wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> eCryptfs blindly casts the user-supplied key payload to a
> 'struct ecryptfs_auth_tok' without validating that the payload does, in
> fact, have the size of a 'struct ecryptfs_auth_tok'.  Fix it.
> 
> Fixes: 237fead61998 ("[PATCH] ecryptfs: fs/Makefile and fs/Kconfig")
> Cc: <stable@vger.kernel.org>    [v2.6.19+]
> Signed-off-by: Eric Biggers <ebiggers@google.com>


Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
