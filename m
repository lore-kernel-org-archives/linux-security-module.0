From: dmitry.kasatkin@gmail.com (Dmitry Kasatkin)
Date: Tue, 22 Aug 2017 12:24:40 +0300
Subject: [Linux-ima-devel] [PATCH v4 1/5] ima: always measure and audit
	files in policy
In-Reply-To: <1501075375-29469-2-git-send-email-zohar@linux.vnet.ibm.com>
References: <1501075375-29469-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1501075375-29469-2-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <CACE9dm-zy0RpWNLn4EqLKU0y_JicL5wiZs3STjQA9NnZp98jHw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jul 26, 2017 at 4:22 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> All files matching a "measure" rule must be included in the IMA
> measurement list, even when the file hash cannot be calculated.
> Similarly, all files matching an "audit" rule must be audited, even when
> the file hash can not be calculated.
>
> The file data hash field contained in the IMA measurement list template
> data will contain 0's instead of the actual file hash digest.
>
> Mimi Zohar <zohar@linux.vnet.ibm.com>
>
> ---
> Changelog v4:
> - Based on both -EBADF and -EINVAL
> - clean up ima_collect_measurement()
>
>  security/integrity/ima/ima_api.c  | 58 +++++++++++++++++++++++----------------
>  security/integrity/ima/ima_main.c |  4 +--
>  2 files changed, 37 insertions(+), 25 deletions(-)
>
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index c2edba8de35e..bbf3ba8bbb09 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -199,37 +199,49 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>         struct inode *inode = file_inode(file);
>         const char *filename = file->f_path.dentry->d_name.name;
>         int result = 0;
> +       int length;
> +       void *tmpbuf;
> +       u64 i_version;
>         struct {
>                 struct ima_digest_data hdr;
>                 char digest[IMA_MAX_DIGEST_SIZE];
>         } hash;
>
> -       if (!(iint->flags & IMA_COLLECTED)) {
> -               u64 i_version = file_inode(file)->i_version;
> +       if (iint->flags & IMA_COLLECTED)
> +               goto out;
>
> -               if (file->f_flags & O_DIRECT) {
> -                       audit_cause = "failed(directio)";
> -                       result = -EACCES;
> -                       goto out;
> -               }
> +       if (file->f_flags & O_DIRECT) {
> +               audit_cause = "failed(directio)";
> +               result = -EACCES;
> +               goto out;
> +       }
>
> -               hash.hdr.algo = algo;
> -
> -               result = (!buf) ?  ima_calc_file_hash(file, &hash.hdr) :
> -                       ima_calc_buffer_hash(buf, size, &hash.hdr);
> -               if (!result) {
> -                       int length = sizeof(hash.hdr) + hash.hdr.length;
> -                       void *tmpbuf = krealloc(iint->ima_hash, length,
> -                                               GFP_NOFS);
> -                       if (tmpbuf) {
> -                               iint->ima_hash = tmpbuf;
> -                               memcpy(iint->ima_hash, &hash, length);
> -                               iint->version = i_version;
> -                               iint->flags |= IMA_COLLECTED;
> -                       } else
> -                               result = -ENOMEM;
> -               }
> +       i_version = file_inode(file)->i_version;
> +       hash.hdr.algo = algo;
> +
> +       /* Initialize hash digest to 0's in case of failure */
> +       memset(&hash.digest, 0, sizeof(hash.digest));
> +
> +       result = (!buf) ?  ima_calc_file_hash(file, &hash.hdr) :
> +               ima_calc_buffer_hash(buf, size, &hash.hdr);
> +
> +       if (result && result != -EBADF && result != -EINVAL)
> +               goto out;
> +
> +       length = sizeof(hash.hdr) + hash.hdr.length;
> +       tmpbuf = krealloc(iint->ima_hash, length, GFP_NOFS);
> +       if (!tmpbuf) {
> +               result = -ENOMEM;
> +               goto out;
>         }
> +
> +       iint->ima_hash = tmpbuf;
> +       memcpy(iint->ima_hash, &hash, length);
> +       iint->version = i_version;
> +
> +       /* Possibly temporary failure due to type of read (eg. DAX, O_DIRECT) */
> +       if (result != -EBADF && result != -EINVAL)
> +               iint->flags |= IMA_COLLECTED;

Result can be other than 0, EBADF and EINVAL here?
It is confusing.. simpler than can be just

if (!result)
 iint->flags |= IMA_COLLECTED;

Isn't it?

>  out:
>         if (result)
>                 integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 2aebb7984437..3941371402ff 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -235,7 +235,7 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
>         hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
>
>         rc = ima_collect_measurement(iint, file, buf, size, hash_algo);
> -       if (rc != 0) {
> +       if (rc != 0 && rc != -EBADF && rc != -EINVAL) {
>                 if (file->f_flags & O_DIRECT)
>                         rc = (iint->flags & IMA_PERMIT_DIRECTIO) ? 0 : -EACCES;
>                 goto out_digsig;
> @@ -247,7 +247,7 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
>         if (action & IMA_MEASURE)
>                 ima_store_measurement(iint, file, pathname,
>                                       xattr_value, xattr_len, pcr);
> -       if (action & IMA_APPRAISE_SUBMASK)
> +       if ((rc == 0) && (action & IMA_APPRAISE_SUBMASK))
>                 rc = ima_appraise_measurement(func, iint, file, pathname,
>                                               xattr_value, xattr_len, opened);
>         if (action & IMA_AUDIT)
> --
> 2.7.4
>
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-ima-devel mailing list
> Linux-ima-devel at lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-ima-devel



-- 
Thanks,
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
