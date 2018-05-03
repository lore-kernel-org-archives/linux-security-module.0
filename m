From: mjg59@google.com (Matthew Garrett)
Date: Thu, 03 May 2018 20:39:48 +0000
Subject: [PATCH 0/3] kexec: limit kexec_load syscall
In-Reply-To: <87r2mso5up.fsf@xmission.com>
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
	<87r2mso5up.fsf@xmission.com>
Message-ID: <CACdnJuukT4SYLcDwi7+ObqbCDS4ZEAMpgz57OL3_eSevW0QuVg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, May 3, 2018 at 1:13 PM Eric W. Biederman <ebiederm@xmission.com>
wrote:

> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> > In environments that require the kexec kernel image to be signed,
prevent
> > using the kexec_load syscall.  In order for LSMs and IMA to
differentiate
> > between kexec_load and kexec_file_load syscalls, this patch set adds a
> > call to security_kernel_read_file() in kexec_load_check().

> Having thought about it some more this justification for these changes
> does not work.  The functionality of kexec_load is already root-only.
> So in environments that require the kernel image to be signed just don't
> use kexec_load.  Possibly even compile kexec_load out to save space
> because you will never need it.  You don't need a new security hook to
> do any of that.  Userspace is a very fine mechanism for being the
> instrument of policy.

> If you don't trust userspace that needs to be spelled out very clearly.
> You need to talk about what your threat models are.

kexec_load gives root arbitrary power to modify the running kernel image,
including the ability to disable enforcement of module signatures. Given
that it weakens other security mechanisms that are designed to prevent root
from disabling them, it makes sense to allow the imposition of an
equivalent restriction.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
