From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Mon, 23 Oct 2017 15:41:15 +0200
Subject: [RFC][PATCH 1/2] ima: preserve the integrity of appraised files
In-Reply-To: <1508759202.3639.87.camel@linux.vnet.ibm.com>
References: <20171020154138.23635-1-roberto.sassu@huawei.com>
	<20171020154138.23635-2-roberto.sassu@huawei.com>
	<1508759202.3639.87.camel@linux.vnet.ibm.com>
Message-ID: <f81dcce1-491d-d977-54ed-32f8c03c80db@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 10/23/2017 1:46 PM, Mimi Zohar wrote:
> On Fri, 2017-10-20 at 17:41 +0200, Roberto Sassu wrote:
>> The existing 'ima_appraise_tcb' policy aims at protecting the integrity
>> of files owned by root against offline attacks, while LSMs should decide
>> if those files can be modified, and new files can be created. However,
>> LSMs cannot take this decision independently, if IMA appraises only
>> a subset of files that a process is allowed to access. A process can
>> become compromised due to reading files not appraised by IMA.
>>
>> To avoid this issue, the IMA policy should contain as criteria process
>> credentials rather than files attributes. Then, when a process matches
>> those criteria, files will be always appraised by IMA, regardless of
>> file attributes.
>>
>> The IMA policy with process credentials will define which process belongs
>> to the TCB and which not. With this information, IMA would be be able
>> to preserve the integrity of appraised files, without an LSM, for example
>> by denying writes by processes outside the TCB (Biba strict policy).
>>
>> This patch adds support for enforcing the Biba strict policy. More
>> policies will be introduced later. Enforcement will be enabled by
>> adding 'ima_integrity_policy=biba-strict' to the kernel command line.
> 
> Way, way back, before the any of the integrity code was upstreamed,
> the original integrity design had LSMs calling exported integrity
> functions to verify file integrity (eg. evm_verifyxattr). ?A decision
> was made, at the time, to have a clear delineation between Mandatory
> Access Control (MAC) and integrity. ?There have been recent
> discussions about LSMs blurring this line and calling
> evm_verifyxattr() directly.

If IMA/EVM were used to check the integrity of every file (content +
labels) before any other LSMs makes security decisions, I would agree
with you that there are two distinct layers: IMA/EVM at the bottom,
that protect the system against offline attacks (the association
between file content and LSM labels); LSMs at the top, protect it
against runtime attacks (i.e. preserve the integrity of the TCB).

If instead IMA appraises a subset of the system, e.g. when the default
appraisal policy (called appraise_tcb) is selected, then LSMs alone
cannot guarantee anymore the runtime integrity of the system if subjects
in the LSMs TCB are allowed to read files not verified by IMA (read up
violation in the Biba strict model, because the integrity of files not
verified by IMA is low).

Then, in order to preserve the runtime integrity of the system, IMA must
complement LSMs and prevent the non-appraised portion of the system
from interacting with the appraised portion.

For example, the recent work by Matthew Garrett (IMA: Support using new
creds in appraisal policy) goes in this direction. With the policy:

appraise euid=0 func=CREDS_CHECK

IMA enforces the Biba strict policy (read up) because it prevents bad
code, loaded through execve(), from being executed by the TCB (root
processes).

As I mentioned in the patch set description, it could be possible to
enforce a more generic policy, which includes also FILE_CHECK and
MMAP_CHECK.

With digital signatures, the enforcement of the write down rule is
guaranteed because signed files are immutable. This patch set adds
support for enforcing the write down rule on mutable files.

Roberto


> Never was there any thought or discussion of adding MAC to the
> integrity subsystem. ?A Biba implementation doesn't belong in IMA, but
> should be defined as a separate LSM. ?(Years ago we implemented a low-
> water mark LSM named SLIM, based on LOMAC.)
> 
> Mimi
> 
>> To enforce this policy, it is necessary to upload to IMA a new policy
>> which defines the subjects part of the TCB. For example, the rule
>> 'appraise fowner=0' could be replaced with two rules: 'appraise uid=0'
>> and 'appraise euid=0'.
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt |  4 ++
>>   security/integrity/ima/ima.h                    | 23 ++++++++++
>>   security/integrity/ima/ima_appraise.c           | 61 +++++++++++++++++++++++++
>>   security/integrity/ima/ima_main.c               | 25 ++++++----
>>   4 files changed, 104 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 05496622b4ef..37810c6a3b28 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1532,6 +1532,10 @@
>>   	                [IMA] Define a custom template format.
>>   			Format: { "field1|...|fieldN" }
>>
>> +	ima_integrity_policy=
>> +			[IMA] Select an integrity policy to enforce.
>> +			Policies: { "biba-strict" }
>> +
>>   	ima.ahash_minsize= [IMA] Minimum file size for asynchronous hash usage
>>   			Format: <min_file_size>
>>   			Set the minimal file size for using asynchronous hash.
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index d52b487ad259..377e1d8c2afb 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -36,6 +36,8 @@ enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
>>   		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
>>   enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
>>
>> +enum integrity_policies { BIBA_STRICT = 1, INTEGRITY_POLICY__LAST };
>> +
>>   /* digest size for IMA, fits SHA1 or MD5 */
>>   #define IMA_DIGEST_SIZE		SHA1_DIGEST_SIZE
>>   #define IMA_EVENT_NAME_LEN_MAX	255
>> @@ -57,6 +59,7 @@ extern int ima_initialized;
>>   extern int ima_used_chip;
>>   extern int ima_hash_algo;
>>   extern int ima_appraise;
>> +extern int ima_integrity_policy;
>>
>>   /* IMA event related data */
>>   struct ima_event_data {
>> @@ -247,6 +250,11 @@ enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
>>   				 int xattr_len);
>>   int ima_read_xattr(struct dentry *dentry,
>>   		   struct evm_ima_xattr_data **xattr_value);
>> +bool ima_inode_is_appraised(struct dentry *dentry, struct inode *inode);
>> +bool ima_appraise_biba_check(struct file *file,
>> +			     struct integrity_iint_cache *iint,
>> +			     int must_appraise, char **pathbuf,
>> +			     const char **pathname, char *namebuf);
>>
>>   #else
>>   static inline int ima_appraise_measurement(enum ima_hooks func,
>> @@ -289,6 +297,21 @@ static inline int ima_read_xattr(struct dentry *dentry,
>>   	return 0;
>>   }
>>
>> +static inline bool ima_inode_is_appraised(struct dentry *dentry,
>> +					  struct inode *inode);
>> +{
>> +	return false;
>> +}
>> +
>> +static inline bool ima_appraise_biba_check(struct file *file,
>> +					   struct integrity_iint_cache *iint,
>> +					   int must_appraise, char **pathbuf,
>> +					   const char **pathname,
>> +					   char *namebuf)
>> +{
>> +	return false;
>> +}
>> +
>>   #endif /* CONFIG_IMA_APPRAISE */
>>
>>   /* LSM based policy rules require audit */
>> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
>> index 809ba70fbbbf..c24824ef64c4 100644
>> --- a/security/integrity/ima/ima_appraise.c
>> +++ b/security/integrity/ima/ima_appraise.c
>> @@ -18,6 +18,10 @@
>>
>>   #include "ima.h"
>>
>> +static char *ima_integrity_policies_str[INTEGRITY_POLICY__LAST] = {
>> +	[BIBA_STRICT] = "biba-strict",
>> +};
>> +
>>   static int __init default_appraise_setup(char *str)
>>   {
>>   #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
>> @@ -33,6 +37,15 @@ static int __init default_appraise_setup(char *str)
>>
>>   __setup("ima_appraise=", default_appraise_setup);
>>
>> +static int __init integrity_policy_setup(char *str)
>> +{
>> +	if (strcmp(str, ima_integrity_policies_str[BIBA_STRICT]) == 0)
>> +		ima_integrity_policy = BIBA_STRICT;
>> +
>> +	return 1;
>> +}
>> +__setup("ima_integrity_policy=", integrity_policy_setup);
>> +
>>   /*
>>    * is_ima_appraise_enabled - return appraise status
>>    *
>> @@ -189,6 +202,54 @@ int ima_read_xattr(struct dentry *dentry,
>>   	return ret;
>>   }
>>
>> +bool ima_inode_is_appraised(struct dentry *dentry, struct inode *inode)
>> +{
>> +	ssize_t len;
>> +
>> +	len =  __vfs_getxattr(dentry, inode, XATTR_NAME_IMA, NULL, 0);
>> +
>> +	return (len > 0 && len >= sizeof(struct evm_ima_xattr_data));
>> +}
>> +
>> +/*
>> + * ima_appraise_biba_check - detect violations of a Biba policy
>> + *
>> + * The appraisal policy identifies which subjects belong to the TCB. Files
>> + * with a valid digital signature or HMAC are also part of the TCB. This
>> + * function detects attempts to write appraised files by subjects outside
>> + * the TCB. The Biba strict policy denies this operation.
>> + *
>> + * Return: true if current operation violates a Biba policy, false otherwise
>> + */
>> +bool ima_appraise_biba_check(struct file *file,
>> +			     struct integrity_iint_cache *iint,
>> +			     int must_appraise, char **pathbuf,
>> +			     const char **pathname, char *namebuf)
>> +{
>> +	struct inode *inode = file_inode(file);
>> +	fmode_t mode = file->f_mode;
>> +	char *cause = "write_down";
>> +
>> +	/* check write up, ima_appraise_measurement() checks read down */
>> +	if (!must_appraise && (mode & FMODE_WRITE)) {
>> +		if (IS_IMA(inode)) {
>> +			if (!iint)
>> +				iint = integrity_iint_find(inode);
>> +			if (iint->flags & IMA_APPRAISE)
>> +				goto out_violation;
>> +		} else if (ima_inode_is_appraised(file_dentry(file), inode)) {
>> +			goto out_violation;
>> +		}
>> +	}
>> +	return false;
>> +out_violation:
>> +	*pathname = ima_d_path(&file->f_path, pathbuf, namebuf);
>> +	integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, *pathname,
>> +			    ima_integrity_policies_str[ima_integrity_policy],
>> +			    cause, 0, 0);
>> +	return true;
>> +}
>> +
>>   /*
>>    * ima_appraise_measurement - appraise file measurement
>>    *
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index bb7e36e90c79..6e85ea8e2373 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -31,6 +31,7 @@ int ima_initialized;
>>
>>   #ifdef CONFIG_IMA_APPRAISE
>>   int ima_appraise = IMA_APPRAISE_ENFORCE;
>> +int ima_integrity_policy;
>>   #else
>>   int ima_appraise;
>>   #endif
>> @@ -103,7 +104,8 @@ static void ima_rdwr_violation_check(struct file *file,
>>   	if (!send_tomtou && !send_writers)
>>   		return;
>>
>> -	*pathname = ima_d_path(&file->f_path, pathbuf, filename);
>> +	if (!*pathname)
>> +		*pathname = ima_d_path(&file->f_path, pathbuf, filename);
>>
>>   	if (send_tomtou)
>>   		ima_add_violation(file, *pathname, iint,
>> @@ -168,7 +170,7 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
>>   	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
>>   	struct evm_ima_xattr_data *xattr_value = NULL;
>>   	int xattr_len = 0;
>> -	bool violation_check;
>> +	bool violation_check, policy_violation = false;
>>   	enum hash_algo hash_algo;
>>
>>   	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
>> @@ -181,7 +183,7 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
>>   	action = ima_get_action(inode, mask, func, &pcr);
>>   	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
>>   			   (ima_policy_flag & IMA_MEASURE));
>> -	if (!action && !violation_check)
>> +	if (!action && !violation_check && !ima_integrity_policy)
>>   		return 0;
>>
>>   	must_appraise = action & IMA_APPRAISE;
>> @@ -198,13 +200,16 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
>>   			goto out;
>>   	}
>>
>> -	if (violation_check) {
>> +	if (ima_integrity_policy)
>> +		policy_violation = ima_appraise_biba_check(file, iint,
>> +						must_appraise, &pathbuf,
>> +						&pathname, filename);
>> +	if (violation_check)
>>   		ima_rdwr_violation_check(file, iint, action & IMA_MEASURE,
>>   					 &pathbuf, &pathname);
>> -		if (!action) {
>> -			rc = 0;
>> -			goto out_free;
>> -		}
>> +	if (!action) {
>> +		rc = 0;
>> +		goto out_free;
>>   	}
>>
>>   	/* Determine if already appraised/measured based on bitmask
>> @@ -260,7 +265,9 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
>>   		__putname(pathbuf);
>>   out:
>>   	inode_unlock(inode);
>> -	if ((rc && must_appraise) && (ima_appraise & IMA_APPRAISE_ENFORCE))
>> +	if (((rc && must_appraise) ||
>> +	    (ima_integrity_policy && policy_violation)) &&
>> +	    (ima_appraise & IMA_APPRAISE_ENFORCE))
>>   		return -EACCES;
>>   	return 0;
>>   }
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
