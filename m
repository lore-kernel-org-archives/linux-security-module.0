From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Sun, 10 Sep 2017 10:02:42 -0400
Subject: [GIT PULL] Security subsystem updates for 4.14
In-Reply-To: <20170910081047.GA19533@infradead.org>
References: <alpine.LRH.2.21.1709041959220.27950@namei.org>
	<CA+55aFw8wgA+jhBOhnY-TSdbPgiYcrFiipCV=rsS1=GQEN+JgQ@mail.gmail.com>
	<alpine.LRH.2.21.1709081448090.7880@namei.org>
	<20170908070943.GA26549@infradead.org>
	<CA+55aFwMgUJSMQ96XdKnTbn8UsxzHTb8tZQdH40nxDeF7fWObw@mail.gmail.com>
	<20170910081047.GA19533@infradead.org>
Message-ID: <1505052162.3224.64.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, 2017-09-10 at 01:10 -0700, Christoph Hellwig wrote:
> On Fri, Sep 08, 2017 at 10:25:53AM -0700, Linus Torvalds wrote:
> > I don't think anybody actually tests linux-next kernels in any big
> > way, and the automated tests that do get run probably don't run with
> > any integrity checking enabled.
> 
> Well, for the atual IMA deadlock issue I asked Mimi to produce automated
> tests and we get started on it.  I was pretty pissed about the
> assumptions IMA made on the fs, whch weren't documented or automatically
> tested - coming from the XFS background where we want all our features
> to run through automated tests that was just not how I'd expect thing
> to work.
> 
> But now as part of that I messed up the other caller of it, so I
> shouldn't complain too loud..
> 
> That being said - I really hink the certificate loading should not
> even go thorught this whole call path, but use our common helper to
> load a file into a buffer.  Something like the patch below, I'm just
> not sure if the last policy argument is what people want or if we'd need
> to add a new policy type for certificates.

We need to differentiate between policies and x509 certificates. ?In
the policy case, they need to be signed and appraised, while in the
x509 certificate case, the certificate itself is signed so the file
doesn't need to be signed or verified.

> 
> ---
> From 3092ca95dfeff0dbd4e03ae62a51762facb15592 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Sun, 10 Sep 2017 09:49:45 +0200
> Subject: security/digisig: read file using kernel_read_file_from_path
> 
> This avoid using the new integrity_read file operation which requires
> i_rwsem already to be held, and avoids a lot of code duplication and
> call the proper LSM hooks.
> 
> [also constifies the path argument to kernel_read_file_from_path,
> as the callers needs it. Should probably be split into a separate patch]
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/exec.c                      |  2 +-
>  include/linux/fs.h             |  2 +-
>  security/integrity/digsig.c    |  8 ++++---
>  security/integrity/iint.c      | 49 ------------------------------------------
>  security/integrity/integrity.h |  2 --
>  5 files changed, 7 insertions(+), 56 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 01a9fb9d8ac3..957a8ce294af 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -974,7 +974,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>  }
>  EXPORT_SYMBOL_GPL(kernel_read_file);
> 
> -int kernel_read_file_from_path(char *path, void **buf, loff_t *size,
> +int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
>  			       loff_t max_size, enum kernel_read_file_id id)
>  {
>  	struct file *file;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2d0e6748e46e..58855daba1eb 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2791,7 +2791,7 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
>  extern int kernel_read(struct file *, loff_t, char *, unsigned long);
>  extern int kernel_read_file(struct file *, void **, loff_t *, loff_t,
>  			    enum kernel_read_file_id);
> -extern int kernel_read_file_from_path(char *, void **, loff_t *, loff_t,
> +extern int kernel_read_file_from_path(const char *, void **, loff_t *, loff_t,
>  				      enum kernel_read_file_id);
>  extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
>  				    enum kernel_read_file_id);
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 06554c448dce..8112cdeeee3c 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -112,13 +112,15 @@ int __init integrity_init_keyring(const unsigned int id)
>  int __init integrity_load_x509(const unsigned int id, const char *path)
>  {
>  	key_ref_t key;
> -	char *data;
> +	void *data = NULL;
> +	loff_t size;
>  	int rc;
> 
>  	if (!keyring[id])
>  		return -EINVAL;
> 
> -	rc = integrity_read_file(path, &data);
> +	rc = kernel_read_file_from_path(path, data, &size,
> +			0, READING_POLICY);

READING_X509_CERT?

>  	if (rc < 0)
>  		return rc;
> 
> @@ -139,6 +141,6 @@ int __init integrity_load_x509(const unsigned int id, const char *path)
>  			  key_ref_to_ptr(key)->description, path);
>  		key_ref_put(key);
>  	}
> -	kfree(data);
> +	vfree(data);
>  	return 0;
>  }
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 6fc888ca468e..c84e05866052 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -200,55 +200,6 @@ int integrity_kernel_read(struct file *file, loff_t offset,
>  }
> 
>  /*
> - * integrity_read_file - read entire file content into the buffer
> - *
> - * This is function opens a file, allocates the buffer of required
> - * size, read entire file content to the buffer and closes the file
> - *
> - * It is used only by init code.
> - *
> - */
> -int __init integrity_read_file(const char *path, char **data)
> -{
> -	struct file *file;
> -	loff_t size;
> -	char *buf;
> -	int rc = -EINVAL;
> -
> -	if (!path || !*path)
> -		return -EINVAL;
> -
> -	file = filp_open(path, O_RDONLY, 0);
> -	if (IS_ERR(file)) {
> -		rc = PTR_ERR(file);
> -		pr_err("Unable to open file: %s (%d)", path, rc);
> -		return rc;
> -	}
> -
> -	size = i_size_read(file_inode(file));
> -	if (size <= 0)
> -		goto out;
> -
> -	buf = kmalloc(size, GFP_KERNEL);
> -	if (!buf) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> -
> -	rc = integrity_kernel_read(file, 0, buf, size);
> -	if (rc == size) {
> -		*data = buf;
> -	} else {
> -		kfree(buf);
> -		if (rc >= 0)
> -			rc = -EIO;
> -	}
> -out:
> -	fput(file);
> -	return rc;
> -}
> -
> -/*
>   * integrity_load_keys - load integrity keys hook
>   *
>   * Hooks is called from init/main.c:kernel_init_freeable()
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index a53e7e4ab06c..e1bf040fb110 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -120,8 +120,6 @@ struct integrity_iint_cache *integrity_iint_find(struct inode *inode);
>  int integrity_kernel_read(struct file *file, loff_t offset,
>  			  void *addr, unsigned long count);
> 
> -int __init integrity_read_file(const char *path, char **data);
> -
>  #define INTEGRITY_KEYRING_EVM		0
>  #define INTEGRITY_KEYRING_IMA		1
>  #define INTEGRITY_KEYRING_MODULE	2

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
