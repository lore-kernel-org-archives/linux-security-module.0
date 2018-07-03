From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 03 Jul 2018 09:07:39 -0400
Subject: [PATCH v5 3/8] ima: based on policy require signed kexec kernel
	images
In-Reply-To: <840dae63-5a90-1327-437e-1ed92e165754@gmail.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1530542283-26145-4-git-send-email-zohar@linux.vnet.ibm.com>
	<840dae63-5a90-1327-437e-1ed92e165754@gmail.com>
Message-ID: <1530623259.3452.28.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 2018-07-02 at 11:31 -0700, J Freyensee wrote:
> 
> On 7/2/18 7:37 AM, Mimi Zohar wrote:
> > The original kexec_load syscall can not verify file signatures, nor can
> > the kexec image be measured.  Based on policy, deny the kexec_load
> > syscall.
> 
> 
> Curiosity question: I thought kexec_load() syscall was used to load a 
> crashdump?

kexec is used to collect the memory used to analyze the crash dump.

> If this is true, how would this work if kexec_load() is 
> being denied?? I don't think I'd want to be hindered in cases where I'm 
> trying to diagnose a crash.

For trusted & secure boot, we need a full measurement list and
signature chain of trust rooted in HW. ?Permitting kexec_load would
break these chains of trust.

Permitting/denying kexec_load is based on a runtime IMA policy. ?Patch
6/8 "ima: add build time policy", in this patch set, introduces the
concept of a build time policy. ?With these patches, you could
configure your kernel and/or load an IMA policy permitting kexec_load.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
