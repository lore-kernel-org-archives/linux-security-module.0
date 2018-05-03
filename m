From: mjg59@google.com (Matthew Garrett)
Date: Thu, 03 May 2018 22:51:05 +0000
Subject: [PATCH 0/3] kexec: limit kexec_load syscall
In-Reply-To: <876044l7tr.fsf@xmission.com>
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
	<87r2mso5up.fsf@xmission.com>
	<CACdnJuukT4SYLcDwi7+ObqbCDS4ZEAMpgz57OL3_eSevW0QuVg@mail.gmail.com>
	<876044l7tr.fsf@xmission.com>
Message-ID: <CACdnJut4R-BQCYcT5_OuFezf8046-HmvvdEP4g7=ADgAW+qdeA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, May 3, 2018 at 2:59 PM Eric W. Biederman <ebiederm@xmission.com>
wrote:

> Matthew Garrett <mjg59@google.com> writes:
> > kexec_load gives root arbitrary power to modify the running kernel
image,
> > including the ability to disable enforcement of module signatures.

> No.  It does absolutely nothing to the running kernel image.
> Combined with reboot(..., LINUX_REBOOT_CMD_KEXE, ...) it does allow
> booting something different.  It is argubably a little more efficient
> than writing to a file to direct the bootloader to boot something
> different and then calling reboot.  But it is not fundamentally
> different.

It absolutely does - https://mjg59.dreamwidth.org/28746.html gives an
example. The payload just needs to return.

> > Given
> > that it weakens other security mechanisms that are designed to prevent
root
> > from disabling them, it makes sense to allow the imposition of an
> > equivalent restriction.

> Say what.  You are saying a lot of words without any specifics.  Not a
> specific threat mode.  Not which security mecahnisms you are worried
> about weakening.  Not what classes of problems you are trying to defend
> against.

I have a kernel configured with module.sig_enforce enabled - root is unable
to load kernel modules that are unsigned, and since sig_enforce is
bool_enable_only, root is unable to flip that back. Any number of security
models may be implemented with that assumption. However, root still has
access to kexec_load(), and can therefore kexec into a dummy payload that
flips that byte back to 0 and permits loading unsigned module code.

There may well be other mechanisms that permit root to gain arbitrary
ability to modify kernel code. My argument is that we should treat those as
bugs, not use their existence as a justification for leaving open known
cases.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
