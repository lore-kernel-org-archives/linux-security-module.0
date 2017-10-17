From: ebiggers@google.com (Eric Biggers)
Date: Tue, 17 Oct 2017 16:23:16 -0700
Subject: [GIT PULL] KEYS: Fixes
In-Reply-To: <866.1508281053@warthog.procyon.org.uk>
References: <866.1508281053@warthog.procyon.org.uk>
Message-ID: <20171017232316.GA29388@google.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

+Cc tyhicks at canonical.com

Hi David,

On Tue, Oct 17, 2017 at 11:57:33PM +0100, David Howells wrote:
> 
>  (2) Fix some ecryptfs bits.

Sorry for the late notice, but just looking at it again I think the patch
"ecryptfs: fix out-of-bounds read of key payload" is broken because the
->private_key is of variable-length.  See
ecryptfs_add_key_module_key_to_keyring() in ecryptfs-utils.

So can you please drop the following two patches:

	ecryptfs: fix out-of-bounds read of key payload
	ecryptfs: move key payload accessor functions into keystore.c

I'll fix them and try to get Tyler Hicks to take them through the ecryptfs tree
later instead.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
