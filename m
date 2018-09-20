From: David.Laight@ACULAB.COM (David Laight)
Date: Thu, 20 Sep 2018 08:51:09 +0000
Subject: [PATCH v3 09/16] SELinux: Abstract use of file security blob
In-Reply-To: <14db9a22-9f31-88fb-dbc1-8bc4ade74bf6@schaufler-ca.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
	<14db9a22-9f31-88fb-dbc1-8bc4ade74bf6@schaufler-ca.com>
Message-ID: <124ae3859e8141deb35ed8355370b4ed@AcuMS.aculab.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Casey Schaufler
> Sent: 20 September 2018 01:21
> 
> SELinux: Abstract use of file security blob
> 
> Don't use the file->f_security pointer directly.
> Provide a helper function that provides the security blob pointer.
...
> +static inline struct file_security_struct *selinux_file(const struct file *file)
> +{
> +	return file->f_security;
> +}
> +

Why?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
