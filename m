From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Wed, 9 Aug 2017 11:31:15 -0400
Subject: [Linux-ima-devel] [RFC PATCH 1/5] ima: extend clone() with IMA
In-Reply-To: <TU4PR84MB0302CDE76E5E05075CF16A11FF8A0@TU4PR84MB0302.NAMPRD84.PROD.OUTLOOK.COM>
References: <TU4PR84MB0302CDE76E5E05075CF16A11FF8A0@TU4PR84MB0302.NAMPRD84.PROD.OUTLOOK.COM>
Message-ID: <16ab6c1f-3071-22ee-f526-3ac3603a047e@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 08/08/2017 09:22 AM, Magalhaes, Guilherme (Brazil R&D-CL) wrote:
> Stefan,
> Still on the vTPM requirements, could you help answering the following
> questions?
>
> 1. Where will the boot measurements be stored? What is the integrity
> measurement domain for this vTPM? The current proposal is that the
> vTPM would be used for the container (or namespace) files/inodes.
> What else will be available from the vTPM? For example, will the vTPM
> provide the UEFI measurements on the first PCRs (copied/proxied from
> physical TPM)?

The vTPM will receive PCR extends exclusively from the namespace it is 
associated with. The UEFI measurements could be retrieved from the 
hardware TPM. They are not copied since this would require copying the 
UEFI measurement list of the host as well. Otherwise the vTPM allows all 
commands to be used.

>
> 2. From an attestation/quote perspective, how do you envision the key
> material to be managed (e.g. the vTPM EK and/or Attestation Key is
> fixed to the physical TPM, or it's cryptographically bound to it)?

For quotes by the vTPM to work the EK and AIK need to be inside the 
vTPM. Similarly the EK and AIK of the hardware TPM would need be bound 
to the hardware TPM for the quoting of the hardware TPM's PCRs to work. 
If there's an official way, design by TCG for example, for how to quote 
the PCRs of a virtual TPM by the hardware TPM, I would like to know.

>
> 3. Can you elaborate more on the alignment of this solution with the
> TCG requirements, especially considering the lack of isolation on the
> vTPM solution, do you have a future plan to cover those issues?

A software emulated TPM does have its challenges when it comes to 
isolation from the root user, as explained in the last email. I am not 
sure there is a solution for protecting it from attacks from root, 
though we can protect it from non-root users fairly easily. If there are 
other isolation requirements than that, let me know.


>
> 4. In a micro services pattern, or a serverless compute pattern, in
> which one or more containers are created to handle each individual
> request it is possible that there will be several thousand containers
> created per hour on a busy server. What is the expected performance
> and scalability of vTPMs within such an environment?

A vTPM would be created as part of creating a container. The creation of 
certificates takes a couple of seconds to contact the CA and mint the 
cert. I would say not all of the containers would need to have a 
certificate.

     Stefan

>
> --
> Guilherme
>
>> -----Original Message-----
>> From: Stefan Berger [mailto:stefanb at linux.vnet.ibm.com]
>> Sent: quinta-feira, 27 de julho de 2017 17:52
>> To: Magalhaes, Guilherme (Brazil R&D-CL) <guilherme.magalhaes@hpe.com>;
>> Mimi Zohar <zohar@linux.vnet.ibm.com>; Serge E. Hallyn <serge@hallyn.com>
>> Cc: Mehmet Kayaalp <mkayaalp@cs.binghamton.edu>; Yuqiong Sun
>> <sunyuqiong1988@gmail.com>; containers <containers@lists.linux-
>> foundation.org>; linux-kernel <linux-kernel@vger.kernel.org>; David Safford
>> <david.safford@ge.com>; James Bottomley
>> <James.Bottomley@HansenPartnership.com>; linux-security-module <linux-
>> security-module at vger.kernel.org>; ima-devel <linux-ima-
>> devel at lists.sourceforge.net>; Yuqiong Sun <suny@us.ibm.com>
>> Subject: Re: [Linux-ima-devel] [RFC PATCH 1/5] ima: extend clone() with IMA
>> namespace support
>>
>> On 07/27/2017 03:39 PM, Magalhaes, Guilherme (Brazil R&D-CL) wrote:
>>>> There's a vTPM proxy driver in the kernel that enables spawning a
>>>> frontend /dev/tpm%d and an anonymous backend file descriptor where a
>>>> vTPM can listen on for TPM commands. I integrated this with 'swtpm' and
>>>> I have been working on integrating this into runc. Currently each
>>>> container started with runc can get one (or multiple) vTPMs and
>>>> /dev/tpm0 [and /dev/tpmrm0 in case of TPM2] then appear inside the
>>>> container.
>>>>
>>> This is an interesting solution especially for nested namespaces with the
>>> recursive application of measurements and a having list per container.
>>>
>>> Following the TCG specs/requirements, what could we say about security
>>> guarantees of real TPMs Vs this vTPM implementation?
>>
>> A non-root user may not be able to do access the (permanent) state of
>> the vTPM state files since the container management stack would restrict
>> access to the files using DAC. Access to runtime data is also prevented
>> since the vTPM would not run under the account of the non-root user.
>>
>> To protect the vTPM's permanent state file from access by a root user it
>> comes down to preventing the root user from getting a hold of the key
>> used for encrypting that file. Encrypting the state of the vTPM is
>> probably the best we can do to approximate a temper-resistant chip, but
>> preventing the root user from accessing the key may be more challenging.
>> Preventing root from accessing runtime data could be achieved by using
>> XGS or a similar technology.
>>
>>       Stefan
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
