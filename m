From: mpe@ellerman.id.au (Michael Ellerman)
Date: Fri, 09 Jun 2017 20:27:03 +1000
Subject: [PATCH v2 0/6] Appended signatures support for IMA appraisal
In-Reply-To: <1496886555-10082-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1496886555-10082-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-ID: <87d1adihhk.fsf@concordia.ellerman.id.au>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> On the OpenPOWER platform, secure boot and trusted boot are being
> implemented using IMA for taking measurements and verifying signatures.

I still want you to implement arch_kexec_kernel_verify_sig() as well :)

cheers
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
