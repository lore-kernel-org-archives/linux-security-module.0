From: dmitry.kasatkin@gmail.com (Dmitry Kasatkin)
Date: Mon, 10 Jul 2017 17:07:47 +0300
Subject: [Linux-ima-devel] [PATCH 4/4] ima: use read_iter
	(generic_file_read_iter) to calculate file hash
In-Reply-To: <1497031364-19949-5-git-send-email-zohar@linux.vnet.ibm.com>
References: <1497031364-19949-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1497031364-19949-5-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <CACE9dm9iyXuGMa3wXg2RsGP0mgQktJi7No2mgFTDnsyytBJnJw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jun 9, 2017 at 9:02 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> The large marjority of filesystems in the fs directory define
> generic_file_read_iter as the read_iter file operation method.
>
> Instead of specifying the integrity_read file operation method
> for all of these file systems, continue to calculate the file
> hash using the read_iter method, when defined as
> generic_file_read_iter.
>
> For all other read_iter methods, define an integrity_read
> method.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  security/integrity/iint.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index e3ef3fba16dc..8164f57f5cea 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -202,6 +202,9 @@ int integrity_kernel_read(struct file *file, loff_t offset,
>
>         if (file->f_op->integrity_read) {
>                 ret = file->f_op->integrity_read(&kiocb, &iter);
> +       } else if (file->f_op->read_iter &&
> +                  file->f_op->read_iter == generic_file_read_iter) {
> +               ret = file->f_op->read_iter(&kiocb, &iter);
>         } else if (file->f_op->read) {
>                 mm_segment_t old_fs;
>                 char __user *buf = (char __user *)addr;

Why not __vfs_read()?? it uses new_sync_read()

else if (file->f_op->read_iter)
    return new_sync_read(file, buf, count, pos);

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
