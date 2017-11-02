From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 02 Nov 2017 18:01:26 -0400
Subject: [PATCH 00/27] security, efi: Add kernel lockdown
In-Reply-To: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
Message-ID: <1509660086.3416.15.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi David,

>From the man page:

> Only validly signed modules may be loaded.
> .P
> Only validly signed binaries may be kexec'd.
> .P
> Only validly signed device firmware may be loaded.

fw_get_filesystem_firmware() calls kernel_read_file_from_path() to
read the firmware, which calls into the security hooks. Is there
another place that validates the firmware signatures. ?I'm not seeing
which patch requires firmware to be signed?

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
