From: jmorris@namei.org (James Morris)
Date: Tue, 3 Oct 2017 22:05:05 +1100 (AEDT)
Subject: [PATCH 7/7] ecryptfs: move key payload accessor functions into
	keystore.c
In-Reply-To: <20170928212602.41744-8-ebiggers3@gmail.com>
References: <20170928212602.41744-1-ebiggers3@gmail.com>
	<20170928212602.41744-8-ebiggers3@gmail.com>
Message-ID: <alpine.LRH.2.21.1710032204010.25033@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 28 Sep 2017, Eric Biggers wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> As experience has shown, accessing the 'struct key' payload is very
> error-prone, since we need to hold the key semaphore and properly
> validate everything.  Fortunately eCryptfs only does it from one place,
> in ecryptfs_verify_auth_tok_from_key() in keystore.c.  Therefore, move
> the payload accessor functions like ecryptfs_get_key_payload_data() out
> of ecryptfs_kernel.h and into keystore.c so that people might be less
> tempted to use them directly.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/ecryptfs/ecryptfs_kernel.h | 60 -------------------------------------------
>  fs/ecryptfs/keystore.c        | 60 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 60 deletions(-)

Ok, I should have started at this patch :)

Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
