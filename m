From: tadeusz.struk@intel.com (Tadeusz Struk)
Date: Fri, 10 Aug 2018 11:21:14 -0700
Subject: [PATCH v4 2/2] tpm: add support for nonblocking operation
In-Reply-To: <20180810174320.GV4692@linux.intel.com>
References: <153367365951.18015.11320230309813817454.stgit@tstruk-mobl1.jf.intel.com>
	<153367366969.18015.14742040525393494830.stgit@tstruk-mobl1.jf.intel.com>
	<20180810174320.GV4692@linux.intel.com>
Message-ID: <ad02d89f-31d3-7d9f-4580-daf759c8d837@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 08/10/2018 10:43 AM, Jarkko Sakkinen wrote:
>> +static struct workqueue_struct *tpm_dev_wq;
> A naming contradiction with tpm_common_read() and tpm_common_write(). To
> sort that up I would suggest adding a commit to the patch set that
> renames these functions as tpm_dev_common_read() and
> tpm_dev_common_write() and use the name tpm_common_dev_wq here.
> 

Currently we have: tpm_open(), tpm_write(), tpm_release() in tpm-dev.c
tpmrm_open(), tpmrm_read(), tpmrm_write(), tpmrm_release() in tpmrm-dev.c
tpm_common_open(), tpm_common_read(), tpm_common_write(), tpm_common_release() in tpm-dev-common.c

I think that's pretty consistent. Do you want me to rename all of them to tpm_dev_*()?
I don't see any value in doing this. What about if I just rename: 
tpm_dev_wq_lock to tpm_common_wq_lock, and tpm_dev_wq to tpm_common_wq?

>> +static DEFINE_MUTEX(tpm_dev_wq_lock);
> This is an unacceptable way to do it, Rather add:
> 
> int __init  tpm_dev_common_init(void)
> {
> 	tpm_dev_common_wq = alloc_workqueue("tpm_dev_wq", WQ_MEM_RECLAIM, 0);
> 	if (!tpm_dev_common_wq)
> 		return -ENOMEM;
> 
> 	return 0;
> }
> 
> and call this in the driver initialization.
> 
That was the way it was implemented in v1 https://patchwork.kernel.org/patch/10442125/

See: static int __init tpm_dev_common_init(void)

and the feedback I got from Jason was:

"I wonder if it is worth creating this when the first file is
opened.. Lots of systems have TPMs but few use the userspace.."

so I changed this to allocate the WQ on first open. I think it makes sense,
but I leave it to you to decide.

Tadeusz,
-- 
Tadeusz
