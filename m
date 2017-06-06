From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 6 Jun 2017 10:49:37 +0200
Subject: [Linux-ima-devel] [PATCH 5/7] ima: add securityfs interface to
	save a measurements list with kexec header
In-Reply-To: <1496642698.2998.104.camel@linux.vnet.ibm.com>
References: <20170516125347.10574-1-roberto.sassu@huawei.com>
	<20170516125347.10574-6-roberto.sassu@huawei.com>
	<1496642698.2998.104.camel@linux.vnet.ibm.com>
Message-ID: <c4aa904b-052e-778d-caf9-47fbe8d961cb@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 6/5/2017 8:04 AM, Mimi Zohar wrote:
> On Tue, 2017-05-16 at 14:53 +0200, Roberto Sassu wrote:
>> Through the new interface binary_kexec_runtime_measurements, it will be
>> possible to read the same content returned by binary_runtime_measurements,
>> with the kexec header prepended.
>>
>> The new interface has been added for testing ima_restore_measurement_list()
>> which, at the moment, works only on PPC systems. The interface for reading
>> the binary list with the kexec header will be provided in a separate patch.
>>
>> The patch reuses ima_measurements_start() and ima_measurements_next()
>> to send the measurements list to userspace. Their behavior changes
>> depending on the current dentry.
>>
>> To provide the correct information in the kexec header,
>> ima_measurements_start() has to iterate over the whole list and calculate
>> the number of entries and the total size. It is not possible to read
>> the value of the global variable binary_runtime_size and ima_htable.len
>> without taking ima_extend_list_mutex, because there might have been a list
>> add between the two read operations.
>
> Please correct me if I'm wrong.  Your code walks the measurement list
> calculating the total number of measurements and the memory size
> needed to store in the kexec header.  Can't there be additional
> measurements between the time these values - total number of
> measurements and memory needed - were calculated and actually saving
> the measurements?  How would that be any different than the problem
> you're trying to solve?  In both cases, the number of measurements
> might be less than the actual number of measurements.
>
> As long as you query the number of measurements before getting the
> memory needed, unless you're trying to verify a TPM quote, having
> fewer measurements shouldn't be a problem for testing.

The problem is that the total number of entries and the required
memory size might be inconsistent without taking ima_extend_list_mutex.
ima_measurements_start() could read the entries counter before
it is incremented by ima_add_digest_entry() and the required memory
size after it is updated. If this happens, the parser returns an error
because ENFORCE_BUFEND is set for the last entry and there would be
still data to read (the new entry added to the list).

Roberto


>
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>> ---
>>  security/integrity/ima/Kconfig            |  8 ++++++
>>  security/integrity/ima/ima.h              |  2 ++
>>  security/integrity/ima/ima_fs.c           | 42 ++++++++++++++++++++++++++++---
>>  security/integrity/ima/ima_kexec.c        |  2 +-
>>  security/integrity/ima/ima_template.c     |  2 +-
>>  security/integrity/ima/ima_template_lib.c | 19 ++++++++++++++
>>  security/integrity/ima/ima_template_lib.h |  2 ++
>>  7 files changed, 71 insertions(+), 6 deletions(-)
>>
>> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
>> index 370eb2f..0f60c04 100644
>> --- a/security/integrity/ima/Kconfig
>> +++ b/security/integrity/ima/Kconfig
>> @@ -39,6 +39,14 @@ config IMA_KEXEC
>>  	   Depending on the IMA policy, the measurement list can grow to
>>  	   be very large.
>>
>> +config IMA_KEXEC_TESTING
>> +	bool "Enable securityfs interfaces to save/restore measurement list"
>> +	depends on IMA
>> +	default n
>> +	help
>> +	   Use binary_kexec_runtime_measurements to save the binary list
>> +	   with the kexec header; use restore_kexec_list to restore a list.
>> +
>>  config IMA_MEASURE_PCR_IDX
>>  	int
>>  	depends on IMA
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 10ef9c8..416497b 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -49,6 +49,8 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
>>  #define IMA_TEMPLATE_IMA_NAME "ima"
>>  #define IMA_TEMPLATE_IMA_FMT "d|n"
>>
>> +#define IMA_KEXEC_HDR_VERSION 1
>> +
>>  /* current content of the policy */
>>  extern int ima_policy_flag;
>>
>> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
>> index ca303e5..a93f941 100644
>> --- a/security/integrity/ima/ima_fs.c
>> +++ b/security/integrity/ima/ima_fs.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/vmalloc.h>
>>
>>  #include "ima.h"
>> +#include "ima_template_lib.h"
>>
>>  static DEFINE_MUTEX(ima_write_mutex);
>>
>> @@ -75,28 +76,52 @@ static const struct file_operations ima_measurements_count_ops = {
>>  	.llseek = generic_file_llseek,
>>  };
>>
>> +static struct dentry *binary_kexec_runtime_measurements;
>> +
>>  /* returns pointer to hlist_node */
>>  static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
>>  {
>>  	loff_t l = *pos;
>>  	struct ima_queue_entry *qe;
>> +	struct ima_queue_entry *qe_found = NULL;
>> +	unsigned long size = 0, count = 0;
>> +	bool khdr = m->file->f_path.dentry == binary_kexec_runtime_measurements;
>>
>>  	/* we need a lock since pos could point beyond last element */
>>  	rcu_read_lock();
>>  	list_for_each_entry_rcu(qe, &ima_measurements, later) {
>> -		if (!l--) {
>> -			rcu_read_unlock();
>> -			return qe;
>> +		if (!l) {
>> +			qe_found = qe_found ? qe_found : qe;
>
> What is this?
>
>> +
>> +			if (!khdr)
>> +				break;
>
> Does this test need to be in the loop?
>
> Mimi
>
>> +
>> +			if (*pos)
>> +				break;
>> +
>> +			size += ima_get_template_entry_size(qe->entry);
>> +			count++;
>> +			m->private = qe;
>> +			continue;
>>  		}
>> +		l--;
>>  	}
>>  	rcu_read_unlock();
>> -	return NULL;
>> +
>> +	if (khdr && size)
>> +		ima_show_kexec_hdr(m, count, size);
>> +
>> +	return qe_found;
>>  }
>>
>>  static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
>>  {
>> +	bool khdr = m->file->f_path.dentry == binary_kexec_runtime_measurements;
>>  	struct ima_queue_entry *qe = v;
>>
>> +	if (khdr && qe == m->private)
>> +		return NULL;
>> +
>>  	/* lock protects when reading beyond last element
>>  	 * against concurrent list-extension
>>  	 */
>> @@ -490,8 +515,17 @@ int __init ima_fs_init(void)
>>  	if (IS_ERR(ima_policy))
>>  		goto out;
>>
>> +#ifdef CONFIG_IMA_KEXEC_TESTING
>> +	binary_kexec_runtime_measurements =
>> +	    securityfs_create_file("binary_kexec_runtime_measurements",
>> +				   S_IRUSR | S_IRGRP, ima_dir, NULL,
>> +				   &ima_measurements_ops);
>> +	if (IS_ERR(binary_kexec_runtime_measurements))
>> +		goto out;
>> +#endif
>>  	return 0;
>>  out:
>> +	securityfs_remove(binary_kexec_runtime_measurements);
>>  	securityfs_remove(violations);
>>  	securityfs_remove(runtime_measurements_count);
>>  	securityfs_remove(ascii_runtime_measurements);
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index e473eee..b0b8ed2 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -36,7 +36,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>>  	file.count = sizeof(khdr);	/* reserved space */
>>
>>  	memset(&khdr, 0, sizeof(khdr));
>> -	khdr.version = 1;
>> +	khdr.version = IMA_KEXEC_HDR_VERSION;
>>  	list_for_each_entry_rcu(qe, &ima_measurements, later) {
>>  		if (file.count < file.size) {
>>  			khdr.count++;
>> diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
>> index 7412d02..f86456c 100644
>> --- a/security/integrity/ima/ima_template.c
>> +++ b/security/integrity/ima/ima_template.c
>> @@ -347,7 +347,7 @@ int ima_restore_measurement_list(loff_t size, void *buf)
>>  		khdr->buffer_size = le64_to_cpu(khdr->buffer_size);
>>  	}
>>
>> -	if (khdr->version != 1) {
>> +	if (khdr->version != IMA_KEXEC_HDR_VERSION) {
>>  		pr_err("attempting to restore a incompatible measurement list");
>>  		return -EINVAL;
>>  	}
>> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
>> index 28af43f..de2b064 100644
>> --- a/security/integrity/ima/ima_template_lib.c
>> +++ b/security/integrity/ima/ima_template_lib.c
>> @@ -159,6 +159,25 @@ void ima_show_template_sig(struct seq_file *m, enum ima_show_type show,
>>  	ima_show_template_field_data(m, show, DATA_FMT_HEX, field_data);
>>  }
>>
>> +void ima_show_kexec_hdr(struct seq_file *m, unsigned long count,
>> +			unsigned long size)
>> +{
>> +	struct ima_kexec_hdr khdr;
>> +
>> +	memset(&khdr, 0, sizeof(khdr));
>> +	khdr.version = IMA_KEXEC_HDR_VERSION;
>> +	khdr.count = count;
>> +	khdr.buffer_size = sizeof(khdr) + size;
>> +
>> +	if (ima_canonical_fmt) {
>> +		khdr.version = cpu_to_le16(khdr.version);
>> +		khdr.count = cpu_to_le64(khdr.count);
>> +		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
>> +	}
>> +
>> +	ima_putc(m, &khdr, sizeof(khdr));
>> +}
>> +
>>  /**
>>   * ima_parse_buf() - Parses lengths and data from an input buffer
>>   * @bufstartp:       Buffer start address.
>> diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
>> index 6a3d8b8..069e4ba 100644
>> --- a/security/integrity/ima/ima_template_lib.h
>> +++ b/security/integrity/ima/ima_template_lib.h
>> @@ -29,6 +29,8 @@ void ima_show_template_string(struct seq_file *m, enum ima_show_type show,
>>  			      struct ima_field_data *field_data);
>>  void ima_show_template_sig(struct seq_file *m, enum ima_show_type show,
>>  			   struct ima_field_data *field_data);
>> +void ima_show_kexec_hdr(struct seq_file *m, unsigned long count,
>> +			unsigned long size);
>>  int ima_parse_buf(void *bufstartp, void *bufendp, void **bufcurp,
>>  		  int maxfields, struct ima_field_data *fields, int *curfields,
>>  		  unsigned long *len_mask, int enforce_mask, char *bufname);
>

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
