From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 20 Sep 2018 08:20:50 -0700
Subject: [PATCH v3 09/16] SELinux: Abstract use of file security blob
In-Reply-To: <124ae3859e8141deb35ed8355370b4ed@AcuMS.aculab.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
	<14db9a22-9f31-88fb-dbc1-8bc4ade74bf6@schaufler-ca.com>
	<124ae3859e8141deb35ed8355370b4ed@AcuMS.aculab.com>
Message-ID: <4db0c110-c1aa-aac8-901f-a9abf662b605@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/20/2018 1:51 AM, David Laight wrote:
> From: Casey Schaufler
>> Sent: 20 September 2018 01:21
>>
>> SELinux: Abstract use of file security blob
>>
>> Don't use the file->f_security pointer directly.
>> Provide a helper function that provides the security blob pointer.
> ...
>> +static inline struct file_security_struct *selinux_file(const struct file *file)
>> +{
>> +	return file->f_security;
>> +}
>> +
> Why?

In patch 16/16 this becomes:

 static inline struct file_security_struct *selinux_file(const struct file *file)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	return file->f_security + selinux_blob_sizes.lbs_file;
+#else
 	return file->f_security;
+#endif
 }

You could hard code this bit everywhere it's used, but that
would be prone to error. I'm not generally an abstractionist
myself, but it these cases abstraction adds value.
