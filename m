From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Fri, 10 Aug 2018 20:43:20 +0300
Subject: [PATCH v4 2/2] tpm: add support for nonblocking operation
In-Reply-To: <153367366969.18015.14742040525393494830.stgit@tstruk-mobl1.jf.intel.com>
References: <153367365951.18015.11320230309813817454.stgit@tstruk-mobl1.jf.intel.com>
	<153367366969.18015.14742040525393494830.stgit@tstruk-mobl1.jf.intel.com>
Message-ID: <20180810174320.GV4692@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Aug 07, 2018 at 01:27:49PM -0700, Tadeusz Struk wrote:
> Currently the TPM driver only supports blocking calls, which doesn't allow
> asynchronous IO operations to the TPM hardware.
> This patch changes it and adds support for nonblocking write and a new poll
> function to enable applications, which want to take advantage of this.
> 
> Tested-by: Philip Tricca <philip.b.tricca@intel.com>
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> ---
>  drivers/char/tpm/tpm-dev-common.c |  149 ++++++++++++++++++++++++++++---------
>  drivers/char/tpm/tpm-dev.c        |   16 +++-
>  drivers/char/tpm/tpm-dev.h        |   17 +++-
>  drivers/char/tpm/tpm-interface.c  |    1 
>  drivers/char/tpm/tpm.h            |    1 
>  drivers/char/tpm/tpmrm-dev.c      |   19 +++--
>  6 files changed, 150 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index f0c033b69b62..f71d80b94451 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -17,11 +17,36 @@
>   * License.
>   *
>   */
> +#include <linux/poll.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> +#include <linux/workqueue.h>
>  #include "tpm.h"
>  #include "tpm-dev.h"
>  
> +static struct workqueue_struct *tpm_dev_wq;

A naming contradiction with tpm_common_read() and tpm_common_write(). To
sort that up I would suggest adding a commit to the patch set that
renames these functions as tpm_dev_common_read() and
tpm_dev_common_write() and use the name tpm_common_dev_wq here.

> +static DEFINE_MUTEX(tpm_dev_wq_lock);

This is an unacceptable way to do it, Rather add:

int __init  tpm_dev_common_init(void)
{
	tpm_dev_common_wq = alloc_workqueue("tpm_dev_wq", WQ_MEM_RECLAIM, 0);
	if (!tpm_dev_common_wq)
		return -ENOMEM;

	return 0;
}

and call this in the driver initialization.

> +
> +static void tpm_async_work(struct work_struct *work)
> +{
> +	struct file_priv *priv =
> +			container_of(work, struct file_priv, async_work);
> +	ssize_t ret;
> +
> +	mutex_lock(&priv->buffer_mutex);
> +	priv->command_enqueued = false;
> +	ret = tpm_transmit(priv->chip, priv->space, priv->data_buffer,
> +			   sizeof(priv->data_buffer), 0);
> +
> +	tpm_put_ops(priv->chip);
> +	if (ret > 0) {
> +		priv->data_pending = ret;
> +		mod_timer(&priv->user_read_timer, jiffies + (120 * HZ));
> +	}
> +	mutex_unlock(&priv->buffer_mutex);
> +	wake_up_interruptible(&priv->async_wait);
> +}
> +
>  static void user_reader_timeout(struct timer_list *t)
>  {
>  	struct file_priv *priv = from_timer(priv, t, user_read_timer);
> @@ -29,30 +54,44 @@ static void user_reader_timeout(struct timer_list *t)
>  	pr_warn("TPM user space timeout is deprecated (pid=%d)\n",
>  		task_tgid_nr(current));
>  
> -	schedule_work(&priv->work);
> +	schedule_work(&priv->timeout_work);
>  }
>  
> -static void timeout_work(struct work_struct *work)
> +static void tpm_timeout_work(struct work_struct *work)
>  {
> -	struct file_priv *priv = container_of(work, struct file_priv, work);
> +	struct file_priv *priv = container_of(work, struct file_priv,
> +					      timeout_work);
>  
>  	mutex_lock(&priv->buffer_mutex);
>  	priv->data_pending = 0;
>  	memset(priv->data_buffer, 0, sizeof(priv->data_buffer));
>  	mutex_unlock(&priv->buffer_mutex);
> +	wake_up_interruptible(&priv->async_wait);
>  }
>  
> -void tpm_common_open(struct file *file, struct tpm_chip *chip,
> -		     struct file_priv *priv, struct tpm_space *space)
> +int tpm_common_open(struct file *file, struct tpm_chip *chip,
> +		    struct file_priv *priv, struct tpm_space *space)
>  {
>  	priv->chip = chip;
>  	priv->space = space;
>  
>  	mutex_init(&priv->buffer_mutex);
>  	timer_setup(&priv->user_read_timer, user_reader_timeout, 0);
> -	INIT_WORK(&priv->work, timeout_work);
> -
> +	INIT_WORK(&priv->timeout_work, tpm_timeout_work);
> +	INIT_WORK(&priv->async_work, tpm_async_work);
> +	init_waitqueue_head(&priv->async_wait);
>  	file->private_data = priv;
> +	mutex_lock(&tpm_dev_wq_lock);
> +	if (!tpm_dev_wq) {
> +		tpm_dev_wq = alloc_workqueue("tpm_dev_wq", WQ_MEM_RECLAIM, 0);
> +		if (!tpm_dev_wq) {
> +			mutex_unlock(&tpm_dev_wq_lock);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	mutex_unlock(&tpm_dev_wq_lock);
> +	return 0;
>  }
>  
>  ssize_t tpm_common_read(struct file *file, char __user *buf,
> @@ -63,15 +102,17 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
>  	int rc;
>  
>  	del_singleshot_timer_sync(&priv->user_read_timer);
> -	flush_work(&priv->work);
> +	flush_work(&priv->timeout_work);
>  	mutex_lock(&priv->buffer_mutex);
>  
>  	if (priv->data_pending) {
>  		ret_size = min_t(ssize_t, size, priv->data_pending);
> -		rc = copy_to_user(buf, priv->data_buffer, ret_size);
> -		memset(priv->data_buffer, 0, priv->data_pending);
> -		if (rc)
> -			ret_size = -EFAULT;
> +		if (ret_size > 0) {
> +			rc = copy_to_user(buf, priv->data_buffer, ret_size);
> +			memset(priv->data_buffer, 0, priv->data_pending);
> +			if (rc)
> +				ret_size = -EFAULT;
> +		}
>  
>  		priv->data_pending = 0;
>  	}
> @@ -84,10 +125,9 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>  			 size_t size, loff_t *off)
>  {
>  	struct file_priv *priv = file->private_data;
> -	size_t in_size = size;

/Jarkko
