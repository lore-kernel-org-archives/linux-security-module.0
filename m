From: tycho@docker.com (Tycho Andersen)
Date: Thu, 18 May 2017 15:39:39 -0600
Subject: [RFC 04/11] ima: add support to namespace securityfs file
In-Reply-To: <1494511203-8397-5-git-send-email-guilherme.magalhaes@hpe.com>
References: <1494511203-8397-1-git-send-email-guilherme.magalhaes@hpe.com>
	<1494511203-8397-5-git-send-email-guilherme.magalhaes@hpe.com>
Message-ID: <20170518213939.mrvuzxf3kdqqnemc@docker>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Guilherme,

On Thu, May 11, 2017 at 10:59:56AM -0300, Guilherme Magalhaes wrote:
> +static int ima_open_namespaces(struct inode *inode, struct file *filp)
> +{
> +	if (!(filp->f_flags & O_WRONLY))
> +		return -EACCES;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (test_and_set_bit(IMA_FS_BUSY, &ima_fs_flags))
> +		return -EBUSY;

It probably makes sense to do something like:

if (!(ima_appraise & IMA_APPRAISE_NAMESPACE))
	return -EINVAL;

here.

I'll keep playing around with this patchset and see if I have any
other feedback.

Cheers,

Tycho
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
