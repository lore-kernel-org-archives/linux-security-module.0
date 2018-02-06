From: ebiggers@google.com (Eric Biggers)
Date: Mon, 5 Feb 2018 17:54:35 -0800
Subject: [PATCH 1/1] KEYS: encrypted: fix buffer overread in
	valid_master_desc()
In-Reply-To: <20180205200246.12253-1-jinqian@android.com>
References: <20180205200246.12253-1-jinqian@android.com>
Message-ID: <20180206015435.GA91829@google.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Feb 05, 2018 at 12:02:46PM -0800, Jin Qian wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> commit 794b4bc292f5d31739d89c0202c54e7dc9bc3add upstream
> 
> With the 'encrypted' key type it was possible for userspace to provide a
> data blob ending with a master key description shorter than expected,
> e.g. 'keyctl add encrypted desc "new x" @s'.  When validating such a
> master key description, validate_master_desc() could read beyond the end
> of the buffer.  Fix this by using strncmp() instead of memcmp().  [Also
> clean up the code to deduplicate some logic.]
> 
> Cc: stable at vger.kernel.org
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: James Morris <james.l.morris@oracle.com>
> Signed-off-by: Jin Qian <jinqian@android.com>
> ---
>  security/keys/encrypted-keys/encrypted.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 

Hi Jin, see Documentation/stable_kernel_rules.txt -- patches for stable should
be sent To: stable at vger.kernel.org (and generally with a lighter Cc: list,
unless it's a complicated backport), and you need to say which kernel version(s)
it should be applied to.  Also for upstream commits that cherry-pick cleanly,
such as this one, you don't need to send an actual patch but rather just request
that it be applied.  The reason it should be applied is helpful too; in this
case the commit fixes a bug that caused a KASAN warning.

Thanks!

- Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
