From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Fri, 09 Jun 2017 18:19:19 -0300
Subject: [PATCH v2 0/6] Appended signatures support for IMA appraisal
In-Reply-To: <87d1adihhk.fsf@concordia.ellerman.id.au>
References: <1496886555-10082-1-git-send-email-bauerman@linux.vnet.ibm.com>
	<87d1adihhk.fsf@concordia.ellerman.id.au>
Message-ID: <87efusyi3s.fsf@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


Michael Ellerman <mpe@ellerman.id.au> writes:

> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>
>> On the OpenPOWER platform, secure boot and trusted boot are being
>> implemented using IMA for taking measurements and verifying signatures.
>
> I still want you to implement arch_kexec_kernel_verify_sig() as well :)

Yes, I will implement it! We are still working on loading the public
keys for kernel signing from the firmware into a kernel keyring, so
there's not much point in implementing arch_kexec_kernel_verify_sig
without having that first.

The same problem also affects IMA: even with these patches, new code
still neededs to be added to make IMA use the platform keys for kernel
signature verification.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
