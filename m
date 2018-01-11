From: ebiggers3@gmail.com (Eric Biggers)
Date: Wed, 10 Jan 2018 20:00:22 -0800
Subject: [PATCH 1/3] encrypted-keys: add fscrypt format support
In-Reply-To: <20180110124418.24385-1-git@andred.net>
References: <20180110124418.24385-1-git@andred.net>
Message-ID: <20180111040022.GA943@zzz.localdomain>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Andr?,

On Wed, Jan 10, 2018 at 12:44:16PM +0000, Andr? Draszik wrote:
> This is heavily based on commit 79a73d188726
> ("encrypted-keys: add ecryptfs format support").
> 
> The 'encrypted' key type defines its own payload format which contains a
> symmetric key randomly generated that cannot be used directly by the
> fscrypt subsystem, because it instead expects an fscrypt_key structure.
> 
> This patch introduces the new format 'fscrypt' that allows to store an
> fscrypt_key structure inside the encrypted key payload containing
> a randomly generated symmetric key, as the same for the format 'default'
> and 'ecryptfs'.
> 
> More details about the usage of encrypted keys with the fscrypt
> subsystem can be found in the file 'Documentation/security/keys/fscrypt.rst'.
> 

I don't think a new encrypted-key format is needed.  fscrypt really only needs
the raw key.  The fact that fscrypt uses 'struct fscrypt_key' for the key
payloads is a mistake, given that a raw byte array would work just as well.  In
particular, the 'size' field is redundant, since a 'struct key' knows the size
of its payload; and the 'mode' field is meaningless and therefore is ignored.
Also since there are no reserved fields the only way we would ever be able to
add anything new to 'struct fscrypt_key' is by doing a hack where we put an
invalid value in the 'size' field, which would be ugly.

Also I have proposed an fscrypt ioctl to add keys to a filesystem-level keyring,
and it doesn't use 'struct fscrypt_key' at all:
https://marc.info/?l=linux-fsdevel&m=150879505206393

So I think you should just use the "default" encrypted-key format, where the
payload is just the raw key.  fscrypt can very easily be updated to work with
such keys.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
