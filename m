From: ebiggers3@gmail.com (Eric Biggers)
Date: Wed, 10 May 2017 21:04:42 -0700
Subject: [RFC 07/10] fscrypt: move to generic async completion
In-Reply-To: <1494075602-5061-8-git-send-email-gilad@benyossef.com>
References: <1494075602-5061-1-git-send-email-gilad@benyossef.com>
	<1494075602-5061-8-git-send-email-gilad@benyossef.com>
Message-ID: <20170511040442.GB2936@zzz>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Gilad,

On Sat, May 06, 2017 at 03:59:56PM +0300, Gilad Ben-Yossef wrote:
>  int fscrypt_do_page_crypto(const struct inode *inode, fscrypt_direction_t rw,
>  			   u64 lblk_num, struct page *src_page,
>  			   struct page *dest_page, unsigned int len,
> @@ -150,7 +135,7 @@ int fscrypt_do_page_crypto(const struct inode *inode, fscrypt_direction_t rw,
>  		u8 padding[FS_XTS_TWEAK_SIZE - sizeof(__le64)];
>  	} xts_tweak;
>  	struct skcipher_request *req = NULL;
> -	DECLARE_FS_COMPLETION_RESULT(ecr);
> +	DECLARE_CRYPTO_WAIT(ecr);
>  	struct scatterlist dst, src;
>  	struct fscrypt_info *ci = inode->i_crypt_info;
>  	struct crypto_skcipher *tfm = ci->ci_ctfm;
> @@ -168,7 +153,7 @@ int fscrypt_do_page_crypto(const struct inode *inode, fscrypt_direction_t rw,
[...]

This patch looks good --- thanks for doing this!  I suggest also renaming 'ecr'
to 'wait' in the places being updated to use crypto_wait, since the name is
obsolete (and was already; it originally stood for "ext4 completion result").

- Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
