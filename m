From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 18 May 2018 11:29:36 -0400
Subject: [PATCH v2 3/9] security: define security_kernel_read_blob()
	wrapper
In-Reply-To: <cb7f7401-ce7e-f4b5-2daa-62eaa78492ca@schaufler-ca.com>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1526568530-9144-4-git-send-email-zohar@linux.vnet.ibm.com>
	<74c096ca-1ad1-799e-df3d-7b1b099333a7@schaufler-ca.com>
	<87y3ghhbws.fsf@xmission.com>
	<1526643050.3632.127.camel@linux.vnet.ibm.com>
	<cb7f7401-ce7e-f4b5-2daa-62eaa78492ca@schaufler-ca.com>
Message-ID: <1526657376.3404.15.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2018-05-18 at 07:58 -0700, Casey Schaufler wrote:
> On 5/18/2018 4:30 AM, Mimi Zohar wrote:

> > Having to define a separate LSM hook for each of the original, non
> > kernel_read_file(), buffer based method callers, kind of makes sense,
> > as the callers themselves are specific, but is it really necessary?
> > Could we define a new, generic LSM hook named
> > security_kernel_buffer_data() for this purpose?
> 
> If there are two disparate behaviors wrapped into kernel_read_file()
> Eric (bless him) is right. It should be broken into two hooks. I think
> that if we look (too) carefully we'll find other places where hooks
> should get broken up, or combined*. My question is just how important
> is it that this gets changed?

Other than the LSM call in copy_module_from_user(), this patch set is
adding the LSM call in kexec_load() and firmware_fallback_sysfs().

Eric, the question remains whether we need distinct LSM hooks in each
of these places or can we have a single, generic LSM hook named
security_kernel_buffer_data()?

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
