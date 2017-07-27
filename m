From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Thu, 27 Jul 2017 16:51:58 -0400
Subject: [Linux-ima-devel] [RFC PATCH 1/5] ima: extend clone() with IMA
	namespace support
In-Reply-To: <TU4PR84MB030243E7071B5A7455334886FFBE0@TU4PR84MB0302.NAMPRD84.PROD.OUTLOOK.COM>
References: <20170720225033.21298-1-mkayaalp@linux.vnet.ibm.com>
	<20170720225033.21298-2-mkayaalp@linux.vnet.ibm.com>
	<20170725175317.GA727@mail.hallyn.com>
	<1501008554.3689.30.camel@HansenPartnership.com>
	<20170725190406.GA1883@mail.hallyn.com>
	<1501009739.3689.33.camel@HansenPartnership.com>
	<1501012082.27413.17.camel@linux.vnet.ibm.com>
	<645db815-7773-e351-5db7-89f38cd88c3d@linux.vnet.ibm.com>
	<20170725204622.GA4969@mail.hallyn.com>
	<1501016277.27413.50.camel@linux.vnet.ibm.com>
	<20170725210801.GA5628@mail.hallyn.com>
	<1501018134.27413.66.camel@linux.vnet.ibm.com>
	<TU4PR84MB03021F7FDF1B89ECAA8F7FFFFFBE0@TU4PR84MB0302.NAMPRD84.PROD.OUTLOOK.COM>
	<1501166369.28419.171.camel@linux.vnet.ibm.com>
	<TU4PR84MB03025AD26718A173FB3E3F94FFBE0@TU4PR84MB0302.NAMPRD84.PROD.OUTLOOK.COM>
	<3c3d8594-9958-5f53-ec0b-f33c36967f95@linux.vnet.ibm.com>
	<TU4PR84MB030243E7071B5A7455334886FFBE0@TU4PR84MB0302.NAMPRD84.PROD.OUTLOOK.COM>
Message-ID: <e14c46d1-fbc9-bfc7-a078-288141371e67@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 07/27/2017 03:39 PM, Magalhaes, Guilherme (Brazil R&D-CL) wrote:
>
>> There's a vTPM proxy driver in the kernel that enables spawning a
>> frontend /dev/tpm%d and an anonymous backend file descriptor where a
>> vTPM can listen on for TPM commands. I integrated this with 'swtpm' and
>> I have been working on integrating this into runc. Currently each
>> container started with runc can get one (or multiple) vTPMs and
>> /dev/tpm0 [and /dev/tpmrm0 in case of TPM2] then appear inside the
>> container.
>>
> This is an interesting solution especially for nested namespaces with the
> recursive application of measurements and a having list per container.
>
> Following the TCG specs/requirements, what could we say about security
> guarantees of real TPMs Vs this vTPM implementation?


A non-root user may not be able to do access the (permanent) state of 
the vTPM state files since the container management stack would restrict 
access to the files using DAC. Access to runtime data is also prevented 
since the vTPM would not run under the account of the non-root user.

To protect the vTPM's permanent state file from access by a root user it 
comes down to preventing the root user from getting a hold of the key 
used for encrypting that file. Encrypting the state of the vTPM is 
probably the best we can do to approximate a temper-resistant chip, but 
preventing the root user from accessing the key may be more challenging.
Preventing root from accessing runtime data could be achieved by using 
XGS or a similar technology.

     Stefan


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
