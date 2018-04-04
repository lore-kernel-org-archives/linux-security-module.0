From: jannh@google.com (Jann Horn)
Date: Wed, 4 Apr 2018 18:23:28 +0200
Subject: An actual suggestion (Re: [GIT PULL] Kernel lockdown for secure
	boot)
In-Reply-To: <1119.1522858644@warthog.procyon.org.uk>
References: <CALCETrUVQLDC6_VEvuAbdCOuGrmcxohqTB6P8eyNojm9AryNkg@mail.gmail.com>
	<1119.1522858644@warthog.procyon.org.uk>
Message-ID: <CAG48ez3edmZo1iFXqpvzOKNY0jLzcqa18KuoRrBaPyfp=7huZQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

+ast at kernel.org

On Wed, Apr 4, 2018 at 6:17 PM, David Howells <dhowells@redhat.com> wrote:
> Andy Lutomirski <luto@kernel.org> wrote:
[...]
>> 3. All the bpf and tracing stuf, etc, gets changed so it only takes
>> effect when LOCKDOWN_PROTECT_INTEGRITY_AND_SECRECY is set.
>
> Uh, no.  bpf, for example, can be used to modify kernel memory.

I'm pretty sure bpf isn't supposed to be able to modify arbitrary
kernel memory. AFAIU if you can use BPF to write to arbitrary kernel
memory, that's a bug; with CAP_SYS_ADMIN, you can read from userspace,
write to userspace, and read from kernelspace, but you shouldn't be
able to write to kernelspace.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
